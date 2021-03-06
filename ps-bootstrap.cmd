@echo off
setlocal
REM Check to see if Powershell is in path
for %%X in (powershell.exe) do (set FOUND=%%~$PATH:X)
if not defined FOUND (
    echo Please install PowerShell v2 or newer.
	pause
	exit /b 1
)

REM Check to see if we have powershell v2 or later
PowerShell.exe -command "& { if ($host.Version.Major -lt 2) { exit 1 } }"
if %ERRORLEVEL% EQU 1 (
	echo Please upgrade to PowerShell v2 or later.
	pause
	exit /b 1
)
Set Query=HKLM\Software\Microsoft\Windows NT\CurrentVersion
REM Windows XP -- version 5.1
REG.exe Query %Query% | find /i "CurrentVersion" | find /i "5.1"
if %ErrorLevel% == 0 {
    Echo "This is a Windows XP Machine"
    Goto :VersionErr
}
REM Windows 7 -- version 6.1
REG.exe Query %Query% | find /i "CurrentVersion" | find /i "6.1"
if %ErrorLevel% == 0 {
    Echo "This is a Windows 7 Machine"
    Goto :FindBits
}
REM Vista -- version 6.0
REG.exe Query %Query% | find /i "CurrentVersion" | find /i "6.0"
if %ERRORLevel% == 0 {
    Echo "This is a Vista Machine"
    Goto :FindBits
}
:VersionErr
Echo "Only works on Windows Vista and Windows 7, Sorry!"
exit /b 1
:FindBits
Set Query=HKLM\Hardware\Description\System\CentralProcessor\0
REG.exe Query %Query% | find /i "Platform ID" | find /i "20" 
If %ERRORLEVEL% == 0 (
    Echo "This is 32 Bit Operating system"
    Echo "Use 32-bit version of PowerShell"
    Echo "C:\Windows\SysWOW64\WindowsPowerShell\v1.0\powershell.exe"
) ELSE (
    Echo "This is 64 Bit Operating System"
    Echo "Use 64-bit version of PowerShell"
    Echo "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe"
)
REM Set scriptDir to directory the batch file is located
set scriptDir=%~dp0
echo Running powershell.exe %scriptDir%get_env.ps1
REM Note the RemoteSigned in case the system is defaulted to restricted
powershell.exe -ExecutionPolicy RemoteSigned -command "& { "%scriptDir%get_env.ps1"; exit $LastExitCode }"
if "%ERRORLEVEL%" NEQ "0" (
	echo There may have been a problem with MyScript.  Please read the above text carefully before exiting.
)
pause
endlocal
