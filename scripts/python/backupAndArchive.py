import shutil
import os
from datetime import date
import time

# Cameo path is expected as:
# C:\Users\<USERNAME>\AppData\Local\.<modeling tool name>\<modeling tool version number>\
# Offline: ..\restricted\offline
# Cache: ..\cache

def removeOfflineProjects(cameoPath):
    print("Removing offline projects...")
    print("Creating a backup...")
    # Append \projects directory onto root path for offline files
    rootPath = os.path.join(cameoPath, 'projects')
    archiveName = os.path.join(cameoPath, 'archive', str(date.today()))
    shutil.make_archive(archiveName, "zip", rootPath)
    time.sleep(3)
    print("Removing offline projects...")
    shutil.rmtree(rootPath) # this needs to be tested...
    # TODO confirm path is as expected (so as to not nuke the entire cameo directory)
    # TODO force RMDIR on rootPath
    print('Offlines projects have been archived and removed...')
    
def removeCache(cameoPath):
    print("Removing cache files...")
    print("Creating a backup...")
    # Append \cache directory onto root path for offline files
    rootPath = os.path.join(cameoPath, 'cache')
    archiveName = os.path.join(cameoPath, 'cache-archive', str(date.today()))
    shutil.make_archive(archiveName, "zip", rootPath)
    time.sleep(3)
    print("Removing cache files...")
    shutil.rmtree(rootPath) # this needs to be tested
    # TODO confirm path is as expected (so as to not nuke the entire cameo directory)
    # TODO force RMDIR on rootpath
    print("Cache files have been removed...")