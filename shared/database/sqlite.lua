local M = {}

function M.new(db_path)
    local sqlite = {}
    
    function sqlite:execute(sql, params)
        params = params or {}
        local success, err = pcall(function()
            print(string.format("Executing SQL: %s", sql))
            if #params > 0 then
                print(string.format("With params: %s", table.concat(params, ", ")))
            end
        end)
        
        return {
            success = true,
            message = "SQL executed successfully (mock implementation)"
        }
    end
    
    function sqlite:select(sql, params)
        params = params or {}
        print(string.format("Selecting with SQL: %s", sql))
        
        return {
            success = true,
            rows = {
                {id = 1, name = "Sample Record 1"},
                {id = 2, name = "Sample Record 2"}
            }
        }
    end
    
    function sqlite:insert(table_name, data)
        print(string.format("Inserting into %s: %s", table_name, table.concat(data, ", ")))
        return {
            success = true,
            id = math.random(1000, 9999)
        }
    end
    
    function sqlite:update(table_name, data, where_clause)
        print(string.format("Updating %s with %s where %s", table_name, table.concat(data, ", "), where_clause))
        return {
            success = true,
            affected_rows = 1
        }
    end
    
    function sqlite:delete(table_name, where_clause)
        print(string.format("Deleting from %s where %s", table_name, where_clause))
        return {
            success = true,
            affected_rows = 1
        }
    end
    
    function sqlite:close()
        print("Database connection closed")
    end
    
    return sqlite
end

return M