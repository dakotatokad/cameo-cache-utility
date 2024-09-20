#!/bin/bash

# Name: cameo-cache-utility.cmd
# Purpose: Clears the users unique Cameo offline files and cache for a specified version of cameo

# ==== Functions ====

checkForRunningApp () {}

getUserId () {}

getCustomUserId () {}

buildCameoPath () {}

getCameoVersion () {}

removeOfflineProjects () {}

removeCache () {}

# ==== MAIN ROUTINE ====

set -e

echo "==============================================================================================================="
echo "   ______                                  ______              __             __  __ __   _  __ _  __          "
echo "  / ____/____ _ ____ ___   ___   ____     / ____/____ _ _____ / /_   ___     / / / // /_ (_)/ /(_)/ /_ __  __  "
echo " / /    / __  // __  __ \ / _ \ / __ \   / /    / __  // ___// __ \ / _ \   / / / // __// // // // __// / / /  "
echo "/ /___ / /_/ // / / / / //  __// /_/ /  / /___ / /_/ // /__ / / / //  __/  / /_/ // /_ / // // // /_ / /_/ /   "
echo "\____/ \__,_//_/ /_/ /_/ \___/ \____/   \____/ \__,_/ \___//_/ /_/ \___/   \____/ \__//_//_//_/ \__/ \__, /    "
echo "                                                                                                    /____/     "
echo "This script will give you the option to delete all offline projects"
echo "and/or the local cache data for Cameo. For more information about this"
echo "utility refer to the README.md file."
echo 
echo "  *******************************************************************"
echo "  ** Be sure to commit projects to TWC before running this script  **"
echo "  ** as this script can remove ALL saved offline and cache data    **"
echo "  ** from your machine.                                            **"
echo "  *******************************************************************"
echo 
echo "==============================================================================================================="
echo 

read -p "Press any key to continue..."

checkForRunningApp

getCameoVersion

buildCameoPath

removeOfflineProjects

removeCache

echo
echo "Script complete."
read -p "Press any key to continue..."