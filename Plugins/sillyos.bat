@echo off
title SillyOS Desktop
color 17
cls

:: --- DEBUG PAUSE ---
:: If it crashes, this lets you see why.
echo [DEBUG] Loading SillyOS...
timeout /t 1 >nul

:: --- MAIN MENU ---
:desktop
cls
echo.
echo  _________________________________________________________
echo  |  SILLY OS v1.8                        User: Admin       |
echo  |_________________________________________________________|
echo.
echo      .---.          .---.          .---.          .---.
echo     | [_] |        |  $  |        |  ?  |        |  X  |
echo     '-----'        '-----'        '-----'        '-----'
echo    [1] Apps       [2] Store      [3] Info       [4] Log Out
echo.
echo   _________________________________________________________
echo.
set /p os_choice=Command^> 

if %os_choice%==1 goto apps
if %os_choice%==2 goto launch_store
if %os_choice%==3 goto info
if %os_choice%==4 goto logout
goto desktop

:apps
cls
echo.
echo  [ APP DRAWER ]
echo  1. AutoClicker
echo  2. Matrix
echo  3. Back
echo.
set /p app=Select^> 

if %app%==3 goto desktop

:: LAUNCH LOGIC (No Parentheses!)
if %app%==1 goto run_auto
if %app%==2 goto run_matrix
goto apps

:run_auto
start Files\auto.EXE
goto apps

:run_matrix
call Files\Plugins\matrix.bat
goto apps

:launch_store
call Files\Plugins\store.bat
goto desktop

:info
cls
echo.
echo  [ SYSTEM INFO ]
echo  OS: SillyOS v1.8
echo  Status: Working
echo.
pause
goto desktop

:logout
cls
echo.
echo  Logging out...
timeout /t 1 >nul
exit /b
