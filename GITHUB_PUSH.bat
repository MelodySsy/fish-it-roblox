@echo off
REM ============================================
REM Fish It - GitHub Auto-Push Setup
REM ============================================
REM This script automates pushing to GitHub
REM ============================================

setlocal enabledelayedexpansion

:menu
cls
echo.
echo ╔═══════════════════════════════════════════╗
echo ║   Fish It - GitHub Setup & Push Script    ║
echo ╚═══════════════════════════════════════════╝
echo.
echo Select an option:
echo.
echo 1. First-time GitHub setup (create remote)
echo 2. Push updates to GitHub
echo 3. Check repository status
echo 4. Configure Git credentials
echo 5. Exit
echo.
set /p choice="Enter choice (1-5): "

if "%choice%"=="1" goto setup
if "%choice%"=="2" goto push
if "%choice%"=="3" goto status
if "%choice%"=="4" goto config
if "%choice%"=="5" goto end
goto menu

:setup
cls
echo.
echo ╔═══════════════════════════════════════════╗
echo ║     First-Time GitHub Setup               ║
echo ╚═══════════════════════════════════════════╝
echo.
echo This will setup remote connection to GitHub
echo.
set /p username="Enter your GitHub username: "
set /p email="Enter your GitHub email: "

echo.
echo Configuring Git...
git config --global user.email "%email%"
git config --global user.name "%username%"

echo.
echo Removing old origin (if exists)...
git remote remove origin 2>nul

echo.
echo Adding new GitHub remote...
git remote add origin https://github.com/%username%/fish-it-roblox.git

echo.
echo Renaming branch to main...
git branch -M main

echo.
echo ✅ Setup complete!
echo Repository: https://github.com/%username%/fish-it-roblox
echo.
pause
goto menu

:push
cls
echo.
echo ╔═══════════════════════════════════════════╗
echo ║     Pushing to GitHub                     ║
echo ╚═══════════════════════════════════════════╝
echo.
echo Checking status...
git status
echo.
set /p message="Enter commit message (or press Enter for default): "
if "%message%"=="" set message=Update Fish It script
echo.
echo Staging files...
git add -A
echo.
echo Creating commit: %message%
git commit -m "%message%"
echo.
echo Pushing to GitHub...
git push -u origin main
echo.
echo ✅ Push complete!
echo.
pause
goto menu

:status
cls
echo.
echo ╔═══════════════════════════════════════════╗
echo ║     Repository Status                     ║
echo ╚═══════════════════════════════════════════╝
echo.
echo Git Status:
git status
echo.
echo Remote:
git remote -v
echo.
pause
goto menu

:config
cls
echo.
echo ╔═══════════════════════════════════════════╗
echo ║     Configure Git Credentials             ║
echo ╚═══════════════════════════════════════════╝
echo.
set /p email="Enter your email: "
set /p username="Enter your username: "
echo.
echo Configuring...
git config --global user.email "%email%"
git config --global user.name "%username%"
echo.
echo ✅ Git credentials updated!
echo Email: %email%
echo Username: %username%
echo.
pause
goto menu

:end
echo.
echo Goodbye! 🐟
echo.
exit /b 0
