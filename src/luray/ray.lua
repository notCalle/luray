--- A ray has origin and direction.
-- @classmod Ray
-- @usage
-- Ray = require'luray.ray'
-- r = Ray{origin=point(-1,1,0), direction=vector(1,0,0)}

local ipairs,print = ipairs,print
local matrix = require'luray.matrix'
local point,vector = matrix.point,matrix.vector
local List = require'lucy.list'
local M = List'Ray'
_ENV=M

function M:__init()
    self.origin = self.origin or point(0,0,0)
    self.direction = self.direction or vector(0,1,0)
end

--- Return a transformed copy of the ray
-- @see luray.matrix
-- @tparam matrix transform a transform matrix
-- @treturn Ray transformed copy
function M:__call(transform)
    return self.class({
        origin = transform * self.origin,
        direction = transform * self.direction
    })
end

local function isect_lt(lhs,rhs)
    return lhs.t < rhs.t
end

--- Cast a ray at something intersectable, and collect intersections
-- @tparam Intersectable world Intersectable thing to cast ray into
-- @treturn Ray self
function M:cast(world)
    for _,i in ipairs(world:intersect(self)) do
        i.world=world
        self:insert(i)
    end
    self:sort(isect_lt)
    return self
end

--- Return the nearest intersection in front of origin
-- @treturn struct.intersection|nil
-- @treturn point world space position of hit
function M:hit()
    for _,i in ipairs(self) do
        local t = i.t
        if t > 0 then
            i.normal = i.object:normal(i)
            return i,self.origin+self.direction*t
        end
    end
end

return M
