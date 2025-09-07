@REM Author: Jakub Samojluk j.samojluk@jasam.eu
@REM V 1.9
@REM This program checks and prints external IP address
@ECHO OFF
chcp 65001
cls 

@REM Header
echo PingDump by CirtuitWorks Jakub Samojluk &echo.
echo External IP address checker
echo Version: %programVersion%
echo _____________________________________________________________________________________________________
echo.

for /f "tokens=1* delims=: " %%A in ('nslookup myip.opendns.com. resolver1.opendns.com 2^>NUL^|find "Address:"'
) do set ExtIP=%%B

echo External IP is: %ExtIP%
echo. && echo. && pause