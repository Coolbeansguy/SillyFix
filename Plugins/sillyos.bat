@echo off
cd /d "%~dp0"
title SillyOS Desktop
setlocal enabledelayedexpansion

:: --- LOGGING FUNCTION ---
set "logfile=Files\system.log"
if not exist "Files" mkdir "Files" 2>nul
echo [%DATE% %TIME%] SillyOS Booted >> "%logfile%"

:: --- LOAD SAVED COLOR ---
if exist "Files\os_color.dat" (
    set /p current_color=<"Files\os_color.dat"
    color !current_color!
) else (
    color 0B
)

:desktop
cls
echo.
echo  =============================================================
echo  ^|  SILLY OS v2.2 [ULTIMATE]                User: Admin    ^|
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

:settings
cls
echo.
echo  =============================================================
echo  ^|  PERSONALIZATION SETTINGS                              ^|
echo  =============================================================
echo.
echo    [1] Matrix Green    [2] Deep Blue     [3] Blood Red
echo    [4] Classic Cyan    [5] Purple Rain   [6] Gold Edition
echo    [7] VIEW SYSTEM LOG [8] BACK TO DESKTOP
echo.
set /p "col_choice=Select Option > "

if "%col_choice%"=="1" set "new_col=0A" & set "theme_n=Matrix"
if "%col_choice%"=="2" set "new_col=09" & set "theme_n=DeepBlue"
if "%col_choice%"=="3" set "new_col=0C" & set "theme_n=BloodRed"
if "%col_choice%"=="4" set "new_col=0B" & set "theme_n=Classic"
if "%col_choice%"=="5" set "new_col=05" & set "theme_n=Purple"
if "%col_choice%"=="6" set "new_col=0E" & set "theme_n=Gold"
if "%col_choice%"=="7" start notepad.exe "%logfile%" & goto settings
if "%col_choice%"=="8" goto desktop

color %new_col%
echo %new_col% > "Files\os_color.dat"
echo [%DATE% %TIME%] Theme changed to %theme_n% >> "%logfile%"
goto settings

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
echo [%DATE% %TIME%] Entered Store >> "%logfile%"
if exist "store.bat" call "store.bat"
goto desktop

:logout
cls
color 0c
echo.
echo  [!] SYSTEM SHUTDOWN
echo    Returning to SillyFix...
echo [%DATE% %TIME%] User Logged Out >> "%logfile%"
timeout /t 2 >nul
:: --- THE CHANGE BACK FIX ---
:: This moves back two folders and runs the main SillyFix.bat
cd ..\..
if exist "SillyFix.bat" (
    start "" "SillyFix.bat"
)
exit
