# YMMV: Your Mileage May Vary - System Configuration and Automation Scripts

Welcome to **YMMV**, a comprehensive collection of bash scripts and configurations designed to
automate system setup and management, primarily for macOS environments. This project simplifies the
installation of essential tools, applications, and system configurations, ensuring a secure and
efficient operating environment.

## Table of Contents

- [Introduction](#introduction)
- [Features](#features)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Usage](#usage)
- [Directory Structure](#directory-structure)
- [Scripts Overview](#scripts-overview)
  - [Payload Bin Scripts](#payload-bin-scripts)
  - [Setup Scripts](#setup-scripts)
  - [Test Scripts](#test-scripts)
- [Configuration Files](#configuration-files)
- [Testing](#testing)
- [Contributing](#contributing)
- [License](#license)

## Status

**Master**
[![status](https://travis-ci.org/reactive-firewall/ymmv.svg?branch=master)](https://travis-ci.org/reactive-firewall/ymmv)
[![code coverage](https://codecov.io/gh/reactive-firewall/ymmv/branch/master/graph/badge.svg)](https://codecov.io/gh/reactive-firewall/ymmv/branch/master/)

**Stable**
[![status](https://travis-ci.org/reactive-firewall/ymmv.svg?branch=stable)](https://travis-ci.org/reactive-firewall/ymmv)
[![code coverage](https://codecov.io/gh/reactive-firewall/ymmv/branch/stable/graph/badge.svg)](https://codecov.io/gh/reactive-firewall/ymmv/branch/stable/)

## Introduction

**YMMV** aims to streamline the process of setting up a new macOS environment or maintaining an
existing one by automating the installation of software and configuration of system settings.
Whether you're a developer, system administrator, or power user, these scripts help you get up
and running quickly with a tailored environment.

## Features

- Automated installation of essential applications and tools.
- System configuration for security and performance optimization.
- Setup scripts for specialized software like audio plugins and development tools.
- Comprehensive testing scripts to validate configurations.
- Customizable Makefile for simplified command execution.

## Prerequisites

- **macOS** 10.14 or later.
- **bash** shell.
- Administrative privileges (sudo access) for installation scripts.
- Internet connection for downloading applications and updates.

## Installation

To begin using **YMMV**, clone the repository to your local machine:

```bash
git clone https://github.com/reactive-firewall/ymmv.git
cd ymmv
```

## Usage

The project utilizes a `Makefile` to streamline the installation and setup process.
Below are some common commands:

- **Install all configurations and tools:**

  ```bash
  sudo make install
  ```

- **Install only system configurations:**

  ```bash
  sudo make install-etc
  ```

- **Install tools and applications:**

  ```bash
  sudo make install-tools
  ```

- **Run tests to validate configurations:**

  ```bash
  make test
  ```

- **Clean up temporary files:**

  ```bash
  make clean
  ```

For a full list of available commands, refer to the `Makefile`.

## Directory Structure

```ascii
ymmv/
├── payload/
│   ├── bin/
│   ├── config/
│   ├── Setup/
│   └── etc/
├── tests/
├── Makefile
└── dot_files/
```

- **payload/**
  - **bin/**: Custom bash scripts and tools.
  - **config/**: Configuration files for various applications and services.
  - **Setup/**: Setup scripts for installing and configuring software.
  - **etc/**: System configuration files (e.g., `bashrc`, `environment`).
- **tests/**: Bash scripts for testing configurations and setups.
- **Makefile**: Automates installation, testing, and cleanup tasks.
- **dot_files/**: Template dotfiles like `.bashrc`, `.profile`.

## Scripts Overview

### Payload Bin Scripts

Located in **`payload/bin/`**, these scripts perform various system tasks:

- **`ssl_banner_sniff.bash`**: Extracts SSL certificates from a remote host.
- **`ssl_banner_grab.bash`**: Grabs SSL banners for analysis.
- **`makedict.sh`**: Processes text files to generate sorted word lists.
- **`getAppID.bash`**: Retrieves the application identifier of a macOS app.
- **`entropy_feed.bash`**: Generates entropy to keep SSH connections alive.
- **`printBanner.sh`**: Prints text in banner form.
- **`openssl_x509_text.sh`**: Extracts X.509 certificate details.

### Setup Scripts

Found in **`payload/Setup/`**, these scripts automate software installation:

- **`install_homebrew.bash`**: Installs Homebrew and essential packages.
- **`install_zoom.bash`**: Installs Zoom client.
- **`install_discord.bash`**: Installs Discord client.
- **`install_gpg_tools.bash`**: Installs GPG tools for encryption.
- **`install_sonic_visualiser.bash`**: Installs Sonic Visualiser for audio analysis.
- **`install_macs_fan_control.bash`**: Installs Macs Fan Control for temperature monitoring.
- **`install_steam.bash`**: Installs Steam gaming platform.
- **`install_signal.bash`**: Installs Signal private messenger.
- **`install_brew_bundle.bash`**: Installs packages from a Brewfile.

### Test Scripts

Located in **`tests/`**, these scripts validate configurations:

- **`test_spell_lintian.sh`**: Checks for spelling errors in scripts.
- **`test_git_config.sh`**: Validates Git configuration files.
- **`test_pf_config.sh`**: Validates PF firewall configuration files.
- **`test_plist.sh`**: Validates plist files for proper XML formatting.
- **`test_bash_env.sh`**: Tests the bash environment scripts.
- **`test_sh_lock.sh`**: Tests custom `shlock` implementation.
- **`test_codecov_yaml.sh`**: Validates the `codecov.yml` configuration.

## Configuration Files

The **`payload/config/`** directory contains configuration files for applications:

- **`lxsession`**: Session settings for LXDE.
- **`lxterminal`**: Configuration for LXTerminal emulator.
- **`pcmanfm`**: Settings for PCManFM file manager.
- **`libfm`**: Configuration for file management.
- **`lxpanel`**: Panel settings for LXDE.

## Testing

After installation, it's recommended to run tests to ensure all configurations are correct:

```bash
make test
```

This command executes scripts in the `tests/` directory to validate the setup.

## Contributing

I welcome contributions! If you have ideas for improvements or new features, feel free to fork
the repository and submit a pull request. Please ensure that your code adheres to the project's
coding standards and passes all tests.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE.md) file for details.

### Copyright (c), 2018-2024

---
