local matrix = require'luray.matrix'
local point,vector = matrix.point,matrix.vector
local Bounds = require'luray.bounds'
local Ray = require'luray.ray'

describe("a bounding box", function()
    local bbox = Bounds{}

    it("defaults to the bounds of a unit sphere",
    function()
        assert.is.close(point(-1,-1,-1),bbox.min)
        assert.is.close(point(1,1,1),bbox.max)
    end)

    it("can be intersected by a ray",
    function()
        local ray = Ray{}
        assert.is_function(bbox.intersect)
        assert.has.no.errors(function() bbox:intersect(ray) end)
    end)

    context("when hit by a ray",
    function()
        local ray = Ray{}
        local t_min,t_max = bbox:intersect(ray)

        it("returns the min and max t values of the intersections",
        function()
            assert.is.number(t_min)
            assert.is.number(t_max)
            assert.is_true(t_min <= t_max)
        end)
    end)

    context("when missed by a ray",
    function()
        local ray = Ray{origin=point(2,2,2)}
        local t_min,t_max = bbox:intersect(ray)

        it("returns nothing",
        function()
            assert.is_nil(t_min)
            assert.is_nil(t_max)
        end)
    end)
end)
