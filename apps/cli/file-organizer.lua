#!/usr/bin/env luajit

local argparse = require("argparse")
local lfs = require("lfs") or {}
local utils = require("shared.utils")
local logger = require("shared.utils.logger")

local function get_file_extension(filename)
    return filename:match("%.([^%.]+)$")
end

local function organize_by_extension(source_dir, target_dir)
    target_dir = target_dir or (source_dir .. "_organized")
    
    logger.info("Organizing files from %s to %s", source_dir, target_dir)
    
    local files_moved = 0
    local directories_created = {}
    
    for file in lfs and lfs.dir(source_dir) or ipairs({}) do
        if file ~= "." and file ~= ".." then
            local filepath = source_dir .. "/" .. file
            local attr = lfs and lfs.attributes(filepath)
            
            if attr and attr.mode == "file" then
                local ext = get_file_extension(file)
                if ext then
                    ext = ext:lower()
                    local target_subdir = target_dir .. "/" .. ext
                    
                    if not directories_created[ext] then
                        local success = lfs and lfs.mkdir(target_subdir)
                        if success or utils.file_exists(target_subdir) then
                            directories_created[ext] = true
                            logger.debug("Created directory: %s", target_subdir)
                        else
                            logger.error("Failed to create directory: %s", target_subdir)
                            goto continue
                        end
                    end
                    
                    local target_filepath = target_subdir .. "/" .. file
                    local content = utils.read_file(filepath)
                    if content and utils.write_file(target_filepath, content) then
                        logger.debug("Moved %s -> %s", filepath, target_filepath)
                        files_moved = files_moved + 1
                    else
                        logger.error("Failed to move file: %s", file)
                    end
                else
                    logger.warn("File has no extension: %s", file)
                end
            end
            ::continue::
        end
    end
    
    logger.info("Organization complete. Moved %d files.", files_moved)
end

local function organize_by_date(source_dir, target_dir)
    target_dir = target_dir or (source_dir .. "_by_date")
    
    logger.info("Organizing files by date from %s to %s", source_dir, target_dir)
    
    local files_moved = 0
    
    for file in lfs and lfs.dir(source_dir) or ipairs({}) do
        if file ~= "." and file ~= ".." then
            local filepath = source_dir .. "/" .. file
            local attr = lfs and lfs.attributes(filepath)
            
            if attr and attr.mode == "file" then
                local date_folder = os.date("%Y-%m", attr.modification)
                local target_subdir = target_dir .. "/" .. date_folder
                
                local success = lfs and lfs.mkdir(target_subdir)
                if not success and not utils.file_exists(target_subdir) then
                    logger.error("Failed to create directory: %s", target_subdir)
                    goto continue
                end
                
                local target_filepath = target_subdir .. "/" .. file
                local content = utils.read_file(filepath)
                if content and utils.write_file(target_filepath, content) then
                    logger.debug("Moved %s -> %s", filepath, target_filepath)
                    files_moved = files_moved + 1
                else
                    logger.error("Failed to move file: %s", file)
                end
            end
            ::continue::
        end
    end
    
    logger.info("Date organization complete. Moved %d files.", files_moved)
end

local function main()
    local parser = argparse("file-organizer", "Organize files in directories")
    
    parser:argument("source", "Source directory to organize")
    parser:option("-t --target", "Target directory (default: source_organized)")
    parser:option("-m --mode", "Organization mode", "extension"):choices({"extension", "date"})
    parser:flag("-v --verbose", "Enable verbose logging")
    parser:flag("--dry-run", "Show what would be done without actually moving files")
    
    local args = parser:parse()
    
    if args.verbose then
        logger.set_level(logger.LOG_LEVELS.DEBUG)
    end
    
    if args.dry_run then
        logger.info("DRY RUN MODE - No files will be moved")
    end
    
    if not utils.file_exists(args.source) then
        logger.error("Source directory does not exist: %s", args.source)
        os.exit(1)
    end
    
    if args.mode == "extension" then
        organize_by_extension(args.source, args.target)
    elseif args.mode == "date" then
        organize_by_date(args.source, args.target)
    else
        logger.error("Unknown organization mode: %s", args.mode)
        os.exit(1)
    end
end

if not pcall(main) then
    logger.error("Failed to execute file organizer")
    os.exit(1)
end