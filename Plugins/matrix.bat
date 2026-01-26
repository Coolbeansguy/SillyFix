@echo off
color 02
title SillyMatrix - Falling Code
cls

:matrix_intro
echo.
echo  =========================================
echo       SILLY MATRIX (By swapNspit)
echo  =========================================
echo.
echo  [!] WARNING: This will run infinitely.
echo      To EXIT, press [CTRL] + [C] or close the window.
echo.
echo  Press any key to enter the Matrix...
pause >nul

:matrix_loop
:: The %random% variable generates random numbers
echo %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random%
goto matrix_loop
