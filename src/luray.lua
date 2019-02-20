--- Luray is a Lua Ray Tracer
-- @module luray
-- @author Calle Englund &lt;calle@discord.bofh.se&gt;
-- @copyright &copy; 2019 Calle Englund
-- @license
-- The MIT License (MIT)
--
-- Permission is hereby granted, free of charge, to any person obtaining a
-- copy of this software and associated documentation files (the
-- "Software"), to deal in the Software without restriction, including
-- without limitation the rights to use, copy, modify, merge, publish,
-- distribute, sublicense, and/or sell copies of the Software, and to
-- permit persons to whom the Software is furnished to do so, subject to
-- the following conditions:
--
-- The above copyright notice and this permission notice shall be included
-- in all copies or substantial portions of the Software.
--
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
-- OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
-- MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
-- IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
-- CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
-- TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
-- SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

require'numlua'
local type = numlua.type
local abs,pi = math.abs,math.pi
local error,require,type = error,require,type
local format = string.format
local _ENV = {
    _VERSION = "scm-1"
}
--- An immeasurably small value
epsilon = 1e-6
--- The circle constant
tau = 2*pi

--- "Close enough" equality for numbers avd matrices
-- @tparam number this
-- @tparam number that
-- @treturn boolean this and that are within EPSILON
function isclose(this,that)
    if type(this) == "number" and type(that) == "number" then
        return abs(this-that) < epsilon
    elseif type(this) == "matrix" and type(that) == "matrix" then
        local m = this-that
        return not m:find(function(v) return abs(v) >= epsilon end)
    else
        error(format("can't compare %s with %s", type(this), type(that)))
    end
end

return _ENV
