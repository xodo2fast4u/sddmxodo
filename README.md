<h1 align="center">Xodo</h1>

<p align="center">
  <a href="https://github.com/xodo2fast4u/sddmxodo/blob/master/LICENSE">
    <img src="https://img.shields.io/badge/license-MIT-2E8B57?style=for-the-badge" alt="License: MIT" />
  </a>
  <a href="https://wiki.archlinux.org/title/SDDM">
    <img src="https://img.shields.io/badge/SDDM-0.21%2B-0078D4?style=for-the-badge&logo=linux" alt="SDDM 0.21+" />
  </a>
  <a href="https://www.qt.io/">
    <img src="https://img.shields.io/badge/Qt-6-41CD52?style=for-the-badge&logo=qt" alt="Qt 6" />
  </a>
  <a href="https://github.com/xodo2fast4u/sddmxodo">
    <img src="https://img.shields.io/badge/status-active-2ECC71?style=for-the-badge" alt="Status: active" />
  </a>
</p>

Xodo is a sleek, modern, dark-layered login theme for the Simple Desktop Display Manager (SDDM), built with Qt 6 QML. Featuring a bold digital clock and date display, an elegant floating card interface, seamless desktop session selection and integrated power controls, Xodo provides a polished and distraction-free entry to your Linux desktop.

## Disclaimer

**IMPORTANT**: Modifying system display manager configuration files requires administrative privileges (`root` / `sudo`).
Please ensure you:

- **Test before applying**: Always preview the theme using `sddm-greeter-qt6 --test-mode` before setting it as your default login theme.
- **Maintain fallback access**: Keep an alternative display manager or virtual console (`Ctrl + Alt + F3` / `F4`) accessible in case of misconfiguration.
- **Verify Qt 6 dependencies**: Ensure your distribution's SDDM package includes Qt 6 greeter support (`sddm-greeter-qt6`).

> [!NOTE]
> Xodo requires SDDM 0.21 or newer with Qt 6 QML support enabled. Older distributions running SDDM with Qt 5 greeters are not supported.

## Why Xodo?

Xodo combines minimalist aesthetics with lightweight, dependable functionality:

- **Dark Layered Design**: A deep, low-fatigue palette (`#07090d` base with `#151a24` and `#1d2331` card elevations) paired with a subtle vertical gradient.
- **Large Digital Clock**: Prominent, elegant clock and date display positioned on the left side of the screen.
- **Self-Contained Vector Icons**: Handcrafted 2D canvas vector icons (`Icon.qml`) for login, restart and power off—ensuring crisp scaling with zero external icon pack dependencies.
- **Smooth Session Switching**: Integrated session selector dropdown to quickly launch into your preferred desktop environment or window manager.
- **Effortless Configuration**: Simple INI-style `theme.conf` file allows immediate customization of the background wallpaper and typography.

## Features

### Technical Features

- **Built for Qt 6**: Native declarative QML implementation taking full advantage of Qt 6 rendering performance.
- **Zero Asset Dependencies for UI Controls**: Icons are rendered procedurally using QtQuick `Canvas`, eliminating broken icon links or missing SVG dependencies.
- **Auto-Focus Ready**: Focuses directly on the password input field on load, allowing you to sign in without reaching for the mouse.
- **Keyboard Navigation**: Full support for <kbd>Enter</kbd> / <kbd>Return</kbd> key triggers to log in.
- **Dynamic Error Feedback**: Displays clear authentication status messages upon login failures and clears the password field automatically.

### Core capabilities

- **Digital Clock & Date**: Real-time timer updating time in `HH:mm` format and localized date in `dddd d MMMM` format.
- **User Avatar Initial**: Generates a clean avatar badge using the first letter of the detected system user.
- **Session Management**: Lists all available desktop sessions (Plasma, GNOME, Hyprland, Sway, i3, etc.) through SDDM's `sessionModel`.
- **System Power Controls**: Clean one-click restart (`sddm.reboot()`) and shutdown (`sddm.powerOff()`) buttons with interactive hover states.
- **Customizable Appearance**: Change wallpaper image or switch UI fonts via `theme.conf`.

## Prerequisites

Ensure you have SDDM (0.21 or newer) and Qt 6 Declarative installed on your system.

### Arch Linux / Manjaro

```bash
sudo pacman -S sddm qt6-declarative qt6-svg adwaita-fonts
```

### Fedora / RHEL

```bash
sudo dnf install sddm qt6-qtdeclarative qt6-qtsvg adwaita-sans-fonts
```

### Ubuntu / Debian / Linux Mint

```bash
sudo apt update
sudo apt install sddm qml6-module-qtquick qml6-module-qtquick-controls fonts-adwaita
```

### openSUSE

```bash
sudo zypper install sddm libqt6-declarative adwaita-fonts
```

**Verify installation:**

```bash
sddm --version
```

```bash
sddm-greeter-qt6 --version
```

## Quick Start

### 1. Clone the repository

```bash
git clone https://github.com/xodo2fast4u/sddmxodo.git
```

```bash
cd sddmxodo
```

### 2. Install the theme into SDDM

Copy the theme directory to `/usr/share/sddm/themes/xodo`:

```bash
sudo mkdir -p /usr/share/sddm/themes/xodo
sudo cp -r . /usr/share/sddm/themes/xodo
```

### 3. Configure SDDM to use Xodo

Create or update the SDDM theme configuration file:

