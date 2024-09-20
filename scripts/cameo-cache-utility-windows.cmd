:: Name: cameo-cache-utility.cmd
:: Purpose: Clears the users unique Cameo offline files and cache for a specified version of cameo

:: ==== MAIN ROUTINE ====

@echo off
setlocal enabledelayedexpansion
echo ===============================================================================================================
echo:   ______                                  ______              __             __  __ __   _  __ _  __        
echo:  / ____/____ _ ____ ___   ___   ____     / ____/____ _ _____ / /_   ___     / / / // /_ (_)/ /(_)/ /_ __  __
echo: / /    / __ `// __ `__ \ / _ \ / __ \   / /    / __ `// ___// __ \ / _ \   / / / // __// // // // __// / / /
echo:/ /___ / /_/ // / / / / //  __// /_/ /  / /___ / /_/ // /__ / / / //  __/  / /_/ // /_ / // // // /_ / /_/ / 
echo:\____/ \__,_//_/ /_/ /_/ \___/ \____/   \____/ \__,_/ \___//_/ /_/ \___/   \____/ \__//_//_//_/ \__/ \__, /  
echo:                                                                                                    /____/ 
echo This script will give you the option to delete all offline projects 
echo and/or the local cache data for Cameo. For more information about this
echo utlitiy refer to the README.md file.
echo:
echo   *******************************************************************
echo   ** Be sure to commit projects to TWC before running this script  **
echo   ** as this script can remove ALL saved offline and cache data    **
echo   ** from your machine.                                            **
echo   *******************************************************************
echo: 
echo ===============================================================================================================
echo: 
pause
echo:

CALL :checkForRunningApp
echo:

CALL :getUserId
echo:
CALL :getCameoVersion
echo:
CALL :buildCameoPath
CALL :removeOfflineProjects
echo:
CALL :removeCache
echo:
echo Script complete.
pause
GOTO :eof

:: ==== FUNCTIONS ====

:getUserId
:: Get the user ID for the file path
echo Your User ID is: %USERNAME%
echo:Is this correct?
echo:   [Y]es
echo:   [N]o   
choice /c yn /n /m "[Y/N]: "
set _erl=%ERRORLEVEL%
IF %_erl%==2 (GOTO :getCustomUserId)
IF %_erl%==1 (
    echo Using %USERNAME% to find your files...
    set userId=%USERNAME%
)
GOTO :eof

:  =========

:getCustomUserId
:: Get customer user ID if it was incorrect or could not be pulled from windows
:redoUserInputOfId
echo Enter your User ID which is your Windows login (msmith, e12345, n12345, etc.)
set /p userId= Enter your User ID as plaintext with no whitespace: 
echo: 
echo You entered: %userid%
echo:Is this correct?
echo:   [Y]es
echo:   [N]o   
choice /c yn /n /m "[Y/N]: "
set _erl=%ERRORLEVEL%
IF %_erl%==2 (GOTO :redoUserInputOfId)
IF %_erl%==1 (echo I will use %userId% to find your files...) 
GOTO :eof

:  =========
:buildCameoPath
:: Build the path to use for other functions
::
:: Default installation path
:: C:\Users\<USERNAME>\AppData\Local\.<modeling tool name>\<modeling tool version number>
::
:: Tool Versions
:: MagicDraw: magicdraw
:: Cameo Enterprise Architecture: cameoea
:: Cameo Systems Modeler: cameo.systems.modeler

set offlineProjectsPath=C:\Users\%userID%\AppData\Local\.%cameoTool%\%cameoVersion%\restricted\offline\projects\
set cachePath=C:\Users\%userID%\AppData\Local\.%cameoTool%\%cameoVersion%\cache\
rem echo DEBUG Projects: %offlineProjectsPath%
rem echo DEBUG Cache: %cachePath%
GOTO :eof

:  =========

:getCameoVersion
:: Get the type of Cameo for the file path
echo:Select the version of Cameo you are using:
echo:   [M]agicDraw
echo:   [C]ameo Systems Modeler
echo:   [E]nterprise Architect
choice /c mce /n /m "Tool [M,C,E]: "
set _erl=%ERRORLEVEL%
if %_erl%==3 set cameoTool=cameoea
if %_erl%==2 set cameoTool=cameo.systems.modeler
if %_erl%==1 set cameoTool=magicdraw
echo:
:: Get the version of Cameo for the file path
echo:Select the tool version that you are using:
echo:    [1] 2021x
echo:    [2] 2022x
choice /c 12 /n /m "Version [1,2]: "
set _erl=%ERRORLEVEL%
if %_erl%==2 set cameoVersion=2022x
if %_erl%==1 set cameoVersion=2021x
rem echo DEBUG Selected Tool: %cameoTool% %cameoVersion%
GOTO :eof

:: ========

:removeOfflineProjects
:: Remove the \projects\ folder containing offline files based on the user's ID and the
:: version of Cameo being used
echo:Do you want to remove the stored offline projects?
echo:   [Y]es
echo:   [N]o
choice /c yn /n /m "[Y/N]: "
set _erl=%ERRORLEVEL%
IF %_erl%==2 (
        echo Skipping Offline projects...
)
IF %_erl%==1 (
    echo Checking %userId%'s directory for offline files...
    IF EXIST %offlineProjectsPath% (
        echo Offline projects folder exists...
        CALL :deleteSpinner
        :: remove projects folder and all subdirectories, when saving a project from TWC, Cameo recreates the ...\projects\ directory
        RMDIR /S /Q %offlineProjectsPath%
        IF NOT EXIST %offlineProjectsPath% (
            echo SUCCESS: Offline projects successfully deleted.
        ) else (
            echo ERROR: The file path is valid but the files were not deleted.
        )
    ) else (
        echo ERROR: Offline projects not found.
    )
)
GOTO :eof

:: ========

:removeCache
:: Remove the \cache\ folder containing cached files based on the user's ID and the
:: version of Cameo being used
echo:Do you want to remove the local cache?
echo:   [Y]es
echo:   [N]o
choice /c yn /n /m "[Y/N]: "
set _erl=%ERRORLEVEL%
IF %_erl%==2 (
    echo Skipping Local Cache...
)
if %_erl%==1 (
    echo Checking %userId%'s directory for cache files...
    IF EXIST %cachePath% (
        echo Cache folder exists...
        CALL :deleteSpinner
        :: remove cache folder and all subdirectories, when opening Cameo recreates the ...\cache\ directory
        RMDIR /S /Q %cachePath%
        IF NOT EXIST %cachePath% (
            echo SUCCESS: Offline projects successfully deleted.
        ) else (
            echo ERROR: The file path is valid but the files were not deleted.
        )
    ) else (
        echo ERROR: Cache not found.
    )
) 
GOTO :eof

:: ========

:checkForRunningApp
setlocal enabledelayedexpansion
:: Checks if Cameo is running
:recheckForRunningApp
echo Checking if Cameo (javaw.exe) is running...
set cameoProcess="javaw.exe"
tasklist /fi "STATUS eq running" | findstr /i %cameoProcess% >nul
if %errorlevel% == 0 (
    echo Cameo appears to be running.
    echo: 
    echo **********************************
    echo * Close Cameo before continuing. *
    echo **********************************
    echo:
    pause
    GOTO :recheckForRunningApp
) else (
    echo Cameo does not appear to be running.
)
GOTO :eof

:: ========

:deleteSpinner
:: Add UX progress spinner - CMD seems to render this rather slowly
for /f %%a in ('copy /Z "%~dpf0" nul') do set "CR=%%a"

FOR /L %%n in (1,1,10) DO (
    call :spinner
    ping localhost -n 1 > nul
)
GOTO :eof

:spinner
:: Animate spinning cursor
set /a "spinner=(spinner + 1) %% 4"
set "spinChars=\|/-"
<nul set /p ".=Deleting... !spinChars:~%spinner%,1!!CR!"
GOTO :eof

:: ====
:: END OF FILE
:: ====

EXIT /B 0