# 🐟 FISH IT - Quick Start Guide

## ⚡ 30 Detik Setup

### Step 1: Copy Script
Buka file `src/FishIt.lua` dan copy **seluruh isi file**

### Step 2: Paste ke Executor
- Buka Roblox executor (Volcano, Delta, Synapse X, etc)
- Paste script ke editor
- **Jangan lupa reload game jika sudah login**

### Step 3: Execute
Klik tombol Execute/Inject
- Tunggu notifikasi "✅ Script Loaded v1.0.0"
- Tekan **F1** untuk buka/tutup UI

### Step 4: Setup (Optional)
Jika ingin Discord notifications:
1. Buka **Settings Tab** di UI
2. Masukkan Discord webhook URL
3. Pilih rarity filter
4. Klik Save Config

**Done!** 🎉

---

## 🎮 Basic Usage

### Main Tab
```
✅ WalkSpeed      - Ngebut jalan
✅ JumpPower      - Lompat lebih tinggi
✅ Save Spot      - Simpan lokasi
✅ Load Spot      - Teleport ke saved spot
✅ TP: Custom     - Teleport ke tempat custom
```

### Automation Tab
```
1. Pilih Fishing Mode:
   - Instant: Tercepat (high risk)
   - Legit: Balance (medium risk)
   - Blatant: Aggressive (high reward)

2. Klik tombol toggle untuk mulai
3. Monitor status di chat
4. Disable saat selesai
```

### Settings Tab
```
✅ FPS Unlock     - Set FPS ke 999
✅ Save Config    - Simpan pengaturan
✅ Load Config    - Load pengaturan sebelumnya
```

---

## 🔔 Discord Webhook Setup

### Buat Webhook
1. Buka Discord server Anda
2. Go to: Server Settings → Webhooks
3. Click: New Webhook
4. Set Name: "Fish It"
5. Click: Copy Webhook URL

### Setup di Script
1. Buka Settings Tab
2. Paste webhook URL ke kolom "Discord Webhook URL"
3. Pilih rarity filter yang diinginkan
4. Save Config

Sekarang semua fish yang tertangkap akan notify ke Discord! 📩

---

## ⚙️ Fishing Modes Explained

### 🔴 Instant Mode
- **Speed**: Very Fast
- **Detection**: High
- **Best For**: Solo farming, alt account
- **Risk**: Moderate-High

### 🟡 Legit Mode
- **Speed**: Medium
- **Detection**: Low
- **Best For**: Main account, chill farming
- **Risk**: Low

### 🟢 Blatant Mode
- **Speed**: Super Fast
- **Detection**: Very High
- **Best For**: Speed runs, testing
- **Risk**: Very High (USE WITH CAUTION)

---

## 🆘 Troubleshooting

### Script tidak load?
```
❌ Executor error?
   → Reload/Restart executor
   → Check internet connection
   → Try different executor

❌ Notifikasi tidak muncul?
   → Tunggu 2-3 detik setelah execute
   → Check game console (F9) untuk error
   → Restart game dan executor
```

### UI tidak muncul?
```
✅ Tekan F1 untuk toggle visibility
✅ Check jika ScreenGui terblokir
✅ Restart dan re-execute script
```

### Fishing tidak jalan?
```
✅ Pastikan ada rod di hand
✅ Pastikan di spot yang tepat
✅ Check mode yang dipilih
✅ Monitor status di automation tab
```

### Webhook tidak work?
```
✅ Double-check webhook URL
✅ Pastikan webhook masih valid
✅ Check Discord permissions
✅ Test dengan manual notification dulu
```

---

## 📱 Mobile Support

Script fully support mobile devices!

### Mobile-Specific Features
- Responsive UI (auto-adjust ke screen size)
- Touch-friendly buttons
- Optimized layout untuk small screens
- All features work on mobile

### Tips untuk Mobile
- Use **Minimize Mode** untuk better visibility
- Tap once untuk toggle buttons
- Use **Legit Mode** untuk avoid detection
- Monitor battery usage dengan FPS unlock off

---

## 🔐 Safety Tips

1. **Jangan gunakan di account utama** (gunakan alt dulu)
2. **Start dengan Legit Mode** dahulu
3. **Monitor bot detection** - stop jika ada warning
4. **Use random delays** - jangan always run 24/7
5. **Vary your farming patterns** - jangan selalu same spot

---

## 📊 Performance Tips

### Optimize untuk Better Performance
```lua
-- Settings Tab:
✅ Enable FPS Unlock (untuk non-low-end PC)
✅ Enable Low Graphics (recommended)
✅ Disable unnecessary visuals
```

### Monitor Performance
- Check FPS (top-left atau F9)
- Monitor CPU/GPU usage
- Disable automation saat lag
- Use Legit Mode untuk reduce load

---

## 🐛 Reporting Issues

Jika ketemu bug/error:

1. **Screenshot/record** issue
2. **Note exact steps** untuk reproduce
3. **Check console** (F9) untuk error message
4. **Report di** GitHub Issues dengan detail:
   - Script version
   - Executor used
   - Error message
   - Steps to reproduce

---

## 📚 File Structure Reference

```
FMS/
├── src/
│   ├── FishIt.lua              ← MAIN SCRIPT (copy this!)
│   ├── main.lua
│   └── modules/
│       ├── ui/UIModule.lua           (UI components)
│       ├── automation/                (Farming logic)
│       ├── webhook/                   (Discord notifications)
│       └── config/                    (Settings management)
├── README.md                    ← Full documentation
├── QUICK_START.md              ← This file!
└── LICENSE
```

---

## 🎯 Next Steps

### Beginner
- [ ] Execute script successfully
- [ ] Explore Main Tab features
- [ ] Test one automation feature
- [ ] Setup Discord webhook (optional)

### Intermediate
- [ ] Try different fishing modes
- [ ] Setup multiple saved locations
- [ ] Enable multiple automations
- [ ] Optimize settings for your account

### Advanced
- [ ] Study module structure
- [ ] Customize automation logic
- [ ] Create custom profiles
- [ ] Contribute improvements

---

## 📞 Getting Help

### Quick Support
- Check README.md untuk full docs
- Review this guide untuk common issues
- Check GitHub Issues untuk solutions

### Advanced Help
- Create GitHub Issue dengan details
- Include error messages
- Describe what you've tried already
- Be patient, we help as soon as possible

---

## 🚀 Happy Fishing!

**Version:** 1.0.0  
**Status:** Active ✅  
**Last Updated:** December 2025

Enjoy the script! 🐟✨

Questions? Check full README.md atau create GitHub Issue.

**DISCLAIMER:** Use at your own risk. Follow Roblox ToS. User responsible for consequences.
