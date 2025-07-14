local socket = require("socket")
local http = require("socket.http")
local url = require("socket.url")
local ltn12 = require("ltn12")

local M = {}

function M.get(request_url, headers)
    headers = headers or {}
    local response_body = {}
    
    local result, status_code, response_headers = http.request {
        url = request_url,
        method = "GET",
        headers = headers,
        sink = ltn12.sink.table(response_body)
    }
    
    return {
        body = table.concat(response_body),
        status = status_code,
        headers = response_headers,
        success = status_code and status_code >= 200 and status_code < 300
    }
end

function M.post(request_url, data, headers)
    headers = headers or {}
    headers["Content-Type"] = headers["Content-Type"] or "application/json"
    headers["Content-Length"] = tostring(#data)
    
    local response_body = {}
    
    local result, status_code, response_headers = http.request {
        url = request_url,
        method = "POST",
        headers = headers,
        source = ltn12.source.string(data),
        sink = ltn12.sink.table(response_body)
    }
    
    return {
        body = table.concat(response_body),
        status = status_code,
        headers = response_headers,
        success = status_code and status_code >= 200 and status_code < 300
    }
end

function M.put(request_url, data, headers)
    headers = headers or {}
    headers["Content-Type"] = headers["Content-Type"] or "application/json"
    headers["Content-Length"] = tostring(#data)
    
    local response_body = {}
    
    local result, status_code, response_headers = http.request {
        url = request_url,
        method = "PUT",
        headers = headers,
        source = ltn12.source.string(data),
        sink = ltn12.sink.table(response_body)
    }
    
    return {
        body = table.concat(response_body),
        status = status_code,
        headers = response_headers,
        success = status_code and status_code >= 200 and status_code < 300
    }
end

function M.delete(request_url, headers)
    headers = headers or {}
    local response_body = {}
    
    local result, status_code, response_headers = http.request {
        url = request_url,
        method = "DELETE",
        headers = headers,
        sink = ltn12.sink.table(response_body)
    }
    
    return {
        body = table.concat(response_body),
        status = status_code,
        headers = response_headers,
        success = status_code and status_code >= 200 and status_code < 300
    }
end

return M