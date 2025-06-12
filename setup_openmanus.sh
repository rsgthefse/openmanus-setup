#!/bin/bash

set -e
set -o pipefail

echo "[+] Installing uv package manager..."
curl -LsSf https://astral.sh/uv/install.sh | sh

echo "[+] Updating PATH..."
export PATH="$HOME/.local/bin:$PATH"
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc

echo "[+] Cloning OpenManus repository..."
git clone https://github.com/FoundationAgents/OpenManus.git
cd OpenManus

echo "[+] Creating Python 3.12 virtual environment..."
uv venv --python 3.12
source .venv/bin/activate

echo "[+] Installing Python dependencies..."
uv pip install -r requirements.txt

echo "[+] Installing Playwright system dependencies..."
playwright install-deps

echo "[+] Installing additional required libraries..."
sudo apt-get update
sudo apt-get install -y libnss3 libnspr4 libasound2t64

echo "[+] Installing Playwright browsers..."
playwright install

echo "[+] Installing Firefox..."
sudo snap install firefox

echo
echo "⚠️  Update your Anthropic API key in the config file."
echo "Press ENTER to continue and open the editor..."
read
nano config/config.toml

echo "[+] Starting OpenManus..."
python main.py
