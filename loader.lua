-- 🐟 FISH IT - Loader Script
-- Execute this in Roblox executor to load the script from GitHub
-- loadstring(game:HttpGet('https://raw.githubusercontent.com/MelodySsy/fish-it-roblox/main/loader.lua'))()

local GameVersion = "1.0.0"
local GitHubRawURL = "https://raw.githubusercontent.com/MelodySsy/fish-it-roblox/main"

-- Function to load script from GitHub
local function LoadScriptFromGitHub(ScriptPath)
    local Success, Result = pcall(function()
        local FullURL = GitHubRawURL .. ScriptPath
        return game:HttpGet(FullURL)
    end)
    
    if Success then
        return Result
    else
        warn("Failed to load: " .. ScriptPath .. " | Error: " .. tostring(Result))
        return nil
    end
end

-- Load main script
local MainScript = LoadScriptFromGitHub("/src/FishIt.lua")

if MainScript then
    -- Execute main script
    local Executed, Error = pcall(function()
        loadstring(MainScript)()
    end)
    
    if not Executed then
        warn("Error executing main script: " .. tostring(Error))
    end
else
    warn("Failed to load main script from GitHub!")
end
