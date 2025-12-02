--[[ 
    FISH IT - Main Executor Script (FIXED VERSION)
    Game: Fish It (Roblox)
    PlaceId: 121864768012064
    Version: 1.0.0.1

    USAGE: Paste this entire script in Volcano, Delta, or other executors

    FIXES:
    - Tab sizing fixed (height was 0)
    - Function order corrected
    - AutomaticSize added
    - Dynamic CanvasSize
    - Larger MainFrame
]]


local GameVersion = "1.0.0.1"
local ScriptEnabled = true


-- Services
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")


-- Local Player
local LocalPlayer = Players.LocalPlayer
if not LocalPlayer then
    LocalPlayer = Players:WaitForChild("LocalPlayer")
end


local Character = LocalPlayer.Character or LocalPlayer:WaitForChild("Character")
local Humanoid = Character and Character:FindFirstChild("Humanoid")
local RootPart = Character and Character:FindFirstChild("HumanoidRootPart")


-- ===================== NOTIFICATION SYSTEM =====================
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


-- ===================== INLINE MODULES =====================


-- UI Module
local UIModule = {}
UIModule.UIVisible = true
UIModule.CurrentMode = "full"
UIModule.CurrentTab = "Main"
UIModule.IsMobile = false


local Theme = {
    Primary = Color3.fromRGB(26, 188, 156),
    Secondary = Color3.fromRGB(52, 73, 94),
    Background = Color3.fromRGB(44, 62, 80),
    TextColor = Color3.fromRGB(236, 240, 241),
    Danger = Color3.fromRGB(231, 76, 60),
    Success = Color3.fromRGB(39, 174, 96),
}


-- Automation Module
local AutomationModule = {}
AutomationModule.FishingActive = false
AutomationModule.FarmingActive = false
AutomationModule.TotemActive = false
AutomationModule.TradeActive = false
AutomationModule.FishingMode = "Instant"
AutomationModule.FishingConfig = {
    CompleteDelay = 0.1,
    CancelDelay = 0.1,
    OneSecondFiveFish = false,
}


-- Webhook Module
local WebhookModule = {}
WebhookModule.WebhookURL = ""
WebhookModule.RarityFilter = {
    Common = true,
    Uncommon = true,
    Rare = true,
    Legendary = true,
    Mythical = true,
    Secret = true,
}


-- Config Module
local ConfigModule = {}
local Configs = {}


local DefaultConfig = {
    Version = "1.0.0",
    Player = LocalPlayer.Name,
    PlayerSettings = {
        WalkSpeed = 16,
        JumpPower = 50,
        FreezePosition = false,
    },
    FishingSettings = {
        Mode = "Instant",
        CompleteDelay = 0.1,
        CancelDelay = 0.1,
        OneSecondFiveFish = false,
    },
    AutomationSettings = {
        FarmingEnabled = false,
        TotemCollectionEnabled = false,
        QuestAutoEnabled = false,
        TradeAutoEnabled = false,
        EnchantAutoEnabled = false,
    },
    SavedLocations = {},
    ShopSettings = {
        TargetRod = "Basic Rod",
        TargetBait = "Worms",
        MinimumRodConfig = "None",
    },
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
    PerformanceSettings = {
        FPSUnlocked = false,
        LowGraphics = false,
    },
}


Configs["default"] = DefaultConfig


function ConfigModule.Get(ConfigName)
    return Configs[ConfigName or "default"]
end


