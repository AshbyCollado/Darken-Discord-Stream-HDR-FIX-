# Darken Stream (HDR Fix)

> **Note:** This plugin was built with the assistance of AI (Antigravity).

A custom Vencord plugin designed to combat HDR glare in Discord screenshares. 

When you use an HDR monitor, watching a standard or un-calibrated screenshare on Discord can often result in blinding white glare. This plugin safely lowers the brightness of the screenshare window using CSS filters without affecting the rest of your Discord UI.

## Features
- **Stream Context Menu Toggle**: Instantly darken the stream by right-clicking the stream window.
- **Adjustable Darkness**: Use the slider to set your perfect brightness level (0-100).
- **Settings Sync**: Your preferences seamlessly sync across the context menu and the main Vencord plugins menu.

---

## Installation

Because this is a custom Vencord user-plugin, Vencord requires it to be built from source on your machine. We have provided a fully automated installation script to make this as painless as possible.

### Prerequisites
Before running the installer, you must have the following installed on your system:
1. **[Git](https://git-scm.com/downloads)**
2. **[Node.js](https://nodejs.org/)** (After installing Node.js, open your terminal and run `npm install -g pnpm` to install `pnpm`, which Vencord requires to build).

### How to Install
1. Download this entire repository (or extract the `.zip` file if you downloaded a release).
2. Ensure you have the `darkenStream` folder and `Install.bat` in the same directory.
3. Double-click **`Install.bat`**.

### What does the `Install.bat` script do?
We understand that running batch scripts can be scary. Here is exactly what the script does so you know you are safe:
- It checks if you have Git and pnpm installed.
- It automatically downloads the latest official Vencord source code from GitHub into a temporary folder in your AppData directory (`%APPDATA%\Vencord-DarkenStream`).
- It copies the `darkenStream` folder into Vencord's custom plugin folder.
- It commands Vencord to build itself and injects the patched version into your Discord installation.
- It securely restarts Discord for the changes to take effect.

---

## ⚠️ Compatibility Note
This plugin was built and tested against **Vencord v1.14.x**. 
Vencord is an actively developed project. Future structural changes to Vencord's core API could potentially break custom user plugins. If Vencord changes their API in the future, this plugin may need to be updated accordingly.

---

**Author:** ashbyalis
