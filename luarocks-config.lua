rocks_trees = {
   { name = "user", root = home .. "/.luarocks" };
   { name = "system", root = "/usr/local" };
   { name = "project", root = "." };
}

lua_interpreter = "luajit"
lua_version = "5.1"
variables = {
   LUA_DIR = "/usr/local",
   LUA_BINDIR = "/usr/local/bin",
   LUA_INCDIR = "/usr/local/include",
   LUA_LIBDIR = "/usr/local/lib"
}