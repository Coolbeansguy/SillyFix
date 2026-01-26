@echo off
:: FIX: This ensures we are looking at the main folder, not the Plugins folder
if exist "..\..\SillyFix.bat" pushd "..\.."

setlocal enabledelayedexpansion
color 17
title SillyOS Desktop

:init_check
:: Debug Check: If we still can't find the Files folder, stop and show error
if not exist "Files" (
    cls
    color 4f
    echo.
    echo  [!] ERROR: FILE SYSTEM NOT FOUND
    echo      SillyOS cannot find the 'Files' folder.
    echo      Current Directory: %cd%
    echo.
    pause
    exit /b
)

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
) else (
    goto setup
)

:setup
cls
echo.
echo  [ WELCOME TO SILLY OS ]
echo  Please create a user account.
echo.
set /p "new_user=Username > "

:: Set the variable in memory first (So the OS works no matter what)
set "username=%new_user%"

:: Try to save to file safely.
cmd /c "(echo %new_user%)>Files\user.dat" >nul 2>&1

:: If the file wasn't created, we just move on.
goto desktop

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
:: Launch Tools (Make sure paths are correct!)
if "%app%"=="1" start "" "Files\auto.EXE" & goto apps
if "%app%"=="2" call "Files\Plugins\matrix.bat" & goto apps
goto apps

:info
cls
echo.
echo  [ SYSTEM INFO ]
echo  OS: SillyOS v1.1
echo  Host Path: %cd%
echo.
pause
goto desktop

:logout
cls
echo.
echo  Logging out...
:: If we used pushd earlier, we popd back to normal
popd
exit /b
