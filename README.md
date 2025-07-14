# Lua Apps Monorepo

A comprehensive monorepo for building various types of applications using the Lua programming language and its ecosystem. This repository demonstrates the versatility of Lua for web development, mobile apps, desktop applications, CLI tools, and static site generation.

## 🚀 Quick Start

```bash
# Set up the development environment
make setup

# Run all tests
make test

# Build all applications
make build

# Try the demo applications
make demo
```

## 📁 Repository Structure

```
lua-apps/
├── apps/                          # Application projects
│   ├── cli/                       # Command-line applications
│   │   ├── todo-manager.lua       # Todo list manager
│   │   └── file-organizer.lua     # File organization tool
│   ├── web/                       # Web applications
│   │   └── blog-api/              # REST API built with Lapis
│   ├── static-site/               # Static site generator
│   │   ├── content/               # Markdown content
│   │   ├── templates/             # HTML templates
│   │   └── generator.lua          # Site generator
│   └── mobile-desktop/            # Cross-platform apps
│       └── solar2d-demo/          # Solar2D demo application
├── shared/                        # Shared libraries and utilities
│   ├── utils/                     # Common utilities
│   ├── networking/                # HTTP client and networking
│   └── database/                  # Database abstractions
├── tools/                         # Development tools
│   ├── setup.lua                  # Environment setup
│   └── test-runner.lua            # Test automation
├── docs/                          # Documentation
└── examples/                      # Code examples
```

## 🛠️ Technology Stack

### Core Runtime
- **[LuaJIT](https://luajit.org/)** - High-performance Lua interpreter with JIT compilation

### Web Development
- **[Lapis](https://leafo.net/lapis/)** - Fast web framework running on OpenResty
- **Custom Static Site Generator** - Markdown-based content management

### Mobile & Desktop
- **[Solar2D](https://solar2d.com/)** - Cross-platform framework for iOS, Android, Windows, macOS, and Linux

### CLI Development
- **[argparse](https://github.com/mpeterv/argparse)** - Command-line argument parsing

### Core Libraries
- **[LuaSocket](https://lunarmodules.github.io/luasocket/)** - Networking library
- **[lua-http](https://daurnimator.github.io/lua-http/)** - HTTP/WebSocket library
- **[Lanes](https://github.com/LuaLanes/lanes)** - Multithreading support
- **[lume](https://github.com/rxi/lume)** - Utility functions

## 🏗️ Applications

### CLI Applications

#### Todo Manager (`apps/cli/todo-manager.lua`)
A full-featured command-line todo list manager.

```bash
# Add a todo
luajit apps/cli/todo-manager.lua add "Learn Lua" -d "Study Lua programming"

# List all todos
luajit apps/cli/todo-manager.lua list

# Complete a todo
luajit apps/cli/todo-manager.lua complete 1

# Remove a todo
luajit apps/cli/todo-manager.lua remove 1
```

#### File Organizer (`apps/cli/file-organizer.lua`)
Organize files by extension or date.

```bash
# Organize by file extension
luajit apps/cli/file-organizer.lua /path/to/messy/folder -m extension

# Organize by modification date
luajit apps/cli/file-organizer.lua /path/to/photos -m date
```

### Web Applications

#### Blog API (`apps/web/blog-api/`)
RESTful API built with the Lapis web framework.

```bash
# Start the development server
cd apps/web/blog-api
lapis server development

# API will be available at http://localhost:8080
```

**API Endpoints:**
- `GET /` - API information
- `GET /posts` - List all posts
- `GET /posts/:id` - Get specific post
- `POST /posts` - Create new post
- `PUT /posts/:id` - Update post
- `DELETE /posts/:id` - Delete post
- `GET /health` - Health check

### Static Site Generator

#### Features (`apps/static-site/`)
- Markdown to HTML conversion
- YAML frontmatter support
- Template rendering
- Fast generation with LuaJIT

```bash
# Build the static site
cd apps/static-site
luajit build.lua

# Output will be in the 'dist' directory
```

### Mobile & Desktop Applications

#### Solar2D Demo (`apps/mobile-desktop/solar2d-demo/`)
Cross-platform application demonstrating:
- Interactive UI elements
- Physics simulation
- Data persistence
- Cross-platform compatibility

Open the project in Solar2D Simulator or build for your target platform.

## 🔧 Development

### Prerequisites

- **LuaJIT** 2.0 or higher
- **LuaRocks** package manager
- **Make** (optional, for convenience commands)

### Setup

1. Clone the repository:
```bash
git clone https://github.com/dunamismax/lua-apps.git
cd lua-apps
```

2. Run the setup script:
```bash
make setup
# or
luajit tools/setup.lua
```

3. Install dependencies:
```bash
make install
# or manually:
luarocks install argparse
luarocks install lapis
luarocks install lume
luarocks install luasocket
luarocks install lanes
```

### Available Commands

```bash
make help          # Show all available commands
make setup          # Set up development environment
make test           # Run all tests
make lint           # Check code syntax
make build          # Build all applications
make clean          # Clean build artifacts
make demo           # Run demo applications
make dev-web        # Start web development server
make dev-static     # Build static site in watch mode
```

### Testing

Run the comprehensive test suite:

```bash
make test
# or
luajit tools/test-runner.lua
```

Tests include:
- Lua syntax validation
- Unit tests for shared utilities
- Application integration tests
- Test report generation

## 📚 Documentation

### Shared Libraries

#### Utils (`shared/utils/init.lua`)
Common utility functions for file operations, string manipulation, and data processing.

#### Logger (`shared/utils/logger.lua`)
Structured logging with configurable levels (DEBUG, INFO, WARN, ERROR).

#### HTTP Client (`shared/networking/http_client.lua`)
Simple HTTP client for making REST API calls.

#### Database (`shared/database/sqlite.lua`)
SQLite database abstraction layer (mock implementation).

### Best Practices

1. **Code Organization**: Keep related functionality in modules
2. **Error Handling**: Use proper error checking and logging
3. **Performance**: Leverage LuaJIT for performance-critical code
4. **Testing**: Write tests for all shared utilities
5. **Documentation**: Document public APIs and complex functions

## 🌟 Features Showcase

### 1. High Performance
- LuaJIT JIT compilation for maximum speed
- Asynchronous request handling in web applications
- Efficient memory usage

### 2. Cross-Platform
- Solar2D apps run on iOS, Android, Windows, macOS, Linux
- CLI tools work on any system with Lua
- Web applications deployable anywhere

### 3. Modern Development
- Package management with LuaRocks
- Automated testing and linting
- Git hooks for code quality
- Comprehensive build system

### 4. Real-World Ready
- Proper error handling and logging
- Configuration management
- Data persistence
- Production deployment considerations

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Add tests for new functionality
4. Ensure all tests pass: `make test`
5. Submit a pull request

## 📄 License

MIT License - see LICENSE file for details.

## 🔗 Resources

- [Lua Official Site](https://www.lua.org/)
- [LuaJIT](https://luajit.org/)
- [Lapis Framework](https://leafo.net/lapis/)
- [Solar2D](https://solar2d.com/)
- [LuaRocks](https://luarocks.org/)

---

**Built with ❤️ and Lua**

This monorepo demonstrates that Lua is not just a configuration or scripting language—it's a powerful, versatile tool capable of building modern applications across all platforms.