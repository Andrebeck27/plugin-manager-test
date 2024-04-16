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
Powershell Invoke-WebRequest -Uri https://raw.githubusercontent.com/Andrebeck27/plugin-manager-test/main/changelog -OutFile C:\ytdl\plugins-a\manager\most-recent-changelog.txt
fc C:\ytdl\plugins-a\manager\most-recent-changelog.txt C:\ytdl\plugins-a\manager\local-changelog.txt >nul
cls
if errorlevel 1 (set Updatestatus=An update is available at https://github.com/Andrebeck27/plugin-manager-test!) else (set Updatestatus=Manager is up-to-date.)
del C:\ytdl\plugins-a\manager\most-recent-changelog.txt
goto setstatuses


:notconnected
echo Not connected to internet. Not checking for update.
set Updatestatus=You are offline. No checks for updates were performed.
goto setstatuses
 


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
if not exist C:\ytdl\plugins-a\GUIps1.ps1 set /A fdGUIps1 = 1
if not exist C:\ytdl\plugins-a\UiHelper.bat set /A fdUiHelper = 1
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
echo.
echo Press 1 to manage files in \plugins-a
echo.
echo Press 2 to manage files in \ytdl 
echo.
echo Press 3 to manage other stuff.
echo.
choice /c 123
rem list errorlevels in DECREASING order
if errorlevel 3 goto pluginsamenu
if errorlevel 2 goto ytdlmenu
if errorlevel 1 goto othermanage
cls
goto menu


:pluginsamenu
cls
echo todo
echo finish this script LMFAOOO
pause

:ytdlmenu
cls
echo todo
echo finish this script LMFAOOO
pause

:othermanage
cls
echo todo
echo finish this script LMFAOOO
pause
