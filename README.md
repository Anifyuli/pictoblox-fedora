# PictoBlox Installer for Fedora

This Bash script allows you to install **PictoBlox** on **Fedora Linux** using the `.deb` package provided by STEMpedia.

> **Note:** Since STEMpedia only provides `.deb` installers (for Debian/Ubuntu-based systems), this script manually extracts and installs the contents on Fedora.

---

## Requirements

- Fedora Linux (tested on Fedora 39+)
- `sudo` privileges
- The PictoBlox `.deb` installer (available at the [PictoBlox download page](https://thestempedia.com/product/pictoblox/#downloads))

---

## How to Use

### 1. Clone this repository or save the script to a file

```bash
git clone https://github.com/anifyuli/pictoblox-fedora.git
cd pictoblox-fedora
````

### 2. Make the script executable

```bash
chmod +x script.sh
```

### 3. Run the script

#### Option 1: Run without arguments (searches for a `.deb` installer in `/home`)

```bash
./script.sh
```

#### Option 2: Specify the directory containing the installer

```bash
./script.sh -d /path/to/installer
```

#### Option 3: Display the help message

```bash
./script.sh --help
```

#### Option 4: Uninstall PictoBlox

```bash
./script.sh --uninstall
```

---

## What the Script Does

* Searches for a `PictoBlox*.deb` installer
* Extracts the `.deb` contents using `ar` and `tar`
* Copies necessary files to system directories (`/opt`, `/usr`)
* Removes any previously installed version of PictoBlox
* Adds a launcher icon to your application menu (if available)

---

## Uninstallation

You can use the `--uninstall` flag to completely remove PictoBlox from your system:

* Deletes `/opt/PictoBlox`
* Removes the `.desktop` launcher
* Cleans up symlinks and icon caches

---

## Disclaimer

This script is **unofficial** and community-maintained. Use it at your own risk.
If you encounter any issues, ensure the `.deb` file from STEMpedia is valid and has the expected structure.

---

## License

This project is released under the MIT License.

---

## Supported Fedora Versions

- [x] Fedora 40 ([EOL: 2025-05-13](https://fedorapeople.org/groups/schedule/f-40/f-40-key-tasks.html))
- [x] Fedora 41
- [x] Fedora 42

> [!NOTE]
> If you are using a distribution based on the regular Fedora edition—such as Fedora Workstation, Fedora KDE Plasma, Fedora Spins, etc.—this script is likely to work.
> **However, this script is not compatible with atomic Fedora variants** such as **Fedora Silverblue**, **Kinoite**, etc., because these use an immutable file system which is not supported by this script.
> If you're using an unsupported system and it doesn't work, feel free to open an issue.
> Fedora-based distributions will not be explicitly listed here.

> [!IMPORTANT]
> If you try this script on another Fedora release, please [report](https://github.com/anifyuli/pictoblox-fedora/issues) any problems or success cases.