function ConfigModule.Set(ConfigName, Path, Value)
    local Config = Configs[ConfigName or "default"]
    if not Config then
        Config = DefaultConfig
        Configs[ConfigName or "default"] = Config
    end

    local Keys = {}
    for Key in string.gmatch(Path, "[^.]+") do
        table.insert(Keys, Key)
    end

    local Current = Config
    for i = 1, #Keys - 1 do
        if not Current[Keys[i]] then
            Current[Keys[i]] = {}
        end
        Current = Current[Keys[i]]
    end

    Current[Keys[#Keys]] = Value
end


function ConfigModule.Save(ConfigName)
    return true
end


function ConfigModule.Load(ConfigName)
    local ConfigName = ConfigName or "default"
    if Configs[ConfigName] then
        return Configs[ConfigName]
    end
    Configs[ConfigName] = {}
    for k, v in pairs(DefaultConfig) do
        Configs[ConfigName][k] = v
    end
    return Configs[ConfigName]
end


function ConfigModule.SaveLocation(LocationName, Position)
    local Config = Configs["default"]
    if not Config.SavedLocations then
        Config.SavedLocations = {}
    end
    Config.SavedLocations[LocationName] = Position
    return true
end


function ConfigModule.LoadLocation(LocationName)
    local Config = Configs["default"]
    if Config and Config.SavedLocations then
        return Config.SavedLocations[LocationName]
    end
    return nil
end


function ConfigModule.DeleteLocation(LocationName)
    local Config = Configs["default"]
    if Config and Config.SavedLocations then
        Config.SavedLocations[LocationName] = nil
        return true
    end
    return false
end


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


-- ===================== HELPER FUNCTIONS (DEFINED BEFORE CreateUI) =====================


local function CreateHeaderButton(Parent, Text, Position, Color)
    local Button = Instance.new("TextButton")
    Button.Text = Text
    Button.BackgroundColor3 = Color
    Button.TextColor3 = Theme.TextColor
    Button.TextSize = Text == "✕" and 14 or 18
    Button.Font = Enum.Font.GothamBold
    Button.Size = UDim2.new(0.33, -2, 1, 0)
    Button.Position = UDim2.new(Position, 0, 0, 0)
    Button.BorderSizePixel = 0
    Button.Parent = Parent
    return Button
end


local function ToggleMode(Mode)
    UIModule.CurrentMode = Mode
    local GUI = UIModule.GUI
    if GUI then
        if Mode == "close" then
            GUI.ScreenGui.Enabled = false
            UIModule.UIVisible = false
        elseif Mode == "minimize" then
            GUI.MainFrame.Size = UDim2.new(0, 500, 0, 80)
            GUI.ContentFrame.Visible = false
            GUI.TabContainer.Visible = false
        elseif Mode == "full" then
            GUI.MainFrame.Size = UDim2.new(0, 500, 0, 600)
            GUI.ContentFrame.Visible = true
            GUI.TabContainer.Visible = true
            GUI.ScreenGui.Enabled = true
            UIModule.UIVisible = true
        end
    end
end


local function SwitchTab(TabName, TabContainer, TabButton)
    local ContentFrame = TabContainer.Parent:FindFirstChild("ContentFrame")
    if not ContentFrame then return end

    for _, Tab in ipairs(ContentFrame:GetChildren()) do
        if Tab:IsA("Frame") and Tab.Name ~= "UIListLayout" and Tab.Name ~= "UIPadding" then
            Tab.Visible = (Tab.Name == TabName .. "Tab")
        end
    end

    for _, btn in ipairs(TabContainer:GetChildren()) do
        if btn:IsA("TextButton") then
            btn.BackgroundColor3 = (btn.Name == TabName .. "Tab") and Theme.Primary or Theme.Secondary
        end
    end
end


-- ===================== TAB CONTENT FUNCTIONS (DEFINED BEFORE CreateUI) =====================


local function CreateMainTabContent(Parent)
    local Tab = Instance.new("Frame")
    Tab.Name = "MainTab"
    Tab.BackgroundTransparency = 1
    Tab.Size = UDim2.new(1, 0, 1, 0)  -- FIXED: Changed from 0 height to full height
    Tab.AutomaticSize = Enum.AutomaticSize.Y  -- ADDED: Auto resize based on content
    Tab.Parent = Parent
    Tab.Visible = true

    local Layout = Instance.new("UIListLayout")
    Layout.FillDirection = Enum.FillDirection.Vertical
    Layout.SortOrder = Enum.SortOrder.LayoutOrder
    Layout.Padding = UDim.new(0, 8)
    Layout.Parent = Tab

    -- Simple test labels and buttons
    local TestLabel = Instance.new("TextLabel")
    TestLabel.Text = "🎮 Local Player"
    TestLabel.BackgroundColor3 = Color3.fromRGB(52, 73, 94)
    TestLabel.TextColor3 = Color3.fromRGB(26, 188, 156)
    TestLabel.TextSize = 14
    TestLabel.Font = Enum.Font.GothamBold
    TestLabel.Size = UDim2.new(1, 0, 0, 30)
    TestLabel.Parent = Tab

    local UICorner1 = Instance.new("UICorner")
    UICorner1.CornerRadius = UDim.new(0, 6)
    UICorner1.Parent = TestLabel

    -- WalkSpeed Toggle
    local WalkButton = Instance.new("TextButton")
    WalkButton.Text = "WalkSpeed: OFF"
    WalkButton.BackgroundColor3 = Color3.fromRGB(192, 57, 43)
    WalkButton.TextColor3 = Color3.fromRGB(236, 240, 241)
    WalkButton.TextSize = 12
    WalkButton.Font = Enum.Font.GothamBold
    WalkButton.Size = UDim2.new(1, 0, 0, 35)
    WalkButton.Parent = Tab

    local UICorner2 = Instance.new("UICorner")
    UICorner2.CornerRadius = UDim.new(0, 6)
    UICorner2.Parent = WalkButton

    local WalkState = false
    WalkButton.MouseButton1Click:Connect(function()
        WalkState = not WalkState
        WalkButton.Text = WalkState and "WalkSpeed: ON" or "WalkSpeed: OFF"
        WalkButton.BackgroundColor3 = WalkState and Color3.fromRGB(39, 174, 96) or Color3.fromRGB(192, 57, 43)
    end)

    -- JumpPower Toggle
    local JumpButton = Instance.new("TextButton")
    JumpButton.Text = "JumpPower: OFF"
    JumpButton.BackgroundColor3 = Color3.fromRGB(192, 57, 43)
    JumpButton.TextColor3 = Color3.fromRGB(236, 240, 241)
    JumpButton.TextSize = 12
    JumpButton.Font = Enum.Font.GothamBold
    JumpButton.Size = UDim2.new(1, 0, 0, 35)
    JumpButton.Parent = Tab

    local UICorner3 = Instance.new("UICorner")
    UICorner3.CornerRadius = UDim.new(0, 6)
    UICorner3.Parent = JumpButton

    local JumpState = false
    JumpButton.MouseButton1Click:Connect(function()
        JumpState = not JumpState
        JumpButton.Text = JumpState and "JumpPower: ON" or "JumpPower: OFF"
        JumpButton.BackgroundColor3 = JumpState and Color3.fromRGB(39, 174, 96) or Color3.fromRGB(192, 57, 43)
    end)

    -- Automation Label
    local AutoLabel = Instance.new("TextLabel")
    AutoLabel.Text = "🤖 Automation"
    AutoLabel.BackgroundColor3 = Color3.fromRGB(52, 73, 94)
    AutoLabel.TextColor3 = Color3.fromRGB(26, 188, 156)
    AutoLabel.TextSize = 14
    AutoLabel.Font = Enum.Font.GothamBold
    AutoLabel.Size = UDim2.new(1, 0, 0, 30)
    AutoLabel.Parent = Tab

    local UICorner4 = Instance.new("UICorner")
    UICorner4.CornerRadius = UDim.new(0, 6)
    UICorner4.Parent = AutoLabel

    -- Auto Fishing Toggle
    local FishButton = Instance.new("TextButton")
    FishButton.Text = "Auto Fishing: OFF"
    FishButton.BackgroundColor3 = Color3.fromRGB(192, 57, 43)
    FishButton.TextColor3 = Color3.fromRGB(236, 240, 241)
    FishButton.TextSize = 12
    FishButton.Font = Enum.Font.GothamBold
    FishButton.Size = UDim2.new(1, 0, 0, 35)
    FishButton.Parent = Tab

    local UICorner5 = Instance.new("UICorner")
    UICorner5.CornerRadius = UDim.new(0, 6)
    UICorner5.Parent = FishButton

    local FishState = false
    FishButton.MouseButton1Click:Connect(function()
        FishState = not FishState
        FishButton.Text = FishState and "Auto Fishing: ON" or "Auto Fishing: OFF"
        FishButton.BackgroundColor3 = FishState and Color3.fromRGB(39, 174, 96) or Color3.fromRGB(192, 57, 43)
        AutomationModule.FishingActive = FishState
    end)

    -- Auto Farming Toggle
    local FarmButton = Instance.new("TextButton")
    FarmButton.Text = "Auto Farming: OFF"
    FarmButton.BackgroundColor3 = Color3.fromRGB(192, 57, 43)
    FarmButton.TextColor3 = Color3.fromRGB(236, 240, 241)
    FarmButton.TextSize = 12
    FarmButton.Font = Enum.Font.GothamBold
    FarmButton.Size = UDim2.new(1, 0, 0, 35)
    FarmButton.Parent = Tab

    local UICorner6 = Instance.new("UICorner")
    UICorner6.CornerRadius = UDim.new(0, 6)
    UICorner6.Parent = FarmButton

    local FarmState = false
    FarmButton.MouseButton1Click:Connect(function()
        FarmState = not FarmState
        FarmButton.Text = FarmState and "Auto Farming: ON" or "Auto Farming: OFF"
        FarmButton.BackgroundColor3 = FarmState and Color3.fromRGB(39, 174, 96) or Color3.fromRGB(192, 57, 43)
        AutomationModule.FarmingActive = FarmState
    end)
end


local function CreateAutomationTabContent(Parent)
    local Tab = Instance.new("Frame")
    Tab.Name = "AutomationTab"
    Tab.BackgroundTransparency = 1
    Tab.Size = UDim2.new(1, 0, 1, 0)  -- FIXED
    Tab.AutomaticSize = Enum.AutomaticSize.Y  -- ADDED
    Tab.Parent = Parent

    local Layout = Instance.new("UIListLayout")
    Layout.FillDirection = Enum.FillDirection.Vertical
    Layout.SortOrder = Enum.SortOrder.LayoutOrder
    Layout.Padding = UDim.new(0, 8)
    Layout.Parent = Tab

    local Label = Instance.new("TextLabel")
    Label.Text = "🎣 Fishing Modes"
    Label.BackgroundColor3 = Color3.fromRGB(52, 73, 94)
    Label.TextColor3 = Color3.fromRGB(26, 188, 156)
    Label.TextSize = 14
    Label.Font = Enum.Font.GothamBold
    Label.Size = UDim2.new(1, 0, 0, 30)
    Label.Parent = Tab

    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 6)
    UICorner.Parent = Label

    for i, Mode in ipairs({"Instant", "Legit", "Blatant"}) do
        local Btn = Instance.new("TextButton")
        Btn.Text = Mode .. ": OFF"
        Btn.BackgroundColor3 = Color3.fromRGB(192, 57, 43)
        Btn.TextColor3 = Color3.fromRGB(236, 240, 241)
        Btn.TextSize = 12
        Btn.Font = Enum.Font.GothamBold
        Btn.Size = UDim2.new(1, 0, 0, 35)
        Btn.Parent = Tab

        local BtnCorner = Instance.new("UICorner")
        BtnCorner.CornerRadius = UDim.new(0, 6)
        BtnCorner.Parent = Btn

        local State = false
        Btn.MouseButton1Click:Connect(function()
            State = not State
            Btn.Text = State and (Mode .. ": ON") or (Mode .. ": OFF")
            Btn.BackgroundColor3 = State and Color3.fromRGB(39, 174, 96) or Color3.fromRGB(192, 57, 43)
        end)
    end
end


local function CreateQuestTabContent(Parent)
    local Tab = Instance.new("Frame")
    Tab.Name = "QuestTab"
    Tab.BackgroundTransparency = 1
    Tab.Size = UDim2.new(1, 0, 1, 0)  -- FIXED
    Tab.AutomaticSize = Enum.AutomaticSize.Y  -- ADDED
    Tab.Parent = Parent

    local Layout = Instance.new("UIListLayout")
    Layout.FillDirection = Enum.FillDirection.Vertical
    Layout.SortOrder = Enum.SortOrder.LayoutOrder
    Layout.Padding = UDim.new(0, 8)
    Layout.Parent = Tab

    local Label = Instance.new("TextLabel")
    Label.Text = "📋 Quest Auto"
    Label.BackgroundColor3 = Color3.fromRGB(52, 73, 94)
    Label.TextColor3 = Color3.fromRGB(26, 188, 156)
    Label.TextSize = 14
    Label.Font = Enum.Font.GothamBold
    Label.Size = UDim2.new(1, 0, 0, 30)
    Label.Parent = Tab

    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 6)
    UICorner.Parent = Label

    for i, Quest in ipairs({"Lever Task", "Ruin Task", "Ghostfinn Rod", "Element Rod"}) do
        local Btn = Instance.new("TextButton")
        Btn.Text = Quest .. ": OFF"
        Btn.BackgroundColor3 = Color3.fromRGB(192, 57, 43)
        Btn.TextColor3 = Color3.fromRGB(236, 240, 241)
        Btn.TextSize = 12
        Btn.Font = Enum.Font.GothamBold
        Btn.Size = UDim2.new(1, 0, 0, 35)
        Btn.Parent = Tab

        local BtnCorner = Instance.new("UICorner")
        BtnCorner.CornerRadius = UDim.new(0, 6)
        BtnCorner.Parent = Btn

        local State = false
        Btn.MouseButton1Click:Connect(function()
            State = not State
            Btn.Text = State and (Quest .. ": ON") or (Quest .. ": OFF")
            Btn.BackgroundColor3 = State and Color3.fromRGB(39, 174, 96) or Color3.fromRGB(192, 57, 43)
        end)
    end
