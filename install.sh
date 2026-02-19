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

export PATH="$PATH:/opt/nvim-linux-x86_64/bin"

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

~/.tmux/plugins/tpm/bin/install_plugins
echo "Tmux plugins installed."

# --- Fish ---
echo "Installing fish..."
if ! command -v fish &> /dev/null; then
    # Add fish PPA for Ubuntu versions that don't have a recent fish in main repos
    if ! apt-cache show fish 2>/dev/null | grep -q "Version: 3"; then
        sudo apt-get install -y software-properties-common
        sudo apt-add-repository -y ppa:fish-shell/release-3
        sudo apt-get update -qq
    fi
    sudo apt-get install -y fish
    echo "Fish installed."
else
    echo "Fish already installed, skipping."
fi

ln -sfn "$DOTFILES/fish" ~/.config/fish
echo "Fish config symlinked."

# Set fish as default shell, fall back to exec fish in .bashrc if chsh fails
FISH_PATH=$(which fish)
if chsh -s "$FISH_PATH" 2>/dev/null; then
    echo "Default shell changed to fish."
else
    echo "Could not change default shell (chsh failed), adding 'exec fish' to ~/.bashrc."
    if ! grep -q "exec fish" ~/.bashrc 2>/dev/null; then
        echo -e '\n# Launch fish shell\nexec fish' >> ~/.bashrc
    fi
fi

# --- Claude Code ---
echo "Installing Claude Code..."
if ! command -v claude &> /dev/null; then
    curl -fsSL https://claude.ai/install.sh | bash
    echo "Claude Code installed."
else
    echo "Claude Code already installed, skipping."
fi

# --- Fisher + Fish plugins ---
echo "Installing fisher and fish plugins..."
fish -c "
    if not functions -q fisher
        curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source
        fisher install jorgebucaran/fisher
    end
    fisher update
" 2>/dev/null || echo "Fisher setup skipped (fish may not be fully configured yet)."

echo ""
echo "========================================"
echo "  Install Complete!"
echo "========================================"
echo "  nvim    -> $(nvim --version 2>/dev/null | head -1 || echo 'not found')"
echo "  tmux    -> $(tmux -V 2>/dev/null || echo 'not found')"
echo "  fish    -> $(fish --version 2>/dev/null || echo 'not found')"
echo "  claude  -> $(claude --version 2>/dev/null || echo 'not found')"
echo "========================================"
