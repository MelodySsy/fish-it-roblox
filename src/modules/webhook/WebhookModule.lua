--[[ 
    Webhook Module - Fish It Script
    Discord notifications with rarity filter
]]

local WebhookModule = {}
local HttpService = game:GetService("HttpService")

-- Rarity levels
local RarityLevels = {
    "Common",
    "Uncommon",
    "Rare",
    "Legendary",
    "Mythical",
    "Secret",
}

-- Rarity colors for Discord embed
local RarityColors = {
    Common = 9807270,      -- Gray
    Uncommon = 5763719,    -- Green
    Rare = 3447003,        -- Blue
    Legendary = 15844367,  -- Gold
    Mythical = 11027200,   -- Purple
    Secret = 16711680,     -- Red
}

-- Module state
WebhookModule.WebhookURL = ""
WebhookModule.RarityFilter = {
    Common = true,
    Uncommon = true,
    Rare = true,
    Legendary = true,
    Mythical = true,
    Secret = true,
}

-- Set webhook URL
function WebhookModule.SetWebhookURL(URL)
    WebhookModule.WebhookURL = URL
end

-- Set rarity filter
function WebhookModule.SetRarityFilter(Rarity, Enabled)
    if WebhookModule.RarityFilter[Rarity] ~= nil then
        WebhookModule.RarityFilter[Rarity] = Enabled
    end
end

-- Send fish caught notification
function WebhookModule.NotifyFishCaught(FishName, Rarity, Weight, Location)
    if not WebhookModule.WebhookURL or WebhookModule.WebhookURL == "" then
        return false
    end
    
    if not WebhookModule.RarityFilter[Rarity] then
        return false
    end
    
    local Embed = {
        title = "🎣 Fish Caught!",
        description = "A new fish has been caught",
        color = RarityColors[Rarity] or 0,
        fields = {
            {
                name = "Fish Name",
                value = FishName,
                inline = true,
            },
            {
                name = "Rarity",
                value = Rarity,
                inline = true,
            },
            {
                name = "Weight",
                value = tostring(Weight) .. " lbs",
                inline = true,
            },
            {
                name = "Location",
                value = Location or "Unknown",
                inline = true,
            },
        },
        footer = {
            text = "Fish It Script v1.0.0",
            icon_url = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. game.Players.LocalPlayer.UserId .. "&width=150&height=150&format=png",
        },
        timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ"),
    }
    
    return SendWebhookMessage(Embed)
end

-- Send general notification
function WebhookModule.NotifyGeneral(Title, Message, Color)
    if not WebhookModule.WebhookURL or WebhookModule.WebhookURL == "" then
        return false
    end
    
    local Embed = {
        title = Title,
        description = Message,
        color = Color or 0,
        footer = {
            text = "Fish It Script v1.0.0",
            icon_url = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. game.Players.LocalPlayer.UserId .. "&width=150&height=150&format=png",
        },
        timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ"),
    }
    
    return SendWebhookMessage(Embed)
end

-- Send error notification
function WebhookModule.NotifyError(ErrorMessage)
    return WebhookModule.NotifyGeneral("⚠️ Error", ErrorMessage, 16711680)
end

-- Send success notification
function WebhookModule.NotifySuccess(Message)
    return WebhookModule.NotifyGeneral("✅ Success", Message, 65280)
end

-- Send info notification
function WebhookModule.NotifyInfo(Message)
    return WebhookModule.NotifyGeneral("ℹ️ Info", Message, 3447003)
end

-- Send quest completed notification
function WebhookModule.NotifyQuestCompleted(QuestName, Reward)
    if not WebhookModule.WebhookURL or WebhookModule.WebhookURL == "" then
        return false
    end
    
    local Embed = {
        title = "🎯 Quest Completed!",
        description = "A quest has been successfully completed",
        color = 65280,
        fields = {
            {
                name = "Quest",
                value = QuestName,
                inline = true,
            },
            {
                name = "Reward",
                value = Reward or "Unknown",
                inline = true,
            },
        },
        footer = {
            text = "Fish It Script v1.0.0",
            icon_url = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. game.Players.LocalPlayer.UserId .. "&width=150&height=150&format=png",
        },
        timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ"),
    }
    
    return SendWebhookMessage(Embed)
end

-- Send trade notification
function WebhookModule.NotifyTrade(Item1, Item2, Status)
    if not WebhookModule.WebhookURL or WebhookModule.WebhookURL == "" then
        return false
    end
    
    local Embed = {
        title = "🔄 Trade " .. Status,
        description = "A trade transaction has occurred",
        color = 3447003,
        fields = {
            {
                name = "Item Given",
                value = Item1,
                inline = true,
            },
            {
                name = "Item Received",
                value = Item2,
                inline = true,
            },
        },
        footer = {
            text = "Fish It Script v1.0.0",
            icon_url = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. game.Players.LocalPlayer.UserId .. "&width=150&height=150&format=png",
        },
        timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ"),
    }
    
    return SendWebhookMessage(Embed)
end

-- Send webhook message
local function SendWebhookMessage(Embed)
    if not WebhookModule.WebhookURL or WebhookModule.WebhookURL == "" then
        return false
    end
    
    local Payload = HttpService:JSONEncode({
        content = "",
        embeds = {Embed},
    })
    
    local Success, Response = pcall(function()
        return HttpService:PostAsync(WebhookModule.WebhookURL, Payload, Enum.HttpContentType.ApplicationJson)
    end)
    
    return Success
end

-- Rate limiter
local LastNotificationTime = 0
local NotificationCooldown = 1

local function CanSendNotification()
    local CurrentTime = tick()
    if CurrentTime - LastNotificationTime >= NotificationCooldown then
        LastNotificationTime = CurrentTime
        return true
    end
    return false
end

-- Notify script loaded
function WebhookModule.NotifyScriptLoaded()
    if not WebhookModule.WebhookURL or WebhookModule.WebhookURL == "" then
        return false
    end
    
    local Embed = {
        title = "✅ Script Loaded",
        description = "Fish It Script has been loaded successfully",
        color = 65280,
        fields = {
            {
                name = "Version",
                value = "1.0.0",
                inline = true,
            },
            {
                name = "Player",
                value = game.Players.LocalPlayer.Name,
                inline = true,
            },
            {
                name = "Time",
                value = os.date("%Y-%m-%d %H:%M:%S"),
                inline = true,
            },
        },
        footer = {
            text = "Fish It Script v1.0.0",
            icon_url = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. game.Players.LocalPlayer.UserId .. "&width=150&height=150&format=png",
        },
        timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ"),
    }
    
    return SendWebhookMessage(Embed)
end

return WebhookModule
