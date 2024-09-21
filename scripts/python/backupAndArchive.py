import shutil
import os
from datetime import date
from signal import pause
import time

def removeOfflineProjects(cameoPath):
    print("Creating a backup...")
    rootPath = os.path.join(cameoPath, 'projects')
    archiveName = os.path.join(cameoPath, 'archive', str(date.today()))
    shutil.make_archive(archiveName, "zip", rootPath)
    time.sleep(3)
    print('Offlines projects have been archived and removed...')
    os.system('tree')
    os.system('pause')

    
def removeCache(cameoPath):
    print("Path: ", cameoPath)

removeOfflineProjects(cameoPath)