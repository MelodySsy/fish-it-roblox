-- 🐟 FISH IT - Loader Script
-- Execute this in Roblox executor to load the script from GitHub
-- loadstring(game:HttpGet('https://raw.githubusercontent.com/MelodySsy/fish-it-roblox/master/loader.lua'))()

local GameVersion = "1.0.0"
local GitHubRawURL = "https://raw.githubusercontent.com/MelodySsy/fish-it-roblox/master"

-- Function to show Roblox native notifications (bottom right corner)
local function ShowNotification(Title, Message, Duration)
    Duration = Duration or 5
    local StarterGui = game:GetService("StarterGui")
    StarterGui:SetCore("SendNotification", {
        Title = Title,
        Text = Message,
        Duration = Duration,
        Icon = "rbxasset://textures/Notification/In-Game-Notifications/Generic/Logo.png"
    })
end

-- Function to load script from GitHub
local function LoadScriptFromGitHub(ScriptPath)
    local Success, Result = pcall(function()
        local FullURL = GitHubRawURL .. ScriptPath
        return game:HttpGet(FullURL)
    end)
    
    if Success then
        return Result
    else
        ShowNotification("❌ LOAD ERROR", "Failed to load script from GitHub!", 8)
        return nil
    end
end

-- Show loading notification
ShowNotification("🚀 Loading Script", "Fetching Fish It from GitHub...", 3)

-- Load main script
local MainScript = LoadScriptFromGitHub("/src/FishIt.lua")

if MainScript then
    -- Execute main script
    local Executed, Error = pcall(function()
        loadstring(MainScript)()
    end)
    
    if not Executed then
        ShowNotification("❌ EXECUTION ERROR", "Script execution failed!", 8)
    else
        ShowNotification("✅ SUCCESS", "Fish It Script v" .. GameVersion .. " Loaded!", 5)
    end
else
    ShowNotification("❌ CRITICAL ERROR", "Failed to load main script from GitHub!", 8)
end
