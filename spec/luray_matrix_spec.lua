local isclose = require'luray'.isclose
local matrix = require'luray.matrix'
local point,ispoint = matrix.point,matrix.ispoint
local vector,isvector = matrix.vector,matrix.isvector
local normalize = matrix.normalize

describe("luray.matrix", function()
    context("matrices",function()
        it("can be called to create matrices",
        function()
            assert.has.no.errors(function() matrix{1,2,3} end)
        end)
    end)

    context("points and vectors",function()
        it("can make 3D points",
        function()
            local p = point(3,2,1)
            assert.are.equal(p[1],3)
            assert.are.equal(p[2],2)
            assert.are.equal(p[3],1)
            assert.are.equal(p[4],1)
        end)

        it("can make 3D vectors",
        function()
            local p = vector(3,2,1)
            assert.are.equal(p[1],3)
            assert.are.equal(p[2],2)
            assert.are.equal(p[3],1)
            assert.are.equal(p[4],0)
        end)

        it("yields neither a point nor vector when adding points",
        function()
            local v = point(1,2,3) + point(3,2,1)
            assert.is_not.point(v)
            assert.is_not.vector(v)
        end)

        it("yields a point when adding vector to point",
        function()
            local v = point(1,2,3) + vector(3,2,1)
            assert.is.point(v)
        end)

        it("yields a vector when adding vectors",
        function()
            local v = vector(1,2,3) + vector(3,2,1)
            assert.is.vector(v)
        end)

        it("yields a vector when subtracting points",
        function()
            local v = point(1,2,3) - point(3,2,1)
            assert.is.vector(v)
        end)

        it("yields a vector when subtracting vectors",
        function()
            local v = vector(1,2,3) - vector(3,2,1)
            assert.is.vector(v)
        end)

        it("yields a point when subtracting vector from point",
        function()
            local v = point(1,2,3) - vector(3,2,1)
            assert.is.point(v)
        end)

        it("can normalize a vector",
        function()
            local v = vector(1,1,0)
            local n = normalize(v)
            assert.is.close(1,normalize(v):norm())
            assert.is.close(n[1],1/math.sqrt(2))
            assert.is.close(n[2],1/math.sqrt(2))
        end)
    end)
end)
