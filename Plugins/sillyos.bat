@echo off
:: SILLY OS THEME FILE
cls
color 17
title SillyOS Desktop

:desktop
cls
echo.
echo   _________________________________________________________
echo  |  SILLY OS v1.0                        User: Admin     |
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
if "%os_choice%"=="3" echo This is the SillyOS Theme! & pause & goto desktop
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
:: Add your tool logic here
echo Tool not linked in this demo.
pause
goto apps

:logout
cls
echo.
echo  Logging out of SillyOS...
echo DEFAULT > "Files\config.dat"
timeout /t 2 >nul
start "" "SillyFix.bat"
exit
