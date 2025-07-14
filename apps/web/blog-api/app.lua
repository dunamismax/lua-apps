local lapis = require("lapis")
local app = lapis.Application()
local utils = require("shared.utils")
local logger = require("shared.utils.logger")
local http_client = require("shared.networking.http_client")
local db = require("shared.database.sqlite")

local database = db.new("blog.db")

local posts = {
    {
        id = 1,
        title = "Welcome to Lua Lapis Blog",
        content = "This is a demo blog post built with the Lapis web framework for Lua. Lapis provides a fast and efficient way to build web applications.",
        author = "Lua Developer",
        created_at = "2024-01-15 10:30:00",
        published = true
    },
    {
        id = 2,
        title = "Building High-Performance Web APIs",
        content = "Learn how to leverage LuaJIT and OpenResty to build lightning-fast web APIs that can handle thousands of concurrent requests.",
        author = "Performance Expert",
        created_at = "2024-01-20 14:15:00",
        published = true
    },
    {
        id = 3,
        title = "Lua in Production",
        content = "Real-world experiences and best practices for running Lua applications in production environments.",
        author = "DevOps Engineer",
        created_at = "2024-01-25 09:45:00",
        published = false
    }
}

app:get("/", function(self)
    return { json = { 
        message = "Welcome to Lua Blog API",
        version = "1.0.0",
        endpoints = {
            "/posts",
            "/posts/:id",
            "/posts/published",
            "/health"
        }
    }}
end)

app:get("/health", function(self)
    return { json = { 
        status = "healthy",
        timestamp = os.date("%Y-%m-%d %H:%M:%S"),
        uptime = "Available"
    }}
end)

app:get("/posts", function(self)
    local query_published = self.params.published
    local filtered_posts = {}
    
    for _, post in ipairs(posts) do
        if not query_published or (query_published == "true" and post.published) or (query_published == "false" and not post.published) then
            table.insert(filtered_posts, post)
        end
    end
    
    return { json = {
        posts = filtered_posts,
        total = #filtered_posts
    }}
end)

app:get("/posts/published", function(self)
    local published_posts = {}
    
    for _, post in ipairs(posts) do
        if post.published then
            table.insert(published_posts, post)
        end
    end
    
    return { json = {
        posts = published_posts,
        total = #published_posts
    }}
end)

app:get("/posts/:id", function(self)
    local post_id = tonumber(self.params.id)
    
    if not post_id then
        self.status = 400
        return { json = { error = "Invalid post ID" }}
    end
    
    for _, post in ipairs(posts) do
        if post.id == post_id then
            return { json = { post = post }}
        end
    end
    
    self.status = 404
    return { json = { error = "Post not found" }}
end)

app:post("/posts", function(self)
    local body = self.params
    
    if not body.title or not body.content or not body.author then
        self.status = 400
        return { json = { error = "Missing required fields: title, content, author" }}
    end
    
    local new_post = {
        id = #posts + 1,
        title = body.title,
        content = body.content,
        author = body.author,
        created_at = os.date("%Y-%m-%d %H:%M:%S"),
        published = body.published == "true" or body.published == true
    }
    
    table.insert(posts, new_post)
    
    logger.info("Created new post: %s", new_post.title)
    
    self.status = 201
    return { json = { 
        message = "Post created successfully",
        post = new_post
    }}
end)

app:put("/posts/:id", function(self)
    local post_id = tonumber(self.params.id)
    local body = self.params
    
    if not post_id then
        self.status = 400
        return { json = { error = "Invalid post ID" }}
    end
    
    for i, post in ipairs(posts) do
        if post.id == post_id then
            posts[i].title = body.title or post.title
            posts[i].content = body.content or post.content
            posts[i].author = body.author or post.author
            if body.published ~= nil then
                posts[i].published = body.published == "true" or body.published == true
            end
            posts[i].updated_at = os.date("%Y-%m-%d %H:%M:%S")
            
            logger.info("Updated post: %s", posts[i].title)
            
            return { json = { 
                message = "Post updated successfully",
                post = posts[i]
            }}
        end
    end
    
    self.status = 404
    return { json = { error = "Post not found" }}
end)

app:delete("/posts/:id", function(self)
    local post_id = tonumber(self.params.id)
    
    if not post_id then
        self.status = 400
        return { json = { error = "Invalid post ID" }}
    end
    
    for i, post in ipairs(posts) do
        if post.id == post_id then
            local deleted_post = table.remove(posts, i)
            logger.info("Deleted post: %s", deleted_post.title)
            
            return { json = { 
                message = "Post deleted successfully",
                post = deleted_post
            }}
        end
    end
    
    self.status = 404
    return { json = { error = "Post not found" }}
end)

return app