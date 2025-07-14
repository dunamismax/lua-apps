local M = {}

function M.file_exists(path)
    local file = io.open(path, "r")
    if file then
        file:close()
        return true
    end
    return false
end

function M.read_file(path)
    local file = io.open(path, "r")
    if not file then
        return nil, "Could not open file: " .. path
    end
    local content = file:read("*all")
    file:close()
    return content
end

function M.write_file(path, content)
    local file = io.open(path, "w")
    if not file then
        return false, "Could not write to file: " .. path
    end
    file:write(content)
    file:close()
    return true
end

function M.deep_copy(original)
    local copy = {}
    for k, v in pairs(original) do
        if type(v) == "table" then
            copy[k] = M.deep_copy(v)
        else
            copy[k] = v
        end
    end
    return copy
end

function M.merge_tables(...)
    local result = {}
    for _, t in ipairs({...}) do
        for k, v in pairs(t) do
            result[k] = v
        end
    end
    return result
end

function M.split_string(str, delimiter)
    local result = {}
    local pattern = "([^" .. delimiter .. "]+)"
    for match in str:gmatch(pattern) do
        table.insert(result, match)
    end
    return result
end

function M.trim_string(str)
    return str:match("^%s*(.-)%s*$")
end

function M.slugify(str)
    return str:lower():gsub("[^%w%s%-]", ""):gsub("%s+", "-"):gsub("%-+", "-"):gsub("^%-", ""):gsub("%-$", "")
end

return M