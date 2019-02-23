local matrix = require'luray.matrix'
local point,vector = matrix.point,matrix.vector
local Transformable = require'luray.transformable'
local Mixin = require'lucy.mixin'

describe("transformable", function()
    it("is a mixin",
    function()
        assert.is_true(Mixin <= Transformable)
    end)
end)

local Transform = require'luray.transform'

describe("a transform",function()
    it("is an instance of transformable",
    function()
        assert.is_true(Transformable <= Transform)
    end)

    it("has a transform matrix",
    function()
        local t = Transform{}
        assert.is.not_nil(t._transform)
        assert.is.matrix(t._transform)
    end)

    it("has an inverse of the transform",
    function()
        local t = Transform{}
        assert.is.not_nil(t._inverse)
        assert.is.matrix(t._inverse)
    end)

    it("has an inverse transpose for normal vectors",
    function()
        local t = Transform{}
        assert.is.not_nil(t._invnormal)
        assert.is.matrix(t._invnormal)
    end)

    it("returns the string representation of its transform matrix",
    function()
        local t = Transform{}
        assert.is.equal(tostring(t),tostring(t._transform))
    end)

    it("can multiply points and vectors",
    function()
        local t = Transform{}
        local p,v = point(),vector()
        assert.has.no.errors(function() return t*p end)
        assert.has.no.errors(function() return t*v end)
    end)

    it("is the identity transform, by default",
    function()
        local t = Transform{}
        local p,v = point(1,2,3),vector(4,5,6)
        assert.is.close(t*p,p)
        assert.is.close(t*v,v)
    end)

    context("rotation",function()
        it("is measured in units of tau, 1 = identity",
        function()
            local t0 = Transform{}._transform
            assert.is.close(Transform{}:rotate_x(1)._transform,t0)
            assert.is.close(Transform{}:rotate_y(1)._transform,t0)
            assert.is.close(Transform{}:rotate_z(1)._transform,t0)
        end)

        it("affects both points and vectors",
        function()
            local t = Transform{}:rotate_x(1/3)
            local p,v = point(1,1,1),vector(1,1,1)
            assert.is_not.close(t*p,p)
            assert.is_not.close(t*v,v)
        end)
    end)

    context("scaling",function()
        it("defaults to identity scale",
        function()
            local t0 = Transform{}._transform
            assert.is.close(Transform{}:scale()._transform,t0)
        end)

        it("affects both points and vectors",
        function()
            local t = Transform{}:scale(2)
            local p,v = point(1,1,1),vector(1,1,1)
            assert.is_not.close(t*p,p)
            assert.is_not.close(t*v,v)
        end)
    end)

    context("shearing",function()
        it("affects both points and vectors",
        function()
            local t = Transform{}:shear(2,3,4,5,6,7)
            local p,v = point(1,1,1),vector(1,1,1)
            assert.is_not.close(t*p,p)
            assert.is_not.close(t*v,v)
        end)
    end)

    context("translation",function()
        it("defaults to identity translation",
        function()
            local t0 = Transform{}._transform
            assert.is.close(Transform{}:translate()._transform,t0)
        end)

        it("affects points, but not vectors",
        function()
            local t = Transform{}:translate(1,2,3)
            local p,v = point(1,1,1),vector(1,1,1)
            assert.is_not.close(t*p,p)
            assert.is.close(t*v,v)
        end)
    end)
end)
