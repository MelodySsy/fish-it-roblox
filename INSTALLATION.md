# 📦 Fish It - Installation Guide

## System Requirements

### Minimum Requirements
- Windows 7+ / Mac / Linux
- Roblox installed and updated
- Executor software (free atau paid)
- Internet connection (untuk webhook)

### Recommended Requirements
- Windows 10/11
- Modern PC (i5+ / 8GB RAM)
- Stable internet connection
- Discord account (untuk notifications)

---

## Supported Executors

✅ **Free Executors**
- Volcano
- Delta  
- Arceus X
- Wave

✅ **Paid Executors**
- Synapse X
- Script-Ware
- JJSploit (semi-free)

❌ **Not Recommended**
- ExploitHub (outdated)
- Old Oxygen U (discontinued)

---

## Installation Steps

### Option 1: Direct Copy-Paste (Easiest)

#### Step 1: Prepare
1. Buka text editor (Notepad++, VS Code, atau built-in Notepad)
2. Open file: `src/FishIt.lua`
3. Select All (Ctrl+A)
4. Copy (Ctrl+C)

#### Step 2: Inject
1. Buka Roblox executor
2. Paste script (Ctrl+V) ke editor window
3. Execute/Inject button

#### Step 3: Verify
- Check notifikasi "✅ Script Loaded v1.0.0"
- Press F1 - UI seharusnya muncul
- Check game console (F9) untuk errors

---

### Option 2: Download Repository (Advanced)

#### Using GitHub CLI
```bash
gh repo clone [USERNAME]/fish-it-roblox
cd fish-it-roblox
```

#### Using Git
```bash
git clone https://github.com/[USERNAME]/fish-it-roblox.git
cd fish-it-roblox
```

#### Using Download ZIP
1. Visit GitHub repo
2. Click "Code" → "Download ZIP"
3. Extract ke folder
4. Open `src/FishIt.lua`

---

### Option 3: Setup Development Environment

#### Prerequisites
- Node.js/npm (optional)
- VS Code (recommended)
- Git (untuk version control)

#### Setup
```bash
# Clone repository
git clone https://github.com/[USERNAME]/fish-it-roblox.git
cd fish-it-roblox

# Install extensions (VS Code)
# - Roblox LSP
# - Luau Language Server

# Setup workspace
# Open in VS Code
code .
```

---

## Configuration Setup

### Basic Configuration

#### 1. Discord Webhook (Optional)
```
1. Open Discord Server
2. Server Settings → Webhooks
3. Create New Webhook
4. Copy URL
5. Paste di Settings Tab → Discord Webhook URL
```

#### 2. Fishing Mode
```
Open Automation Tab:
- Select mode: Instant / Legit / Blatant
- Toggle "Auto Fishing"
- Adjust delays if needed
```

#### 3. Save Locations
```
Main Tab:
1. Go to desired location in-game
2. Click "Save Spot"
3. Can load/delete later
```

### Advanced Configuration

#### Custom Profiles
```lua
-- Edit dalam script jika ingin custom profile:
DefaultConfig = {
    FishingSettings = {
        Mode = "Instant",
        CompleteDelay = 0.1,  -- Edit ini
        CancelDelay = 0.1,    -- Dan ini
    },
    -- More settings...
}
```

#### Config File Structure
```lua
Config = {
    Version = "1.0.0",
    PlayerSettings = {
        WalkSpeed = 16,
        JumpPower = 50,
    },
    FishingSettings = {
        Mode = "Instant",
        CompleteDelay = 0.1,
        CancelDelay = 0.1,
    },
    SavedLocations = {},
    WebhookSettings = {
        WebhookURL = "",
        RarityFilter = {},
    },
}
```

---

## First Run Checklist

- [ ] Executor installed dan updated
- [ ] Roblox game running
- [ ] Script file ready
- [ ] Account logged in
- [ ] No VPN/Proxy (akan cause issues)
- [ ] Internet connection stable

### Execution
1. [ ] Open executor
2. [ ] Paste script
3. [ ] Click Execute/Inject
4. [ ] Wait untuk notifikasi
5. [ ] Press F1 untuk test UI
6. [ ] Try basic feature (WalkSpeed)
7. [ ] Enable automation tab feature
8. [ ] Monitor status

### Post-Execution
- [ ] UI responsive dan smooth
- [ ] No lag or freezing
- [ ] Commands working
- [ ] Notifications showing (if enabled)
- [ ] Can toggle mode (full/minimize/close)

