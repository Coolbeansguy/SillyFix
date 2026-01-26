@echo off
setlocal enabledelayedexpansion
color 05
cls

:cipher_main
cls
echo.
echo  ==============================================
echo     SILLY CIPHER - SECRET MESSAGING
echo         (Created by swapNspit)
echo  ==============================================
echo.
echo  [1] ENCRYPT a Message
echo  [2] DECRYPT a Message
echo  [3] Exit
echo.
set /p "ch=Selection > "

if "%ch%"=="1" goto encrypt
if "%ch%"=="2" goto decrypt
if "%ch%"=="3" exit /b
goto cipher_main

:encrypt
cls
echo.
echo  [ ENCRYPTION MODE ]
echo  Type your message below (Letters A-Z only).
echo.
set /p "text=Message > "

:: Simple substitution logic
set "code=!text!"
set "code=!code:a=z!" & set "code=!code:b=y!" & set "code=!code:c=x!"
set "code=!code:d=w!" & set "code=!code:e=v!" & set "code=!code:f=u!"
set "code=!code:g=t!" & set "code=!code:h=s!" & set "code=!code:i=r!"
set "code=!code:j=q!" & set "code=!code:k=p!" & set "code=!code:l=o!"
set "code=!code:m=n!" & set "code=!code:n=m!" & set "code=!code:o=l!"
set "code=!code:p=k!" & set "code=!code:q=j!" & set "code=!code:r=i!"
set "code=!code:s=h!" & set "code=!code:t=g!" & set "code=!code:u=f!"
set "code=!code:v=e!" & set "code=!code:w=d!" & set "code=!code:x=c!"
set "code=!code:y=b!" & set "code=!code:z=a!"

echo.
echo  ----------------------------------------------
echo  ENCRYPTED OUTPUT:
echo  ----------------------------------------------
echo  !code!
echo  ----------------------------------------------
echo.
echo  (Copy this and send it to a friend)
pause
goto cipher_main

:decrypt
cls
echo.
echo  [ DECRYPTION MODE ]
echo  Paste the secret code below.
echo.
set /p "code=Secret Code > "

:: Reverse substitution
set "text=!code!"
set "text=!text:z=a!" & set "text=!text:y=b!" & set "text=!text:x=c!"
set "text=!text:w=d!" & set "text=!text:v=e!" & set "text=!text:u=f!"
set "text=!text:t=g!" & set "text=!text:s=h!" & set "text=!text:r=i!"
set "text=!text:q=j!" & set "text=!text:p=k!" & set "text=!text:o=l!"
set "text=!text:n=m!" & set "text=!text:m=n!" & set "text=!text:l=o!"
set "text=!text:k=p!" & set "text=!text:j=q!" & set "text=!text:i=r!"
set "text=!text:h=s!" & set "text=!text:g=t!" & set "text=!text:f=u!"
set "text=!text:e=v!" & set "text=!text:d=w!" & set "text=!text:c=x!"
set "text=!text:b=y!" & set "text=!text:a=z!"

echo.
echo  ----------------------------------------------
echo  DECODED MESSAGE:
echo  ----------------------------------------------
echo  !text!
echo  ----------------------------------------------
pause
goto cipher_main
