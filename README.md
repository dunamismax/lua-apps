<p align="center">
  <img src="lua-new.png" alt="Lua Image" width="400" />
</p>

<p align="center">
  <a href="https://github.com/dunamismax/lua-apps">
    <img src="https://readme-typing-svg.demolab.com/?font=Fira+Code&size=24&pause=1000&color=000080&center=true&vCenter=true&width=800&lines=Lua+Apps+Monorepo;Complete+Application+Development+Stack;CLI+%2B+Web+%2B+Mobile+%2B+Static+Sites;From+Command+Line+to+Cross+Platform;Pure+Lua%2C+Maximum+Versatility." alt="Typing SVG" />
  </a>
</p>

<p align="center">
  <a href="https://www.lua.org/"><img src="https://img.shields.io/badge/Lua-5.4+-000080.svg?logo=lua" alt="Lua Version"></a>
  <a href="https://luajit.org/"><img src="https://img.shields.io/badge/LuaJIT-2.1-blue.svg" alt="LuaJIT Version"></a>
  <a href="https://leafo.net/lapis/"><img src="https://img.shields.io/badge/Lapis-1.9+-green.svg" alt="Lapis Version"></a>
  <a href="https://solar2d.com/"><img src="https://img.shields.io/badge/Solar2D-2024-orange.svg" alt="Solar2D"></a>
  <a href="https://github.com/mpeterv/argparse"><img src="https://img.shields.io/badge/argparse-0.7+-red.svg" alt="argparse"></a>
  <a href="https://img.shields.io/github/license/dunamismax/lua-apps"><img src="https://img.shields.io/github/license/dunamismax/lua-apps" alt="License"></a>
  <a href="https://github.com/dunamismax/lua-apps/pulls"><img src="https://img.shields.io/badge/PRs-welcome-brightgreen.svg" alt="PRs Welcome"></a>
  <a href="https://github.com/dunamismax/lua-apps/stargazers"><img src="https://img.shields.io/github/stars/dunamismax/lua-apps" alt="GitHub Stars"></a>
</p>

---

## About This Project

A comprehensive, production-ready monorepo for application development using the complete Lua ecosystem. This repository demonstrates modern development workflows across multiple platforms, from command-line utilities to web APIs, mobile applications, and static site generation.

**Key Features:**

- **Complete Platform Coverage** - CLI, Web, Mobile, Desktop, and Static Sites all in one place
- **Production-Grade Structure** - Shared libraries, utilities, and organized project templates
- **Working Demo Applications** - Fully functional examples for each platform
- **Developer-Friendly Tools** - Scripts for setup, testing, building, and deployment
- **Comprehensive Documentation** - Guides, best practices, and API references
- **Cross-Platform Ready** - Support for all major operating systems and deployment targets

---

## Use This Template

This repository serves as a GitHub template, providing developers with a robust foundation for building Lua-based applications across multiple platforms. Rather than cloning, you can create your own repository instance with all essential infrastructure and demo applications pre-configured.

**To get started:**

1. Click the green **"Use this template"** button at the top right of this repository
2. Choose "Create a new repository"
3. Name your repository and set it to public or private
4. Click "Create repository from template"

This will create a new repository in your GitHub account with all the code, structure, and configuration files needed to start building applications immediately using the complete Lua development stack.

**Advantages of using the template:**

- Establishes a clean git history beginning with your initial commit
- Configures your repository as the primary origin (not a fork)
- Enables complete customization of repository name and description
- Provides full ownership and administrative control of the codebase

---

## Quick Start

### Prerequisites

