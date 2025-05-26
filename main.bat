@echo off
:: Test validation batch file
echo [%date% %time%] Starting validation process...

:: Get command line arguments
set VMType=unknown
set CloudVaultId=unknown

:parse_args
if "%~1" == "" goto continue
if /i "%~1" == "-VMType" (
    set VMType=%~2
    shift
    shift
    goto parse_args
)
if /i "%~1" == "-CloudVaultId" (
    set CloudVaultId=%~2
    shift
    shift
    goto parse_args
)
shift
goto parse_args

:continue
echo [%date% %time%] Parameters:
echo [%date% %time%] - VMType: %VMType%
echo [%date% %time%] - CloudVaultId: %CloudVaultId%

:: Create output directory
mkdir output 2>nul

:: Check for admin rights
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo [%date% %time%] ERROR: This script requires administrator privileges!
    echo [%date% %time%] Please run as administrator.
    exit /b 1
)

:: Call helper script
call lib\helper.bat
if %errorlevel% neq 0 (
    echo [%date% %time%] ERROR: Helper script failed!
    exit /b %errorlevel%
)

:: Simulate work
echo [%date% %time%] Checking system compatibility...
timeout /t 2 >nul
echo [%date% %time%] System check complete.

echo [%date% %time%] Validating OS version %VMType%...
timeout /t 3 >nul
echo [%date% %time%] OS validation complete.

echo [%date% %time%] Accessing CloudVault with ID %CloudVaultId%...
timeout /t 2 >nul

:: Simulate random success/failure
set /a random_num=%random% %% 10
if %random_num% geq 8 (
    echo [%date% %time%] ERROR: CloudVault access failed!
    echo [%date% %time%] Validation failed!
    exit /b 1
)

echo [%date% %time%] CloudVault access successful.

:: Write some output for testing
echo Test completed successfully! > output\result.txt
echo VMType: %VMType% >> output\result.txt
echo CloudVaultId: %CloudVaultId% >> output\result.txt
echo Timestamp: %date% %time% >> output\result.txt

:: Show system info for validation
echo [%date% %time%] Collecting system information...
systeminfo | findstr /B /C:"OS Name" /C:"OS Version" > output\system-info.txt

echo [%date% %time%] Validation completed successfully!
exit /b 0