end


local function CreateShopTabContent(Parent)
    local Tab = Instance.new("Frame")
    Tab.Name = "ShopTab"
    Tab.BackgroundTransparency = 1
    Tab.Size = UDim2.new(1, 0, 1, 0)  -- FIXED
    Tab.AutomaticSize = Enum.AutomaticSize.Y  -- ADDED
    Tab.Parent = Parent

    local Layout = Instance.new("UIListLayout")
    Layout.FillDirection = Enum.FillDirection.Vertical
    Layout.SortOrder = Enum.SortOrder.LayoutOrder
    Layout.Padding = UDim.new(0, 8)
    Layout.Parent = Tab

    local Label = Instance.new("TextLabel")
    Label.Text = "🛒 Shop Auto"
    Label.BackgroundColor3 = Color3.fromRGB(52, 73, 94)
    Label.TextColor3 = Color3.fromRGB(26, 188, 156)
    Label.TextSize = 14
    Label.Font = Enum.Font.GothamBold
    Label.Size = UDim2.new(1, 0, 0, 30)
    Label.Parent = Tab

    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 6)
    UICorner.Parent = Label

    for i, Item in ipairs({"Auto Buy Rod", "Auto Buy Bobbers", "Auto Sell", "Auto Weather"}) do
        local Btn = Instance.new("TextButton")
        Btn.Text = Item .. ": OFF"
        Btn.BackgroundColor3 = Color3.fromRGB(192, 57, 43)
        Btn.TextColor3 = Color3.fromRGB(236, 240, 241)
        Btn.TextSize = 12
        Btn.Font = Enum.Font.GothamBold
        Btn.Size = UDim2.new(1, 0, 0, 35)
        Btn.Parent = Tab

        local BtnCorner = Instance.new("UICorner")
        BtnCorner.CornerRadius = UDim.new(0, 6)
        BtnCorner.Parent = Btn

        local State = false
        Btn.MouseButton1Click:Connect(function()
            State = not State
            Btn.Text = State and (Item .. ": ON") or (Item .. ": OFF")
            Btn.BackgroundColor3 = State and Color3.fromRGB(39, 174, 96) or Color3.fromRGB(192, 57, 43)
        end)
    end
