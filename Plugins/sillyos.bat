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
echo  ^|  SILLY OS v2.0 [PRO]                      User: Admin    ^|
echo  =============================================================
echo.
echo        .-----------.           .-----------.
echo        ^|   APPS    ^|           ^|   STORE   ^|
echo        ^|   [#]     ^|           ^|    ($)    ^|
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
echo  ^|  APP DRAWER                                             ^|
echo  =============================================================
echo.
echo    [1] AutoClicker v1.0
echo    [2] Matrix Code Rain
echo.
echo    [3] ^<-- Back to Desktop
echo.
echo  =============================================================
echo.
set "app="
set /p "app=Open App > "

if "%app%"=="3" goto desktop
if "%app%"=="1" goto run_auto
if "%app%"=="2" goto run_matrix
goto apps

:run_auto
start "" "Files\auto.EXE"
goto apps

:run_matrix
call "Files\Plugins\matrix.bat"
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
echo    OS Version:   SillyOS v2.0 Pro
echo    User:         Admin
echo    Status:       Online
echo    Resolution:   Text-Based (Batch)
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
