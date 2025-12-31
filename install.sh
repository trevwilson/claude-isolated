#!/usr/bin/bash
# Install claude-isolated and bash completions

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Default install locations (user-local)
BIN_DIR="${HOME}/.local/bin"
COMPLETION_DIR="${HOME}/.local/share/bash-completion/completions"

# Parse flags
USE_SYSTEM=false
while [[ $# -gt 0 ]]; do
    case "$1" in
        --system)
            USE_SYSTEM=true
            BIN_DIR="/usr/local/bin"
            COMPLETION_DIR="/etc/bash_completion.d"
            shift
            ;;
        -h|--help)
            echo "Usage: install.sh [--system]"
            echo ""
            echo "Installs claude-isolated and bash completions."
            echo ""
            echo "Options:"
            echo "  --system    Install system-wide (requires sudo)"
            echo "              Default: installs to ~/.local/bin"
            exit 0
            ;;
        *)
            echo "Unknown option: $1"
            exit 1
            ;;
    esac
done

# Create directories if needed
mkdir -p "$BIN_DIR"
mkdir -p "$COMPLETION_DIR"

# Install main script
if $USE_SYSTEM; then
    sudo cp "$SCRIPT_DIR/claude-isolated" "$BIN_DIR/claude-isolated"
    sudo chmod +x "$BIN_DIR/claude-isolated"
else
    cp "$SCRIPT_DIR/claude-isolated" "$BIN_DIR/claude-isolated"
    chmod +x "$BIN_DIR/claude-isolated"
fi
echo "Installed claude-isolated to $BIN_DIR/claude-isolated"

# Install completion (strip .bash extension)
if $USE_SYSTEM; then
    sudo cp "$SCRIPT_DIR/completions/claude-isolated.bash" "$COMPLETION_DIR/claude-isolated"
else
    cp "$SCRIPT_DIR/completions/claude-isolated.bash" "$COMPLETION_DIR/claude-isolated"
fi
echo "Installed completions to $COMPLETION_DIR/claude-isolated"

# Check if BIN_DIR is in PATH
if [[ ":$PATH:" != *":$BIN_DIR:"* ]]; then
    echo ""
    echo "Note: $BIN_DIR is not in your PATH."
    echo "Add this to your ~/.bashrc:"
    echo "  export PATH=\"$BIN_DIR:\$PATH\""
fi

echo ""
echo "Done! Open a new terminal to use claude-isolated with tab completion."
