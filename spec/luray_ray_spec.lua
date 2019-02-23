local matrix = require'luray.matrix'
local point,ispoint = matrix.point,matrix.ispoint
local vector,isvector = matrix.vector,matrix.isvector
local Shape = require'luray.shape'
local Ray = require'luray.ray'
local Bounds = require'luray.bounds'
local Transform = require'luray.transform'

local Surface=Shape'Surface'
function Surface:__init()
    Shape.__init(self)
    self.bounds = Bounds{}
end
function Surface:__intersect(ray)
    local origo = point()
    return {(ray.origin-origo):norm()}
end
function Surface:__normal(hit)
    return vector(1,0,0)
end

describe("a ray", function()
    local r = Ray{}

    it("has an origin",
    function()
        assert.is.point(r.origin)
    end)

    it("has a direction",
    function()
        assert.is.vector(r.direction)
    end)

    it("create a transformed copy of itself",
    function()
        local t = Transform{}:scale(1,2,3):translate(3,2,1)
        local r1 = Ray{origin=point(1,1,1),direction=vector(1,1,1)}
        local r2 = r1(t)
        assert.is_true(Ray <= r2)
        assert.is.close(r2.origin,point(4,4,4))
        assert.is.close(r2.direction,vector(1,2,3))
    end)

    it("can be cast at an intersectable object",
    function()
        assert.has.no.error(function() r:cast(Surface{}) end)
    end)

    context("when it hits something",function()
        local r = Ray{origin=point(1,0,0), direction=vector(-1,0,0)}
        local s = Surface{}
        r:cast(s)
        local hit,p = r:hit()

        it("can find the intersection",
        function()
            assert.is.table(hit)
        end)

        it("can find the point of intersection",
        function()
            assert.is.point(p)
        end)

        context("the hit",function()
            it("includes the distance",
            function()
                assert.is.number(hit.t)
            end)

            it("includes the object",
            function()
                assert.is.equal(s,hit.object)
            end)

            it("has the expected object point of intersection",
            function()
                assert.is.point(hit.point)
                assert.is.close(hit.point,point())
            end)

            it("has the expected object normal at intersection",
            function()
                assert.is.vector(hit.normal)
                assert.is.close(hit.normal,-r.direction)
            end)
        end)
    end)
end)