```bash
sudo mkdir -p /etc/sddm.conf.d
printf '[Theme]\nCurrent=xodo\n' | sudo tee /etc/sddm.conf.d/theme.conf
```

Alternatively, if you use a unified `/etc/sddm.conf`, ensure the `[Theme]` section points to `xodo`:

```ini
[Theme]
Current=xodo
```

### 4. Preview the theme

Verify the theme looks right without logging out:

```bash
sddm-greeter-qt6 --test-mode --theme /usr/share/sddm/themes/xodo
```

Or preview directly from your local repository folder:

```bash
sddm-greeter-qt6 --test-mode --theme .
```

## Configuration

Xodo reads its appearance settings from `theme.conf`.

| Variable          | Description                                                         | Default         |
| ----------------- | ------------------------------------------------------------------- | --------------- |
| `background`      | Filename or relative path to the background                         | `wallpaper.png` |
| `backgroundLight` | Optional separate background used in light mode, empty reuses above | empty           |
| `font`            | Font family applied to all UI text elements                         | `Adwaita Sans`  |
| `mode`            | `dark`, `light` or `auto`                                           | `auto`          |
| `lightFrom`       | Hour (0 to 23) when `auto` switches to light                        | `7`             |
| `darkFrom`        | Hour (0 to 23) when `auto` switches back to dark                    | `19`            |

### Light and dark mode

SDDM runs before you log in, as its own system user, so it cannot see your desktop color scheme. Xodo therefore decides by itself using `mode`:

- `dark` always uses the dark palette.
- `light` always uses the light palette.
- `auto` uses the light palette between `lightFrom` and `darkFrom` by the machine clock and the dark palette the rest of the day.

```ini
[General]
mode=light
```

The bundled wallpaper is dark. In light mode it is covered by a pale tint, so for the best result set `backgroundLight` to a brighter image placed next to `theme.conf`.

### Changing the wallpaper

1. Place your desired image (PNG or JPG) into `/usr/share/sddm/themes/xodo/`.
2. Edit `/usr/share/sddm/themes/xodo/theme.conf`:

```ini
[General]
background=my-wallpaper.jpg
font=Adwaita Sans
```

3. Alternatively, replace the default `wallpaper.png` directly:

```bash
sudo cp /path/to/your/image.png /usr/share/sddm/themes/xodo/wallpaper.png
```

### Changing the font

If you prefer a different font (e.g. `Inter`, `Roboto`, `Fira Sans` or `Cantarell`):

```ini
[General]
background=wallpaper.png
font=Inter
```

Ensure the specified font package is installed on your system.

## Project structure

The theme files are organized as follows:

| Path               | Purpose                                                                             |
| ------------------ | ----------------------------------------------------------------------------------- |
| `Main.qml`         | Main login interface: layout, clock/date timer, login card, session selector, power |
| `Icon.qml`         | Procedural 2D vector canvas icons for login arrow, reboot symbol and power button   |
| `theme.conf`       | User-configurable properties for wallpaper path and UI font family                  |
| `metadata.desktop` | SDDM theme metadata, entry points and Qt 6 compatibility declarations               |
| `wallpaper.png`    | Default dark minimalist backdrop image                                              |

## Testing and Development

You can run the SDDM greeter in test mode at any time inside your active desktop environment.

### Run in a window

```bash
sddm-greeter-qt6 --test-mode --theme .
```

### Testing with different resolutions

You can resize the preview window or specify custom geometry to test various screen sizes and aspect ratios.

## Troubleshooting

### Common Issues

**Theme does not appear after reboot**

- Ensure SDDM is enabled as the default display manager:
  ```bash
  sudo systemctl status sddm
  ```
- Check that `/etc/sddm.conf.d/theme.conf` contains:
  ```ini
  [Theme]
  Current=xodo
  ```
- Confirm the theme folder name in `/usr/share/sddm/themes/` exactly matches the `Current` value (`xodo`).

**Greeter shows a blank white or black screen**

- Run the test mode command from a terminal to inspect console output:
  ```bash
  sddm-greeter-qt6 --test-mode --theme /usr/share/sddm/themes/xodo
  ```
- Verify that Qt 6 QML modules are installed (e.g., `qt6-declarative` on Arch, `qml6-module-qtquick` on Debian/Ubuntu).

**Font glyphs look misaligned or fall back to system default**

- Verify that the font set in `theme.conf` is installed on your system:
  ```bash
  fc-list : family | grep -i "Adwaita Sans"
  ```
- Change `font` in `theme.conf` to an installed family such as `Sans` or `DejaVu Sans`.

**Authentication fails unexpectedly**

- Make sure PAM and SDDM services are functioning normally. Test mode does not authenticate real system passwords but live login uses standard SDDM authentication.

## Contributing

We welcome contributions and improvements!

1. Fork the repository
2. Create a feature branch:
   ```bash
   git checkout -b feature/your-improvement
   ```
3. Test your changes locally using test mode:
   ```bash
   sddm-greeter-qt6 --test-mode --theme .
   ```
4. Commit your changes:
   ```bash
   git commit -m "Add feature or fix"
   ```
5. Push to your branch and submit a pull request

## Support

For issues, questions or feature requests:

- Open an issue in the [GitHub issue tracker](https://github.com/xodo2fast4u/sddmxodo/issues)
- Review existing documentation and QML files

## License

This project is licensed under the [MIT License](LICENSE).
