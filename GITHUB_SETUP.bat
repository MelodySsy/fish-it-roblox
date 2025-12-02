@echo off
REM GitHub Setup Script untuk Fish It Roblox Script (Windows)
REM Jalankan script ini untuk setup dan push ke GitHub

setlocal enabledelayedexpansion

echo.
echo ========================================
echo   Fish It - GitHub Setup Guide
echo ========================================
echo.

REM Check if git is installed
git --version >nul 2>&1
if errorlevel 1 (
    echo [X] Git tidak terinstall. Silakan install Git terlebih dahulu.
    echo Visit: https://git-scm.com/download/win
    pause
    exit /b 1
)

echo [OK] Git ditemukan
echo.

REM Show instructions
echo Langkah-langkah untuk publish ke GitHub:
echo.
echo 1. Buat repository baru di GitHub:
echo    - Visit: https://github.com/new
echo    - Repository name: fish-it-roblox
echo    - Description: Full-featured automation script untuk Roblox game Fish It
echo    - Choose: Public
echo    - Click: Create repository
echo.

echo 2. Copy URL repository dari GitHub:
echo    (Contoh: https://github.com/YOUR_USERNAME/fish-it-roblox.git)
echo.

echo 3. Jalankan command berikut (ganti dengan URL Anda):
echo.
echo    git remote add origin https://github.com/YOUR_USERNAME/fish-it-roblox.git
echo    git branch -M main
echo    git push -u origin main
echo.

echo 4. Setelah push, update settings di GitHub:
echo    - Add Topics: roblox, lua, automation, fishing, script
echo    - Add Description
echo    - Check 'Discussions' di Advanced settings
echo.

echo ========================================
echo   Current Git Status
echo ========================================
echo.
git status
echo.

for /f "delims=" %%i in ('git config --get remote.origin.url 2^>nul') do set "REMOTE=%%i"
if defined REMOTE (
    echo [OK] Remote repository sudah dikonfigurasi:
    echo     %REMOTE%
    echo.
    echo Ready to push! Run:
    echo     git push -u origin main
) else (
    echo [!] Remote repository belum dikonfigurasi.
    echo     Follow step 3 di atas untuk set remote URL
)

echo.
echo ========================================
echo   Useful Git Commands
echo ========================================
echo.
echo   git log --oneline                  # View commit history
echo   git branch -v                      # View branches
echo   git status                         # Check status
echo   git pull                           # Update dari remote
echo   git push                           # Push changes ke remote
echo.

echo ========================================
echo   Script setup complete!
echo ========================================
echo.

pause
