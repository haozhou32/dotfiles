# CLAUDE.md


## Development Preferences

- Always ask before running destructive commands
- After compiling a LaTeX document, clean up auxiliary files

## Code Style

- Prefer readable code over clever optimizations

## Tools and Workflows

- Use `uv` instead of `pip` for Python package management
  - `uv pip install <package>` to install packages
  - `uv pip compile` for dependency resolution
  - `uv venv` to create virtual environments
- Use `latexmk -pdf` to compile LaTeX documents
- Use `latexmk -c` to clean up LaTeX auxiliary files

