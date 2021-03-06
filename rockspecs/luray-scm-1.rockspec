rockspec_format = "3.0"
package = "luray"
version = "scm-1"
source = {
    url = "git+https://github.com/notcalle/luray.git",
    branch = "master"
}
description = {
    summary = "A Lua Ray Tracer",
    homepage = "https://github.com/notcalle/luray",
    license = "MIT",
    maintainer = "Calle Englund <calle@discord.bofh.se>",
    labels = { }
}
dependencies = {
    "lua ~> 5.3",
    "lucy = scm-1",
    "numlua = 0.3.git-1"
}
build = {
    type = "builtin",
    modules = {
        luray = "src/luray.lua",
        ["luray.bounds"] = "src/luray/bounds.lua",
        ["luray.intersectable"] = "src/luray/intersectable.lua",
        ["luray.matrix"] = "src/luray/matrix.lua",
        ["luray.ray"] = "src/luray/ray.lua",
        ["luray.shape"] = "src/luray/shape.lua",
        ["luray.transform"] = "src/luray/transform.lua",
        ["luray.transformable"] = "src/luray/transformable.lua",
    }
}