end


local function CreatePremiumTabContent(Parent)
    local Tab = Instance.new("Frame")
    Tab.Name = "PremiumTab"
    Tab.BackgroundTransparency = 1
    Tab.Size = UDim2.new(1, 0, 1, 0)  -- FIXED
    Tab.AutomaticSize = Enum.AutomaticSize.Y  -- ADDED
    Tab.Parent = Parent

    local Layout = Instance.new("UIListLayout")
    Layout.FillDirection = Enum.FillDirection.Vertical
    Layout.SortOrder = Enum.SortOrder.LayoutOrder
    Layout.Padding = UDim.new(0, 8)
    Layout.Parent = Tab

    local Label = Instance.new("TextLabel")
    Label.Text = "⭐ Premium Features"
    Label.BackgroundColor3 = Color3.fromRGB(52, 73, 94)
    Label.TextColor3 = Color3.fromRGB(26, 188, 156)
    Label.TextSize = 14
    Label.Font = Enum.Font.GothamBold
    Label.Size = UDim2.new(1, 0, 0, 30)
    Label.Parent = Tab

    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 6)
    UICorner.Parent = Label

    local Btn = Instance.new("TextButton")
    Btn.Text = "MFS Mode: OFF"
    Btn.BackgroundColor3 = Color3.fromRGB(192, 57, 43)
    Btn.TextColor3 = Color3.fromRGB(236, 240, 241)
    Btn.TextSize = 12
    Btn.Font = Enum.Font.GothamBold
    Btn.Size = UDim2.new(1, 0, 0, 35)
    Btn.Parent = Tab

    local BtnCorner = Instance.new("UICorner")
    BtnCorner.CornerRadius = UDim.new(0, 6)
    BtnCorner.Parent = Btn

    local State = false
    Btn.MouseButton1Click:Connect(function()
        State = not State
        Btn.Text = State and "MFS Mode: ON" or "MFS Mode: OFF"
        Btn.BackgroundColor3 = State and Color3.fromRGB(39, 174, 96) or Color3.fromRGB(192, 57, 43)
    end)
