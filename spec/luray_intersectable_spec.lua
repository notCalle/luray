local matrix = require'luray.matrix'
local point,vector = matrix.point,matrix.vector
local Intersectable = require'luray.intersectable'
local Ray = require'luray.ray'
local Object = require'lucy.object'
local Bounds = require'luray.bounds'

describe("an intersectable object", function()
    local Surface=Object'Surface'+Intersectable
    Surface.bounds = Bounds{}
    function Surface:__intersect()
        return {1}
    end

    it("can be intersected",
    function()
        local ray = Ray{}
        assert.is_function(Surface.intersect)
        assert.has.no.errors(function() Surface{}:intersect(ray) end)
    end)

    context("when intersected",
    function()
        local ray = Ray{}
        local isects = Surface{}:intersect(ray)

        it("returns a table of intersections",
        function()
            assert.is.table(isects)
        end)

        context("an intersection",
        function()
            local i = isects[1]

            it("has a numeric t value",
            function()
                assert.is.number(i.t)
            end)

            it("has an object reference",
            function()
                assert.is.table(i.object)
            end)

            it("has point of intersection in object space",
            function()
                assert.is.matrix(i.point)
            end)
        end)
    end)
end)
