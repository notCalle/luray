--- Module extension of numlua matrices
-- See <a href="http://www.numlua.luaforge.net">numlua</a>.
-- @module luray.matrix

require'numlua'
local matrix,type = matrix,numlua.type
local luray = require'luray'
local isclose = luray.isclose
local M={
    __index=matrix,
    __call=function(_,...) return matrix(...) end
}
_ENV=setmetatable(M,M)

--- Points
-- @section

--- Create a 3D point
-- @tparam ?number x coordinate (default 0)
-- @tparam ?number y coordinate (default 0)
-- @tparam ?number z coordinate (default 0)
-- @treturn point 4x1 matrix
function point(x,y,z)
    return matrix{x or 0,y or 0,z or 0,1}
end

--- Zero point
point0 = point()

--- Test if a 4x1 matrix is a point
-- @tparam matrix v the point candidate
-- @treturn boolean
function ispoint(v)
    return type(v) == "matrix" and isclose(v[4],1.0)
end

--- Vectors
-- @section

--- Create a 3D vector
-- @tparam ?number x coordinate (default 0)
-- @tparam ?number y coordinate (default 0)
-- @tparam ?number z coordinate (default 0)
-- @treturn vector 4x1 matrix
function vector(x,y,z)
    return matrix{x or 0,y or 0,z or 0,0}
end

--- Zero vector
vector0 = vector()
--- X axis vector
vectorX = vector(1,0,0)
--- Y axis vector
vectorY = vector(0,1,0)
--- Z axis vector
vectorZ = vector(0,0,1)

--- Test if a 4x1 matrix is a vector
-- @tparam matrix v the vector candidate
-- @treturn boolean
function isvector(v)
    return type(v) == "matrix" and isclose(v[4],0.0)
end

function normalize(v)
    return v/v:norm()
end

return _ENV
