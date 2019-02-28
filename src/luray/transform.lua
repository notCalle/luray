--- Create transform matrices
-- @classmod Transform
-- @usage
-- Transform = require'luray.transform'
-- t = Transform{}
-- @see Transformable

local ipairs,tostring,print = ipairs,tostring,print
local Transformable = require'luray.transformable'
local Object = require'lucy.object'
local M,_M = Object'Transform'+Transformable
_ENV=M

function M:__init()
    self:__init_transform()
end

function M:__mul(something)
    return self._transform * something
end

function M:__tostring()
    return tostring(self._transform)
end

return M
