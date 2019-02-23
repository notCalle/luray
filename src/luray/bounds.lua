--- Axis aligned bounding box
-- @classmod Bounds
-- @usage
-- Bounds = require'luray.bounds'

local inf = 1/0
local point = require'luray.matrix'.point
local Object = require'lucy.object'
local M = Object'Bounds'
_ENV=M

function M:__init()
    self.min = self.min or point(-1,-1,-1)
    self.max = self.max or point(1,1,1)
end

--- Find intersections of a bounding box with a ray.
-- @tparam Ray ray the intersecting ray
-- @treturn number|nil t value for the closest intersection, if any
-- @treturn number|nil t value for the farthest intersection, if any
function M:intersect(ray)
    local t_min,t_max = -inf,inf
    local min = self.min-ray.origin
    local max = self.max-ray.origin
    local d = ray.direction
    for n=1,3 do
        local _min,_max = min[n]/d[n],max[n]/d[n]
        if _min > _max then _min,_max = _max,_min end
        if _min > t_min then t_min = _min end
        if _max < t_max then t_max = _max end
        if t_min > t_max then return end
    end
    return t_min,t_max
end

return M
