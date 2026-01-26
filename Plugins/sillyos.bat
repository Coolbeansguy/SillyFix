@echo off
setlocal enabledelayedexpansion
color 17
title SillyOS Desktop

:: --- SMART PATH FINDER ---
:: 1. Check if we are already in the Main Folder (Launcher Mode)
if exist "SillyFix.bat" (
    set "USER_PATH=Files\user.dat"
    set "ROOT_PATH=."
    goto check_done
)

:: 2. Check if we are in the Plugins Folder (Direct Mode)
if exist "..\..\SillyFix.bat" (
    set "USER_PATH=..\..\Files\user.dat"
    set "ROOT_PATH=..\.."
    goto check_done
)

:: 3. If neither, we are lost.
cls
color 4f
echo.
echo  [!] ERROR: PATH NOT FOUND
echo  -------------------------
echo  SillyOS doesn't know where it is.
echo  Current Dir: %CD%
echo.
echo  Please make sure this file is in Files\Plugins\
pause
exit /b

:check_done
:: --- BOOT SEQUENCE ---
cls
echo.
echo  [ SILLY BIOS ]
echo  ---------------------------
echo  [OK] Root Detected: %ROOT_PATH%
echo  [OK] User File: %USER_PATH%
echo.
echo  Loading Kernel...
timeout /t 1 >nul

:: --- LOGIN LOGIC ---
if exist "%USER_PATH%" (
    set /p username=<"%USER_PATH%"
    goto desktop
)

:setup
cls
echo.
echo  [ WELCOME TO SILLY OS ]
echo  Please create a user account.
echo.
set /p "new_user=Username > "

if "%new_user%"=="" set "new_user=Admin"
set "username=%new_user%"

:: --- SAFE SAVE ---
:: We use the variable we found earlier
(echo %new_user%) > "%USER_PATH%"

goto desktop

:desktop
cls
color 17
title SillyOS Desktop - User: %username%

echo.
echo   _________________________________________________________
echo  |  SILLY OS v1.4                        User: %username%  |
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

if "%os_choice%"=="1" goto apps
if "%os_choice%"=="2" call "%ROOT_PATH%\Files\Plugins\store.bat" & goto desktop
if "%os_choice%"=="3" goto info
if "%os_choice%"=="4" goto logout
goto desktop

:apps
cls
echo.
echo  [ APP DRAWER ]
echo  1. AutoClicker
echo  2. Matrix
echo  3. Back
echo.
set /p "app=Select > "
if "%app%"=="3" goto desktop
:: Use ROOT_PATH to find tools safely
if "%app%"=="1" start "" "%ROOT_PATH%\Files\auto.EXE" & goto apps
if "%app%"=="2" call "%ROOT_PATH%\Files\Plugins\matrix.bat" & goto apps
goto apps

:info
cls
echo.
echo  [ SYSTEM INFO ]
echo  OS: SillyOS v1.4
echo  User Path: %USER_PATH%
echo  Root Path: %ROOT_PATH%
echo.
pause
goto desktop

:logout
cls
echo.
echo  Logging out...
exit /b
