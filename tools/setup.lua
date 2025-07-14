#!/usr/bin/env luajit

local logger = require("shared.utils.logger")
local utils = require("shared.utils")

local function check_luajit()
    local version = jit and jit.version or _VERSION
    logger.info("Lua version: %s", version)
    
    if not jit then
        logger.warn("LuaJIT not detected. Consider using LuaJIT for better performance.")
        return false
    end
    
    logger.info("LuaJIT detected: %s", jit.version)
    return true
end

local function check_luarocks()
    local handle = io.popen("luarocks --version 2>/dev/null")
    if not handle then
        logger.error("LuaRocks not found. Please install LuaRocks.")
        return false
    end
    
    local result = handle:read("*a")
    handle:close()
    
    if result and result:find("LuaRocks") then
        logger.info("LuaRocks found")
        return true
    else
        logger.error("LuaRocks not found. Please install LuaRocks.")
        return false
    end
end

local function install_dependencies()
    local dependencies = {
        "argparse",
        "lapis", 
        "lume",
        "luasocket",
        "lanes"
    }
    
    logger.info("Installing dependencies...")
    
    for _, dep in ipairs(dependencies) do
        logger.info("Installing %s...", dep)
        local cmd = string.format("luarocks install %s", dep)
        local handle = io.popen(cmd .. " 2>&1")
        
        if handle then
            local result = handle:read("*a")
            local success = handle:close()
            
            if success then
                logger.info("✓ %s installed successfully", dep)
            else
                logger.warn("⚠ %s installation may have issues: %s", dep, result)
            end
        else
            logger.error("✗ Failed to install %s", dep)
        end
    end
end

local function create_local_config()
    local config_content = [[
-- Local development configuration
local config = {}

config.development = {
    debug = true,
    log_level = "DEBUG",
    auto_reload = true
}

config.paths = {
    shared = "./shared",
    apps = "./apps",
    tools = "./tools",
    docs = "./docs"
}

return config
]]
    
    local config_path = "local_config.lua"
    if not utils.file_exists(config_path) then
        utils.write_file(config_path, config_content)
        logger.info("Created local configuration file: %s", config_path)
    else
        logger.info("Local configuration file already exists")
    end
end

local function setup_git_hooks()
    if not utils.file_exists(".git") then
        logger.warn("Not a git repository. Skipping git hooks setup.")
        return
    end
    
    local hook_content = [[#!/bin/sh
# Pre-commit hook for lua-apps

echo "Running Lua syntax checks..."

# Check all Lua files for syntax errors
find . -name "*.lua" -not -path "./luarocks_modules/*" | while read file; do
    luajit -bl "$file" > /dev/null 2>&1
    if [ $? -ne 0 ]; then
        echo "Syntax error in $file"
        exit 1
    fi
done

echo "All Lua files passed syntax check"
]]
    
    local hook_path = ".git/hooks/pre-commit"
    utils.write_file(hook_path, hook_content)
    
    local handle = io.popen("chmod +x " .. hook_path)
    if handle then
        handle:close()
        logger.info("Git pre-commit hook installed")
    end
end

local function main()
    logger.info("Setting up Lua Apps development environment...")
    
    local checks_passed = 0
    local total_checks = 2
    
    if check_luajit() then
        checks_passed = checks_passed + 1
    end
    
    if check_luarocks() then
        checks_passed = checks_passed + 1
        install_dependencies()
    end
    
    create_local_config()
    setup_git_hooks()
    
    logger.info("Setup complete!")
    logger.info("Checks passed: %d/%d", checks_passed, total_checks)
    
    if checks_passed < total_checks then
        logger.warn("Some checks failed. Please resolve the issues above.")
        os.exit(1)
    else
        logger.info("Environment is ready for development!")
        logger.info("Next steps:")
        logger.info("  • Run CLI apps: luajit apps/cli/todo-manager.lua --help")
        logger.info("  • Start web server: cd apps/web/blog-api && lapis server")
        logger.info("  • Build static site: cd apps/static-site && luajit build.lua")
        logger.info("  • Open Solar2D project: apps/mobile-desktop/solar2d-demo/")
    end
end

main()