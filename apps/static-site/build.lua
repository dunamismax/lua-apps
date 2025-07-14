#!/usr/bin/env luajit

package.path = package.path .. ";../../shared/?.lua"

local generator = require("generator")
local logger = require("shared.utils.logger")

logger.set_level(logger.LOG_LEVELS.INFO)

local function main()
    local content_dir = "content"
    local output_dir = "dist"
    local template_dir = "templates"
    
    print("Building static site...")
    generator.generate_site(content_dir, output_dir, template_dir)
    print("Build complete! Check the 'dist' directory for generated files.")
end

main()