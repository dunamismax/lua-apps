---
title: About This Project
description: Learn about the Lua static site generator
author: Lua Developer
date: 2024-01-15
---

# About This Project

This static site generator is part of a comprehensive Lua application monorepo that demonstrates the versatility and power of the Lua programming language.

## Technology Stack

This site is built using:

- **LuaJIT**: High-performance Lua interpreter
- **Custom Markdown Parser**: Built-in Lua for fast processing
- **Template Engine**: Simple yet powerful templating system
- **Shared Utilities**: Reusable components from the monorepo

## Features

### Markdown Support
Write your content in Markdown and let the generator handle the HTML conversion. Supports:
- Headers (H1-H3)
- **Bold** and *italic* text
- `Inline code`
- [Links](https://lua.org)

### Frontmatter
Each content file can include YAML-style frontmatter for metadata:

```yaml
---
title: Page Title
author: Author Name
date: 2024-01-15
published: true
---
```

### Fast Generation
Thanks to LuaJIT's performance, this generator can process hundreds of pages in seconds.

## Extensibility

The generator is designed to be easily extensible. You can:
- Add new template types
- Extend the Markdown parser
- Create custom data processors
- Integrate with external APIs

## Source Code

This project is part of the lua-apps monorepo, showcasing best practices for Lua application development.