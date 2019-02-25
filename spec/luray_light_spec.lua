local matrix = require'luray.matrix'
local point,vector = matrix.point,matrix.vector
local Sphere = require'luray.shape.sphere'
local Ray = require'luray.ray'
local Light = require'luray.light'
local Light = require'luray.light'

local SubLight = Light'SubLight'
function SubLight:__lighting(hit)
    return {{illumination=1,lightv=self.lightv,distance=1/0}}
end

describe("an abstract light",function()
    it("requires a concrete implementation of lighting calculations",
    function()
        local light = Light{}
        assert.has.error(function() light:lighting() end,
                         "attempt to call a nil value (method '__lighting')")
    end)

    context("subclass",function()
        local shape = Sphere{}
        local ray = Ray{origin=point(2,0,0),direction=vector(-1,0,0)}
        local hit = ray:cast(shape):hit()
        local l1 = SubLight{lightv=vector(1,0,0)}:lighting(hit)
        local l2 = SubLight{lightv=vector(-1,0,0)}:lighting(hit)

        it("removes lighting for hits in shadow",
        function()
            assert.is.equal(0,#l2)
            assert.is_true(#l1 > #l2)
        end)
    end)
end)
