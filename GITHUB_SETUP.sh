#!/bin/bash
# GitHub Setup Script untuk Fish It Roblox Script
# Jalankan script ini untuk push ke GitHub

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}🐟 Fish It - GitHub Setup Guide${NC}"
echo "=================================="
echo ""

# Check if git is installed
if ! command -v git &> /dev/null; then
    echo -e "${RED}❌ Git tidak terinstall. Silakan install Git terlebih dahulu.${NC}"
    exit 1
fi

echo -e "${GREEN}✅ Git ditemukan${NC}"
echo ""

# Instructions
echo -e "${YELLOW}📋 Langkah-langkah untuk publish ke GitHub:${NC}"
echo ""
echo "1. Buat repository baru di GitHub:"
echo "   - Visit: https://github.com/new"
echo "   - Repository name: fish-it-roblox"
echo "   - Description: Full-featured automation script untuk Roblox game Fish It"
echo "   - Choose: Public"
echo "   - Click: Create repository"
echo ""

echo "2. Copy URL repository dari GitHub (https://github.com/YOUR_USERNAME/fish-it-roblox.git)"
echo ""

echo "3. Jalankan command berikut di terminal (ganti dengan URL Anda):"
echo ""
echo -e "${BLUE}git remote add origin https://github.com/YOUR_USERNAME/fish-it-roblox.git${NC}"
echo -e "${BLUE}git branch -M main${NC}"
echo -e "${BLUE}git push -u origin main${NC}"
echo ""

echo "4. Setelah push ke GitHub, update repository settings:"
echo "   - Add Topics: roblox, lua, automation, fishing, script"
echo "   - Add Description"
echo "   - Check 'Discussions' di Advanced settings"
echo ""

echo -e "${GREEN}✅ Repository sudah siap untuk di-push!${NC}"
echo ""
echo "Current Git Status:"
git status
echo ""

# Check if remote is set
if git config --get remote.origin.url > /dev/null; then
    echo -e "${GREEN}✅ Remote repository sudah dikonfigurasi:${NC}"
    echo "   $(git config --get remote.origin.url)"
    echo ""
    echo -e "${YELLOW}Ready to push! Run:${NC}"
    echo -e "${BLUE}git push -u origin main${NC}"
else
    echo -e "${YELLOW}⚠️  Remote repository belum dikonfigurasi.${NC}"
    echo "   Follow step 3 di atas untuk set remote URL"
fi

echo ""
echo "=================================="
echo -e "${BLUE}📚 Useful Git Commands:${NC}"
echo ""
echo "  git log --oneline                  # View commit history"
echo "  git branch -v                      # View branches"
echo "  git status                         # Check status"
echo "  git pull                           # Update dari remote"
echo "  git push                           # Push changes ke remote"
echo ""

echo -e "${GREEN}Script setup complete! 🚀${NC}"
