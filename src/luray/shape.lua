--- Base class for intersectable, transformable surface shapes.
-- Subclasses must implement the @{Intersectable:__intersect} metamethod
-- to define their intersection criteria. And the @{Shape:__normal}
-- metamethod to define their normal vector where hit by a ray.
--
-- @classmod Shape
-- @see Shadable
-- @see Intersectable
-- @see Transformable
-- @usage
-- Shape = require'luray.shape'
-- Icosahedron = Shape'Icosahedron'

local Object = require'lucy.object'
local Shadable = require'luray.shadable'
local Intersectable = require'luray.intersectable'
local Transformable = require'luray.transformable'
local M = Object'Shape'..Shadable..Intersectable..Transformable
_ENV=M

function M:__init()
    self:__init_transform()
end

--- Calculate the normal vector at an intersection
-- @tparam struct.intersection hit the intersection
-- @treturn matrix.vector normal vector in world space
function M:normal(hit)
    local transform = self._invnormal
    if not transform then return self:__normal(hit)
    else return transform * self:__normal(hit)
    end
end

--- Abstract methods
-- @section

--- Calculate the normal vector at an intersection
-- @function __normal
-- @tparam struct.intersection hit the intersection
-- @treturn matrix.vector normal vector in object space

return M
