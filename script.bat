@echo off
set /A timer = 10
title yt-dlp Plugin Manager
goto check_Permissions

:check_Permissions
    net session >nul 2>&1
    if %errorLevel% == 0 (
        goto adminon
    ) else (
        goto adminoff
    )
    
    pause >nul
	
:adminoff
echo _________________________________________________________________
echo.
echo.
echo.
echo.
echo       This script requires administrator permission to run.
echo               Please run as administrator.
echo. 
echo.
echo.
echo.
echo.                   Exiting in %timer% . . . 
echo.
echo.
echo.
echo.
echo _________________________________________________________________
timeout /t 1 >nul
cls
if %timer% == 1 (exit) else (set /A timer = %timer% - 1)
goto adminoff



:newchangelog
echo.
echo.
echo.
echo      v0.05
echo.
echo.
echo beginning shortcut creations for plugins-a and root
choice >nul
goto menu

rem THIS IS THE START OF THE SCRIPT





:adminon
if not exist C:\ytdl\plugins-a Powershell New-Item -Path "C:\ytdl" -Name "plugins-a" -ItemType Directory
if not exist C:\ytdl\plugins-a\Manager Powershell New-Item -Path "C:\ytdl\plugins-a" -Name "Manager" -ItemType Directory
goto UpdateCheck



