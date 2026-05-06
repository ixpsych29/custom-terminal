#!/usr/bin/env bash
set -e

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "==> Setting up custom-terminal"

# --- detect OS ---
if [ -f /etc/fedora-release ]; then
  OS="fedora"
elif [ -f /etc/debian_version ]; then
  OS="debian"
else
  OS="unknown"
fi

echo "OS detected: $OS"

# --- install base packages ---
if [ "$OS" = "fedora" ]; then
  sudo dnf install -y zsh git curl fastfetch kitty zsh-autosuggestions zsh-syntax-highlighting
elif [ "$OS" = "debian" ]; then
  sudo apt update
  sudo apt install -y zsh git curl fastfetch kitty

  # install zsh plugins manually (Ubuntu/Debian)
  mkdir -p "$HOME/.local/share/zsh"

  if [ ! -d "$HOME/.local/share/zsh/zsh-autosuggestions" ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions "$HOME/.local/share/zsh/zsh-autosuggestions"
  fi

  if [ ! -d "$HOME/.local/share/zsh/zsh-syntax-highlighting" ]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting "$HOME/.local/share/zsh/zsh-syntax-highlighting"
  fi
fi

# --- install fnm (idempotent) ---
if ! command -v fnm >/dev/null 2>&1; then
  curl -fsSL https://fnm.vercel.app/install | bash
fi

# --- ensure config dirs exist ---
mkdir -p "$HOME/.config/kitty"
mkdir -p "$HOME/.config/fastfetch"

# --- link zsh config ---
if [ -f "$REPO_DIR/zsh/.zshrc" ]; then
  ln -sf "$REPO_DIR/zsh/.zshrc" "$HOME/.zshrc"
else
  echo "ERROR: zsh config missing"
  exit 1
fi

# --- link kitty config ---
if [ -f "$REPO_DIR/kitty/kitty.conf" ]; then
  ln -sf "$REPO_DIR/kitty/kitty.conf" "$HOME/.config/kitty/kitty.conf"
fi

# --- setup fastfetch config (dynamic repo path) ---
if [ -f "$REPO_DIR/fastfetch/config.jsonc" ]; then
  sed "s|__REPO__|$REPO_DIR|g" \
    "$REPO_DIR/fastfetch/config.jsonc" \
    > "$HOME/.config/fastfetch/config.jsonc"
fi

# --- set zsh as default shell ---
if [ "$SHELL" != "$(command -v zsh)" ]; then
  chsh -s "$(command -v zsh)" || true
fi

echo "==> Installation complete"
echo "Restart terminal or run: exec zsh"
