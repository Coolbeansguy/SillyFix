@echo off
setlocal enabledelayedexpansion
color 17
title SillyOS Desktop

:: --- PATH CALCULATION ---
:: Resolves the path to the folder two levels up from this script
set "SCRIPT_DIR=%~dp0"
for %%i in ("%SCRIPT_DIR%..\..") do set "ROOT_DIR=%%~fi\"
set "USER_FILE=%ROOT_DIR%Files\user.dat"

:: --- SAFETY CHECK ---
:: Create the Files folder if it doesn't exist so the script doesn't crash
if not exist "%ROOT_DIR%Files" mkdir "%ROOT_DIR%Files"

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

if "%new_user%"=="" set "new_user=Admin"
set "username=%new_user%"

:: Save the username
(echo %new_user%)>"%USER_FILE%"
goto desktop

:desktop
cls
color 17
title SillyOS Desktop - User: %username%

echo.
echo   _________________________________________________________
echo  ^|  SILLY OS v1.3                User: %username%  ^|
echo  ^|_________________________________________________________^|
echo.
echo       .---.          .---.          .---.          .---.
echo      ^| [_] ^|        ^|  $  ^|        ^|  ?  ^|        ^|  X  ^|
echo      '-----'        '-----'        '-----'        '-----'
echo     [1] Apps        [2] Store      [3] Info       [4] Log Out
echo.
echo   _________________________________________________________
echo.
set /p "os_choice=Command > "

if "%os_choice%"=="1" goto apps
if "%os_choice%"=="2" (
    if exist "%ROOT_DIR%Files\Plugins\store.bat" (
        call "%ROOT_DIR%Files\Plugins\store.bat"
    ) else (
        echo Store not found! & pause
    )
    goto desktop
)
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
