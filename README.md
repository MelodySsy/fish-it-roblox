# 🐟 FISH IT - Roblox Script

Full-featured Roblox script untuk game **Fish It** dengan automation lengkap, webhook notifications, dan UI yang responsive.

## 📋 Fitur Utama

### Main Tab
- **Local Player** - WalkSpeed, JumpPower, Freeze Position
- **Location Saver** - Save, Load, Delete custom spots
- **Teleport** - Preset locations + custom teleportation

### Automation Tab
- **Auto Fishing** - 3 Modes (Instant, Legit, Blatant)
  - Auto Fish - Complete Delay
  - Auto Fish - Cancel Delay
  - 1 Detik 5 Ikan Mode
- **Auto Farming** - Fishing loop otomatis
- **Auto Totems** - Collect totem area
- **Auto Favorite/Unfavorite** - Manage fish
- **Auto Trade** - Trading automation
- **Auto Enchants 1 & 2** - Enchant management
- **Auto Claim Battlepass** - Battlepass claim

### Quest Tab
- Auto Quest: Lever Task
- Auto Quest: Ruin Task
- Auto Quest: Ghostfinn Rod
- Auto Quest: Element Rod

### Shop Tab
- Auto Buy Rod
- Auto Buy Bobbers
- Auto Buy From Traveling Merchant
- Auto Buy From Tix Shop
- Auto Sell (inventory management)
- Auto Sell Enchant Stone
- Auto Weather

### Premium Tab
- Minimum Rod Config (untuk quest)
- Target Rod to Buy (auto upgrade)
- Target Bait to Buy
- MFS Mode (auto farming berdasarkan quest progress)

### Settings Tab
- **Webhook** - Discord webhook URL + rarity filter
- **Performance** - FPS unlock, low graphics mode
- **Config System** - Save/load profiles
- **Auto Update Check**

## 🔔 Webhook System

Discord webhook notifications dengan filter rarity:
- Common (Gray)
- Uncommon (Green)
- Rare (Blue)
- Legendary (Gold)
- Mythical (Purple)
- Secret (Red)

**Info yang dikirim:**
- Fish name
- Rarity level
- Weight
- Location
- Player info
- Timestamp

## 📱 UI Features

### Responsive Design
- Support desktop dan mobile
- Adaptive layout berdasarkan device

### Mode Selection
- **Full** - UI lengkap dan besar
- **Minimize** - Hanya header (compact)
- **Close** - Sembunyikan UI (F1 untuk show)

### Navigation
- 6 Tab utama dengan easy switching
- Scrollable content area
- Modern dark theme

## 🚀 Cara Menggunakan

### Prerequisites
- Roblox executor (Volcano, Delta, atau equivalent)
- Game "Fish It" harus running
- (Optional) Discord webhook untuk notifications

### Installation

1. **Copy script utama dari file `src/FishIt.lua`**

2. **Paste ke executor Anda**

3. **Tunggu notifikasi "Script Loaded"**

4. **Setup Discord Webhook (opsional):**
   - Buka Settings Tab
   - Masukkan Discord webhook URL
   - Pilih rarity filter yang diinginkan

5. **Gunakan F1 untuk toggle UI**

### Usage

#### Main Tab
- Gunakan untuk player modifications dan location management
- Save spot yang sering digunakan untuk quick teleport

#### Automation Tab
- Pilih fishing mode sesuai kebutuhan:
  - **Instant** - Tercepat, high risk
  - **Legit** - Balanced, medium risk
  - **Blatant** - Aggressive, high automation
- Toggle automation features sesuai kebutuhan
- Monitor status dari setiap automation

#### Settings Tab
- Setup webhook URL jika ingin Discord notifications
- Unlock FPS untuk performance boost
- Save/load configuration

## ⚙️ Configuration

Script menggunakan config system built-in untuk menyimpan settings:

```lua
-- Default Config Structure
{
    PlayerSettings = {
        WalkSpeed = 16,
        JumpPower = 50,
        FreezePosition = false
    },
    FishingSettings = {
        Mode = "Instant",
        CompleteDelay = 0.1,
        CancelDelay = 0.1
    },
    SavedLocations = {},
    WebhookSettings = {
        WebhookURL = "",
        RarityFilter = { ... }
    }
}
```

## 🎮 Keybinds

- **F1** - Toggle UI Visibility

## 🔒 Safety Notes

- Script menggunakan method vanilla Roblox
- No suspicious activity yang akan trigger anti-cheat
- Modes legit dirancang untuk avoid detection
- Monitor automation untuk best results

## 📦 File Structure

```
FMS/
├── src/
│   ├── FishIt.lua              # Main executor script
│   ├── main.lua                # Server script template
│   └── modules/
│       ├── ui/
│       │   └── UIModule.lua
│       ├── automation/
│       │   └── AutomationModule.lua
│       ├── webhook/
│       │   └── WebhookModule.lua
│       └── config/
│           └── ConfigModule.lua
├── README.md
└── LICENSE
```

## 🤝 Support

Untuk issues atau suggestions:
1. Check GitHub issues
2. Create detailed bug report
3. Include script version + game version

## 📄 License

MIT License - Lihat file LICENSE untuk details

## ⚠️ Disclaimer

- Gunakan script ini sesuai dengan Roblox Terms of Service
- User bertanggung jawab untuk konsekuensi penggunaan
- Script dibuat untuk educational purposes
- Tidak ada garansi script akan work selamanya

## 🔄 Version History

### v1.0.0
- Initial release
- Semua fitur utama implemented
- UI responsive dan mobile-friendly
- Webhook system with filters
- Config management system

## 🎯 TODO / Planned Features

- [ ] Advanced fishing AI
- [ ] More quest automation types
- [ ] Cloud config backup
- [ ] Advanced webhook formatting
- [ ] Script auto-updater
- [ ] Performance profiling tools

---

**Last Updated:** December 3, 2025
**Version:** 1.0.0
**Executor:** Volcano, Delta, Synapse X
