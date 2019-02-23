require'numlua.seeall'
local assert = require'busted'.assert

local isclose = require'luray'.isclose
local function is_close(_,args)
    return isclose(args[1],args[2])
end
assert:register("assertion","close",is_close,
                "assertion.same.positive","assertion.same.negative")

local ispoint = require'luray.matrix'.ispoint
local function is_point(_,args)
    table.insert(args,"a point")
    return ispoint(args[1])
end
assert:register("assertion","point",is_point,
                "assertion.same.positive","assertion.same.negative")

local isvector = require'luray.matrix'.isvector
local function is_vector(_,args)
    table.insert(args,"a vector")
    return isvector(args[1])
end
assert:register("assertion","vector",is_vector,
                "assertion.same.positive","assertion.same.negative")

local function is_matrix(_,args)
    table.insert(args,"a matrix")
    return type(args[1]) == "matrix"
end
assert:register("assertion","matrix",is_matrix,
                "assertion.same.positive","assertion.same.negative")
