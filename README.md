# custom-terminal

Portable terminal setup for **Zsh + Kitty + Fastfetch** with a custom image logo and cross-distro support (Fedora / Ubuntu / Debian).

---

## Features

* Zsh configuration with:

  * autosuggestions
  * syntax highlighting
* Kitty terminal configuration
* Fastfetch dashboard on startup
* Custom image logo (Kitty graphics protocol)
* Works across different Linux distributions
* No hardcoded paths (auto-resolves repo location)

---

## Requirements

* Linux (Fedora, Ubuntu, Debian)
* Internet connection (for package installs)

---

## Installation

```bash
git clone <your-repo-url> ~/custom-terminal
cd ~/custom-terminal
./install.sh
```

Then restart terminal or run:

```bash
exec zsh
```

---

## What it sets up

* Installs:

  * zsh
  * git
  * curl
  * fastfetch
  * kitty
* Installs zsh plugins:

  * autosuggestions
  * syntax highlighting
* Installs fnm (Node version manager)
* Symlinks configs:

  * `.zshrc`
  * `kitty.conf`
  * `fastfetch config`
* Sets zsh as default shell

---

## Project Structure

```
custom-terminal/
├── install.sh
├── zsh/
│   └── .zshrc
├── kitty/
│   └── kitty.conf
├── fastfetch/
│   └── config.jsonc
└── assets/
    └── logo.png
```

---

## Custom Logo

Replace the image (if you don't like the default one):

```
assets/sample_logo.png
```

Recommended:

* PNG format
* Transparent background
* Medium resolution (optimized for terminal)

---

## Fastfetch Configuration

* Uses Kitty image protocol (`type: kitty`)
* Path is dynamically injected during install
* No manual edits required

---

## Notes

* Designed to be **idempotent** (safe to run multiple times)
* Works regardless of where the repo is cloned
* Keeps system clean using symlinks instead of copying configs

---

## Troubleshooting

### Fastfetch image not showing

* Ensure you are using Kitty:

  ```bash
  echo $TERM
  ```

  Should be:

  ```
  xterm-kitty
  ```

### Zsh not default

```bash
chsh -s $(which zsh)
```

### Plugins not working

Restart terminal or:

```bash
source ~/.zshrc
```

---

## License

MIT (or your preferred license)

---

## Future Improvements

* Node + pnpm auto-install
* Font installation (Nerd Fonts)
* Git config integration
* Full dev environment bootstrap

---

