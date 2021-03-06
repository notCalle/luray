local matrix = require'luray.matrix'
local point,vector = matrix.point,matrix.vector
local Ray = require'luray.ray'
local Sphere = require'luray.shape.sphere'

describe("a sphere",function()
    local s = Sphere{}

    it("can be intersected by a ray",
    function()
        local r = Ray{}
        assert.has.no.errors(function() r:cast(s) end)
    end)

    context("when hit by a perpendicular ray",function()
        local r = Ray{origin=point(2,0,0),direction=vector(-1,0,0)}
        local hit = r:cast(s):hit()

        it("has a normal opposite of the ray direction",
        function()
            assert.is.close(hit.normalv,-r.direction)
        end)

        it("has a bright surface shade",
        function()
            assert.is.close(s:shade(hit),1)
        end)
    end)

    context("when hit by a tangential ray",function()
        local r = Ray{origin=point(2,1,0),direction=vector(-1,0,0)}
        local hit = r:cast(s):hit()

        it("has a normal perpendicular to the ray direction",
        function()
            assert.is.close(0,hit.normalv:dot(r.direction))
        end)

        it("has a dark surface shade",
        function()
            assert.is.close(s:shade(hit),0)
        end)
    end)

    context("when hit by a radial ray",function()
        local r = Ray{origin=point(0,0,0),direction=vector(-1,0,0)}
        local hit = r:cast(s):hit()

        it("has a normal opposite of the ray direction",
        function()
            assert.is.close(hit.normalv,-r.direction)
        end)

        it("has a bright surface shade",
        function()
            assert.is.close(s:shade(hit),1)
        end)
    end)
end)