:UpdateCheck
@echo off
echo. Pre-boot checks...
echo.
echo Checking for Internet access.
echo.
Ping www.google.com -n 1 -w 1000
if errorlevel 1 (set /a internet=0) else (set /a internet=1)
if %internet% == 0 (goto notconnected)
echo Success!
echo.
echo.
echo Checking for updates...
echo.
Powershell Invoke-WebRequest -Uri https://raw.githubusercontent.com/Andrebeck27/plugin-manager-test/main/local-changelog.txt -OutFile C:\ytdl\plugins-a\manager\most-recent-changelog.txt
fc C:\ytdl\plugins-a\manager\most-recent-changelog.txt C:\ytdl\plugins-a\manager\local-changelog.txt >nul
cls
if errorlevel 1 (set Updatestatus=An update is available at https://github.com/Andrebeck27/plugin-manager-test!) else (set Updatestatus=Manager is up-to-date.)
del C:\ytdl\plugins-a\manager\most-recent-changelog.txt
goto setstatuses

:update2
cls
echo Checking for Internet access.
echo.
Ping www.google.com -n 1 -w 1000
if errorlevel 1 (set /a internet=0) else (set /a internet=1)
if %internet% == 0 (goto notconnected2)
echo Success!
echo.
echo.
echo Checking for updates...
echo.
Powershell Invoke-WebRequest -Uri https://raw.githubusercontent.com/Andrebeck27/plugin-manager-test/main/local-changelog.txt -OutFile C:\ytdl\plugins-a\manager\most-recent-changelog.txt
fc C:\ytdl\plugins-a\manager\most-recent-changelog.txt C:\ytdl\plugins-a\manager\local-changelog.txt >nul
cls
if errorlevel 1 (set Updatestatus=An update is available at https://github.com/Andrebeck27/plugin-manager-test!) else (set Updatestatus=Manager is up-to-date.)
del C:\ytdl\plugins-a\manager\most-recent-changelog.txt
goto statuses

:notconnected
echo Not connected to internet. Not checking for update.
set Updatestatus=You are offline. No checks for updates were performed.
goto setstatuses
 
:notconnected2
echo Not connected to internet. Not checking for update.
set Updatestatus=You are offline. No checks for updates were performed.
goto statuses


:setstatuses
set /A GUIps1 = 0
set /A UiHelper = 0
set /A mp3qd = 0
set /A mp4qd = 0
if not exist C:\ytdl\GUIps1.ps1 set /A GUIps1 = 1
if not exist C:\ytdl\UiHelper.bat set /A UiHelper = 1
if not exist C:\ytdl\mp3-qd.ps1 set /A mp3qd = 1
if not exist C:\ytdl\mp4-qd.ps1 set /A mp4qd = 1
rem ___________________________________________ 
if exist C:\ytdl\plugins-a set /A pluginsfolder = 1
rem ___________________________________________
set /A fdGUIps1 = 0
set /A fdUiHelper = 0
set /A fdmp3qd = 0
set /A fdmp4qd = 0
if not exist C:\ytdl\plugins-a\GUI\GUIps1.ps1 set /A fdGUIps1 = 1
if not exist C:\ytdl\plugins-a\GUI\UiHelper.bat set /A fdUiHelper = 1
if not exist C:\ytdl\plugins-a\mp3-qd.ps1 set /A fdmp3qd = 1
if not exist C:\ytdl\plugins-a\mp4-qd.ps1 set /A fdmp4qd = 1
echo Temporary Debug info
echo holy fucking shit this is gonna be the end of me
echo.
echo %GUIPs1%
echo %UiHelper%
echo %mp3qd%
echo %mp4qd%
echo %fdGUIps1%
echo %fdUiHelper%
echo %fdmp3qd%
echo %fdmp4qd%
echo.
echo Proceed:

goto statuses
:statuses
cls
echo.
echo %Updatestatus%
echo.
echo CHECKS IN C:\ytdl\plugins-a
if %fdGUIps1% == 1 (if %fdUIHelper% == 1 (echo GUI not installed or corrupted.) else (echo UiHelper is installed, but GUIps1 is not.)) else (if %fdUIHelper% == 1 (echo GUIps1.ps1 is installed, but UiHelper is not.) else (echo GUI files are installed correctly.))
if %fdmp3qd% == 1 (if %fdmp4qd% == 1 (echo Quick Downloader not installed.) else (echo mp3-qd is installed, but mp4-qd is not.)) else (if %fdmp4qd% == 1 (echo mp3-qd is installed, but mp4-qd is not.) else (echo mp4-qd and mp3-qd are installed.))
echo.
echo PROGRAM STATUSES RUNDOWN:
if %fdGUIps1% == 1 (if %fdUIHelper% == 1 (echo yt-dlp PoSh GUI = [91mMISSING[0m) else (echo yt-dlp PoSh GUI = [93mCORRUPT[0m)) else (if %fdUIHelper% == 1 (echo yt-dlp PoSh GUI = [93mCORRUPT[0m) else (echo yt-dlp PoSh GUI = [92mINSTALLED[0m))
if %fdmp3qd% == 1 (if %fdmp4qd% == 1 (echo Quick Download = [91mMISSING[0m) else (echo Quick Download = [93mPARTIALLY INSTALLED[0m)) else (if %fdmp4qd% == 1 (echo Quick Download = [93mCORRUPT[0m) else (echo Quick Download = [92mINSTALLED[0m))
echo Old batch script = [90mNot detectable[0m
echo.
echo _________________________________________________________________
echo.
echo CHECKS IN C:\ytdl
if %GUIps1% == 1 (if %UIHelper% == 1 (echo GUI not installed.) else (echo UiHelper is installed, but GUIps1 is not.)) else (if %UIHelper% == 1 (echo GUIps1.ps1 is installed, but UiHelper is not.) else (echo GUI is installed.))
if %mp3qd% == 1 (if %mp4qd% == 1 (echo Quick Downloader not installed.) else (echo mp3-qd is installed, but mp4-qd is not.)) else (if %mp4qd% == 1 (echo mp3-qd is installed, but mp4-qd is not.) else (echo Quick Downloader is installed.))
echo.
echo PROGRAM STATUSES RUNDOWN:
if %GUIps1% == 1 (if %UIHelper% == 1 (echo yt-dlp PoSh GUI = [91mMISSING[0m) else (echo yt-dlp PoSh GUI = [93mCORRUPT[0m)) else (if %UIHelper% == 1 (echo yt-dlp PoSh GUI = [93mCORRUPT[0m) else (echo yt-dlp PoSh GUI = [92mINSTALLED[0m))
if %mp3qd% == 1 (if %mp4qd% == 1 (echo Quick Download = [91mMISSING[0m) else (echo Quick Download = [93mPARTIALLY INSTALLED[0m)) else (if %mp4qd% == 1 (echo Quick Download = [93mCORRUPT[0m) else (echo Quick Download = [92mINSTALLED[0m))
echo Old batch script = [90mNot detectable[0m
echo.
echo Press any key to move to the menu.
pause >nul
goto menu

:menu
cls
echo ----------- :menu -----------
echo.
echo Press 1 to manage files in \plugins-a
echo.
echo Press 2 to manage files in \ytdl 
echo.
echo Press 3 to manage other stuff.
echo.
echo Press 4 to check for updates.
echo.
echo Press 5 to see additions to local changelog.
echo.
echo Press 6 to go back to statuses.
echo.
choice /c 123456
rem list errorlevels in DECREASING order
if errorlevel 6 goto statuses
if errorlevel 5 goto newchangelog
if errorlevel 4 goto update2
if errorlevel 3 goto othermanage
if errorlevel 2 goto ytdlmenu
if errorlevel 1 goto pluginsamenu
cls
goto menu


:pluginsamenu
cls
echo ----------- :pluginsamenu -----------
echo.
echo Press 1 to manage shortcuts
echo.
echo Press 2 to install or uninstall plugins
echo.
echo Press 3 to manage plugins-a settings
echo.
echo Press any key to go back to :menu
choice /c 123
rem list errorlevels in DECREASING order
if errorlevel 3 goto plugamanage
if errorlevel 2 goto plugainstuninst
if errorlevel 1 goto plugashortcuts
cls
goto menu



:plugashortcuts
cls
echo ----------- :plugashortcuts -----------
echo.
echo Press 1 to create GUI shortcut.
echo.
echo Press 2 to create Quick Download shortcuts.
echo.
echo Press any key to return to :pluginsamenu
echo.
choice /c 123
rem DECREASING
cls
if errorlevel 2 goto plugaqdshortcut
if errorlevel 1 goto plugaGUIshortcut
cls
goto pluginsamenu

:plugaqdshortcut
echo ----------- :plugaqdshortcut -----------
echo.
echo Press 1 to create the shortcut for mp3-qd.
echo.
echo Press 2 to create the shortcut for mp4-qd.
echo.
echo Press any key to return to :plugashortcuts
echo.
choice /c 12
rem DECREASING
cls
if errorlevel 2 goto createplugamp4qdshort
if errorlevel 1 goto createplugamp3qdshort
cls
goto plugashortcuts

:createplugamp3qdshort
powershell "$s=(New-Object -COM WScript.Shell).CreateShortcut('C:\ytdl\plugins-a\shortcut\mp3-qd.lnk');$s.TargetPath='C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -WindowStyle Hidden -ExecutionPolicy Bypass -File "C:\ytdl\plugins-a\mp3-qd.ps1"';$s.Save()"
cls
echo Created mp3-qd shortcut in \plugins-a\shortcuts
echo.
goto plugaqdshortcut



:ytdlmenu
cls
echo ----------- :ytdlmenu -----------
echo.
echo Press 1 to transfer plugins in plugins-a to root
echo.
echo Press 2 to install or uninstall plugins
echo.
echo Press 3 to manage yt-dlp settings
echo.
choice /c 123
rem list errorlevels in DECREASING order
if errorlevel 3 goto ytdlpsettings
if errorlevel 2 goto rootmanage
if errorlevel 1 goto transferwarnroot
cls
goto menu

:othermanage
cls
echo todo
echo.
echo finish this script LMFAOOO
pause
goto statuses
