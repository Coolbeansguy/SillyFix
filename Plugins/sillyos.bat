@echo off
:: FIX: Ensure we are in the main folder
if exist "..\..\SillyFix.bat" pushd "..\.."

setlocal enabledelayedexpansion
color 17
title SillyOS Desktop

:init_check
if not exist "Files" mkdir "Files"

:boot
cls
echo.
echo  [ SILLY BIOS ]
echo  Loading Kernel... OK
echo  Mounting User Data... OK
timeout /t 1 >nul

:: --- LOGIN LOGIC ---
if exist "Files\user.dat" (
    set /p username=<"Files\user.dat"
    goto desktop
)

:setup
cls
echo.
echo  [ WELCOME TO SILLY OS ]
echo  Please create a user account.
echo.
set /p "new_user=Username > "

:: Fallback if empty
if "%new_user%"=="" set "new_user=Admin"

:: Set variable in memory
set "username=%new_user%"

:: SIMPLE SAVE (No crash risk)
:: We move the save logic to a subroutine to avoid syntax errors
call :save_user "%new_user%"
goto desktop

:save_user
:: This writes the file safely outside of any loops/brackets
(echo %~1) > "Files\user.dat"
exit /b

:desktop
cls
color 17
title SillyOS Desktop - User: %username%

echo.
echo   _________________________________________________________
echo  |  SILLY OS v1.0                        User: %username%  |
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
if "%os_choice%"=="2" call "Files\Plugins\store.bat" & goto desktop
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
if "%app%"=="1" start "" "Files\auto.EXE" & goto apps
if "%app%"=="2" call "Files\Plugins\matrix.bat" & goto apps
goto apps

:info
cls
echo.
echo  [ SYSTEM INFO ]
echo  OS: SillyOS v1.2
echo  Host Path: %cd%
echo.
pause
goto desktop

:logout
cls
echo.
echo  Logging out...
:: Restore original directory and exit
popd
exit /b
