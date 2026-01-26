@echo off
:: Force script to run in its own directory
cd /d "%~dp0"
title SillyOS Desktop
setlocal enabledelayedexpansion

:: --- 1. BOOT SCREEN ANIMATION ---
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

:: --- 2. SAFE COLOR LOADER ---
:: This sets a default first, so we don't error out if the file is missing
set "current_color=0B"

:: We check if the file exists. If yes, we read it. If no, we skip it.
if exist "Files\os_color.dat" (
    set /p current_color=<"Files\os_color.dat"
)

:: Apply the color (Default is 0B if no file exists)
color !current_color!

:desktop
cls
echo.
echo  =============================================================
echo  ^|  SILLY OS v2.6 [ULTIMATE]                User: Admin    ^|
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
echo  =============================================================
echo  ^|  DYNAMIC PROGRAM LIST                                  ^|
echo  =============================================================
:: This lists all .bat files in the current folder
dir /b *.bat
echo.
set /p "app=Open Program > "
if /i "%app%"=="back" goto desktop
if exist ".\%app%" (
    start "" ".\%app%"
    goto apps
)
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

:: --- 3. THE LOGOUT FIX ---
:: Since SillyFix 'called' this script, we just need to reset the folder and exit.
cd /d "%~dp0..\.."

:: Exit /b tells the script "I am done, go back to the previous window"
exit /b
