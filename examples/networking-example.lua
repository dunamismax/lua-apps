#!/usr/bin/env luajit

package.path = package.path .. ";../shared/?.lua"

local http_client = require("shared.networking.http_client")
local logger = require("shared.utils.logger")

logger.set_level(logger.LOG_LEVELS.INFO)

local function example_api_calls()
    logger.info("Starting networking examples...")
    
    logger.info("1. Making a GET request to httpbin.org...")
    local response = http_client.get("https://httpbin.org/get", {
        ["User-Agent"] = "Lua HTTP Client Example"
    })
    
    if response.success then
        logger.info("GET request successful!")
        logger.info("Status: %s", response.status)
        logger.info("Response body (first 200 chars): %s", 
                   response.body:sub(1, 200) .. (response.body:len() > 200 and "..." or ""))
    else
        logger.error("GET request failed with status: %s", response.status)
    end
    
    logger.info("\n2. Making a POST request...")
    local post_data = '{"message": "Hello from Lua!", "timestamp": "' .. os.date("%Y-%m-%d %H:%M:%S") .. '"}'
    local post_response = http_client.post("https://httpbin.org/post", post_data, {
        ["Content-Type"] = "application/json",
        ["User-Agent"] = "Lua HTTP Client Example"
    })
    
    if post_response.success then
        logger.info("POST request successful!")
        logger.info("Status: %s", post_response.status)
    else
        logger.error("POST request failed with status: %s", post_response.status)
    end
    
    logger.info("\n3. Testing error handling...")
    local error_response = http_client.get("https://httpbin.org/status/404")
    
    if not error_response.success then
        logger.info("Expected 404 error received: %s", error_response.status)
    else
        logger.warn("Expected error but got success: %s", error_response.status)
    end
    
    logger.info("\nNetworking examples completed!")
end

local function safe_example()
    local success, error_msg = pcall(example_api_calls)
    
    if not success then
        logger.error("Example failed with error: %s", error_msg)
        logger.info("This might be due to network connectivity or missing dependencies.")
        logger.info("Make sure you have luasocket installed: luarocks install luasocket")
    end
end

safe_example()