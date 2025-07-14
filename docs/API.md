# API Documentation

## Shared Libraries API

### Utils (`shared/utils/init.lua`)

#### File Operations

##### `file_exists(path)`
Check if a file exists at the given path.
- **Parameters**: `path` (string) - File path to check
- **Returns**: `boolean` - True if file exists, false otherwise

##### `read_file(path)`
Read the entire contents of a file.
- **Parameters**: `path` (string) - File path to read
- **Returns**: `string|nil, string` - File contents or nil, error message

##### `write_file(path, content)`
Write content to a file.
- **Parameters**: 
  - `path` (string) - File path to write
  - `content` (string) - Content to write
- **Returns**: `boolean, string` - Success status, error message if failed

#### Data Manipulation

##### `deep_copy(original)`
Create a deep copy of a table.
- **Parameters**: `original` (table) - Table to copy
- **Returns**: `table` - Deep copy of the original table

##### `merge_tables(...)`
Merge multiple tables into one.
- **Parameters**: `...` (tables) - Tables to merge
- **Returns**: `table` - Merged table

#### String Operations

##### `split_string(str, delimiter)`
Split a string by delimiter.
- **Parameters**: 
  - `str` (string) - String to split
  - `delimiter` (string) - Delimiter character
- **Returns**: `table` - Array of string parts

##### `trim_string(str)`
Remove leading and trailing whitespace.
- **Parameters**: `str` (string) - String to trim
- **Returns**: `string` - Trimmed string

##### `slugify(str)`
Convert string to URL-safe slug.
- **Parameters**: `str` (string) - String to slugify
- **Returns**: `string` - URL-safe slug

### Logger (`shared/utils/logger.lua`)

#### Configuration

##### `set_level(level)`
Set the minimum logging level.
- **Parameters**: `level` (number) - One of `LOG_LEVELS` constants
- **Returns**: None

#### Logging Methods

##### `debug(message, ...)`
Log debug message (lowest priority).
- **Parameters**: 
  - `message` (string) - Message format string
  - `...` - Format arguments
- **Returns**: None

##### `info(message, ...)`
Log informational message.
- **Parameters**: 
  - `message` (string) - Message format string
  - `...` - Format arguments
- **Returns**: None

##### `warn(message, ...)`
Log warning message.
- **Parameters**: 
  - `message` (string) - Message format string
  - `...` - Format arguments
- **Returns**: None

##### `error(message, ...)`
Log error message (highest priority).
- **Parameters**: 
  - `message` (string) - Message format string
  - `...` - Format arguments
- **Returns**: None

#### Constants

```lua
LOG_LEVELS = {
    DEBUG = 1,
    INFO = 2,
    WARN = 3,
    ERROR = 4
}
```

### HTTP Client (`shared/networking/http_client.lua`)

#### Request Methods

##### `get(url, headers)`
Make HTTP GET request.
- **Parameters**:
  - `url` (string) - Request URL
  - `headers` (table, optional) - HTTP headers
- **Returns**: `table` - Response object

##### `post(url, data, headers)`
Make HTTP POST request.
- **Parameters**:
  - `url` (string) - Request URL
  - `data` (string) - Request body
  - `headers` (table, optional) - HTTP headers
- **Returns**: `table` - Response object

##### `put(url, data, headers)`
Make HTTP PUT request.
- **Parameters**:
  - `url` (string) - Request URL
  - `data` (string) - Request body
  - `headers` (table, optional) - HTTP headers
- **Returns**: `table` - Response object

##### `delete(url, headers)`
Make HTTP DELETE request.
- **Parameters**:
  - `url` (string) - Request URL
  - `headers` (table, optional) - HTTP headers
- **Returns**: `table` - Response object

#### Response Object

All HTTP methods return a response object with the following structure:

```lua
{
    body = "...",        -- Response body as string
    status = 200,        -- HTTP status code
    headers = {...},     -- Response headers table
    success = true       -- Boolean indicating 2xx status
}
```

### Database (`shared/database/sqlite.lua`)

#### Factory

##### `new(db_path)`
Create a new database connection.
- **Parameters**: `db_path` (string) - Path to SQLite database
- **Returns**: `table` - Database connection object

#### Connection Methods

##### `execute(sql, params)`
Execute SQL statement.
- **Parameters**:
  - `sql` (string) - SQL statement
  - `params` (table, optional) - Query parameters
- **Returns**: `table` - Result object

##### `select(sql, params)`
Execute SELECT query.
- **Parameters**:
  - `sql` (string) - SELECT statement
  - `params` (table, optional) - Query parameters
- **Returns**: `table` - Result with rows array

##### `insert(table_name, data)`
Insert data into table.
- **Parameters**:
  - `table_name` (string) - Target table name
  - `data` (table) - Data to insert
- **Returns**: `table` - Result with new record ID

