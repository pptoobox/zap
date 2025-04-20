# ⚡ zap - A Fast apt Wrapper

`zap` is a lightweight and simple wrapper for `apt` that helps automate package management tasks on Debian-based systems. It runs `apt update` automatically before installation or upgrades and cleans up unused packages after actions like install, upgrade, remove, and purge.

## 🚀 Features
- **Auto Update**: Always updated package list before install or upgrade.
- **Auto Cleanup**: Automatically cleans up unused packages afterwards.
- **Simple Commands**: Easily manage packages with `zap install`, `zap upgrade`, `zap remove`, and `zap purge`.

## 🔥 Installation

### Method 1: Using the Install Script

1. Make sure curl is installed. If not run:
   ```
   sudo apt update && sudo apt install curl -y
   ```

2. Install `zap` with one simple command:
   ```
   sudo bash -c "$(curl -fsSL https://raw.githubusercontent.com/pptoolbox/zap/main/install.sh)"
   ```

This will:
- Download the `zap` script from the GitHub repository.
- Copy it to `/usr/local/bin/zap`.
- Make it executable.
- Create a symlink in `/bin` so you can run zap from anywhere.

### Method 2: Manually
If you prefer to manually install `zap`, follow these steps:

1. Clone the repository:
   ```
   git clone https://github.com/pptoolbox/zap.git
   cd zap
   ```

2. Copy the `zap` script to `/usr/local/bin/`:
   ```
   sudo cp zap /usr/local/bin/
   ```

3. Make it executable:
   ```
   sudo chmod +x /usr/local/bin/zap
   ```

4. (Optional) Create a symlink in `/bin/` for easy access:
   ```
   sudo ln -s /usr/local/bin/zap /bin/zap
   ```

## 🚀 Usage
Once installed, you can use various commands to install, remove and upgrade your packages with ease.

To know about all the cool commands, use
```
zap help
```
or
```
zap h
```
This will show you a complete list of command that you can utilize along with their usecases.
### 🛠️ Contributing
Feel free to open issues or create pull requests if you'd like to contribute to the project.