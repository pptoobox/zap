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
   bash -c "$(curl -fsSL https://raw.githubusercontent.com/pptoolbox/zap/main/install.sh)"
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
Once installed, you can use the following commands to manage packages:

### 1. Install a Package
```
zap install <package-name>
```
This will:
- Update the package lists.
- Install the package.

### 2. Upgrade All Packages
```
zap upgrade
```
This will:
- Update the package lists.
- Upgrade all installed packages.
- Automatically clean up unused packages `(apt autoremove --purge)`.

### 3. Remove a Package
```
zap remove <package-name>
```
This will:
- Remove the specified package.
- Automatically clean up unused packages `(apt autoremove)`.

### 4. Purge a Package (Remove Configuration Files)
```
zap purge <package-name>
```
This will:
- Purge the specified package along with its configuration files.
- Automatically clean up unused packages `(apt autoremove --purge)`.

### 🛠️ Contributing
Feel free to open issues or create pull requests if you'd like to contribute to the project.