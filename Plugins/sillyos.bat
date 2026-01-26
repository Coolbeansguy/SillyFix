@echo off
:: --- 1. RESIZE WINDOW ---
:: Forces the window to be 80 columns wide, 30 lines tall so it looks correct
mode con: cols=80 lines=30
cd /d "%~dp0"
title SillyOS Desktop
setlocal enabledelayedexpansion

:: --- 2. BOOT ANIMATION ---
cls
color 0B
echo.
echo   [ SILLY OS KERNEL ]
echo.
echo   Loading Drivers . . .
timeout /t 1 >nul
echo   Mounting File System . . .
if not exist "Files" mkdir "Files" 2>nul
timeout /t 1 >nul
echo   Starting User Interface . . .
timeout /t 1 >nul
cls

:: --- 3. THE "NO ERROR TEXT" FIX ---
set "current_color=0B"
:: This loop checks if the file exists first. If not, it does nothing. No error text possible.
if exist "Files\os_color.dat" (
    for /f "usebackq delims=" %%a in ("Files\os_color.dat") do set "current_color=%%a"
)
color !current_color!

:desktop
cls
echo.
echo  =============================================================
echo  ^|  SILLY OS v3.1 [ULTIMATE]                User: Admin    ^|
echo  =============================================================
echo.
echo        .-----------.            .-----------.
echo        ^|   APPS    ^|            ^| SILLYFIX  ^|
echo        ^|   [#]     ^|            ^|   STORE   ^|
echo        '-----------'            '-----------'
echo             (1)                      (2)
echo.
echo        .-----------.            .-----------.
echo        ^| SETTINGS  ^|            ^|  LOGOUT   ^|
echo        ^|   (s)     ^|            ^|   <--     ^|
echo        '-----------'            '-----------'
echo             (3)                      (4)
echo.
echo  =============================================================
echo  DATE: %DATE% ^| TIME: %TIME:~0,5% ^| STATUS: ONLINE
echo  =============================================================
echo.

set "os_choice="
set /p "os_choice=Selection > "

if "%os_choice%"=="1" goto apps
if "%os_choice%"=="2" goto launch_store
if "%os_choice%"=="3" goto settings
if "%os_choice%"=="s" goto settings
if "%os_choice%"=="4" goto logout
goto desktop

:apps
cls
echo.
echo  =============================================================
echo  ^|  INSTALLED PROGRAMS                                    ^|
echo  =============================================================
echo.
echo    [1] AutoClicker       [2] SillySniffer    [3] SillySpam
echo    [4] SillyWeb          [5] SillySpecs      [6] SillyCheck
echo    [7] SillyClean        [8] SillyNuke       [9] SillyMusic
echo    [10] SillyChat        [11] SillyWatch     [12] SillyVault
echo    [13] Matrix Rain      [14] BACK
echo.
echo  =============================================================
echo.
set "app="
set /p "app=Open Program > "

if "%app%"=="14" goto desktop

:: --- APP LAUNCHER (Fixed Paths) ---
:: We use "..\" to look in the parent folder where your apps actually are

if "%app%"=="1" start "" "..\auto.EXE" & goto apps
if "%app%"=="2" start "" "..\wifi.bat" & goto apps
if "%app%"=="3" start "" "..\spam.bat" & goto apps
if "%app%"=="4" start "" "..\web.bat" & goto apps
if "%app%"=="5" start "" "..\specs.bat" & goto apps
if "%app%"=="6" start "" "..\check.bat" & goto apps
if "%app%"=="7" start "" "..\clean.bat" & goto apps
if "%app%"=="8" start "" "..\nuke.bat" & goto apps
if "%app%"=="9" start "" "..\music.bat" & goto apps
if "%app%"=="10" start "" "..\chat.bat" & goto apps
if "%app%"=="11" start "" "..\watch.bat" & goto apps
if "%app%"=="12" start "" "..\locker.bat" & goto apps
if "%app%"=="13" (
    if exist "matrix.bat" start "" "matrix.bat"
    if exist "..\matrix.bat" start "" "..\matrix.bat"
    goto apps
)

echo [!] App not found.
timeout /t 1 >nul
goto apps

:launch_store
if exist "store.bat" (
    call "store.bat"
) else (
    echo [!] store.bat not found.
    pause
)
goto desktop

:settings
cls
echo  [ PERSONALIZATION ]
echo  1. Matrix  2. Blue  3. Red  4. Cyan  5. Purple  6. Gold  7. Back
set /p "col_choice=Option > "
if "%col_choice%"=="1" set "new_col=0A"
if "%col_choice%"=="2" set "new_col=09"
if "%col_choice%"=="3" set "new_col=0C"
if "%col_choice%"=="4" set "new_col=0B"
if "%col_choice%"=="5" set "new_col=05"
if "%col_choice%"=="6" set "new_col=0E"
if "%col_choice%"=="7" goto desktop
color %new_col%
echo %new_col% > "Files\os_color.dat"
goto settings

:logout
cls
color 0C
echo.
echo  [!] SYSTEM SHUTDOWN
echo    Returning to SillyFix...
timeout /t 2 >nul

:: Move back to main folder
cd /d "%~dp0..\.."

:: Simply exit. Since SillyFix called us, we return to it automatically.
exit /b
