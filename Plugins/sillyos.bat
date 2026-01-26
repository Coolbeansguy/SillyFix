@echo off
:: Force script to run in its own directory
cd /d "%~dp0"
title SillyOS Desktop
setlocal enabledelayedexpansion

:: --- PRE-BOOT CHECKS ---
:: Create Files folder if it's missing to prevent "File Not Found" crashes
if not exist "Files" mkdir "Files" 2>nul

:: --- LOGIN SYSTEM ---
:login
cls
color 0B
echo.
echo  =============================================================
echo  ^|                   SILLY OS SECURE LOGIN                 ^|
echo  =============================================================
echo.
set /p "pass=ENTER SYSTEM PASSWORD: "
if not "%pass%"=="silly123" (
    echo [!] ACCESS DENIED.
    timeout /t 2 >nul
    goto login
)

:: --- LOGGING & CONFIG ---
set "logfile=Files\system.log"
echo [%DATE% %TIME%] User Admin Logged In >> "%logfile%"

:: Use 2>nul to ignore errors if the file is empty or missing
if exist "Files\os_color.dat" (
    set /p current_color=<"Files\os_color.dat"
    color !current_color!
) 2>nul

:desktop
cls
echo.
echo  =============================================================
echo  ^|  SILLY OS v2.4 [ULTIMATE]                User: Admin    ^|
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
dir /b *.bat
echo.
set /p "app=Open Program > "
if /i "%app%"=="back" goto desktop
if exist ".\%app%" (
    echo [%DATE% %TIME%] Launched App: %app% >> "%logfile%"
    start "" ".\%app%"
    goto apps
)
goto apps

:launch_store
if exist "store.bat" call "store.bat"
goto desktop

:settings
cls
echo  [ PERSONALIZATION ]
echo  1. Matrix  2. Blue  3. Red  4. Cyan  5. Purple  6. Gold  7. Log  8. Back
set /p "col_choice=Option > "
if "%col_choice%"=="1" set "new_col=0A"
if "%col_choice%"=="2" set "new_col=09"
if "%col_choice%"=="3" set "new_col=0C"
if "%col_choice%"=="4" set "new_col=0B"
if "%col_choice%"=="5" set "new_col=05"
if "%col_choice%"=="6" set "new_col=0E"
if "%col_choice%"=="7" start notepad.exe "%logfile%" & goto settings
if "%col_choice%"=="8" goto desktop
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

:: Move out of 'Files\plugins' back to the main folder
cd /d "%~dp0..\.."

:: Start the main file and IMMEDIATELY exit this one to prevent a crash loop
if exist "SillyFix.bat" (
    start SillyFix.bat
    exit
) else (
    echo [!] ERROR: SillyFix.bat not found at: %cd%
    pause
    goto login
)
