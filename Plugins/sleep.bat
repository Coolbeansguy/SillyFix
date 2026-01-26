@echo off
color 05
cls

:sleep_menu
cls
echo.
echo  =========================================
echo    SILLY SLEEP - AUTO SHUTDOWN MANAGER
echo       (Created by swapNspit)
echo  =========================================
echo.
echo  [1] Shutdown in 1 Hour
echo  [2] Shutdown in 2 Hours
echo  [3] Custom Timer (Minutes)
echo  [4] CANCEL Scheduled Shutdown
echo  [5] Exit
echo.
set /p "ch=Selection > "

if "%ch%"=="1" set "min=60" & goto schedule
if "%ch%"=="2" set "min=120" & goto schedule
if "%ch%"=="3" goto custom
if "%ch%"=="4" goto cancel
if "%ch%"=="5" exit /b
goto sleep_menu

:custom
echo.
set /p "min=Enter minutes until shutdown > "
goto schedule

:schedule
set /a sec=%min%*60
shutdown -s -t %sec%
cls
echo.
echo  [!] TIMER SET!
echo  -----------------------------------------
echo  System will shutdown in %min% minutes.
echo  You can close SillyFix now.
echo  -----------------------------------------
pause
goto sleep_menu

:cancel
shutdown -a
cls
echo.
echo  [!] TIMER CANCELLED.
echo  Your PC will stay awake.
pause
goto sleep_menu
