# 🐟 GITHUB SETUP GUIDE - Step by Step

**Follow these steps EXACTLY untuk publish Fish It script sa GitHub!**

---

## 📋 Prerequisites Check

Sebelum mulai, pastikan:
- [ ] Punya email (gmail, outlook, etc)
- [ ] Punya internet connection
- [ ] Punya folder `c:\Users\WINDOWS 11\Desktop\FMS`
- [ ] Git sudah installed (check with: `git --version`)

---

## ⚡ STEP 1: Create GitHub Account (5 minutes)

### 1.1 Go to GitHub
1. Open browser
2. Go to: https://github.com/signup
3. Fill form:
   - **Email:** Your email (gmail recommended)
   - **Password:** Strong password (12+ characters)
   - **Username:** What you'll use for GitHub
     - Can include letters, numbers, hyphens
     - Example: `fish-it-dev`, `roblox-scripts`, etc

4. Click "Create account"
5. Verify your email
6. **SAVE YOUR USERNAME** - You'll need this later!

---

## ⚡ STEP 2: Check/Install Git (5 minutes)

### 2.1 Check if Git is installed

Open PowerShell (search "PowerShell" sa Windows):

```powershell
git --version
```

**If it shows version number:** ✅ Git is installed, skip to STEP 3

**If it shows "not found":** Install Git

### 2.2 Install Git (if needed)

1. Download: https://git-scm.com/download/win
2. Run installer
3. Click "Next" para lahat default settings
4. Finish
5. Restart PowerShell
6. Test: `git --version`

---

## ⚡ STEP 3: Configure Git (2 minutes)

Open PowerShell and run:

```powershell
git config --global user.email "your-email@gmail.com"
git config --global user.name "YOUR_USERNAME"
```

Replace:
- `your-email@gmail.com` with your actual email
- `YOUR_USERNAME` with your GitHub username

Example:
```powershell
git config --global user.email "john@gmail.com"
git config --global user.name "john-roblox-dev"
```

---

## ⚡ STEP 4: Create GitHub Repository (5 minutes)

### 4.1 Login to GitHub

1. Go to: https://github.com/login
2. Login with your credentials

### 4.2 Create New Repository

1. Click **+** icon (top right)
2. Click "New repository"
3. Fill details:
   - **Owner:** Your account (auto-selected)
   - **Repository name:** `fish-it-roblox`
   - **Description:** `Full-featured automation script untuk Roblox game Fish It`
   - **Visibility:** Click **Public** (important!)
   - **Add a README file:** Check this ✓
   - **Add .gitignore:** Lua
   - **Choose a license:** MIT License

4. Click **"Create repository"**

### 4.3 Verify Repository Created

You should see:
- Green "Code" button
- Your repository files
- "This repository is public"

---

## ⚡ STEP 5: Push Local Files to GitHub (10 minutes)

### 5.1 Setup Remote Connection

Open PowerShell at folder `c:\Users\WINDOWS 11\Desktop\FMS`:

```powershell
cd "c:\Users\WINDOWS 11\Desktop\FMS"
```

Check if remote already exists:
```powershell
git remote -v
```

If shows "origin", remove it first:
```powershell
git remote remove origin
```

### 5.2 Add GitHub as Remote

```powershell
git remote add origin https://github.com/YOUR_USERNAME/fish-it-roblox.git
```

Replace `YOUR_USERNAME` with your actual GitHub username!

Example:
```powershell
git remote add origin https://github.com/john-roblox-dev/fish-it-roblox.git
```

### 5.3 Rename Branch to Main (if needed)

```powershell
git branch -M main
```

### 5.4 Verify Remote

```powershell
git remote -v
```

Should show:
```
origin  https://github.com/YOUR_USERNAME/fish-it-roblox.git (fetch)
origin  https://github.com/YOUR_USERNAME/fish-it-roblox.git (push)
```

---

## ⚡ STEP 6: Push Files to GitHub (5 minutes)

Push all commits:

```powershell
git push -u origin main
```

**First time?** It might ask for authentication:
- Click "Sign in with browser" or similar
- Login sa GitHub
- Authorize
- Done!

---

## ⚡ STEP 7: Verify Files on GitHub (2 minutes)

1. Go to: https://github.com/YOUR_USERNAME/fish-it-roblox
2. Refresh page
3. Check if all files appear:
   - ✅ src/ folder
   - ✅ loader.lua
   - ✅ README.md
   - ✅ LICENSE
   - ✅ Other files

---

## ⚡ STEP 8: Update Loader Script (5 minutes)

### 8.1 Get Your Raw GitHub URL

1. Go to your repository on GitHub
2. Click file `loader.lua`
3. Click **"Raw"** button (top right)
4. Copy URL from address bar (looks like):
   ```
   https://raw.githubusercontent.com/YOUR_USERNAME/fish-it-roblox/main/loader.lua
   ```
5. **SAVE THIS URL!** You'll share this!

### 8.2 Update loader.lua Locally

