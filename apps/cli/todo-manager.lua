#!/usr/bin/env luajit

local argparse = require("argparse")
local utils = require("shared.utils")
local logger = require("shared.utils.logger")

local TODO_FILE = "todos.json"

local function load_todos()
    if not utils.file_exists(TODO_FILE) then
        return {}
    end
    
    local content = utils.read_file(TODO_FILE)
    if not content then
        return {}
    end
    
    local success, todos = pcall(function()
        local json = require("dkjson") or require("cjson") or require("json")
        return json.decode(content)
    end)
    
    if not success then
        logger.warn("Could not parse todos file, starting with empty list")
        return {}
    end
    
    return todos or {}
end

local function save_todos(todos)
    local success, json_str = pcall(function()
        local json = require("dkjson") or require("cjson") or require("json")
        return json.encode(todos)
    end)
    
    if not success then
        logger.error("Could not encode todos to JSON")
        return false
    end
    
    local ok, err = utils.write_file(TODO_FILE, json_str)
    if not ok then
        logger.error("Failed to save todos: %s", err)
        return false
    end
    
    return true
end

local function list_todos()
    local todos = load_todos()
    
    if #todos == 0 then
        print("No todos found.")
        return
    end
    
    print("\nTodo List:")
    print("----------")
    
    for i, todo in ipairs(todos) do
        local status = todo.completed and "[✓]" or "[ ]"
        print(string.format("%d. %s %s", i, status, todo.text))
        if todo.description then
            print(string.format("   %s", todo.description))
        end
    end
    print()
end

local function add_todo(text, description)
    local todos = load_todos()
    
    local new_todo = {
        text = text,
        description = description,
        completed = false,
        created_at = os.date("%Y-%m-%d %H:%M:%S")
    }
    
    table.insert(todos, new_todo)
    
    if save_todos(todos) then
        logger.info("Todo added: %s", text)
    else
        logger.error("Failed to save todo")
    end
end

local function complete_todo(index)
    local todos = load_todos()
    
    if index < 1 or index > #todos then
        logger.error("Invalid todo index: %d", index)
        return
    end
    
    todos[index].completed = true
    todos[index].completed_at = os.date("%Y-%m-%d %H:%M:%S")
    
    if save_todos(todos) then
        logger.info("Todo completed: %s", todos[index].text)
    else
        logger.error("Failed to save todo")
    end
end

local function remove_todo(index)
    local todos = load_todos()
    
    if index < 1 or index > #todos then
        logger.error("Invalid todo index: %d", index)
        return
    end
    
    local removed_todo = table.remove(todos, index)
    
    if save_todos(todos) then
        logger.info("Todo removed: %s", removed_todo.text)
    else
        logger.error("Failed to save todo")
    end
end

local function main()
    local parser = argparse("todo", "A simple todo manager CLI application")
    
    parser:command("list", "List all todos")
    
    local add_cmd = parser:command("add", "Add a new todo")
    add_cmd:argument("text", "Todo text")
    add_cmd:option("-d --description", "Todo description")
    
    local complete_cmd = parser:command("complete", "Mark a todo as completed")
    complete_cmd:argument("index", "Todo index"):convert(tonumber)
    
    local remove_cmd = parser:command("remove", "Remove a todo")
    remove_cmd:argument("index", "Todo index"):convert(tonumber)
    
    parser:option("-v --verbose", "Enable verbose logging"):action("store_true")
    
    local args = parser:parse()
    
    if args.verbose then
        logger.set_level(logger.LOG_LEVELS.DEBUG)
    end
    
    if args.list then
        list_todos()
    elseif args.add then
        add_todo(args.text, args.description)
    elseif args.complete then
        complete_todo(args.index)
    elseif args.remove then
        remove_todo(args.index)
    else
        parser:error("No command specified")
    end
end

if not pcall(main) then
    logger.error("Failed to execute todo manager")
    os.exit(1)
end