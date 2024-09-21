from functools import cache
import os
import getpass
from datetime import date
import backupAndArchive
import array

def main():
    cleanScreen()
    print("===============================================================================================================")
    print("This script will give you the option to delete all offline projects and/or the local cache data for Cameo. For more information about this utility refer to the README.md file.")
    print("")
    print("*******************************************************************")
    print("** Be sure to commit projects to TWC before running this script  **")
    print("** as this script can remove ALL saved offline and cache data    **")
    print("** from your machine.                                            **")
    print("*******************************************************************")
    print("")
    print("===============================================================================================================")

    username = getUserId()
    cameoVersion = getCameoVersion()
    cameoPathArray = buildCameoPath(username, cameoVersion)

    while True:
        cleanScreen()
        print("Do you want to...")
        print("[1] Remove offline projects")
        print("[2] Remove local cache")
        print("[0] Exit")
        choice = int(input("[1,2,0]: "))
        if choice == 1:
            backupAndArchive.removeOfflineProjects(cameoPathArray[0])
            os.system('pause')
        elif choice == 2:
            backupAndArchive.removeCache(cameoPathArray[1])
            os.system('pause')
        elif choice == 0:
            break
        else:
            print("Your selection is not a valid option. Please try again...")
            os.system('pause')

# =========================

def getUserId():
    print("Get user ID")
    username = getpass.getuser()
    print("Your username is: ", username) 
    choice = input("Is this correct [Y/N]? ")
    if str(choice).capitalize() != 'Y':
        username = getCustomeUsername()
    return username

def getCustomeUsername():
        username = input("Enter your username: ")
        print("Your username is: ", username)

def cleanScreen():
    if os.name == 'nt':
        os.system('cls')
    else:
        os.system('clear')

def getCameoVersion():
    cleanScreen()
    csm = "cameo.systems.modeler"
    ea = "cameoea"
    md = "magicdraw"

    print("")
    print("[1] Cameo Systems Modeler 2021x")
    print("[2] Enterprise Architect 2021x")
    print("[3] MagicDraw 2021x")
    print("[4] Cameo System Modeler 2022x")
    print("[5] Enterprise Architecture")
    print("[6] MagicDraw 2022x")
    print("")

    while True:
        choice = input("Select your tool version: ")
        if choice == '1':
            cameoVersion = [csm, "2021x"]
            break
        elif choice == '2':
            cameoVersion = [ea, "2021x"]
            break
        elif choice == "3":
            cameoVersion = [md, "2021x"]
            break
        elif choice == '4':
            cameoVersion = [csm, "2022x"]
            break
        elif choice == '5':
            cameoVersion = [ea, "2022x"] 
            break
        elif choice == '6':
            cameoVersion = [md, "2022x"]
            break
        else:
            print("Invalid choice. Please try again...")
    
    return cameoVersion

def buildCameoPath(username, cameoVersion):
    cameoPathArray = ["offline path", "cache path"]
    offlinePath = os.path.join('C:\\Users', username, 'AppData', 'Local', cameoVersion[0], cameoVersion[1], 'restricted', 'offline')
    cachePath = os.path.join('C:\\Users', username, 'AppData', 'Local', cameoVersion[0], cameoVersion[1], 'cache')
    cameoPathArray = [offlinePath, cachePath]
    return cameoPathArray

if __name__ == "__main__":
    main()