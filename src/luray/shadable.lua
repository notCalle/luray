--- Mixin for shadable objects.
-- Combines the list of shaders in `self._shaders` if defined, or defaults to a
-- simple facing ratio shader (normalv dot eyev).
--
-- @classmod Shadable
-- @usage
-- Shadable = require'luray.shadable'
-- Thing..Shadable

local ipairs = ipairs
local Mixin = require'lucy.mixin'
local M = Mixin'Shadable'
_ENV=M

local function default_shader(hit)
    return hit.normalv:dot(hit.eyev)
end

function M:shade(hit,lighting)
    local shade = 0
    local shaders = self._shaders or {default_shader}
    for _,shader in ipairs(shaders) do
        shade = shade + shader(hit,lighting)
    end
    return shade
end

return M
