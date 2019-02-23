--- Mixin for intersectable objects.
-- Instances can include a 'bounds' property, holding their @{Bounds}, for
-- early termination of intersection tests.
-- If the instance has a 'transform' property, holding their @{Transform},
-- any intersecting rays will be transformed by its inverse.
-- @classmod Intersectable
-- @usage
-- Intersectable = require'luray.intersectable'
-- Something..Intersectable

local ipairs = ipairs
local Mixin = require'lucy.mixin'
local List = require'lucy.list'
local M = Mixin'Intersectable'
_ENV=M

--- Intersect an object with a ray in world space
-- If the object has a transform, first apply its inverse to the ray.
-- Requires implementation of @{__intersect} for object space intersection.
--
-- @tparam Ray ray intersecting ray, in world space
-- @treturn {struct.intersection,...}
function M:intersect(ray)
    local bounds,transform = self.bounds,self._inverse
    if transform then ray = ray(transform) end
    if bounds and not bounds:intersect(ray) then return {} end

    local isects = List{}
    for _,t in ipairs(self:__intersect(ray)) do
        isects:insert{
            t = t,
            object = self,
            point = ray.origin + t * ray.direction
        }
    end
    return isects
end

--- Abstract methods
-- @section

--- Intersect an object with a ray in object space
--
-- @function __intersect
-- @tparam Ray ray intersecting ray, in object space
-- @treturn {number} t values for intersections

return M
