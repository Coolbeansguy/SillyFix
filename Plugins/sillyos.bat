@echo off
setlocal enabledelayedexpansion
color 17
title SillyOS Debug Mode

echo [DEBUG] Starting Path Detection...

:: --- 1. DETERMINE ROOT ---
if exist "SillyFix.bat" (
    set "ROOT=."
    echo [DEBUG] Mode: Launcher (Root is current dir)
) else (
    if exist "..\..\SillyFix.bat" (
        set "ROOT=..\.."
        echo [DEBUG] Mode: Plugin (Root is 2 levels up)
    ) else (
        echo [!] FATAL ERROR: Cannot find SillyFix.bat!
        echo     Current Dir: %CD%
        pause
        exit /b
    )
)

:: --- 2. DEFINE PATHS ---
set "USER_FILE=%ROOT%\Files\user.dat"
set "FILES_DIR=%ROOT%\Files"

echo [DEBUG] Root Path: %ROOT%
echo [DEBUG] User File: %USER_FILE%
echo.
echo Press any key to check for the Files folder...
pause >nul

:: --- 3. CHECK FILES FOLDER ---
if not exist "%FILES_DIR%" (
    echo [DEBUG] Files folder missing. Creating it...
    mkdir "%FILES_DIR%"
    if exist "%FILES_DIR%" (
        echo [OK] Folder created.
    ) else (
        echo [!] ERROR: Could not create folder at: %FILES_DIR%
        echo     Check permissions!
        pause
        exit /b
    )
) else (
    echo [OK] Files folder found.
)

echo.
echo Press any key to try Login...
pause >nul

:: --- 4. LOGIN LOGIC ---
if exist "%USER_FILE%" (
    echo [DEBUG] Found user.dat. Reading...
    set /p username=<"%USER_FILE%"
    echo [DEBUG] Read Username: !username!
    goto desktop
)

echo [DEBUG] No user found. Going to Setup.
echo Press any key to start Setup...
pause >nul

:setup
cls
echo.
echo  [ WELCOME TO SILLY OS ]
echo  Please create a user account.
echo.
set /p "new_user=Username > "

if "%new_user%"=="" set "new_user=Admin"
set "username=%new_user%"

echo.
echo [DEBUG] Attempting to save to: %USER_FILE%
echo Press any key to write file...
pause >nul

:: --- 5. THE SAVE COMMAND ---
(echo %new_user%) > "%USER_FILE%"

echo [DEBUG] File saved successfully!
pause
goto desktop

:desktop
cls
echo.
echo  [ SUCCESS! ]
echo  You made it to the desktop.
echo  User: %username%
echo.
pause
exit /b
