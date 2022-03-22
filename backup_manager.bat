@echo OFF

set basedir=%~dp0
set logsdir=%basedir%logs\robocopy.log
set dest=D:\

del /q "%logsdir%"

TITLE "Robocopy - Daily Dev Backup %basedir%"

@REM See https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/robocopy for robocopy commands. 
@REM And if you use "/mir" command, use it with CAUTION, I heard that it can delete your source files and stuff so be careful. Most of the time just the "/purge" command is more than enough

robocopy "F:\localhost" "%dest%\localhost" /e /purge /xo /tee /log+:"%logsdir%"
call :NOTIFY "Daily backup operation has been completed.", "Information", "Local Dev Server Backups"

:NOTIFY
@REM This function will create a notification in Windows 10 notifications center so I don't know if it will work with older version of Windows 

if "%~1"=="" exit /b 1
setlocal

if "%~2"=="" (set Icon=Information) else (set Icon=%~2)
powershell -Command "[void] [System.Reflection.Assembly]::LoadWithPartialName('System.Windows.Forms'); $objNotifyIcon=New-Object System.Windows.Forms.NotifyIcon; $objNotifyIcon.BalloonTipText='%~1'; $objNotifyIcon.Icon=[system.drawing.systemicons]::%Icon%; $objNotifyIcon.BalloonTipTitle='%~3'; $objNotifyIcon.BalloonTipIcon='None'; $objNotifyIcon.Visible=$True; $objNotifyIcon.ShowBalloonTip(5000);"

endlocal
GOTO :EOF

exit /b

