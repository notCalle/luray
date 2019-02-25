--- A distant, directional light
-- The default direction of the light is (1,0,0)
-- @classmod DirectionalLight
-- @see Light
-- @usage
-- DirectionalLight = require'luray.light.directional'

local inf = 1/0
local matrix = require'luray.matrix'
local normalize,vectorZ = matrix.normalize,matrix.vectorZ
local Light = require'luray.light'
local M = Light'DirectionalLight'
_ENV=M

local direction = vectorZ

function M:__init()
    Light.__init(self)
end

function M:__lighting(hit)
    return {{
        distance = inf,
        illumination = self.intensity,
        lightv = normalize(self._transform * direction)
    }}
end

return M
