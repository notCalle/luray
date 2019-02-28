--- Mixin for objects with transform matrices.
-- Instances must call @{Transformable:__init_transform} to initialize
-- matrices before use.
-- @classmod Transformable
-- @usage
-- Transformable = require'luray.transformable'
-- TransObj = Object'TransObj'..Transformable

local tau = require'luray'.tau
local sin,cos = math.sin,math.cos
local matrix = require'luray.matrix'
local eye,normalize = matrix.eye,matrix.normalize
local ipairs,tostring,print = ipairs,tostring,print
local Mixin = require'lucy.mixin'
local M = Mixin'Transformable'
_ENV=M

local zeropoint=matrix{0,0,0,1}

local function update(self,m)
    self._transform = m * self._transform
    self._inverse = self._transform:inv()
    self._invnormal = self._inverse:transpose()
    self._invnormal:set(4,zeropoint) -- remove translation
    return self
end

--- Initialize transform matrices
function M:__init_transform()
    self._transform = eye(4)
    self._inverse = self._transform
    self._invnormal = self._transform
end

function M:__edge_from(parent)
    if self._parent then error("can't have more than one parent") end
    self._parent = parent
end

function M:normal_to_world(n)
    n = normalize(self._invnormal*n)
    if self._parent then
        return self._parent:normal_to_world(n)
    else
        return n
    end
end

--- Rotate transform around the X axis
-- @tparam number r rotation in units of tau
-- @treturn Transform self
function M:rotate_x(r)
    local m = eye(4)
    local r = r * tau
    local sin,cos = sin(r),cos(r)
    m[2][2] = cos ; m[2][3] =-sin
    m[3][2] = sin ; m[3][3] = cos
    return update(self,m)
end

--- Rotate transform around the Y axis
-- @tparam number r rotation in units of tau
-- @treturn Transform self
function M:rotate_y(r)
    local m = eye(4)
    local r = r * tau
    local sin,cos = sin(r),cos(r)
    m[1][1] = cos ; m[1][3] = sin
    m[3][1] =-sin ; m[3][3] = cos
    return update(self,m)
end

--- Rotate transform around the Z axis
-- @tparam number r rotation in units of tau
-- @treturn Transform self
function M:rotate_z(r)
    local m = eye(4)
    local r = r * tau
    local sin,cos = sin(r),cos(r)
    m[1][1] = cos ; m[1][2] =-sin
    m[2][1] = sin ; m[2][2] = cos
    return update(self,m)
end

--- Scale transform
-- @tparam ?number sx scale factor along X axis (default 1)
-- @tparam ?number sy scale factor along Y axis (default sx)
-- @tparam ?number sz scale factor along Z axis (default sx)
-- @treturn Transform self
function M:scale(sx,sy,sz)
    local v = {sx or 1, sy or sx or 1, sz or sx or 1}
    local m = eye(4)
    for n = 1,3 do m[n][n] = v[n] end
    return update(self,m)
end

--- Shear transform
-- @tparam number xy shear factor on X axis proportioal to Y axis
-- @tparam number xz shear factor on X axis proportioal to Z axis
-- @tparam number yx shear factor on Y axis proportioal to X axis
-- @tparam number yz shear factor on Y axis proportioal to Z axis
-- @tparam number zx shear factor on Z axis proportioal to X axis
-- @tparam number zy shear factor on Z axis proportioal to Y axis
-- @treturn Transform self
function M:shear(xy,xz,yx,yz,zx,zy)
    local m = eye(4)
    m[1][2] = xy ; m[1][3] = xz
    m[2][1] = yz ; m[2][3] = yz
    m[3][1] = zx ; m[3][2] = zy
    return update(self,m)
end

--- Translate transform
-- @tparam ?number x translation along X axis (default 0)
-- @tparam ?number y translation along Y axis (default 0)
-- @tparam ?number z translation along Z axis (default 0)
-- @treturn Transform self
function M:translate(x,y,z)
    local v = {x or 0, y or 0, z or 0}
    local m = eye(4)
    for n = 1,3 do m[n][4] = v[n] end
    return update(self,m)
end

return M
