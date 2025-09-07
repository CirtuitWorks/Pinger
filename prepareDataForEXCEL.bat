@REM Author: Jakub Samojluk j.samojluk@jasam.eu
@REM This programs parses data from output folder into comma separated values file

@REM Credits: user6811411 @ stackoverflow

@ECHO OFF
chcp 65001
cls 

@REM Header
echo PingDump by CirtuitWorks Jakub Samojluk &echo.
echo Version: %programVersion%
echo Data processing module
echo _____________________________________________________________________________________________________
echo.

@REM load config file
for /f "delims=" %%x in (TOOLS\config.cfg) do (set "%%x")

echo. && echo.  && echo|set /p ="Config loaded!"
setlocal enabledelayedexpansion
echo.
echo.
echo Reading files...
echo.


echo Options:
echo [1] Process singular file
echo [2] Porcess all files
echo.
choice /C 12 /M "Mode:" 
echo. &echo. Chosen mode: %ERRORLEVEL% 
if %ERRORLEVEL% EQU 1 (goto :SINGULARITY)
if %ERRORLEVEL% EQU 2 ()

:SINGULARITY
set n=0
for /r %%a in (%rawDir%\*.txt) do (
    set /a n+=1
    set "menu_!n!=%%a"
    echo Type !n! to choose %%~nxa
)
set /p "take=your choice:"

@REM extract filename
for %%F in ("!menu_%take%!") do set "fileName=%%~nF"

echo. && echo|set /p ="Creating temporary file: %rawDir%\%fileName%%tmpFileSuffix%" echo. && echo.
echo. && echo.  && echo|set /p ="final CSV fle to create: %finishedOutputFolder%\%fileName%"
echo.
echo.

if not exist %finishedOutputFolder%\ mkdir %finishedOutputFolder% && echo Creating output directory: %finishedOutputFolder% && echo.

echo. Processing data from input file! This may take a while... && echo. && echo.
echo External_IP;Date;Time;Host:Bytes sent;Response_time;TTL > %rawDir%\%fileName%%tmpFileSuffix%
(for /f "skip=1 usebackq delims=" %%A in (!menu_%take%!) do (
    set "line=%%A"
    call :cleanupData
)) >> %rawDir%\%fileName%%tmpFileSuffix%

@REM pause
call :powerShellScript

:cleanupData
setlocal enabledelayedexpansion
set "line=!line: =!"
set "line=!line:Replyfrom=!"
@REM set "line=!line::=;!"
set "line=!line:bytes=!"
set "line=!line:time=;!"
set "line=!line:ms=!"
set "line=!line:TTL=;!"
echo !line!
endLocal
goto :eof

:powerShellScript
echo Starting PowerShell script - output file cleanup
setlocal enableextensions disabledelayedexpansion
set textFile=%rawDir%\%fileName%%tmpFileSuffix%

:PowerShell
SET PSScript=%temp%\~tmpStrRplc.ps1
ECHO (Get-Content "%~dp0%textFile%").replace("=", "") ^| Set-Content "%~dp0%textFile%">"%PSScript%"

SET PowerShellDir=C:\Windows\System32\WindowsPowerShell\v1.0
CD /D "%PowerShellDir%"
Powershell -ExecutionPolicy Bypass -Command "& '%PSScript%'"
echo. && echo.  && echo|set /p ="Cleaning up!" && echo.
move %~dp0\%rawDir%\%fileName%%tmpFileSuffix% %~dp0\%finishedOutputFolder%\%fileName%%finalFileSuffix%
echo. && echo.  && echo|set /p ="Finished!" && echo. && echo.
pause
EXIT