@echo off
setlocal enabledelayedexpansion
color 17
title SillyOS Desktop

:: --- STEP 1: FIND THE ROOT FOLDER ---
:: We still need this so the Apps (AutoClicker, Store) work correctly.

if exist "SillyFix.bat" goto :found_root
if exist "..\..\SillyFix.bat" goto :move_up_2
if exist "..\SillyFix.bat" goto :move_up_1

:: Fallback: If we can't find it, just proceed and hope for the best.
goto :found_root

:move_up_2
cd ..\..
goto :found_root

:move_up_1
cd ..
goto :found_root

:found_root
:: --- STEP 2: SKIP LOGIN ---
:: No saving, no reading. Just set the name in memory.
set "username=Admin"

:: Go straight to the desktop!
goto :desktop

:desktop
cls
color 17
title SillyOS Desktop - User: %username%

echo.
echo   _________________________________________________________
echo  |  SILLY OS v1.6                        User: %username%     |
echo  |_________________________________________________________|
echo.
echo      .---.          .---.          .---.          .---.
echo     | [_] |        |  $  |        |  ?  |        |  X  |
echo     '-----'        '-----'        '-----'        '-----'
echo    [1] Apps       [2] Store      [3] Info       [4] Log Out
echo.
echo   _________________________________________________________
echo.
set /p "os_choice=Command > "

if "%os_choice%"=="1" goto :apps
if "%os_choice%"=="2" goto :launch_store
if "%os_choice%"=="3" goto :info
if "%os_choice%"=="4" goto :logout
goto :desktop

:launch_store
:: We use call so it returns here when done
call "Files\Plugins\store.bat"
goto :desktop

:apps
cls
echo.
echo  [ APP DRAWER ]
echo  1. AutoClicker
echo  2. Matrix
echo  3. Back
echo.
set /p "app=Select > "
if "%app%"=="3" goto :desktop
if "%app%"=="1" start "" "Files\auto.EXE" & goto :apps
if "%app%"=="2" call "Files\Plugins\matrix.bat" & goto :apps
goto :apps

:info
cls
echo.
echo  [ SYSTEM INFO ]
echo  OS: SillyOS v1.6 (No Login)
echo  Location: %CD%
echo.
pause
goto :desktop

:logout
cls
echo.
echo  Logging out...
exit /b
