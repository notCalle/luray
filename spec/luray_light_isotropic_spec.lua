local matrix = require'luray.matrix'
local point,vector = matrix.point,matrix.vector
local Sphere = require'luray.shape.sphere'
local Ray = require'luray.ray'
local Light = require'luray.light'
local IsotropicLight = require'luray.light.isotropic'

describe("an isotropic light",function()
    it("is a kind of light",
    function()
        assert.is_true(Light <= IsotropicLight)
    end)

    it("calculates lighting conditions dependent of the hit distance",
    function()
        local ray = Ray{origin=point(2,0,0),direction=vector(-1,0,0)}
        local hit = ray:cast(Sphere{}):hit()
        local l1 = IsotropicLight{}:translate(2,0,0):__lighting(hit)[1]
        local l2 = IsotropicLight{}:translate(3,0,0):__lighting(hit)[1]
        assert.is_true(l1.illumination > l2.illumination)
        assert.is_true(l1.distance < l2.distance)
    end)
end)
