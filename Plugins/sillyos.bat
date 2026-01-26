@echo off
title SillyOS Desktop
color 17
cls

:: --- SAFETY PAUSE ---
:: If the script crashes instantly, this pause will catch it so you can see why.
:: Once it works, you can remove this line.
echo [DEBUG] SillyOS is starting...
timeout /t 1 >nul

:: --- MAIN MENU ---
:desktop
cls
echo.
echo   _________________________________________________________
echo  |  SILLY OS v1.7                        User: Admin     |
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
if "%os_choice%"=="2" goto launch_store
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

:: LAUNCH LOGIC
:: We assume we are in the main folder.
if "%app%"=="1" (
    if exist "Files\auto.EXE" (
        start "" "Files\auto.EXE"
    ) else (
        echo [!] Missing Files\auto.EXE
        pause
    )
    goto apps
)

if "%app%"=="2" (
    if exist "Files\Plugins\matrix.bat" (
        call "Files\Plugins\matrix.bat"
    ) else (
        echo [!] Missing Files\Plugins\matrix.bat
        pause
    )
    goto apps
)
goto apps

:launch_store
if exist "Files\Plugins\store.bat" (
    call "Files\Plugins\store.bat"
) else (
    echo [!] Store plugin not found.
    pause
)
goto desktop

:info
cls
echo.
echo  [ SYSTEM INFO ]
echo  OS: SillyOS v1.7
echo  Mode: Safe Start
echo.
pause
goto desktop

:logout
cls
echo.
echo  Logging out...
timeout /t 1 >nul
exit /b