---

## Troubleshooting Installation

### Script Won't Execute
```
Problem: Syntax Error / Script Failed
Solution:
1. Check executor status
2. Reload executor
3. Make sure Roblox is running
4. Try different executor
5. Check console (F9) for error details
```

### UI Won't Show
```
Problem: F1 pressed but no UI
Solution:
1. Check game console (F9)
2. Make sure script was executed successfully
3. Try waiting 5 seconds
4. Reload and re-execute
5. Check if PlayerGui is accessible
```

### Script Running But Features Don't Work
```
Problem: Automations not starting
Solution:
1. Check if target was correctly identified
2. Make sure you're in right game area
3. Check required items exist
4. Review automation settings
5. Check console logs
```

### Performance Issues
```
Problem: Game lagging / FPS drops
Solution:
1. Disable FPS Unlock setting
2. Enable Low Graphics mode
3. Close unnecessary programs
4. Reduce automation count
5. Use Legit mode instead of Instant
```

---

## Antivirus/Security Warnings

### If Executor Detected as Malware

Executor detection is **NORMAL**. Roblox executors trigger false positives.

**Solution:**
1. Add executor ke whitelist
2. Disable antivirus temporarily (not recommended)
3. Use different antivirus
4. Use executor dari trusted source

### Script Safety
✅ Script is open-source dan safe
✅ No malicious code included
✅ No file system access
✅ No data collection
✅ Local execution only

---

## Uninstallation

### Remove Script
1. Close Roblox game
2. Close executor
3. Delete downloaded files
4. Clear cache:
   - Windows: `%appdata%\Roblox\`
   - Mac: `~/Library/Application Support/Roblox/`

### Remove Files
```bash
# If using git clone
rm -r fish-it-roblox

# Or manual delete folder
```

### Discord Webhook Removal
- Go to Discord server
- Settings → Webhooks
- Delete "Fish It" webhook

---

## Update Installation

### Check for Updates
1. Visit GitHub repo
2. Check latest release
3. Compare version numbers

### Update Steps
```bash
# Using Git
git fetch origin
git pull origin main

# Manual update
# Download latest src/FishIt.lua
# Replace old file
# Re-execute in game
```

---

## Advanced Setup

### Development Setup
```bash
# Clone repo
git clone [REPO_URL]

# Create branch untuk development
git checkout -b feature/my-feature

# Make changes
# Test locally
# Commit dan push
git add .
git commit -m "Added new feature"
git push origin feature/my-feature

# Create Pull Request di GitHub
```

### Custom Modifications
1. Edit `src/FishIt.lua` atau modules
2. Test changes di executor
3. Commit changes: `git add . && git commit -m "Custom mod"`
4. Keep track ng changes

### Version Control
```bash
# View history
git log --oneline

# See changes
git diff

# Create branch
git branch feature-name
git checkout feature-name

# Merge back
git checkout main
git merge feature-name
```

---

## Getting Help

### Installation Issues
1. Check README.md
2. Review QUICK_START.md
3. Check GitHub Issues
4. Search error message online

### Community Help
- Create GitHub Issue dengan details:
  - Error message
  - Steps to reproduce
  - Executor used
  - OS version
  - Roblox version

### Resources
- Documentation: `README.md`
- Quick Guide: `QUICK_START.md`
- GitHub: issues/discussions
- Community: Roblox forums

---

## Best Practices

### Do's ✅
- [ ] Read documentation first
- [ ] Test on alt account first
- [ ] Use Legit mode untuk start
- [ ] Monitor status regularly
- [ ] Keep backups ng config
- [ ] Update script regularly
- [ ] Report bugs kindly

### Don'ts ❌
- [ ] Don't use on banned account
- [ ] Don't afk 24/7
- [ ] Don't use Blatant mode recklessly
- [ ] Don't spam notifications
- [ ] Don't share webhook URLs publicly
- [ ] Don't modify code recklessly
- [ ] Don't claim you made the script

---

## Success!

Jika semua steps completed successfully, congratulations! 🎉

**Now:**
1. Read QUICK_START.md untuk usage guide
2. Check README.md untuk full documentation
3. Setup webhooks jika ingin
4. Enjoy the script! 🐟

---

**Version:** 1.0.0  
**Last Updated:** December 2025  
**Status:** Actively Maintained ✅

For more help, visit GitHub repository atau create issue dengan details.

Happy fishing! 🎣✨
