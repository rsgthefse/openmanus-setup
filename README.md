# OpenManus Setup Script

This repository contains a single-file automated setup script to deploy [OpenManus](https://github.com/FoundationAgents/OpenManus) inside WSL on Ubuntu.

---

## 🚀 Quick Start

### 1. Enable WSL on Windows by running the following command in Admin PowerShell:
wsl --install

### 1a. If the system reboots, run the following in Admin PowerShell:
wsl

## 🚀 Ubuntu Terminal should be open now. The rest of the commands are run from here:

### 2. Create a new file:
nano setup_openmanus.sh
### Paste the contents from setup_openmanus.sh, save with CTRL+O, exit with CTRL+X.

### 3. Update the script permissions and launch the setup:
chmod +x setup_openmanus.sh
./setup_openmanus.sh

### 4. You’ll be prompted to enter your Anthropic API key for Claude Sonnet-4. Paste the config when prompted:
[llm]
model = "claude-sonnet-4-20250514"
base_url = "https://api.anthropic.com/v1/"
api_key = "sk-key-goes-here"
max_tokens = 8192
temperature = 0.0

[llm.vision]
model = "claude-sonnet-4-20250514"
base_url = "https://api.anthropic.com/v1/"
api_key = "sk-key-goes-here"
max_tokens = 8192
temperature = 0.0

