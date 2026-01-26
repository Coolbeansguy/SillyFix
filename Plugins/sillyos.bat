@echo off
:: Force script to run in its own directory
cd /d "%~dp0"
title SillyOS Desktop
setlocal enabledelayedexpansion

:: --- PRE-BOOT CHECKS ---
if not exist "Files" mkdir "Files" 2>nul

:: FIX: Safely load color. If missing, use default without showing error text.
if exist "Files\os_color.dat" (
    <"Files\os_color.dat" set /p "current_color="
) 2>nul
if defined current_color (color !current_color!) else (color 0B)

:desktop
cls
echo.
echo  =============================================================
echo  ^|  SILLY OS v2.5 [ULTIMATE]                User: Admin    ^|
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


cd /d "%~dp0..\.."


exit /b
