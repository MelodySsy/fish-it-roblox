# 🐟 FISH IT - GitHub Publishing Guide

## Step-by-Step GitHub Setup

### Step 1: Create GitHub Account (Jika Belum Ada)
1. Go to https://github.com/signup
2. Fill form dengan email & password
3. Verify email
4. Setup profile (username - ingat ini!)
5. Done!

---

### Step 2: Create New Repository

1. **Login ke GitHub**
   - Go to https://github.com
   - Click profile icon (top right)
   - Click "Your repositories"

2. **Click "New" button** (hijau, top right)

3. **Fill Repository Details:**
   - **Repository name:** `fish-it-roblox`
   - **Description:** `Full-featured automation script untuk Roblox game Fish It dengan 50+ features, webhooks, at mobile support`
   - **Public** (pilih ini!)
   - **Add README.md** ✓ (check ini)
   - Click **Create repository**

---

### Step 3: Git Configuration (Windows)

#### Install Git (Jika Belum)
1. Download dari: https://git-scm.com/download/win
2. Install dengan default settings
3. Restart computer

#### Setup Git Credentials
Buka PowerShell/Command Prompt:

```powershell
git config --global user.email "YOUR_EMAIL@gmail.com"
git config --global user.name "YOUR_USERNAME"
```

---

### Step 4: Push Existing Repository to GitHub

Buka PowerShell di folder `c:\Users\WINDOWS 11\Desktop\FMS`:

```powershell
cd "c:\Users\WINDOWS 11\Desktop\FMS"

# Remove old origin (jika ada)
git remote remove origin

# Add new GitHub remote
git remote add origin https://github.com/YOUR_USERNAME/fish-it-roblox.git

# Rename branch to main
git branch -M main

# Push ke GitHub
git push -u origin main
```

**Replace `YOUR_USERNAME` dengan username GitHub Anda!**

---

### Step 5: Verify GitHub Push

1. Go to https://github.com/YOUR_USERNAME/fish-it-roblox
2. Check semua files ada
3. Check commits history
4. ✅ Done! Script sudah sa GitHub!

---

### Step 6: Get Raw File URL untuk Loader

1. Open file sa GitHub: `src/FishIt.lua`
2. Click **"Raw"** button (top right)
3. Copy URL (sesuatu seperti):
   ```
   https://raw.githubusercontent.com/YOUR_USERNAME/fish-it-roblox/main/src/FishIt.lua
   ```

---

### Step 7: Update Loader Script

Sekarang update `loader.lua` dengan GitHub URL:

1. Edit file `loader.lua` sa local
2. Ganti baris ini:
   ```lua
   local GitHubRawURL = "https://raw.githubusercontent.com/YOUR_USERNAME/fish-it-roblox/main"
   ```
3. Replace `YOUR_USERNAME` dengan GitHub username Anda
4. Save file

Contoh:
```lua
local GitHubRawURL = "https://raw.githubusercontent.com/regata69f/fish-it-roblox/main"
```

---

### Step 8: Push Updated Loader

```powershell
cd "c:\Users\WINDOWS 11\Desktop\FMS"

git add loader.lua
git commit -m "Update loader with GitHub repository URL"
git push origin main
```

---

### Step 9: Get Loader URL para Copy-Paste

1. Go to GitHub repository
2. Click file `loader.lua`
3. Click **"Raw"** button
4. Copy full URL
5. This is your **MAIN SCRIPT URL!**

Example:
```
https://raw.githubusercontent.com/YOUR_USERNAME/fish-it-roblox/main/loader.lua
```

---

## 🎮 Final Executor Command

Setelah semua setup, users hanya perlu:

```lua
loadstring(game:HttpGet('https://raw.githubusercontent.com/YOUR_USERNAME/fish-it-roblox/main/loader.lua'))()
```

Replace URL dengan YOUR URL!

---

## 📝 Quickstart untuk Users

Users tinggal:
1. Copy loader command (dari above)
2. Paste di executor
3. Execute
4. Done! 🎉

---

## 🔄 Update Process (Untuk Future)

Jika update script:

```powershell
cd "c:\Users\WINDOWS 11\Desktop\FMS"

# Edit file sesuai kebutuhan
# ...

# Commit dan push
git add .
git commit -m "Update: deskripsi perubahan"
git push origin main
```

Users tetap pakai same loader URL - automatically get latest version!

---

## ⚙️ Repository Settings (Optional)

1. Go to GitHub repo
2. Settings → General
3. Add:
   - **Topics:** roblox, lua, automation, fishing, script
   - **Website:** (optional)
   - **Description:** Already set
4. Settings → Pages (for documentation)
5. Select `main` branch
6. Save

---

## 🔐 Security Notes

✅ Repository is **PUBLIC** (intentional)  
✅ No credentials sa code  
✅ No API keys exposed  
✅ Safe to share publicly  

---

## ✅ GitHub Setup Checklist

- [ ] GitHub account created
- [ ] Repository created
- [ ] Git installed locally
- [ ] Git credentials configured
- [ ] Files pushed to GitHub
- [ ] loader.lua updated with URL
- [ ] loader.lua pushed to GitHub
- [ ] Raw file URLs confirmed
- [ ] Ready for distribution!

---

## 📢 Distribution

Sekarang Anda bisa share:

**One-liner for users:**
```lua
loadstring(game:HttpGet('https://raw.githubusercontent.com/YOUR_USERNAME/fish-it-roblox/main/loader.lua'))()
```

**Share di:**
- Twitter/X
- Discord servers
- Reddit communities
- Roblox forums
- Friend groups
- etc

---

## 🎯 Full Process Summary

```
1. Create GitHub account
2. Create public repository
3. Install Git locally
4. Configure Git credentials
5. Push existing files to GitHub
6. Update loader.lua with GitHub URL
7. Push updated loader
8. Get raw GitHub URL
9. Share with community!

✨ Done! Script is live on GitHub! 🚀
```

---

## 🆘 Troubleshooting

### Push fails with authentication?
```powershell
# Use GitHub token instead
git remote set-url origin https://YOUR_TOKEN@github.com/YOUR_USERNAME/fish-it-roblox.git

# Or use GitHub CLI
gh auth login
```

### Can't find Raw URL?
1. Click file sa GitHub
2. Look for "Raw" button (next to "Blame")
3. Copy URL from address bar

### Loader not working?
1. Check URL sa loader.lua
2. Verify raw URL works sa browser
3. Check file permissions (must be public)

---

## 🚀 You're Ready!

Once everything is setup, users sa buong mundo ay pwedeng i-execute ang script gamit ang single line:

```lua
loadstring(game:HttpGet('https://raw.githubusercontent.com/YOUR_USERNAME/fish-it-roblox/main/loader.lua'))()
```

**Congratulations! Your script is now live! 🎉🐟**

---

*Last Updated: December 3, 2025*  
*Version: 1.0.0*  
*Status: Ready for GitHub Publishing*
