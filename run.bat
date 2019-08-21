@echo off
cd /D %~dp0
for /F %%i in ('powershell Get-ExecutionPolicy') do (set oldpolicy=%%i)
rem echo %oldpolicy%
powershell Set-ExecutionPolicy remotesigned
powershell ./switch_album_sorter.ps1
powershell Set-ExecutionPolicy %oldpolicy%
pause