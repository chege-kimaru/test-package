@echo off
:: Helper functions for validation

echo [%date% %time%] Helper: Initializing validation environment...
timeout /t 1 >nul

:: Create a test file
echo This is test data > resources\runtime-data.txt

echo [%date% %time%] Helper: Checking network connectivity...
ping -n 1 www.microsoft.com >nul
if %errorlevel% neq 0 (
    echo [%date% %time%] ERROR: Network connectivity check failed!
    exit /b 1
)

echo [%date% %time%] Helper: Environment setup complete.
exit /b 0