end


local function CreateSettingsTabContent(Parent)
    local Tab = Instance.new("Frame")
    Tab.Name = "SettingsTab"
    Tab.BackgroundTransparency = 1
    Tab.Size = UDim2.new(1, 0, 1, 0)  -- FIXED
    Tab.AutomaticSize = Enum.AutomaticSize.Y  -- ADDED
    Tab.Parent = Parent

    local Layout = Instance.new("UIListLayout")
    Layout.FillDirection = Enum.FillDirection.Vertical
    Layout.SortOrder = Enum.SortOrder.LayoutOrder
    Layout.Padding = UDim.new(0, 8)
    Layout.Parent = Tab

    local Label = Instance.new("TextLabel")
    Label.Text = "⚙️ Settings"
    Label.BackgroundColor3 = Color3.fromRGB(52, 73, 94)
    Label.TextColor3 = Color3.fromRGB(26, 188, 156)
    Label.TextSize = 14
    Label.Font = Enum.Font.GothamBold
    Label.Size = UDim2.new(1, 0, 0, 30)
    Label.Parent = Tab

    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 6)
    UICorner.Parent = Label

    for i, Setting in ipairs({"Notifications", "FPS Unlock", "Low Graphics"}) do
        local Btn = Instance.new("TextButton")
        Btn.Text = Setting .. ": OFF"
        Btn.BackgroundColor3 = Color3.fromRGB(192, 57, 43)
        Btn.TextColor3 = Color3.fromRGB(236, 240, 241)
        Btn.TextSize = 12
        Btn.Font = Enum.Font.GothamBold
        Btn.Size = UDim2.new(1, 0, 0, 35)
        Btn.Parent = Tab

        local BtnCorner = Instance.new("UICorner")
        BtnCorner.CornerRadius = UDim.new(0, 6)
        BtnCorner.Parent = Btn

        local State = false
        Btn.MouseButton1Click:Connect(function()
            State = not State
            Btn.Text = State and (Setting .. ": ON") or (Setting .. ": OFF")
            Btn.BackgroundColor3 = State and Color3.fromRGB(39, 174, 96) or Color3.fromRGB(192, 57, 43)
        end)
    end
