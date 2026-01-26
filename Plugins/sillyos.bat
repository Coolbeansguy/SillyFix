@echo off
setlocal enabledelayedexpansion
color 17
title SillyOS Desktop

:: --- PATH CALCULATION (The Bulletproof Fix) ---
:: We calculate the 'Root' folder relative to this script.
:: Since this script is in Files\Plugins\, the root is two steps up.
set "SCRIPT_DIR=%~dp0"
set "ROOT_DIR=%SCRIPT_DIR%..\..\"
set "USER_FILE=%ROOT_DIR%Files\user.dat"

:boot
cls
echo.
echo  [ SILLY BIOS ]
echo  Loading Kernel... OK
echo  Mounting User Data... OK
timeout /t 1 >nul

:: --- LOGIN LOGIC ---
if exist "%USER_FILE%" (
    set /p username=<"%USER_FILE%"
    goto desktop
)

:setup
cls
echo.
echo  [ WELCOME TO SILLY OS ]
echo  Please create a user account.
echo.
set /p "new_user=Username > "

:: Prevent empty username
if "%new_user%"=="" set "new_user=Admin"

:: Set variable in memory
set "username=%new_user%"

:: Save using the calculated path
(echo %new_user%)>"%USER_FILE%"
goto desktop

:desktop
cls
color 17
title SillyOS Desktop - User: %username%

echo.
echo   _________________________________________________________
echo  |  SILLY OS v1.3                        User: %username%  |
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
if "%os_choice%"=="2" call "%ROOT_DIR%Files\Plugins\store.bat" & goto desktop
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
:: Note: We use ROOT_DIR to find tools safely
if "%app%"=="1" start "" "%ROOT_DIR%Files\auto.EXE" & goto apps
if "%app%"=="2" call "%ROOT_DIR%Files\Plugins\matrix.bat" & goto apps
goto apps

:info
cls
echo.
echo  [ SYSTEM INFO ]
echo  OS: SillyOS v1.3
echo  Root: %ROOT_DIR%
echo.
pause
goto desktop

:logout
cls
echo.
echo  Logging out...
exit /b
