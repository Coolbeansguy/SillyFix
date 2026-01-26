@echo off
setlocal enabledelayedexpansion
color 17
title SillyOS Desktop

:: --- STEP 1: FIND THE ROOT FOLDER ---
:: We do this one step at a time to avoid crashes.

if exist "SillyFix.bat" goto :found_root
if exist "..\..\SillyFix.bat" goto :move_up_2
if exist "..\SillyFix.bat" goto :move_up_1

:: If we can't find it anywhere:
cls
echo.
echo  [!] CRITICAL ERROR
echo  Cannot find 'SillyFix.bat'.
echo  Please ensure this file is inside 'Files\Plugins'.
pause
exit /b

:move_up_2
cd ..\..
goto :found_root

:move_up_1
cd ..
goto :found_root

:found_root
:: --- STEP 2: WE ARE NOW SAFELY AT THE ROOT ---
:: Now we don't need weird paths. Everything is just "Files\..."

if not exist "Files" mkdir "Files"

:: --- STEP 3: LOGIN CHECK ---
if exist "Files\user.dat" goto :load_user
goto :create_user

:load_user
set /p username=<"Files\user.dat"
goto :desktop

:create_user
cls
echo.
echo  [ WELCOME TO SILLY OS ]
echo  Please create a user account.
echo.
set /p "new_user=Username > "
if "%new_user%"=="" set "new_user=Admin"

:: Set variable
set "username=%new_user%"

:: Save file safely
echo %new_user% > "Files\user.dat"
goto :desktop

:desktop
cls
color 17
title SillyOS Desktop - User: %username%

echo.
echo   _________________________________________________________
echo  |  SILLY OS v1.5                        User: %username%  |
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
echo  OS: SillyOS v1.5 (Stable)
echo  Location: %CD%
echo.
pause
goto :desktop

:logout
cls
echo.
echo  Logging out...
exit /b
