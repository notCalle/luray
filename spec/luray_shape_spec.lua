local matrix = require'luray.matrix'
local point,vector = matrix.point,matrix.vector
local Ray = require'luray.ray'
local Graph = require'lucy.graph'
local Transformable = require'luray.transformable'
local Intersectable = require'luray.intersectable'
local Shape = require'luray.shape'

describe("a sphere",function()
    it("can be a graph vertex",
    function()
        assert.is_true(Graph <= Shape)
    end)

    it("can be transformed",
    function()
        assert.is_true(Transformable <= Shape)
    end)

    it("can be intersected",
    function()
        assert.is_true(Intersectable <= Shape)
    end)
end)