- **[Lua/LuaJIT](https://www.lua.org/)** - The Lua programming language
- **[LuaRocks](https://luarocks.org/)** - Lua package manager
- **[Lapis](https://leafo.net/lapis/)** - Web framework (for web apps)
- **[Solar2D](https://solar2d.com/)** - Cross-platform framework (for mobile/desktop apps)

### Quick Setup

```bash
# 1. Clone and enter the repository
git clone https://github.com/dunamismax/lua-apps.git
cd lua-apps

# 2. Set up development environment
make setup

# 3. Run demo applications
make demo  # Show all available demos
make build  # Build all applications
make test   # Run comprehensive test suite
```

---

## Architecture

### Project Structure

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

---

<details>
<summary><strong>Click to expand: Technology Stack Details</strong></summary>

Below is a comprehensive, refined technology stack for application development using the Lua programming language. This stack is designed as a complete toolkit for creating cross-platform web, mobile, desktop, GUI, and CLI applications. Lua is celebrated for its simplicity, performance, and ease of integration, making this stack ideal for a wide range of projects, from simple utilities to complex applications.

### **Core Runtime: The Foundation of Your Application**

The high-performance core remains the same, providing the speed needed for demanding applications.

- [**LuaJIT**](https://luajit.org/luajit.html)
  - **Role:** High-Performance Lua Interpreter
  - **Description:** A Just-In-Time (JIT) compiler and high-performance interpreter for the Lua language. It significantly boosts execution speed, which is critical for demanding applications. LuaJIT is the foundation of this stack, enabling the performance required for modern development.

### **Application Frameworks**

This section is now broken down by application type for greater clarity, adding a crucial new category for native desktop GUI development.

### **Web Development**

- [**Lapis**](https://leafo.net/lapis/reference.html)
  - **Role:** High-Performance Web Framework
  - **Description:** A fast and flexible web framework for Lua that runs on OpenResty (a specialized Nginx). Lapis leverages Lua coroutines to handle a high number of concurrent requests, making it ideal for building scalable APIs and web applications.
- [**Satelito**](https://github.com/dpapavas/satelito)
  - **Role:** Static Site Generator
  - **Description:** A simple, elegant, and effective static site generator written in Lua. It's a prime example of a tool that compiles content from templates and Markdown into a set of static HTML files, perfect for blogs, documentation, and content-focused websites.

### **Mobile & Rich Interactive Apps**

- [**Solar2D**](https://docs.solar2d.com/)
  - **Role:** Cross-Platform Mobile and Desktop Framework
  - **Description:** A mature, free, and open-source framework for building 2D applications and games for all major platforms from a single codebase. Its strength lies in creating rich, interactive, and graphically-intensive applications.

### **Native Desktop GUI Applications**

- [**IUP**](https://www.tecgraf.puc-rio.br/iup/)
  - **Role:** Native GUI Toolkit
  - **Description:** A portable, cross-platform toolkit for building graphical user interfaces with native controls. IUP provides a simple API that allows Lua applications to have a conventional look and feel on Windows, Linux, and macOS, making it the ideal choice for creating traditional desktop tools and utilities.

### **Command-Line Interface (CLI)**

- [**argparse**](https://github.com/mpeterv/argparse)
  - **Role:** Command-Line Parsing Library
  - **Description:** A feature-rich command-line parser that simplifies the creation of professional CLI applications. It supports positional arguments, options, and sub-commands while automatically generating help and usage messages.

### **Core Libraries: A Curated & Expanded Toolset**

This section is expanded with dedicated categories for data handling and system operations—critical for application development.

### **Data Handling & Storage**

- [**LuaSQL**](https://keplerproject.github.io/luasql/)
  - **Role:** Database Connectivity
  - **Description:** A universal database interface that provides a consistent API for connecting to various SQL databases like MySQL, PostgreSQL, and SQLite through ODBC and native drivers.
- [**pgmoon**](https://github.com/leafo/pgmoon)
  - **Role:** PostgreSQL Driver
  - **Description:** A pure-Lua PostgreSQL driver that works seamlessly with Lapis and other frameworks. It supports asynchronous and blocking modes, making it a versatile choice for web applications connecting to PostgreSQL.
- [**lua-cjson**](https://www.kyne.com.au/~mark/software/lua-cjson.php)
  - **Role:** JSON Encoding/Decoding
  - **Description:** A high-performance JSON library implemented in C. It provides extremely fast encoding and decoding of JSON data, a critical task for web APIs and configuration management.

### **Networking & Concurrency**

- [**LuaSocket**](https://lunarmodules.github.io/luasocket/introduction.html)
  - **Role:** Low-Level Networking Library
  - **Description:** The foundational Lua library for network programming, providing straightforward access to low-level network protocols like TCP and UDP. It's the essential building block for most network-aware applications.
- [**Copas**](https://keplerproject.github.io/copas/)
  - **Role:** Asynchronous Task Dispatcher
  - **Description:** A library that simplifies creating concurrent, non-blocking network applications using Lua coroutines. Copas works on top of LuaSocket to handle many network connections simultaneously without the complexity of multithreading.
- [**Lanes**](https://github.com/LuaLanes/lanes)
  - **Role:** Multithreading Library
  - **Description:** An extension library that enables true multithreading by running parallel Lua states in separate OS threads. Lanes is essential for CPU-intensive tasks, allowing you to leverage multi-core systems to their full potential.

### **System & File Operations**

- [**LuaFileSystem (LFS)**](https://keplerproject.github.io/luafilesystem/manual.html)
  - **Role:** Filesystem Operations
  - **Description:** An indispensable library that provides a portable way to access the underlying file system. LFS allows you to work with directories, file attributes, and paths in a platform-independent manner.

### **Utility & Helpers**

- [**lume**](https://github.com/rxi/lume)
  - **Role:** General-Purpose Utility Library
  - **Description:** A collection of essential, well-tested helper functions that extends Lua's standard library. Lume provides a lightweight, focused set of tools for common tasks involving math, table manipulation, and functional programming.

### **Development, Tooling, & Quality Assurance**

This section is enhanced with dedicated tools for code quality and application distribution, mirroring professional development workflows.

### **Development Environments & Package Management**

- [**LuaRocks**](https://luarocks.org/learn)
  - **Role:** Package Manager
  - **Description:** The premier package manager for the Lua ecosystem. LuaRocks allows you to easily find, install, and manage Lua libraries and dependencies ("rocks"), streamlining project setup.

### **Quality Assurance**

- [**busted**](https://lunarmodules.github.io/busted/)
  - **Role:** Unit Testing Framework
  - **Description:** The most popular testing framework for Lua, enabling you to write and run automated tests for your application's logic. Adopting unit testing is critical for ensuring code correctness and refactoring with confidence.
- [**luacheck**](https://github.com/mpeterv/luacheck)
  - **Role:** Static Analyzer & Linter
  - **Description:** A tool that analyzes your code to detect issues like unused variables, undefined globals, and syntax errors before you run your application. Integrating a linter is a best practice for maintaining high-quality, bug-free code.

### **Build & Distribution**

- [**luastatic**](https://github.com/ers35/luastatic)
  - **Role:** Single-File Executable Builder
  - **Description:** A tool to bundle a Lua script and its dependencies into a single, standalone executable. This is essential for distributing CLI tools or desktop applications to users who do not have a Lua interpreter installed.

</details>

---

## Demo Applications

This monorepo includes four fully functional demo applications showcasing each platform:

### 💻 **CLI Applications** (Lua + argparse)

Professional command-line tools with full argument parsing and help systems.

**Todo Manager** - Full-featured task management with JSON persistence
**File Organizer** - Intelligent file organization by extension or date

### 🌐 **Web Applications** (Lapis)

High-performance web services built on OpenResty with asynchronous request handling.

**Blog API** - RESTful service with full CRUD operations, JSON responses, and health monitoring

### 📝 **Static Site Generator** (Custom Lua)

Fast static site generation with modern web development features.

**Markdown Processor** - YAML frontmatter support, template rendering, and lightning-fast generation

### 📱 **Mobile & Desktop App** (Solar2D)

Cross-platform application demonstrating native app development capabilities.

**Interactive Demo** - Physics simulation, UI widgets, data persistence, and touch/click interactions

---

## Development

### Creating New Applications

```bash
# Use the convenient make targets for rapid development
make new-cli-app NAME=my-tool         # Create new CLI application
make new-web-app NAME=my-api          # Create new web service
make new-static-site NAME=my-blog     # Create new static site
make new-mobile-app NAME=my-app       # Create new Solar2D project

# Or copy and customize existing demo applications
cp -r apps/cli/todo-manager apps/cli/my-new-tool
cp -r apps/web/blog-api apps/web/my-new-api
```

### Building and Testing

```bash
# Development workflow
make setup        # Set up development environment
make test         # Run comprehensive test suite
make build        # Build all applications
make demo         # Try all demo applications

# Individual application testing
luajit apps/cli/todo-manager.lua --help      # Test CLI app
cd apps/web/blog-api && lapis server         # Test web app
cd apps/static-site && luajit build.lua      # Test static generator
```

### Quality Assurance

```bash
# Code quality and validation
make lint         # Check Lua syntax across all files
make test         # Run unit tests and integration tests
make clean        # Clean build artifacts and temporary files
```

---

## Shared Libraries Usage

The monorepo provides battle-tested libraries for common development patterns:

```lua
-- Utility functions
local utils = require("shared.utils")
local content = utils.read_file("config.txt")
local slug = utils.slugify("My Blog Post Title")

-- Structured logging
local logger = require("shared.utils.logger")
logger.info("Application started")
logger.error("Failed to connect: %s", error_message)

-- HTTP client for web services
local http = require("shared.networking.http_client")
local response = http.get("https://api.example.com/data")
if response.success then
    print("Data received:", response.body)
end

-- Database operations (mock implementation)
local db = require("shared.database.sqlite")
local conn = db.new("app.db")
local result = conn:select("SELECT * FROM users")
```

---

## Documentation

- **[API Documentation](docs/API.md)** - Complete API reference for all shared libraries
- **[Getting Started Guide](docs/getting-started.md)** - Step-by-step tutorial for new developers
- **[Best Practices](docs/best-practices.md)** - Professional development patterns and conventions
- **[Examples](examples/)** - Working code examples and tutorials

---

## Support This Project

If you find this project valuable for your application development journey, consider supporting its continued development:

<p align="center">
  <a href="https://www.buymeacoffee.com/dunamismax" target="_blank">
    <img src="https://cdn.buymeacoffee.com/buttons/v2/default-yellow.png" alt="Buy Me A Coffee" style="height: 60px !important;width: 217px !important;" />
  </a>
</p>

---

## Let's Connect

<p align="center">
  <a href="https://twitter.com/dunamismax" target="_blank"><img src="https://img.shields.io/badge/Twitter-%231DA1F2.svg?&style=for-the-badge&logo=twitter&logoColor=white" alt="Twitter"></a>
  <a href="https://bsky.app/profile/dunamismax.bsky.social" target="_blank"><img src="https://img.shields.io/badge/Bluesky-blue?style=for-the-badge&logo=bluesky&logoColor=white" alt="Bluesky"></a>
  <a href="https://reddit.com/user/dunamismax" target="_blank"><img src="https://img.shields.io/badge/Reddit-%23FF4500.svg?&style=for-the-badge&logo=reddit&logoColor=white" alt="Reddit"></a>
  <a href="https://discord.com/users/dunamismax" target="_blank"><img src="https://img.shields.io/badge/Discord-dunamismax-7289DA.svg?style=for-the-badge&logo=discord&logoColor=white" alt="Discord"></a>
  <a href="https://signal.me/#p/+dunamismax.66" target="_blank"><img src="https://img.shields.io/badge/Signal-dunamismax.66-3A76F0.svg?style=for-the-badge&logo=signal&logoColor=white" alt="Signal"></a>
</p>

---

## License

This project is licensed under the **MIT License** - see the [LICENSE](LICENSE) file for details.

---

<p align="center">
  <strong>Built with Lua</strong><br>
  <sub>A comprehensive foundation for application development across all platforms</sub>
</p>
