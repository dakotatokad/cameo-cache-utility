import shutil
import os
from datetime import date
import time

cameoPath = os.path.join('D:\\git-repository', 'cameo-cache-utility', 'cameo-cache-utility', 'test-environment')

def removeOfflineProjects(cameoPath):
    print("Creating a backup...")
    rootPath = os.path.join(cameoPath, 'src')
    archiveName = os.path.join(cameoPath, 'archive', str(date.today()))
    shutil.make_archive(archiveName, "zip", rootPath)

    #shutil.make_archive(archive_name, "zip", root_dir)

    # This archives the entire directory path instead of a specific directory and i can not understand why....
    #shutil.make_archive(archive_name, "zip", root_dir=cameoPath, base_dir=cameoPath+"\\original")
    #shutil.make_archive(date.today(), zip, cameoPath + "\\archive", cameoPath, False)
    #time.sleep(3)

    
def removeCache(cameoPath):
    print("Path: ", cameoPath)

removeOfflineProjects(cameoPath)