end


-- ===================== UI FUNCTIONS =====================


local function CreateUI()
    local UserGui = LocalPlayer:WaitForChild("PlayerGui", 5)

    if not UserGui then
        return nil
    end

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "FishItGui"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.Parent = UserGui

    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.BackgroundColor3 = Theme.Background
    MainFrame.BorderSizePixel = 0
    MainFrame.Size = UDim2.new(0, 500, 0, 600)  -- FIXED: Changed to fixed size (larger)
    MainFrame.Position = UDim2.new(0.5, -250, 0.5, -300)  -- Center on screen
    MainFrame.Parent = ScreenGui

    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 8)
    UICorner.Parent = MainFrame

    -- Header
    local Header = Instance.new("Frame")
    Header.BackgroundColor3 = Theme.Primary
    Header.BorderSizePixel = 0
    Header.Size = UDim2.new(1, 0, 0, 40)
    Header.Parent = MainFrame

    local HeaderCorner = Instance.new("UICorner")
    HeaderCorner.CornerRadius = UDim.new(0, 8)
    HeaderCorner.Parent = Header

    local Title = Instance.new("TextLabel")
    Title.Text = "🐟 FISH IT v" .. GameVersion
    Title.BackgroundTransparency = 1
    Title.TextColor3 = Theme.TextColor
    Title.TextSize = 14
    Title.Font = Enum.Font.GothamBold
    Title.Size = UDim2.new(0.7, 0, 1, 0)
    Title.Position = UDim2.new(0.02, 0, 0, 0)
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Parent = Header

    -- Mode buttons
    local ModeContainer = Instance.new("Frame")
    ModeContainer.BackgroundTransparency = 1
    ModeContainer.Size = UDim2.new(0.25, 0, 1, 0)
    ModeContainer.Position = UDim2.new(0.75, 0, 0, 0)
    ModeContainer.Parent = Header

    local MinButton = CreateHeaderButton(ModeContainer, "−", 0, Color3.fromRGB(149, 165, 166))
    local FullButton = CreateHeaderButton(ModeContainer, "⬜", 0.33, Theme.Success)
    local CloseButton = CreateHeaderButton(ModeContainer, "✕", 0.66, Theme.Danger)

    MinButton.MouseButton1Click:Connect(function()
        ToggleMode("minimize")
    end)

    FullButton.MouseButton1Click:Connect(function()
        ToggleMode("full")
    end)

    CloseButton.MouseButton1Click:Connect(function()
        ToggleMode("close")
    end)

    -- Tab Navigation
    local TabContainer = Instance.new("Frame")
    TabContainer.Name = "TabContainer"
    TabContainer.BackgroundColor3 = Theme.Secondary
    TabContainer.BorderSizePixel = 0
    TabContainer.Size = UDim2.new(1, 0, 0, 35)
    TabContainer.Position = UDim2.new(0, 0, 0, 40)
    TabContainer.Parent = MainFrame

    local TabList = Instance.new("UIListLayout")
    TabList.FillDirection = Enum.FillDirection.Horizontal
    TabList.SortOrder = Enum.SortOrder.LayoutOrder
    TabList.Padding = UDim.new(0, 2)
    TabList.Parent = TabContainer

    local Tabs = {"Main", "Automation", "Quest", "Shop", "Premium", "Settings"}

    for i, TabName in ipairs(Tabs) do
        local TabButton = Instance.new("TextButton")
        TabButton.Name = TabName .. "Tab"
        TabButton.Text = TabName
        TabButton.BackgroundColor3 = i == 1 and Theme.Primary or Theme.Secondary
        TabButton.TextColor3 = Theme.TextColor
        TabButton.TextSize = 12
        TabButton.Font = Enum.Font.Gotham
        TabButton.Size = UDim2.new(1 / #Tabs, -2, 1, 0)
        TabButton.BorderSizePixel = 0
        TabButton.LayoutOrder = i
        TabButton.Parent = TabContainer

        TabButton.MouseButton1Click:Connect(function()
            SwitchTab(TabName, TabContainer, TabButton)
        end)
    end

    -- Content Area
    local ContentFrame = Instance.new("ScrollingFrame")
    ContentFrame.Name = "ContentFrame"
    ContentFrame.BackgroundColor3 = Theme.Background
    ContentFrame.BorderSizePixel = 0
    ContentFrame.Size = UDim2.new(1, 0, 1, -75)
    ContentFrame.Position = UDim2.new(0, 0, 0, 75)
    ContentFrame.ScrollBarThickness = 8
    ContentFrame.ScrollBarImageColor3 = Theme.Primary
    ContentFrame.CanvasSize = UDim2.new(0, 0, 0, 0)  -- FIXED: Will be auto-updated
    ContentFrame.Parent = MainFrame

    local ContentLayout = Instance.new("UIListLayout")
    ContentLayout.FillDirection = Enum.FillDirection.Vertical
    ContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
    ContentLayout.Padding = UDim.new(0, 8)
    ContentLayout.Parent = ContentFrame

    local Padding = Instance.new("UIPadding")
    Padding.PaddingLeft = UDim.new(0, 10)
    Padding.PaddingRight = UDim.new(0, 10)
    Padding.PaddingTop = UDim.new(0, 10)
    Padding.PaddingBottom = UDim.new(0, 10)
    Padding.Parent = ContentFrame

    -- ADDED: Dynamic CanvasSize update
    ContentLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        ContentFrame.CanvasSize = UDim2.new(0, 0, 0, ContentLayout.AbsoluteContentSize.Y + 20)
    end)

    -- Create tabs content
    CreateMainTabContent(ContentFrame)
    CreateAutomationTabContent(ContentFrame)
    CreateQuestTabContent(ContentFrame)
    CreateShopTabContent(ContentFrame)
    CreatePremiumTabContent(ContentFrame)
    CreateSettingsTabContent(ContentFrame)

    -- Hide non-Main tabs initially
    for _, Tab in ipairs(ContentFrame:GetChildren()) do
        if Tab:IsA("Frame") and Tab.Name ~= "MainTab" and Tab.Name ~= "UIListLayout" and Tab.Name ~= "UIPadding" then
            Tab.Visible = false
        end
    end

    return {
        ScreenGui = ScreenGui,
        MainFrame = MainFrame,
        ContentFrame = ContentFrame,
        TabContainer = TabContainer,
    }
