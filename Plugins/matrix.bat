@echo off
setlocal enabledelayedexpansion
cd /d "%~dp0"
color 05
title SillyStore - Plugin Repository
chcp 65001 >nul

:: --- DEFINE INSTALL PATH ---
set "install_path=%~dp0"

:store_home
cls
echo.
echo  ███████╗██╗██╗      ██╗      ██╗   ██╗    ███████╗████████╗ ██████╗ ██████╗ ███████╗
echo  ██╔════╝██║██║      ██║      ╚██╗ ██╔╝    ██╔════╝╚══██╔══╝██╔═══██╗██╔══██╗██╔════╝
echo  ███████╗██║██║      ██║       ╚████╔╝     ███████╗   ██║   ██║   ██║██████╔╝█████╗  
echo  ╚════██║██║██║      ██║        ╚██╔╝      ╚════██║   ██║   ██║   ██║██╔══██╗██╔══╝  
echo  ███████║██║███████╗███████╗    ██║        ███████║   ██║   ╚██████╔╝██║  ██║███████╗
echo  ╚══════╝╚═╝╚══════╝╚══════╝    ╚═╝        ╚══════╝   ╚═╝    ╚═════╝ ╚═╝  ╚═╝╚══════╝
echo.
echo                     [ OFFICIAL PLUGIN REPOSITORY ]
echo.
echo      [ OPTIONS ]
echo.
echo  ╔══════════════╗    ╔══════════════╗    ╔══════════════╗
echo  ║  Browse Apps ║    ║  Manage Apps ║    ║  Exit Store  ║
echo  ╚═════╔1╗══════╝    ╚═════╔2╗══════╝    ╚═════╔3╗══════╝
echo.
echo  ----------------------------------------------------------------
set /p "ch=-------[ Selection ] > "

if "%ch%"=="1" goto browse
if "%ch%"=="2" goto uninstall
if "%ch%"=="3" exit /b
goto store_home

:browse
cls
echo.
echo  [ MARKETPLACE ]
echo  ===================================================================
echo  ^| ID ^|   PLUGIN NAME    ^|     AUTHOR       ^|      DESCRIPTION      ^|
echo  ^|----^|------------------^|-----------------^|-----------------------^|
echo  ^| 1  ^| SillySleep       ^| swapNspit       ^| Auto-Shutdown Timer   ^|
echo  ^| 2  ^| SillyConvert     ^| swapNspit       ^| Unit Converter Tool   ^|
echo  ^| 3  ^| SillyToDo        ^| swapNspit       ^| Task Manager          ^|
echo  ^| 4  ^| SillyCipher      ^| swapNspit       ^| Secret Message Tool   ^|
echo  ^| 5  ^| SillyMatrix      ^| swapNspit       ^| Falling Code Screen   ^|
echo  ===================================================================
echo.
echo  [B] Back to Menu
echo.
set /p "dl=Enter ID to Install (Example: 1) > "

if /i "%dl%"=="b" goto store_home

if "%dl%"=="1" set "pname=SillySleep" & set "fname=sleep.bat" & set "target_url=https://raw.githubusercontent.com/Coolbeansguy/SillyFix/main/Plugins/sleep.bat" & goto download
if "%dl%"=="2" set "pname=SillyConvert" & set "fname=convert.bat" & set "target_url=https://raw.githubusercontent.com/Coolbeansguy/SillyFix/main/Plugins/convert.bat" & goto download
if "%dl%"=="3" set "pname=SillyToDo" & set "fname=todo.bat" & set "target_url=https://raw.githubusercontent.com/Coolbeansguy/SillyFix/main/Plugins/todo.bat" & goto download
if "%dl%"=="4" set "pname=SillyCipher" & set "fname=cipher.bat" & set "target_url=https://raw.githubusercontent.com/Coolbeansguy/SillyFix/main/Plugins/cipher.bat" & goto download
if "%dl%"=="5" set "pname=SillyMatrix" & set "fname=matrix.bat" & set "target_url=https://raw.githubusercontent.com/Coolbeansguy/SillyFix/main/Plugins/matrix.bat" & goto download

goto browse

:download
cls
echo.
echo  [ DOWNLOAD MANAGER ]
echo  ------------------------------
echo  [~] Connecting to GitHub...
echo  [~] Downloading: %pname%
echo.

curl -L -f "%target_url%" -o "%install_path%%fname%"

if exist "%install_path%%fname%" (
    echo.
    echo  [OK] DOWNLOAD COMPLETE.
    echo  %pname% has been installed successfully.
) else (
    echo.
    echo  [!] DOWNLOAD FAILED.
    echo  Check your internet connection or GitHub link.
    echo  Target: %target_url%
)
echo.
pause
goto store_home

:uninstall
cls
echo.
echo  [ APP MANAGER ]
echo  ------------------------------
echo  Current Installed Plugins:
echo.
dir /b "%install_path%*.bat" | findstr /v /i "store.bat imp_dev.bat"
echo.
echo  ------------------------------
echo  Type the EXACT filename to delete (or 'b' to back).
echo.
set /p "del_target=Filename > "

if /i "%del_target%"=="b" goto store_home
if /i "%del_target%"=="store.bat" goto no_delete
if /i "%del_target%"=="imp_dev.bat" goto no_delete

if exist "%install_path%%del_target%" (
    del "%install_path%%del_target%"
    echo.
    echo  [OK] %del_target% was successfully removed.
    pause
    goto uninstall
) else (
    echo.
    echo  [!] File not found. Check spelling.
    pause
    goto uninstall
)

:no_delete
echo.
echo  [!] SYSTEM FILE PROTECTED.
pause
goto uninstall