Edit file `c:\Users\WINDOWS 11\Desktop\FMS\loader.lua`:

Find this line:
```lua
local GitHubRawURL = "https://raw.githubusercontent.com/YOUR_USERNAME/fish-it-roblox/main"
```

Replace `YOUR_USERNAME` with your actual username!

Example:
```lua
local GitHubRawURL = "https://raw.githubusercontent.com/john-roblox-dev/fish-it-roblox/main"
```

### 8.3 Push Update

```powershell
cd "c:\Users\WINDOWS 11\Desktop\FMS"

git add loader.lua
git commit -m "Update loader with GitHub repository URL"
git push origin main
```

---

## ⚡ STEP 9: Final Executor Command (1 minute)

Now you have your final **one-liner** for users!

```lua
loadstring(game:HttpGet('https://raw.githubusercontent.com/YOUR_USERNAME/fish-it-roblox/main/loader.lua'))()
```

Replace `YOUR_USERNAME` with your GitHub username!

Example:
```lua
loadstring(game:HttpGet('https://raw.githubusercontent.com/john-roblox-dev/fish-it-roblox/main/loader.lua'))()
```

---

## 🎉 Complete! Your Setup is DONE!

### What You Now Have:

✅ **GitHub Repository:** https://github.com/YOUR_USERNAME/fish-it-roblox  
✅ **Public Script:** Accessible to everyone  
✅ **Loader Script:** Auto-loads latest version  
✅ **One-liner Command:** Easy to share  

### Users Can Now Execute:
```lua
loadstring(game:HttpGet('https://raw.githubusercontent.com/YOUR_USERNAME/fish-it-roblox/main/loader.lua'))()
```

---

## 🔄 Future Updates (Easy!)

To update script anytime:

```powershell
cd "c:\Users\WINDOWS 11\Desktop\FMS"

# Edit files as needed
# ...

# Commit and push
git add .
git commit -m "Update: description of changes"
git push origin main
```

Users automatically get latest version! No need to change loader URL!

---

## 🆘 Troubleshooting

### Issue: "fatal: not a git repository"
**Solution:**
```powershell
cd "c:\Users\WINDOWS 11\Desktop\FMS"
git status
```

### Issue: "fatal: cannot access 'https://github.com/...'"
**Solution:**
1. Check internet
2. Check URL (copy-paste carefully)
3. Check if public repository

### Issue: "Permission denied (publickey)"
**Solution:**
```powershell
# Use HTTPS instead of SSH
git remote set-url origin https://github.com/YOUR_USERNAME/fish-it-roblox.git
```

### Issue: "branch 'main' does not exist"
**Solution:**
```powershell
git branch -M main
```

---

## ✅ Final Checklist

- [ ] GitHub account created
- [ ] Repository created (public!)
- [ ] Git installed on computer
- [ ] Git configured with email & username
- [ ] Files pushed to GitHub
- [ ] loader.lua updated with GitHub URL
- [ ] loader.lua pushed to GitHub
- [ ] Can access repository on GitHub
- [ ] Can see all files on GitHub
- [ ] loader.lua Raw URL copied
- [ ] Executor command ready
- [ ] **READY TO SHARE!** 🎉

---

## 📢 Share Your Script!

Now you can share the **one-liner** anywhere:

**Twitter/X:**
> 🐟 Check out my Fish It Roblox automation script! 50+ features, mobile support, Discord webhooks!
> 
> loadstring(game:HttpGet('https://raw.githubusercontent.com/YOUR_USERNAME/fish-it-roblox/main/loader.lua'))()

**Discord:**
```
🐟 Fish It Script - Roblox Automation
loadstring(game:HttpGet('https://raw.githubusercontent.com/YOUR_USERNAME/fish-it-roblox/main/loader.lua'))()
```

**Reddit:**
- Post sa r/robloxhackers or r/roblox
- Include link to GitHub repository
- Share the one-liner

**YouTube Description:**
```
🐟 Fish It Roblox Script - 50+ Features!

Executor: loadstring(game:HttpGet('https://raw.githubusercontent.com/YOUR_USERNAME/fish-it-roblox/main/loader.lua'))()

GitHub: https://github.com/YOUR_USERNAME/fish-it-roblox
```

---

## 🎯 You're All Set!

### Summary:
✅ Script on GitHub (public)  
✅ Loader script ready  
✅ One-liner for users  
✅ Easy to update  
✅ Ready to share worldwide!  

### The One-liner Users Will Use:
```lua
loadstring(game:HttpGet('https://raw.githubusercontent.com/YOUR_USERNAME/fish-it-roblox/main/loader.lua'))()
```

---

## 📚 Next Resources

- **README_GITHUB.md** - For GitHub profile
- **GITHUB_PUBLISH.md** - General guide
- **START_HERE.md** - User onboarding

---

**🐟 Congratulations! Your Fish It Script is now live on GitHub!**

**Happy distributing! 🚀✨**

---

*Created: December 3, 2025*  
*Version: 1.0.0*  
*Status: Complete & Ready*
