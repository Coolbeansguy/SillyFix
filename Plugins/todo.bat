@echo off
color 05
cls

:todo_main
cls
echo.
echo  =========================================
echo         SILLY TODO - TASK MANAGER
echo          (Created by swapNspit)
echo  =========================================
echo.
if exist "Files\todo_list.txt" (
    echo  [ YOUR TASKS ]
    echo  -------------------------------------
    type "Files\todo_list.txt"
    echo  -------------------------------------
) else (
    echo  [!] You have no active tasks.
)
echo.
echo  [1] Add New Task
echo  [2] Clear All Tasks
echo  [3] Exit
echo.
set /p "ch=Selection > "

if "%ch%"=="1" goto add
if "%ch%"=="2" goto clear
if "%ch%"=="3" exit /b
goto todo_main

:add
echo.
set /p "task=Type task > "
echo  * %task% >> "Files\todo_list.txt"
goto todo_main

:clear
echo.
echo  Are you sure you want to delete all tasks? (y/n)
set /p "confirm=> "
if /i "%confirm%"=="y" (
    del "Files\todo_list.txt" >nul 2>&1
    echo  [!] List cleared.
    timeout /t 1 >nul
)
goto todo_main
