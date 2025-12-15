# observatorycore-wine-installer

A simple, opinionated installer script to run **Observatory Core** on Linux using **Wine 10**.

This project exists because Observatory Core depends on modern .NET and Windows fonts that do not work reliably on older Wine versions or default Linux distributions.

The script:

* Installs WineHQ (Wine 10 stable)
* Installs required helpers like winetricks
* Installs Microsoft core fonts to avoid UI crashes
* Downloads the official Wine portable build of Observatory Core
* Extracts it to the user Desktop
* Launches Observatory Core in the background

Tested primarily on **Linux Mint (Ubuntu 24.04 base)**.

---

## Why this exists

Running Observatory Core on Linux often fails due to:

* Outdated Wine versions
* Missing .NET Core runtime support
* Missing Windows fonts such as Segoe UI

This script automates the known working setup so you do not have to debug Wine, .NET, or font issues manually.

---

## Requirements

* Linux Mint 22 or newer (Ubuntu 24.04 base)
* sudo access
* Internet connection

If you are on another Ubuntu based distro, this will likely still work but is not guaranteed.

---

## What gets installed

System packages:

* winehq-stable (Wine 10)
* unzip
* curl

Observatory Core:

* WINE-ObservatoryPortable.zip from the official Observatory site

---

## Installation

Clone the repository:

```bash
git clone https://github.com/GoodrichDev/observatorycore-wine-installer.git
cd observatorycore-wine-installer
```

Make the script executable:

```bash
chmod +x install.sh
```

Run it:

```bash
./install.sh
```

The script will prompt for sudo when required.

Once complete, Observatory Core will be launched automatically in the background.

---

## Where Observatory Core is installed

The portable build is extracted to:

```
~/Desktop/ObservatoryCore
```

The main executable:

```
~/Desktop/ObservatoryCore/ObservatoryCore.exe
```

You can re-launch it manually at any time using:

```bash
wine ~/Desktop/ObservatoryCore/ObservatoryCore.exe
```

---

## Elite Dangerous journal path (Steam Proton)

If you are using Elite Dangerous via Steam Proton, your journal files are located at:

Linux path:

```
~/.steam/steam/steamapps/compatdata/359320/pfx/drive_c/users/steamuser/Saved Games/Frontier Developments/Elite Dangerous
```

Windows style path (for Observatory Core):

```
Z:\home\YOUR_USERNAME\.steam\steam\steamapps\compatdata\359320\pfx\drive_c\users\steamuser\Saved Games\Frontier Developments\Elite Dangerous
```

Make sure Elite Dangerous has been launched at least once so the folder exists.

---

## Troubleshooting

### Wine version is too old

Check your Wine version:

```bash
wine --version
```

It should report wine-10.x. If not, make sure the WineHQ repository was added correctly and that distro Wine packages were not installed instead.

### Observatory does not see journal files

Confirm:

* You are pointing Observatory at the Proton or Wine path, not a native Linux path
* The path is entered using Windows style backslashes
* Elite Dangerous has generated journals

---

## Scope and non-goals

This project:

* Is not a general Wine installer
* Is not a Lutris or Bottles replacement
* Does not manage updates to Observatory Core

It is intentionally minimal and focused on a single known working setup.

---

## License

This repository only contains an installer script.

Observatory Core is the property of its respective authors.
Wine is licensed under the LGPL.

---

## Disclaimer

This is an unofficial community project.
No affiliation with Frontier Developments or the Observatory Core developers.
