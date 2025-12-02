-- 🐟 FISH IT - Loader Script
-- Execute this in Roblox executor to load the script from GitHub
-- loadstring(game:HttpGet('https://raw.githubusercontent.com/MelodySsy/fish-it-roblox/master/loader.lua'))()

local GameVersion = "1.0.0"
local GitHubRawURL = "https://raw.githubusercontent.com/MelodySsy/fish-it-roblox/master"

-- Function to create notification GUI
local function ShowNotification(Title, Message, Duration, Color)
    Duration = Duration or 5
    Color = Color or Color3.fromRGB(0, 127, 255)
    
    local Players = game:GetService("Players")
    local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")
    
    local NotificationGui = Instance.new("ScreenGui")
    NotificationGui.Name = "NotificationGui"
    NotificationGui.ResetOnSpawn = false
    NotificationGui.ZIndex = 999
    NotificationGui.Parent = PlayerGui
    
    local Frame = Instance.new("Frame")
    Frame.Name = "NotificationFrame"
    Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    Frame.BorderColor3 = Color
    Frame.BorderSizePixel = 2
    Frame.Size = UDim2.new(0, 400, 0, 100)
    Frame.Position = UDim2.new(0.5, -200, 0, 20)
    Frame.Parent = NotificationGui
    
    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Name = "Title"
    TitleLabel.Text = "⚠️ " .. Title
    TitleLabel.TextColor3 = Color
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.TextSize = 16
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.Size = UDim2.new(1, -10, 0, 30)
    TitleLabel.Position = UDim2.new(0, 5, 0, 5)
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    TitleLabel.Parent = Frame
    
    local MessageLabel = Instance.new("TextLabel")
    MessageLabel.Name = "Message"
    MessageLabel.Text = Message
    MessageLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    MessageLabel.BackgroundTransparency = 1
    MessageLabel.TextSize = 12
    MessageLabel.Font = Enum.Font.Gotham
    MessageLabel.Size = UDim2.new(1, -10, 1, -40)
    MessageLabel.Position = UDim2.new(0, 5, 0, 35)
    MessageLabel.TextXAlignment = Enum.TextXAlignment.Left
    MessageLabel.TextYAlignment = Enum.TextYAlignment.Top
    MessageLabel.TextWrapped = true
    MessageLabel.Parent = Frame
    
    wait(Duration)
    NotificationGui:Destroy()
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
        local ErrorMsg = "Failed to load: " .. ScriptPath .. " | Error: " .. tostring(Result)
        ShowNotification("LOAD ERROR", ErrorMsg, 10, Color3.fromRGB(255, 0, 0))
        return nil
    end
end

-- Show loading notification
ShowNotification("Loading Script", "Fetching Fish It from GitHub...", 3, Color3.fromRGB(0, 200, 100))

-- Load main script
local MainScript = LoadScriptFromGitHub("/src/FishIt.lua")

if MainScript then
    -- Execute main script
    local Executed, Error = pcall(function()
        loadstring(MainScript)()
    end)
    
    if not Executed then
        local ErrorMsg = "Script execution failed: " .. tostring(Error)
        ShowNotification("EXECUTION ERROR", ErrorMsg, 10, Color3.fromRGB(255, 100, 0))
    else
        ShowNotification("Success", "✅ Fish It Script v" .. GameVersion .. " Loaded Successfully!", 5, Color3.fromRGB(0, 255, 0))
    end
else
    ShowNotification("CRITICAL ERROR", "Failed to load main script from GitHub! Check internet connection.", 10, Color3.fromRGB(255, 0, 0))
end
