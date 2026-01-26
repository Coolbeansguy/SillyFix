@echo off
title SillyOS Desktop
color 0B
cls

:: --- FAKE BOOT ANIMATION ---
echo.
echo  [ SYSTEM ] Loading Graphics Engine...
timeout /t 1 >nul
cls

:: --- MAIN MENU ---
:desktop
cls
echo.
echo  =============================================================
echo  ^|  SILLY OS v2.1 [ULTIMATE]                 User: Admin    ^|
echo  =============================================================
echo.
echo        .-----------.           .-----------.
echo        ^|   APPS    ^|           ^| SILLYFIX  ^|
echo        ^|   [#]     ^|           ^|   STORE   ^|
echo        '-----------'           '-----------'
echo             (1)                     (2)
echo.
echo        .-----------.           .-----------.
echo        ^|   INFO    ^|           ^|  LOGOUT   ^|
echo        ^|   (i)     ^|           ^|   ^<--     ^|
echo        '-----------'           '-----------'
echo             (3)                     (4)
echo.
echo  =============================================================
echo.

set "os_choice="
set /p "os_choice=Selection > "

if "%os_choice%"=="1" goto apps
if "%os_choice%"=="2" goto launch_store
if "%os_choice%"=="3" goto info
if "%os_choice%"=="4" goto logout
goto desktop

:apps
cls
echo.
echo  =============================================================
echo  ^|  ALL PROGRAMS                                           ^|
echo  =============================================================
echo.
echo    [1] AutoClicker       [2] SillySniffer    [3] SillySpam
echo    [4] SillyWeb          [5] SillySpecs      [6] SillyCheck
echo    [7] SillyClean        [8] SillyNuke       [9] SillyMusic
echo    [10] SillyChat        [11] SillyWatch     [12] SillyVault
echo    [13] Matrix Rain      [14] Back
echo.
echo  =============================================================
echo.
set "app="
set /p "app=Open Program > "

if "%app%"=="14" goto desktop

:: --- APP LAUNCHER ---
:: These assume the files exist in the main Files folder

if "%app%"=="1" start "" "Files\auto.EXE" & goto apps
if "%app%"=="2" start "" "Files\wifi.bat" & goto apps
if "%app%"=="3" start "" "Files\spam.bat" & goto apps
if "%app%"=="4" start "" "Files\web.bat" & goto apps
if "%app%"=="5" start "" "Files\specs.bat" & goto apps
if "%app%"=="6" start "" "Files\check.bat" & goto apps
if "%app%"=="7" start "" "Files\clean.bat" & goto apps
if "%app%"=="8" start "" "Files\nuke.bat" & goto apps
if "%app%"=="9" start "" "Files\music.bat" & goto apps
if "%app%"=="10" start "" "Files\chat.bat" & goto apps
if "%app%"=="11" start "" "Files\watch.bat" & goto apps
if "%app%"=="12" start "" "Files\locker.bat" & goto apps
if "%app%"=="13" call "Files\Plugins\matrix.bat" & goto apps

:: Fallback
echo [!] App not found.
timeout /t 1 >nul
goto apps

:launch_store
call "Files\Plugins\store.bat"
goto desktop

:info
cls
echo.
echo  =============================================================
echo  ^|  SYSTEM INFORMATION                                     ^|
echo  =============================================================
echo.
echo    OS Version:   SillyOS v2.1 Ultimate
echo    User:         Admin
echo    Installed:    13 Apps
echo.
echo  =============================================================
pause
goto desktop

:logout
cls
color 0c
echo.
echo  [!] SYSTEM SHUTDOWN
echo      Logging out...
timeout /t 2 >nul
exit /b
