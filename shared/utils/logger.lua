local M = {}

M.LOG_LEVELS = {
    DEBUG = 1,
    INFO = 2,
    WARN = 3,
    ERROR = 4
}

M.current_level = M.LOG_LEVELS.INFO

local function format_message(level, message, ...)
    local timestamp = os.date("%Y-%m-%d %H:%M:%S")
    local level_name = ""
    for name, value in pairs(M.LOG_LEVELS) do
        if value == level then
            level_name = name
            break
        end
    end
    
    if select("#", ...) > 0 then
        message = string.format(message, ...)
    end
    
    return string.format("[%s] %s: %s", timestamp, level_name, message)
end

function M.set_level(level)
    M.current_level = level
end

function M.debug(message, ...)
    if M.current_level <= M.LOG_LEVELS.DEBUG then
        print(format_message(M.LOG_LEVELS.DEBUG, message, ...))
    end
end

function M.info(message, ...)
    if M.current_level <= M.LOG_LEVELS.INFO then
        print(format_message(M.LOG_LEVELS.INFO, message, ...))
    end
end

function M.warn(message, ...)
    if M.current_level <= M.LOG_LEVELS.WARN then
        print(format_message(M.LOG_LEVELS.WARN, message, ...))
    end
end

function M.error(message, ...)
    if M.current_level <= M.LOG_LEVELS.ERROR then
        print(format_message(M.LOG_LEVELS.ERROR, message, ...))
    end
end

return M