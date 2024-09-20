# Cameo Cleaner 🔧

This project will pull your username from your computer and automate the removal of Cameo's cache and offline project files. You can choose which, or both, of the files you want to remove.

Commit all local changes to the server before running this script. This script will 🔥 **permanently delete** 🔥 the cache and/or offline project files if you choose to execute those options.

## Required configuration

Cameo must be configured to store its AppData in: `C:\Users\{USERNAME}\AppData\Local\.{TOOL}\{VERSION}\`\
`USERNAME` is your Windows username/login\
`TOOL` is the Cameo tool you need to fix\
`VERSION` is the version of Cameo installed

This is based on [Cameo's default configuration paths](https://docs.nomagic.com/display/CRMP190/Configuration+files) so unless you have a special installation or a modified configuration file, this is what your installation will have.

If you see errors when running the script to remove files, you can check your configuration path in Cameo by opening the tool and selecting:\
`Help` > `About Cameo Systems Modeler` > `Environment` > `Configuration Files`

👍 Supported Operating Systems and Programs:

- Windows (10/11)
    - Cameo Systems Modeler (2021x, 2022x)
    - Cameo Enterprise Architect (2021x, 2022x)
    - MagicDraw (2021x, 2022x)

👎 Unsupported Operating Systems and Programs:

- Mac
    - Cameo Systems Modeler
    - Cameo Enterprise Architect
    - MagicDraw

## How to use this repo

1. Select Releases
1. Download the Source Code (zip) asset for the latest release
1. Extract the contents of the downloaded zip folder
1. Navigate to `\scripts\`
1. Run the `cameo-cache-utility.cmd` file by double clicking on it and follow the on screen prompts

🌟 This file can be saved and ran whenever you need it.
You can also follow the repo to be notified of new releases which may include bug fixes and new features.