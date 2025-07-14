.PHONY: help setup test clean build install lint docs

LUA := luajit
LUAROCKS := luarocks

help:
	@echo "Lua Apps Monorepo"
	@echo "=================="
	@echo ""
	@echo "Available commands:"
	@echo "  setup    - Set up development environment"
	@echo "  test     - Run all tests"
	@echo "  lint     - Check code syntax"
	@echo "  build    - Build all applications"
	@echo "  clean    - Clean build artifacts"
	@echo "  install  - Install dependencies"
	@echo "  docs     - Generate documentation"
	@echo "  demo     - Run demo applications"
	@echo ""

setup:
	@echo "Setting up development environment..."
	$(LUA) tools/setup.lua

test:
	@echo "Running test suite..."
	$(LUA) tools/test-runner.lua

lint:
	@echo "Running syntax checks..."
	@find . -name "*.lua" -not -path "./luarocks_modules/*" | xargs -I {} $(LUA) -bl {}

build: build-static build-cli
	@echo "Build complete!"

build-static:
	@echo "Building static site..."
	@cd apps/static-site && $(LUA) build.lua

build-cli:
	@echo "CLI applications are ready to run"
	@echo "Usage: $(LUA) apps/cli/todo-manager.lua --help"

clean:
	@echo "Cleaning build artifacts..."
	@rm -rf apps/static-site/dist/
	@rm -f test-report.md
	@rm -f *.log

install:
	@echo "Installing Lua dependencies..."
	$(LUAROCKS) install argparse
	$(LUAROCKS) install lapis
	$(LUAROCKS) install lume
	$(LUAROCKS) install luasocket
	$(LUAROCKS) install lanes

docs:
	@echo "Documentation is available in the docs/ directory"
	@echo "Main README: README.md"

demo: demo-cli demo-static demo-web
	@echo "Demo complete!"

demo-cli:
	@echo "=== CLI Demo ==="
	@echo "Adding a sample todo..."
	$(LUA) apps/cli/todo-manager.lua add "Learn Lua programming" -d "Study Lua syntax and best practices"
	@echo "Listing todos..."
	$(LUA) apps/cli/todo-manager.lua list

demo-static:
	@echo "=== Static Site Demo ==="
	@cd apps/static-site && $(LUA) build.lua
	@echo "Static site built in apps/static-site/dist/"

demo-web:
	@echo "=== Web API Demo ==="
	@echo "Web API is available at apps/web/blog-api/"
	@echo "Run: cd apps/web/blog-api && lapis server"

dev-web:
	@echo "Starting web development server..."
	@cd apps/web/blog-api && lapis server development

dev-static:
	@echo "Building static site in watch mode..."
	@cd apps/static-site && while true; do $(LUA) build.lua; sleep 2; done