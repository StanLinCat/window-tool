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
powershell -Command "Start-Sleep -Milliseconds 500"


echo Next step: Open taskmgr
start /B "" taskmgr
powershell -Command "Start-Sleep -Milliseconds 500"
echo taskmgr opened!

echo Next step: Open GitExtensions
start /B "" "C:\Users\User\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\GitExtensions.lnk"
powershell -Command "Start-Sleep -Milliseconds 500"
echo GitExtensions opened!

echo Next step: Open Google Chrome
start /B "" "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Google Chrome.lnk"
powershell -Command "Start-Sleep -Milliseconds 500"
echo Google Chrome opened!

echo Next step: Open Visual Studio Code
start /B "" "C:\Users\User\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Visual Studio Code\Visual Studio Code.lnk"
powershell -Command "Start-Sleep -Milliseconds 500"
echo Visual Studio Code opened!

echo Next step: Open Microsoft Excel
start /B "" "D:\Stan\buget_stan.xlsx"
powershell -Command "Start-Sleep -Milliseconds 500"
echo Microsoft Excel opened!

echo Next step: Open Obsidian
start /B "" "C:\Users\User\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Obsidian.lnk"
powershell -Command "Start-Sleep -Milliseconds 500"
echo Obsidian opened!

echo All programs and folders have been opened!
echo %time%

REM 這部分可以放你要自動執行的ps1檔路徑
timeout /t 1
powershell -ExecutionPolicy Bypass -File "D:\Stan\Tasks\task03_app_side_project\window_tool\eye_protect.ps1"
pause