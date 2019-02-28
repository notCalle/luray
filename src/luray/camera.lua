--- A camera, that renders a world by casting rays
-- @classmod Camera
-- @see Transformable
-- @usage
-- Camera = require'luray.camera'
-- mycamera = Camera{scene=myscene}

local clock = os.clock
local error,ipairs,math = error,ipairs,math
local matrix = require'luray.matrix'
local type = numlua.type
local pixel = require'luray.pixel'
local normalize,point0,point = matrix.normalize,matrix.point0,matrix.point
local Ray = require'luray.ray'
local List = require'lucy.list'
local Object = require'lucy.object'
local Transformable = require'luray.transformable'
local M = Object'Camera'+Transformable
_ENV=M

function M:__init()
    for _,k in ipairs{"scene","fov","width","height"} do
        if not self[k] then error("a camera must have a "..k) end
    end
    self:__init_transform()
    local aspect = self.width/self.height
    local half = math.tan(self.fov*math.pi)
    if aspect >= 1 then
        self.half_w = half
        self.half_h = half/aspect
        self.pxsize = 2*half/self.width
    else
        self.half_w = half*aspect
        self.half_h = half
        self.pxsize = 2*half/self.height
    end
end

function M:cast_ray(px,py)
    local x,y = (px-0.5)*self.pxsize,(py-0.5)*self.pxsize
    local m = self._inverse
    local p = m*point(x-self.half_w,self.half_h-y,-1)
    local o = m*point0
    local r = Ray{origin=o,direction=normalize(p-o)}
    return r:cast(self.scene)
end

--- Shade a ray/shape hit in a scene
-- @tparam struct.intersection hit the ray/shape intersection
-- @treturn number|matrix the color of the shaded hit
function M:shade(hit)
    if not hit then return 0 end
    local lighting = List{}
    for _,light in ipairs(hit.world._lights or {}) do
        lighting:__concat(light:lighting(hit))
    end
    return hit.object:shade(hit,lighting)
end

function M:render()
    local t0 = clock()
    local pixbuf = pixel.buffer(self.width,self.height)
    for y = 1,self.height do
        for x = 1,self.width do
            local hit = self:cast_ray(x,y):hit()
            local color = self:shade(hit)
            if type(color) ~= "matrix" then color = pixel.gray(color) end
            pixbuf[y][x] = color
        end
    end
    local t1 = clock()
    return pixbuf,{render_time=t1-t0,pixels=self.height*self.width}
end

return M
