@echo off
:: Force script to run in its own directory
cd /d "%~dp0"
title SillyOS Desktop
setlocal enabledelayedexpansion

:: --- RECOVERY & LOGIN SYSTEM ---
:login
cls
color 0B
echo.
echo  =============================================================
echo  |                   SILLY OS SECURE LOGIN                 |
echo  =============================================================
echo.
echo  [1] Enter Password
echo  [2] Use Recovery Key
echo.
set /p "login_ch=Selection > "

if "%login_ch%"=="1" goto pass_entry
if "%login_ch%"=="2" goto recovery_entry
goto login

:pass_entry
set /p "pass=ENTER SYSTEM PASSWORD: "
:: Password is 'silly123'
if "%pass%"=="silly123" goto boot_os
echo [!] ACCESS DENIED.
timeout /t 2 >nul
goto login

:recovery_entry
if not exist "Files\recovery.txt" (
    echo [!] No recovery key found. Generate one in Settings first.
    pause
    goto login
)
set /p "key_input=ENTER RECOVERY KEY: "
set /p "stored_key=<Files\recovery.txt"
if "%key_input%"=="%stored_key%" goto boot_os
echo [!] INVALID KEY.
pause
goto login

:boot_os
:: --- LOGGING & CONFIG ---
set "logfile=Files\system.log"
if not exist "Files" mkdir "Files" 2>nul
echo [%DATE% %TIME%] User Admin Logged In >> "%logfile%"

:: THE FIX: Use 'if exist' and '2>nul' to hide the error from your screenshot
if exist "Files\os_color.dat" (
    set /p current_color=<"Files\os_color.dat"
    color !current_color!
) 2>nul

:desktop
cls
echo.
echo  =============================================================
echo  |  SILLY OS v2.4 [ULTIMATE]                User: Admin    |
echo  =============================================================
echo.
echo        .-----------.            .-----------.
echo        |   APPS    |            | SILLYFIX  |
echo        |   [#]     |            |   STORE   |
echo        '-----------'            '-----------'
echo             (1)                      (2)
echo.
echo        .-----------.            .-----------.
echo        | SETTINGS  |            |  LOGOUT   |
echo        |   (s)     |            |   <--     |
echo        '-----------'            '-----------'
echo             (3)                      (4)
echo.
echo  =============================================================
echo  DATE: %DATE% | TIME: %TIME:~0,5% | STATUS: ONLINE
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

:settings
cls
echo  [ PERSONALIZATION ]
echo  1. Matrix  2. Blue  3. Red  4. Cyan  5. Purple  6. Gold
echo  7. VIEW LOG  8. GENERATE RECOVERY KEY  9. BACK
set /p "col_choice=Option > "
if "%col_choice%"=="1" set "new_col=0A"
if "%col_choice%"=="2" set "new_col=09"
if "%col_choice%"=="3" set "new_col=0C"
if "%col_choice%"=="4" set "new_col=0B"
if "%col_choice%"=="5" set "new_col=05"
if "%col_choice%"=="6" set "new_col=0E"
if "%col_choice%"=="7" start notepad.exe "%logfile%" & goto settings
if "%col_choice%"=="8" goto gen_key
if "%col_choice%"=="9" goto desktop
color %new_col%
echo %new_col% > "Files\os_color.dat"
goto settings

:gen_key
set "key=%RANDOM%%RANDOM%"
echo %key% > "Files\recovery.txt"
echo [!] Recovery Key Generated: %key%
echo [!] This has been saved to Files\recovery.txt
pause
goto settings

:apps
cls
echo  =============================================================
echo  |  DYNAMIC PROGRAM LIST                                  |
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

:logout
cls
color 0C
echo.
echo  [!] SYSTEM SHUTDOWN
echo    Returning to SillyFix...
echo [%DATE% %TIME%] User Logged Out >> "%logfile%"
timeout /t 2 >nul

:: THE FINAL FIX: Move out of the plugins folder and run the main file
cd /d "%~dp0..\.."

if exist "SillyFix.bat" (
    start SillyFix.bat
    exit
) else (
    echo [!] ERROR: SillyFix.bat not found.
    echo Path checked: %CD%
    pause
    goto desktop
)
