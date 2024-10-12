<p align="center">
  <a href="https://github.com/swiftly-solution/swiftly">
    <img src="https://cdn.swiftlycs2.net/swiftly-logo.png" alt="SwiftlyLogo" width="80" height="80">
  </a>

  <h3 align="center">[Swiftly] Quake Sounds</h3>

  <p align="center">
    A simple plugin for Swiftly that implements quake sounds on specificy settings ( supported soundevents and path).
    <br/>
  </p>
</p>

<p align="center">
  <img src="https://img.shields.io/github/downloads/m3ntorsky/qsounds/total" alt="Downloads"> 
  <img src="https://img.shields.io/github/contributors/m3ntorsky/qsounds?color=dark-green" alt="Contributors">
  <img src="https://img.shields.io/github/issues/m3ntorsky/qsounds" alt="Issues">
  <img src="https://img.shields.io/github/license/m3ntorsky/qsounds" alt="License">
</p>


## Requirements 🛠️

- [Cookies](https://github.com/swiftly-solution/cookies/releases)

## Installation 👀
1. Download the newest [release](https://github.com/m3ntorsky/qsounds/releases)
2. Everything is drag & drop, so I think you can do it!
3. If you want you can use my own quake-sounds from workshop [eKill-Sounds](https://steamcommunity.com/sharedfiles/filedetails/?id=3347175501) Every available sounds paths and eventsname you can find [HERE](https://steamcommunity.com/sharedfiles/filedetails/?id=3347175501)

## Configuring the plugin 🧐
- After installing the plugin, you can change the prefix and the database settings from `addons/swiftly/configs/plugins/qsounds.json`
This JSON configuration file is used to manage the settings for the **QSounds** plugin The plugin is responsible for playing sound events triggered by various in-game actions, like getting kills, achieving first blood, or round events.

### 1. Configuration Structure

- **`command_aliases`**: A list of aliases that can be used to invoke the plugin commands. In this case, the available aliases are `"quake"` and `"sounds"`.
  
- **`count_per_round`**: When set to `false`, it means that kill-related sound events will not reset their counts per round. If set to `true`, counts would reset each round.
  
- **`enable_on_warmup`**: Controls whether sound events should be enabled during the warmup period. When set to `false`, no sounds will be played during warmup.

### 2. Menu Configuration

- **`menu`**: This section customizes the appearance and options of the plugin’s in-game menu:
  - **`color`**: Sets the menu color, specified in hexadecimal format (e.g., `"00FF21"` for green).
  - **`options`**: A set of boolean values enabling or disabling specific sound options:
    - **`hit`**: Enables sounds for hits.
    - **`hithead`**: Enables sounds specifically for headshot hits.
    - **`quake`**: Enables Quake-style sounds for various events.

### 3. Events Configuration

- **`events`**: Defines sound events triggered by specific in-game actions. Each event can be configured using one of the following methods:
  - **Using a `sound` and `path`**: Specify the sound directly by providing a path to the sound file:
    ```json
    "hit": {
        "type": "sound",
        "path": "sounds/training/timer_bell.vsnd"
    }
    ```
  - **Using a `soundevent` and `name`**: Use an in-game sound event by providing its event name:
    ```json
    "hithead": {
        "type": "soundevent",
        "name": "eKill.Hit.Head"
    }
    ```
  - Examples of pre-configured events include:
    - **`firstblood`**: Plays a sound for the first kill of the round (`"eKill.Quake.Firstblood"`).
    - **`kills`**: A generic kill sound when no headshot is involved (`"eKill.Quake.Impressive"`).
    - **`kill:headshot`**: A special sound for a headshot kill (`"eKill.Quake.Headshot2"`).
    - **`kill:2`, `kill:3`, `kill:4`, `kill:5`, `kill:{count}**: Different sounds that are triggered as a player achieves consecutive kills (double kill, triple kill, ultra kill, pentakill).
    - **`game_event:OnPlayerSpawn`**, **`game_event:OnRoundStart`**, **`game_event:OnRoundEnd`**, **`game_event:OnRoundFreezeEnd`**: Various sounds for game events like player spawning, round start, round end, and more.


### 4. Sound List

- **`list`**: A comprehensive list of all available sound (These sounds will be precache when plugin start) files that the plugin can use. Each entry specifies a path to a sound file (e.g., `"sounds/ekill/quake/doublekill.vsnd"`). These sounds can be mapped to events through the `events` section.

### 5. Customizing the Plugin

To adjust the plugin’s settings or change the behavior of sounds, modify the `qsounds.json` file. For example, you can:

- Change or add new sound mappings in the `events` section.
- Enable or disable specific sounds through the `menu` options.
- Adjust the prefix or database settings directly in the `addons/swiftly/configs/plugins/qsounds.json` file.

This configuration allows players to experience customized sound effects during gameplay, adding a dynamic and engaging audio experience to match various in-game actions and milestones.

## Creating A Pull Request 😃

1. Fork the Project
2. Create your Feature Branch
3. Commit your Changes
4. Push to the Branch
5. Open a Pull Request

### Have ideas/Found bugs? 💡

Join [Swiftly Discord Server](https://swiftlycs2.net/discord) and send a message in the topic from `📕╎plugins-sharing` of this plugin!

---