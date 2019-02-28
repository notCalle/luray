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

local error,format = error,string.format
local Graph = require'lucy.graph'
local Object = require'lucy.object'
local Shadable = require'luray.shadable'
local Intersectable = require'luray.intersectable'
local Transformable = require'luray.transformable'
local M = Object'Shape'+Graph+Shadable+Intersectable+Transformable
_ENV=M

function M:__init()
    self:__init_transform()
end

function M:__edge_to()
    error(format("a %s can't have children",self.class))
end

--- Calculate the normal vector at an intersection
-- @tparam struct.intersection hit the intersection
-- @treturn matrix.vector normal vector in world space
function M:normal(hit)
    return self:normal_to_world(self:__normal(hit))
end

--- Abstract methods
-- @section

--- Calculate the normal vector at an intersection
-- @function __normal
-- @tparam struct.intersection hit the intersection
-- @treturn matrix.vector normal vector in object space

return M
