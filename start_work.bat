@echo off
title Open Programs and Folders

echo %time%
echo Open Programs and Folders

REM 倒數計時 5 秒
for /l %%i in (5,-1,0) do (
    cls
    echo Starting boot: %%i
    if %%i NEQ 0 timeout /nobreak /t 1 >nul
)


echo Opening D:\User\Desktop...
explorer "D:\User\Desktop"
echo D:\Desktop opened!
powershell -Command "Start-Sleep -Milliseconds 500"


echo Next step: Open D:\Stan
explorer "D:\Stan"
echo D:\Stan opened!
powershell -Command "Start-Sleep -Milliseconds 500"


echo Next step: Open D:\stan_lin\fw\Tasks
explorer "D:\Stan\Tasks"
explorer "D:\Stan\Tasks"
explorer "D:\Stan\Tasks"
echo D:\stan_lin\fw\Tasks opened!

REM 開啟應用程式
powershell -Command "Start-Sleep -Milliseconds 500"
echo Next step: Open Microsoft Edge
"C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"
powershell -Command "Start-Sleep -Milliseconds 500"
echo Microsoft Edge opened!

echo Next step: Open Mozilla Firefox
"C:\Program Files\Mozilla Firefox\firefox.exe"
powershell -Command "Start-Sleep -Milliseconds 500"
echo Mozilla Firefox opened!

echo Next step: Open Microsoft Outlook
start /B "" "C:\Program Files\Microsoft Office\root\Office16\OUTLOOK.exe"
powershell -Command "Start-Sleep -Milliseconds 500"
echo Microsoft Outlook opened!

echo Next step: Open taskmgr
start /B "" taskmgr
powershell -Command "Start-Sleep -Milliseconds 500"
echo taskmgr opened!

echo Next step: Open AndeSight
start /B "" "C:\Andestech\AndeSight_STD_v324\ide\AndeSight.exe"
powershell -Command "Start-Sleep -Milliseconds 500"
echo AndeSight opened!

echo Next step: Open Visual Studio Code
start /B "" "C:\Users\User\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Visual Studio Code\Visual Studio Code.lnk"
powershell -Command "Start-Sleep -Milliseconds 500"
echo Visual Studio Code opened!

echo Next step: Open Microsoft Excel
start /B "" "C:\Program Files\Microsoft Office\root\Office16\EXCEL.exe" "D:\Stan\buget_stan.xlsx"
powershell -Command "Start-Sleep -Milliseconds 500"
echo Microsoft Excel opened!

echo Next step: Open Obsidian
start /B "" "C:\Users\User\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Obsidian.lnk"
powershell -Command "Start-Sleep -Milliseconds 500"
echo Obsidian opened!

echo All programs and folders have been opened!
echo %time%

timeout /t 1
powershell -ExecutionPolicy Bypass -File "D:\stan_lin\side_projects\myshell\eye_protect.ps1"
pause