@echo off
setlocal enabledelayedexpansion
color 05
cls

:convert_menu
cls
echo.
echo  =========================================
echo      SILLY CONVERT - UNIT TOOL
echo       (Created by swapNspit)
echo  =========================================
echo.
echo  [1] Temperature (C to F)
echo  [2] Data Size (MB to GB)
echo  [3] Exit
echo.
set /p "c=Choose > "

if "%c%"=="1" goto temp
if "%c%"=="2" goto data
if "%c%"=="3" exit /b
goto convert_menu

:temp
cls
echo.
echo  [ TEMPERATURE CONVERTER ]
echo  Enter degrees in Celsius:
set /p "deg=Degrees C > "
set /a far=(%deg%*9/5)+32
echo.
echo  Result: %deg%C is approx %far%F
echo.
pause
goto convert_menu

:data
cls
echo.
echo  [ DATA SIZE CONVERTER ]
echo  Enter size in Megabytes (MB):
set /p "mb=Size MB > "
set /a gb=%mb%/1024
set /a rem=%mb%%%1024
echo.
echo  Result: %mb% MB is approx %gb%.%rem% GB
echo.
pause
goto convert_menu
