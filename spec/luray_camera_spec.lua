local matrix = require'luray.matrix'
local point,vector = matrix.point,matrix.vector
local Sphere = require'luray.shape.sphere'
local Camera = require'luray.camera'

describe("a camera",function()
    it("casts rays into the scene",
    function()
        local camera=Camera{scene=Sphere{},width=9,height=9,fov=1/6}
        local ray=camera:cast_ray(5,5)

        assert.are.equal(2,#ray)
    end)

    it("shades pixels where rays hit the scene",
    function()
        local camera=Camera{scene=Sphere{},width=9,height=9,fov=1/6}
        camera:translate(0,0,-2)
        local ray=camera:cast_ray(5,5)
        assert.is_truthy(ray:hit())
        local color = camera:shade(ray:hit())
        assert.is.close(color,1)
    end)

    it("leaves pixels black where rays miss the scene",
    function()
        local camera=Camera{scene=Sphere{},width=9,height=9,fov=1/6}
        camera:translate(0,0,2)
        local ray=camera:cast_ray(5,5)
        assert.is_falsy(ray:hit())
        local color = camera:shade(ray:hit())
        assert.is.close(color,0)
    end)

    it("can render an image from a scene",
    function()
        local camera=Camera{scene=Sphere{},width=9,height=9,fov=1/6}
        assert.has.no.errors(camera:render())
    end)
end)