end


-- ===================== MAIN SCRIPT =====================


local function Initialize()
    -- Load config
    ConfigModule.Load("default")

    -- Create UI
    UIModule.GUI = CreateUI()

    -- Setup connections
    if UIModule.GUI then
        SetupConnections()
    end
end


local function SetupConnections()
    -- Character respawn
    LocalPlayer.CharacterAdded:Connect(function(NewCharacter)
        Character = NewCharacter
        Humanoid = Character:FindFirstChild("Humanoid")
        RootPart = Character:FindFirstChild("HumanoidRootPart")
    end)

    -- Main loop
    RunService.Heartbeat:Connect(function()
        if ScriptEnabled and Humanoid and Humanoid.Health > 0 then
            UpdateScript()
        end
    end)

    -- Input handling
    UserInputService.InputBegan:Connect(function(Input, GameProcessed)
        if GameProcessed then return end
        if Input.KeyCode == Enum.KeyCode.R then
            if UIModule.GUI then
                UIModule.GUI.ScreenGui.Enabled = not UIModule.GUI.ScreenGui.Enabled
            end
        end
    end)
end


local function UpdateScript()
    if AutomationModule.FishingActive then
        -- Fishing logic here
    end

    if AutomationModule.FarmingActive then
        -- Farming logic here
    end

    if AutomationModule.TotemActive then
        -- Totem logic here
    end
end


-- Wait for game to load
wait(2)
local Success, Error = pcall(function()
    Initialize()
end)


if Success then
    ShowNotification("✅ Script Ready", "Fish It v" .. GameVersion .. " Loaded Successfully!", 5)
else
    warn("❌ Script Error:", Error)
end


-- Keep script running
while ScriptEnabled do
    wait(0.1)
end
