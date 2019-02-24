--- Unit sphere surface shape
-- @classmod Sphere
-- @see Shape
-- @usage
-- Sphere = require'luray.shape.sphere'

local point0 = require'luray.matrix'.point0
local solve = require'luray'.quadratic
local Shape = require'luray.shape'
local M = Shape'Sphere'
_ENV=M

function M:__intersect(ray)
    local l = ray.origin-point0
    local d = ray.direction
    return {solve(d:dot(d), 2*d:dot(l), l:dot(l)-1)}
end

function M:__normal(hit)
    return hit.point-point0
end

return M
