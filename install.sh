#!/bin/bash
set -e

DOTFILES="$HOME/dotfiles"

echo "========================================"
echo "  Dotfiles Install"
echo "========================================"

# --- Neovim ---
echo "Installing neovim..."
if ! command -v nvim &> /dev/null; then
    curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
    sudo rm -rf /opt/nvim-linux-x86_64
    sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz
    rm nvim-linux-x86_64.tar.gz
    echo "Neovim installed."
else
    echo "Neovim already installed, skipping."
fi

sudo ln -sf /opt/nvim-linux-x86_64/bin/nvim /usr/local/bin/nvim

mkdir -p ~/.config
ln -sfn "$DOTFILES/nvim" ~/.config/nvim
echo "Neovim config symlinked."

# --- Tmux ---
echo "Installing tmux..."
if ! command -v tmux &> /dev/null; then
    sudo apt-get update -qq
    sudo apt-get install -y tmux
    echo "Tmux installed."
else
    echo "Tmux already installed, skipping."
fi

if [ ! -d ~/.tmux/plugins/tpm ]; then
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    echo "TPM installed."
else
    echo "TPM already installed, skipping."
fi

ln -sf "$DOTFILES/.tmux.conf" ~/.tmux.conf
echo "Tmux config symlinked."

TMUX_PLUGIN_MANAGER_PATH="$HOME/.tmux/plugins/" ~/.tmux/plugins/tpm/bin/install_plugins
echo "Tmux plugins installed."

# --- Alacritty ---
mkdir -p ~/.config/alacritty
ln -sf "$DOTFILES/alacritty.toml" ~/.config/alacritty/alacritty.toml
echo "Alacritty config symlinked."

# --- Claude Code ---
echo "Installing Claude Code..."
if ! command -v claude &> /dev/null; then
    curl -fsSL https://claude.ai/install.sh | bash
    sudo ln -sf "$HOME/.local/bin/claude" /usr/local/bin/claude
    echo "Claude Code installed."
else
    echo "Claude Code already installed, skipping."
fi

echo ""
echo "========================================"
echo "  Install Complete!"
echo "========================================"
echo "  nvim    -> $(nvim --version 2>/dev/null | head -1 || echo 'not found')"
echo "  tmux    -> $(tmux -V 2>/dev/null || echo 'not found')"
echo "  claude  -> $(claude --version 2>/dev/null || echo 'not found')"
echo "========================================"
