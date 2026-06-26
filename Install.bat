@echo off
setlocal EnableDelayedExpansion

echo ====================================================================
echo               Darken Stream (HDR Fix) - Installer
echo ====================================================================
echo.
echo Hello! This script will automatically install the Darken Stream plugin 
echo into Discord. Because Vencord requires custom plugins to be built from 
echo source, this script will download the Vencord source code, insert our 
echo plugin, build it, and inject it into your Discord installation.
echo.
echo NOTE: This plugin is currently verified to work with Vencord v1.14.x.
echo Future Vencord updates may change plugin requirements.
echo.
echo ====================================================================
echo.

:: 1. Check for Git
where git >nul 2>nul
if %errorlevel% neq 0 (
    echo [ERROR] Git is not installed or not in your PATH.
    echo Please install Git from https://git-scm.com/downloads and try again.
    pause
    exit /b 1
)

:: 2. Check for pnpm (or npm, but Vencord strictly uses pnpm)
where pnpm >nul 2>nul
if %errorlevel% neq 0 (
    echo [ERROR] pnpm is not installed.
    echo Vencord requires pnpm to build. Please install Node.js from https://nodejs.org/
    echo Then open your terminal and run: npm install -g pnpm
    echo Once installed, run this installer again!
    pause
    exit /b 1
)

:: 3. Setup Vencord Source Directory
set VENCORD_DIR=%APPDATA%\Vencord-DarkenStream
echo [INFO] Setting up Vencord build environment at %VENCORD_DIR%...

if exist "%VENCORD_DIR%" (
    echo [INFO] Existing Vencord source found. Updating to latest version...
    cd /d "%VENCORD_DIR%"
    git reset --hard >nul
    git pull
) else (
    echo [INFO] Downloading Vencord source code from GitHub...
    git clone https://github.com/Vendicated/Vencord.git "%VENCORD_DIR%"
    cd /d "%VENCORD_DIR%"
)

:: 4. Copy Plugin Code
echo.
echo [INFO] Copying Darken Stream plugin into Vencord...
set PLUGIN_SOURCE="%~dp0darkenStream"
if not exist %PLUGIN_SOURCE% (
    echo [ERROR] Could not find the "darkenStream" folder next to this script!
    echo Make sure you extracted the entire zip file before running Install.bat.
    pause
    exit /b 1
)

:: Ensure the userplugins directory exists
if not exist "src\userplugins" mkdir "src\userplugins"

:: Copy the folder over (overwrite existing)
xcopy %PLUGIN_SOURCE% "src\userplugins\darkenStream" /E /I /H /Y >nul

:: 5. Install Dependencies and Build
echo.
echo [INFO] Installing Vencord dependencies (this may take a minute)...
call pnpm install --frozen-lockfile

echo.
echo [INFO] Building Vencord with the Darken Stream plugin...
call pnpm build

:: 6. Inject into Discord
echo.
echo [INFO] Injecting into Discord...
:: Note: The user might be prompted to select their Discord branch here.
call pnpm inject

:: 7. Restart Discord
echo.
echo [INFO] Restarting Discord to apply changes...
taskkill /F /IM Discord.exe >nul 2>&1
start "" "%LocalAppData%\Discord\Update.exe" --processStart Discord.exe

echo.
echo ====================================================================
echo                           INSTALLATION COMPLETE!
echo ====================================================================
echo.
echo The Darken Stream plugin has been installed! 
echo Check your stream context menu or the Vencord Plugins settings page.
echo.
pause
exit /b 0
