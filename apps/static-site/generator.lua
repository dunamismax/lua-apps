#!/usr/bin/env luajit

local utils = require("shared.utils")
local logger = require("shared.utils.logger")

local M = {}

local function parse_frontmatter(content)
    local frontmatter = {}
    local body = content
    
    if content:match("^---\n") then
        local fm_end = content:find("\n---\n", 4)
        if fm_end then
            local fm_text = content:sub(4, fm_end - 1)
            body = content:sub(fm_end + 5)
            
            for line in fm_text:gmatch("[^\n]+") do
                local key, value = line:match("^([^:]+):%s*(.+)$")
                if key and value then
                    key = utils.trim_string(key)
                    value = utils.trim_string(value)
                    
                    if value:match("^%d+$") then
                        frontmatter[key] = tonumber(value)
                    elseif value:lower() == "true" then
                        frontmatter[key] = true
                    elseif value:lower() == "false" then
                        frontmatter[key] = false
                    else
                        value = value:gsub("^[\"']", ""):gsub("[\"']$", "")
                        frontmatter[key] = value
                    end
                end
            end
        end
    end
    
    return frontmatter, body
end

local function markdown_to_html(markdown)
    local html = markdown
    
    html = html:gsub("\n# ([^\n]+)", "\n<h1>%1</h1>")
    html = html:gsub("\n## ([^\n]+)", "\n<h2>%1</h2>")
    html = html:gsub("\n### ([^\n]+)", "\n<h3>%1</h3>")
    
    html = html:gsub("%*%*([^%*]+)%*%*", "<strong>%1</strong>")
    html = html:gsub("%*([^%*]+)%*", "<em>%1</em>")
    html = html:gsub("`([^`]+)`", "<code>%1</code>")
    
    html = html:gsub("%[([^%]]+)%]%(([^%)]+)%)", '<a href="%2">%1</a>')
    
    html = html:gsub("\n\n+", "\n</p>\n<p>\n")
    html = "<p>\n" .. html .. "\n</p>"
    
    html = html:gsub("<p>\n<h([1-6])>", "<h%1>")
    html = html:gsub("</h([1-6])>\n</p>", "</h%1>")
    
    return html
end

local function render_template(template, data)
    local result = template
    
    for key, value in pairs(data) do
        local pattern = "{{%s*" .. key .. "%s*}}"
        result = result:gsub(pattern, tostring(value))
    end
    
    return result
end

function M.generate_site(source_dir, output_dir, template_dir)
    source_dir = source_dir or "content"
    output_dir = output_dir or "dist"
    template_dir = template_dir or "templates"
    
    logger.info("Generating static site...")
    logger.info("Source: %s", source_dir)
    logger.info("Output: %s", output_dir)
    logger.info("Templates: %s", template_dir)
    
    local base_template = utils.read_file(template_dir .. "/base.html") or [[
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>{{title}}</title>
    <style>
        body { font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif; max-width: 800px; margin: 0 auto; padding: 20px; line-height: 1.6; }
        h1, h2, h3 { color: #333; }
        code { background: #f4f4f4; padding: 2px 4px; border-radius: 3px; }
        a { color: #0066cc; }
    </style>
</head>
<body>
    <nav>
        <h1><a href="/">My Static Site</a></h1>
    </nav>
    <main>
        {{content}}
    </main>
    <footer>
        <p>Generated with Lua Static Site Generator</p>
    </footer>
</body>
</html>
]]
    
    local content_files = {
        "index.md",
        "about.md",
        "posts/hello-world.md",
        "posts/lua-web-development.md"
    }
    
    for _, file_path in ipairs(content_files) do
        local full_path = source_dir .. "/" .. file_path
        local content = utils.read_file(full_path)
        
        if content then
            logger.debug("Processing: %s", file_path)
            
            local frontmatter, body = parse_frontmatter(content)
            local html_content = markdown_to_html(body)
            
            local template_data = utils.merge_tables(frontmatter, {
                content = html_content,
                title = frontmatter.title or "Untitled",
                date = frontmatter.date or os.date("%Y-%m-%d"),
                url = file_path:gsub("%.md$", ".html")
            })
            
            local final_html = render_template(base_template, template_data)
            
            local output_path = output_dir .. "/" .. file_path:gsub("%.md$", ".html")
            local output_success = utils.write_file(output_path, final_html)
            
            if output_success then
                logger.debug("Generated: %s", output_path)
            else
                logger.error("Failed to write: %s", output_path)
            end
        else
            logger.warn("Could not read content file: %s", full_path)
        end
    end
    
    logger.info("Static site generation completed!")
end

return M