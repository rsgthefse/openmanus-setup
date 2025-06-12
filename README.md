# OpenManus Easy Setup Guide

This guide will help you easily configure, install and launch OpenManus on Windows using WSL (Windows Subsystem for Linux).

## Prerequisites

- Windows 11 with PowerShell access
- Administrator privileges

## Step 1: Install WSL

Open PowerShell as Administrator and run:

```powershell
wsl --install
```

## Step 2: Create Setup Script

Navigate to your home directory and create the setup script:

```bash
cd ~
nano setup_openmanus.sh
```

Copy and paste the following script content:

```bash
#!/bin/bash
set -e # Exit on any error
set -o pipefail

# 1. Install `uv`
echo "[+] Installing uv package manager..."
curl -LsSf https://astral.sh/uv/install.sh | sh

# 2. Update PATH
export PATH="$HOME/.local/bin:$PATH"
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc

# 3. Clone OpenManus
echo "[+] Cloning OpenManus repository..."
git clone https://github.com/FoundationAgents/OpenManus.git
cd OpenManus

# 4. Create virtual environment
echo "[+] Setting up Python 3.12 virtual environment with uv..."
uv venv --python 3.12
source .venv/bin/activate

# 5. Install Python dependencies
echo "[+] Installing Python dependencies..."
uv pip install -r requirements.txt

# 6. Install system dependencies for Playwright
echo "[+] Installing Playwright system dependencies..."
playwright install-deps

# Additional packages often required for proper Playwright operation
echo "[+] Installing additional system libraries..."
sudo apt-get update
sudo apt-get install -y libnss3 libnspr4 libasound2t64

# 7. Install Playwright browsers
echo "[+] Installing Playwright browsers..."
playwright install

# 8. Optionally install Firefox (snap)
echo "[+] Installing Firefox via snap..."
sudo snap install firefox

# 8b. Add /snap/bin to PATH if not already included
if ! echo "$PATH" | grep -q "/snap/bin"; then
    echo 'export PATH="/snap/bin:$PATH"' >> ~/.bashrc
    export PATH="/snap/bin:$PATH"
    echo "[+] Added /snap/bin to PATH"
fi

# 9. Prompt for editing config
echo
echo "⚠️ Please edit your config file with your Anthropic API key:"
echo "Press ENTER to continue and open the config editor..."
read
nano config/config.toml

# 10. Start the app
echo "[+] Launching OpenManus..."
python main.py
```

## Step 3: Run the Setup Script

Make the script executable and run it:

```bash
chmod +x setup_openmanus.sh && ./setup_openmanus.sh
```

## What This Script Does

1. **Installs uv package manager** - A fast Python package installer and resolver
2. **Updates PATH** - Ensures uv is accessible from the command line
3. **Clones OpenManus** - Downloads the repository from GitHub
4. **Sets up Python environment** - Creates a Python 3.12 virtual environment
5. **Installs dependencies** - Installs all required Python packages
6. **Configures Playwright** - Installs browser automation dependencies
7. **Installs browsers** - Downloads necessary browser binaries
8. **Configures Firefox** - Installs Firefox via snap package manager
9. **Prompts for API key** - Opens config file for you to add your Anthropic API key
10. **Launches the application** - Starts OpenManus

## Important Notes

- You'll need to add your Anthropic API key to the config file when prompted
- The script will pause to allow you to edit the configuration
- Make sure you have a stable internet connection for downloading dependencies
- The setup process may take several minutes to complete

## Troubleshooting

If you encounter issues:
- Ensure WSL is properly installed and updated
- Check that you have sufficient disk space
- Verify your internet connection is stable
- Make sure you have the necessary permissions for package installation
