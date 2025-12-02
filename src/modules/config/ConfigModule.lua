--[[ 
    Config Module - Fish It Script
    Save/Load profiles and configurations
]]

local ConfigModule = {}
local HttpService = game:GetService("HttpService")

-- Default config structure
local DefaultConfig = {
    Version = "1.0.0",
    Player = game.Players.LocalPlayer.Name,
    
    -- Local Player Settings
    PlayerSettings = {
        WalkSpeed = 16,
        JumpPower = 50,
        FreezePosition = false,
    },
    
    -- Fishing Settings
    FishingSettings = {
        Mode = "Instant",
        CompleteDelay = 0.1,
        CancelDelay = 0.1,
        OneSecondFiveFish = false,
    },
    
    -- Automation Settings
    AutomationSettings = {
        FarmingEnabled = false,
        TotemCollectionEnabled = false,
        QuestAutoEnabled = false,
        TradeAutoEnabled = false,
        EnchantAutoEnabled = false,
    },
    
    -- Saved Locations
    SavedLocations = {
        CustomSpot = Vector3.new(0, 0, 0),
    },
    
    -- Shop Settings
    ShopSettings = {
        TargetRod = "Basic Rod",
        TargetBait = "Worms",
        MinimumRodConfig = "None",
    },
    
    -- Webhook Settings
    WebhookSettings = {
        WebhookURL = "",
        RarityFilter = {
            Common = true,
            Uncommon = true,
            Rare = true,
            Legendary = true,
            Mythical = true,
            Secret = true,
        },
    },
    
    -- Performance Settings
    PerformanceSettings = {
        FPSUnlocked = false,
        LowGraphics = false,
    },
}

-- Stored configs
local Configs = {}

-- Initialize default config
Configs["default"] = DefaultConfig

-- Get config
function ConfigModule.Get(ConfigName)
    return Configs[ConfigName or "default"]
end

-- Set config value
function ConfigModule.Set(ConfigName, Path, Value)
    local Config = Configs[ConfigName or "default"]
    if not Config then
        Config = DefaultConfig
        Configs[ConfigName or "default"] = Config
    end
    
    -- Parse path (e.g., "FishingSettings.Mode")
    local Keys = {}
    for Key in string.gmatch(Path, "[^.]+") do
        table.insert(Keys, Key)
    end
    
    -- Navigate to the location
    local Current = Config
    for i = 1, #Keys - 1 do
        if not Current[Keys[i]] then
            Current[Keys[i]] = {}
        end
        Current = Current[Keys[i]]
    end
    
    -- Set the value
    Current[Keys[#Keys]] = Value
end

-- Save config to local storage (simulated with game UserData)
function ConfigModule.Save(ConfigName)
    local ConfigName = ConfigName or "default"
    local Config = Configs[ConfigName]
    
    if not Config then
        return false
    end
    
    -- Convert to JSON and store
    local JsonData = HttpService:JSONEncode(Config)
    
    -- Store in game (simulated - in real implementation would use file system)
    local StorageKey = "FishIt_Config_" .. ConfigName
    
    -- Store in memory for current session
    return true
end

-- Load config from local storage
function ConfigModule.Load(ConfigName)
    local ConfigName = ConfigName or "default"
    
    -- Check if config exists in memory
    if Configs[ConfigName] then
        return Configs[ConfigName]
    end
    
    -- Load from storage (simulated)
    local StorageKey = "FishIt_Config_" .. ConfigName
    
    -- If not found, create new from default
    Configs[ConfigName] = DeepCopy(DefaultConfig)
    return Configs[ConfigName]
end

-- Delete config
function ConfigModule.Delete(ConfigName)
    local ConfigName = ConfigName or "default"
    if ConfigName == "default" then
        return false -- Cannot delete default config
    end
    
    Configs[ConfigName] = nil
    return true
end

-- List all configs
function ConfigModule.ListConfigs()
    local ConfigList = {}
    for ConfigName, _ in pairs(Configs) do
        table.insert(ConfigList, ConfigName)
    end
    return ConfigList
end

-- Export config
function ConfigModule.Export(ConfigName)
    local ConfigName = ConfigName or "default"
    local Config = Configs[ConfigName]
    
    if not Config then
        return nil
    end
    
    return HttpService:JSONEncode(Config)
end

-- Import config
function ConfigModule.Import(ConfigName, JsonData)
    local Success, Config = pcall(function()
        return HttpService:JSONDecode(JsonData)
    end)
    
    if Success then
        Configs[ConfigName] = Config
        return true
    end
    
    return false
end

-- Save location
function ConfigModule.SaveLocation(LocationName, Position)
    local Config = Configs["default"]
    if not Config.SavedLocations then
        Config.SavedLocations = {}
    end
    
    Config.SavedLocations[LocationName] = Position
    ConfigModule.Save("default")
    return true
end

-- Load location
function ConfigModule.LoadLocation(LocationName)
    local Config = Configs["default"]
    if Config and Config.SavedLocations then
        return Config.SavedLocations[LocationName]
    end
    return nil
end

-- Delete location
function ConfigModule.DeleteLocation(LocationName)
    local Config = Configs["default"]
    if Config and Config.SavedLocations then
        Config.SavedLocations[LocationName] = nil
        ConfigModule.Save("default")
        return true
    end
    return false
end

-- List saved locations
function ConfigModule.ListLocations()
    local Config = Configs["default"]
    local Locations = {}
    
    if Config and Config.SavedLocations then
        for LocationName, Position in pairs(Config.SavedLocations) do
            table.insert(Locations, {
                Name = LocationName,
                Position = Position,
            })
        end
    end
    
    return Locations
end

-- Reset config to default
function ConfigModule.Reset(ConfigName)
    local ConfigName = ConfigName or "default"
    Configs[ConfigName] = DeepCopy(DefaultConfig)
    ConfigModule.Save(ConfigName)
    return true
end

-- Helper: Deep copy
local function DeepCopy(Table)
    local Copy = {}
    for Key, Value in pairs(Table) do
        if type(Value) == "table" then
            Copy[Key] = DeepCopy(Value)
        else
            Copy[Key] = Value
        end
    end
    return Copy
end

-- Initialize
ConfigModule.Load("default")

return ConfigModule
