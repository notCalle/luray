--- Base class for intersectable, transformable surface shapes.
-- Subclasses must implement the @{Intersectable:__intersect} metamethod
-- to define their intersection criteria. And the @{Shape:__normal}
-- metamethod to define their normal vector where hit by a ray.
--
-- @classmod Group
-- @see Intersectable
-- @see Transformable
-- @usage
-- Shape = require'luray.shape'
-- Icosahedron = Shape'Icosahedron'

local ipairs = ipairs
local Object = require'lucy.object'
local Graph = require'lucy.graph'
local List = require'lucy.list'
local Transformable = require'luray.transformable'
local M = Object'Group'+Graph+Transformable
_ENV=M

function M:__init()
    self:__init_transform()
end

---- Intersect the members of a group with a ray in world space
-- If the group has a transform, first apply its inverse to the ray.
--
-- @tparam Ray ray intersecting ray, in world space
-- @treturn {struct.intersection,...}
function M:intersect(ray)
    local bounds,transform = self.bounds,self._inverse
    if transform then ray = ray(transform) end
    if bounds and not bounds:intersect(ray) then return {} end

    local isects = List{}
    for _,o in ipairs(self:tails()) do
        isects:__concat(o:intersect(ray))
    end
    return isects
end

return M