##### `update(table_name, data, where_clause)`
Update records in table.
- **Parameters**:
  - `table_name` (string) - Target table name
  - `data` (table) - Data to update
  - `where_clause` (string) - WHERE condition
- **Returns**: `table` - Result with affected rows count

##### `delete(table_name, where_clause)`
Delete records from table.
- **Parameters**:
  - `table_name` (string) - Target table name
  - `where_clause` (string) - WHERE condition
- **Returns**: `table` - Result with affected rows count

##### `close()`
Close database connection.
- **Parameters**: None
- **Returns**: None

## CLI Applications API

### Todo Manager

Command-line interface for managing todo items.

#### Commands

```bash
luajit apps/cli/todo-manager.lua <command> [options]
```

##### `list`
List all todo items.

##### `add <text> [-d|--description <desc>]`
Add a new todo item.
- `text` - Todo item text (required)
- `-d, --description` - Optional description

##### `complete <index>`
Mark a todo item as completed.
- `index` - Todo item number (required)

##### `remove <index>`
Remove a todo item.
- `index` - Todo item number (required)

#### Global Options

- `-v, --verbose` - Enable verbose logging

### File Organizer

Command-line tool for organizing files.

#### Usage

```bash
luajit apps/cli/file-organizer.lua <source> [options]
```

#### Arguments

- `source` - Source directory to organize (required)

#### Options

- `-t, --target <dir>` - Target directory (default: source_organized)
- `-m, --mode <mode>` - Organization mode: `extension` or `date` (default: extension)
- `-v, --verbose` - Enable verbose logging
- `--dry-run` - Show what would be done without moving files

## Web API

### Blog API Endpoints

Base URL: `http://localhost:8080` (development)

#### `GET /`
Get API information and available endpoints.

**Response:**
```json
{
  "message": "Welcome to Lua Blog API",
  "version": "1.0.0",
  "endpoints": ["/posts", "/posts/:id", ...]
}
```

#### `GET /health`
Health check endpoint.

**Response:**
```json
{
  "status": "healthy",
  "timestamp": "2024-01-15 10:30:00",
  "uptime": "Available"
}
```

#### `GET /posts[?published=true|false]`
List all blog posts with optional filtering.

**Query Parameters:**
- `published` (optional) - Filter by published status

**Response:**
```json
{
  "posts": [...],
  "total": 3
}
```

#### `GET /posts/:id`
Get a specific blog post by ID.

**Response:**
```json
{
  "post": {
    "id": 1,
    "title": "Post Title",
    "content": "Post content...",
    "author": "Author Name",
    "created_at": "2024-01-15 10:30:00",
    "published": true
  }
}
```

#### `POST /posts`
Create a new blog post.

**Request Body:**
```json
{
  "title": "Post Title",
  "content": "Post content...",
  "author": "Author Name",
  "published": true
}
```

**Response:** `201 Created`
```json
{
  "message": "Post created successfully",
  "post": {...}
}
```

#### `PUT /posts/:id`
Update an existing blog post.

**Request Body:** Same as POST (all fields optional)

**Response:**
```json
{
  "message": "Post updated successfully",
  "post": {...}
}
```

#### `DELETE /posts/:id`
Delete a blog post.

**Response:**
```json
{
  "message": "Post deleted successfully",
  "post": {...}
}
```

### Error Responses

All endpoints may return error responses in the following format:

```json
{
  "error": "Error message description"
}
```

Common HTTP status codes:
- `400` - Bad Request (invalid parameters)
- `404` - Not Found (resource doesn't exist)
- `500` - Internal Server Error

## Static Site Generator API

### Generator Module (`apps/static-site/generator.lua`)

#### `generate_site(source_dir, output_dir, template_dir)`
Generate static site from markdown content.

**Parameters:**
- `source_dir` (string, optional) - Content directory (default: "content")
- `output_dir` (string, optional) - Output directory (default: "dist")
- `template_dir` (string, optional) - Templates directory (default: "templates")

**Returns:** None (generates files in output directory)

### Frontmatter Format

Content files support YAML-style frontmatter:

```yaml
---
title: Page Title
author: Author Name
date: 2024-01-15
published: true
tags: tag1, tag2
---

# Page Content

Markdown content here...
```

### Supported Markdown Features

- Headers (H1-H3)
- **Bold** and *italic* text
- `Inline code`
- [Links](https://example.com)
- Basic paragraph formatting

## Development Tools API

### Setup Tool (`tools/setup.lua`)

Environment setup and dependency installation tool.

**Usage:**
```bash
luajit tools/setup.lua
```

**Functions:**
- Check LuaJIT installation
- Verify LuaRocks availability
- Install project dependencies
- Create local configuration
- Set up Git hooks

### Test Runner (`tools/test-runner.lua`)

Comprehensive test suite runner.

**Usage:**
```bash
luajit tools/test-runner.lua
```

**Test Categories:**
- Syntax validation for all Lua files
- Unit tests for shared utilities
- Application integration tests
- Test report generation