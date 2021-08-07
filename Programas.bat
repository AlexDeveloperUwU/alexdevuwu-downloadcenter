@echo off
:: BatchGotAdmin
:-------------------------------------
REM  --> Check for permissions
    IF "%PROCESSOR_ARCHITECTURE%" EQU "amd64" (
>nul 2>&1 "%SYSTEMROOT%\SysWOW64\cacls.exe" "%SYSTEMROOT%\SysWOW64\config\system"
) ELSE (
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
)

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params= %*
    echo UAC.ShellExecute "cmd.exe", "/c ""%~s0"" %params:"=""%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"
:--------------------------------------
title OBS Script
mkdir StreamSetup
cd StreamSetup
pause
echo.
echo [Plugin] OBS.Live
echo ##################
echo Con esto podras acceder al panel de chat, alertas, poner un chatbot para tu directo y mucho mas. Es una herramenta basica y esencial para nuevos streamers.
echo Te instalará también el OBS, programa con el cual haces los directos.
pause
echo.
echo Descargando OBS.Live
curl -o obslive.exe https://cdn.streamelements.com/obs/dist/obs-streamelements-installer-wrapper/windows/latest/obs-streamelements-setup-latest.exe
obslive.exe
pause
echo.
echo ---------------------------
echo.
cd..
echo mkdir Programas_Extras
cd Programas_Extras
echo [Plugin] StreamLabs chatbot
echo ###########################
echo Este es el ChatBot, el cual te permitira poner comandos personalizados y interactuar de diferentes formas.
pause
echo.
echo Descargando ChatBot
curl -o chatbot.exe https://cdn.streamlabs.com/chatbot/Streamlabs+Chatbot+Installer.exe
chatbot.exe /VERYSILENT
pause
echo.
echo ---------------------------
echo.
echo [Borrando archivos residuales de la instalación]
echo.
del /f /s /q StreamSetup 1>nul
rmdir /s /q StreamSetup
del /f /s /q Programas_Extras 1>nul
rmdir /s /q Programas_Extras
echo .
echo Done
exit