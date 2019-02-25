local Light = require'luray.light'
local DirectionalLight = require'luray.light.directional'

describe("a directional light",function()
    it("is a kind of light",
    function()
        assert.is_true(Light <= DirectionalLight)
    end)

    it("calculates lighting conditions independent of the hit",
    function()
        local light = DirectionalLight{}
        assert.has.no.error(function() light:__lighting(nil) end)
    end)
end)
