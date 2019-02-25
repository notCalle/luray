--- Module extension of numlua matrices
-- A pixel is a 3x1 matrix with linear R,G,B values.
-- See <a href="http://www.numlua.luaforge.net">numlua</a>.
-- @module luray.pixel

require'numlua'
local print = print
local matrix,type = matrix,numlua.type
local io,math = io,math
local format = string.format
local unpack = table.unpack
local List = require'lucy.list'
local luray = require'luray'
local isclose = luray.isclose
local M={
    __index=matrix,
    __call=function(_,...) return matrix(...) end
}
_ENV=setmetatable(M,M)

--- Return a pixel value in RGB space
-- @tparam ?number r coordinate (default 0)
-- @tparam ?number g coordinate (default 0)
-- @tparam ?number b coordinate (default 0)
-- @treturn pixel 3x1 matrix
function rgb(r,g,b)
    return matrix{r or 0,g or 0,b or 0}
end

--- Return a pixel value in gray space
-- @tparam ?number y gray tone (default 0)
-- @treturn pixel 3x1 matrix
function gray(y)
    return matrix{y,y,y}
end

--- Return a pixel buffer.
-- @tparam number w width in pixels
-- @tparam number h height in pixels
-- @treturn {{pixel}} matrix of black pixels
function buffer(w,h)
    return zeros(h,w,3)
end

local function clamp_pixel(v)
    return math.min(math.max(v,0),1)
end

local function row_tostring(row,maxcol)
    local chunk=List{}
    for c = 1,#row do
        local r,g,b = unpack(row[c]:map(clamp_pixel)*maxcol)
        chunk:insert(format("%0.0f %0.0f %0.0f",r,g,b))
    end
    return chunk:concat(" ")
end

--- Return a PPM format string for the contents in buffer
-- @tparam {{pixel}} buffer pixel buffer to be written
-- @tparam ?number bits per color component (default 8)
function tostring(buffer,bits)
    local h,w = buffer:size(1),buffer:size(2)
    local maxcol = 2^(bits or 8)-1
    local chunks=List{ format("P3\n%d %d\n%d", w, h, maxcol) }
    for r = 1,#buffer  do
        chunks:insert(row_tostring(buffer[r],maxcol))
    end
    return chunks:concat("\n")
end

--- Save a pixel buffer to a PPM formatted file
-- @tparam {{pixel}} buffer pixel buffer to be saved
-- @tparam string filename name of file to be (over)written
-- @tparam ?number bits per color component (default 8)
function save(buffer,filename,bits)
    local h,w = buffer:size(1),buffer:size(2)
    local maxcol = 2^(bits or 8)-1

    local file,error = io.open(filename,"w")
    if error then error(error) end

    file:write(format("P3\n%d %d\n%d\n", w, h, maxcol))
    for r = 1,#buffer  do
        local _,error = file:write(row_tostring(buffer[r],maxcol).."\n")
        if error then error(error) end
    end

    local _,error = file:flush()
    if error then error(error) end

    file:close()
end

return M
