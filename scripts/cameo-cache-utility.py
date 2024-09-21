import os
import getpass

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
    # Set offline projects path
    cameoPathArray.insert("C:\\Users\\" + username + "\\AppData\\Local\\." + cameoVersion[0] + "\\" + cameoVersion[1] + "\\restricted\\offline\\projects", 0)
    # Set cache projects path
    cameoPathArray.insert("C:\\Users\\" + username + "\\AppData\\Local\\." + cameoVersion[0] + "//" + cameoVersion[1] + "\\cache\\", 1)

    return cameoPathArray

def removeOfflineProjects():
    print("Remove offline projects")

def removeCache():
    print("Remove cache")

if __name__ == "__main__":
    main()