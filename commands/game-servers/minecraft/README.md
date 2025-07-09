# Minecraft Server Management

> **Heads up:** This is a hobby project. While useful, it may contain bugs or breaking changes. Use at your own risk and always review scripts before running them on important systems.

This project provides a flexible Docker Compose-based setup for running various Minecraft server types (CurseForge, FTB, Fabric, NeoForge, etc.) with optional backup support and easy mod management.

This project is based on the [itzg/minecraft-server](https://github.com/itzg/docker-minecraft-server) and the [itzg/mc-backup](https://github.com/itzg/docker-mc-backup).

Original repository: [minecraft-server](https://github.com/energypatrikhu/minecraft-server)

---

## Quick Start
- To get started, create configuration file for the minecraft commands
  ```sh
  cp $EPX_HOME/.config/minecraft.config.example $EPX_HOME/.config/minecraft.config
  ```
  And edit the paths inside the file to match your setup, then restart the shell.

- Next run `mc.install` to install the required dependencies.

- For more details on how to set up a server, see the [Setting Up a Server](#setting-up-a-server-example) or [Creating a New Server Config with mc.create](#creating-a-new-server-config-with-mccreate) sections below.

- For a quick overview of the available commands, run:
  ```sh
  mc.help
  ```

---

## Environments

- **Default Environment Files:**
  - Located in `configs/` (e.g., `configs/curseforge_2025-02-16_all-the-mods-10.env`)
  - Each server has its own `.env` file. The filename format is:

    ```
    <platform>_<YYYY-MM-DD>_<modpack-or-server-name>.env
    ```

    Example: `curseforge_2025-02-16_all-the-mods-10.env`

- **Changeable Variables:**
  - Most variables in the `.env` files can be changed to suit your needs (e.g., `SERVER_NAME`, `WHITELIST`, `OPS`, `BACKUP`, etc.).
  - See `configs/examples/` for template files for each platform.
  - For more environment variables checkout the files located in `env/`.

---

## CurseForge API Key

- To download mods from CurseForge, you **must** set up your API key:
  - Copy `secrets/curseforge_api_key.txt.example` to `secrets/curseforge_api_key.txt` and add your key.

---

## Example Server Config

- **Filename Structure:**
  - `configs/<platform>_<date>_<name>.env`
- **Example Content:**

    ```ini
    # configs/curseforge_2025-02-16_all-the-mods-10.env.example
    CREATED_AT = 2025-02-16
    SERVER_NAME = All The Mods 10
    MODPACK_NAME = all-the-mods-10
    MODPACK_VERSION = 2.39
    MEMORY = 6G
    JAVA_VERSION = 21
    BACKUP = true
    WHITELIST = player1, player2
    OPS = player1
    # ... other variables ...
    ```

---

## Enabling Backups

- To enable the backup container, set `BACKUP = true` in your server's `.env` file.
- To disable backups, either omit the `BACKUP` variable or set `BACKUP = false`.
- The backup container will create backups in the `$MINECRAFT_BACKUPS_DIR/<platform>_<date>_<name>/` directory. (the base directory can be changed in the `$EPX_HOME/.config/minecraft.config` config by changing the variable `MINECRAFT_BACKUPS_DIR`)

---

## Directory Structure

- **Default Directories:**
  - Server data: `$MINECRAFT_SERVERS_DIR/<platform>_<date>_<name>/`
    > Can be changed in `$EPX_HOME/.config/minecraft.config` by changing the variable `MINECRAFT_SERVERS_DIR`
  - Configs: `configs/`
  - Compose files: `compose/`
  - Platform configs: `platforms/`
  - Secrets: `secrets/`
  - Backups: `$MINECRAFT_BACKUPS_DIR/`
    > Can be changed in `$EPX_HOME/.config/minecraft.config` by changing the variable `MINECRAFT_BACKUPS_DIR`

---

## Platform Configs

- Platform-specific Docker Compose and config files are in `compose/` and `platforms/`.
- Example Compose files:
  - `compose/docker-compose.base.yml` (no backup)
  - `compose/docker-compose.full.yml` (with backup)

---

## Server Location

- Each server runs in its own directory under `$MINECRAFT_SERVERS_DIR` (e.g., `$MINECRAFT_SERVERS_DIR/fabric_2025-07-05_bingo/`).

---

## Whitelist, Ops, and Players

- **Whitelist:**
  - Controlled by the `WHITELIST` variable in the `.env` file, by default it is empty.
  - To enable, list players in `WHITELIST`. (e.g., `WHITELIST = player1, player2`).
- **Opped Players:**
  - Set via the `OPS` variable (comma-separated list).

---

## Adding Mods

- **CurseForge:**
  - Requires a valid API key in `secrets/curseforge_api_key.txt`.
  - List mods in the `CURSEFORGE_MODS` variable in your `.env` file.
- **Modrinth:**
  - Supported via the `MODRINTH_MODS` variable as well.

---

## Timezone

- To change the timezone, edit or create `env/.tz.env` and set the `TZ` variable (e.g., `TZ=Europe/Berlin`).

---

## Setting Up a Server (Example)

1. Copy an example config from `configs/examples/`:

    ```sh
    cp configs/examples/@example.curseforge.env configs/curseforge_2025-02-16_all-the-mods-10.env
    # Edit the new file as needed
    ```
2. Set up your CurseForge API key if using CurseForge mods.
3. Start the server:

    ```sh
    mc curseforge_2025-02-16_all-the-mods-10
    ```

---

For more details, see comments in the example config files and the `$EPX_HOME/commands/game-servers/minecraft/mc.sh` script.

---

## Creating a New Server Config with `mc.create`

The `mc.create` command helps you quickly generate a new server configuration file from a template.

- **Usage:**
  ```sh
  mc.create <server_type> [server_name]
  ```
  - `<server_type>`: The type of server (e.g., `curseforge`, `fabric`, `forge`, etc.).
  - `[server_name]`: (Optional) The name for your server or modpack.

- **How it works:**
  - Copies the appropriate example config from `configs/examples/@example.<server_type>.env`.
  - Creates a new file in `configs/` named `<server_type>_<YYYY-MM-DD>_<server_name>.env` (date is today).
  - Fills in `CREATED_AT` and `SERVER_NAME` automatically.

- **Example:**
  ```sh
  mc.create curseforge all-the-mods-10
  # Creates configs/curseforge_2025-07-08_all-the-mods-10.env
  ```
  Edit the new file as needed, then start your server as usual.

- **Tip:**
  If you omit `[server_name]`, the filename will include `CHANGEME` and you'll be prompted to rename it.

---

## Updating project files

To update the project files, you can run the following command:

```sh
mc.update
```
This command will pull the latest changes from the repository and update your local files accordingly. Make sure to review any changes before applying them, especially if you have custom configurations.

---

# Credits
This project is inspired by the work of [itzg](https://github.com/itzg) and aims to provide a user-friendly way to manage Minecraft servers with Docker Compose.
