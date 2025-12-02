--[[ 
    FISH IT - Main Executor Script
    Game: Fish It (Roblox)
    PlaceId: 121864768012064
    Version: 1.0.0
    
    USAGE: Paste this entire script in Volcano, Delta, or other executors
]]

local GameVersion = "1.0.0"
local ScriptEnabled = true

-- Services
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")

-- Local Player
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character
local Humanoid = Character and Character:FindFirstChild("Humanoid")
local RootPart = Character and Character:FindFirstChild("HumanoidRootPart")

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

-- ===================== UI FUNCTIONS =====================

local function CreateUI()
    local UserGui = LocalPlayer:WaitForChild("PlayerGui")
    
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "FishItGui"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.Size = UDim2.new(0.4, 0, 0.6, 0)
    ScreenGui.Position = UDim2.new(0, 10, 0, 10)
    ScreenGui.Parent = UserGui
    
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.BackgroundColor3 = Theme.Background
    MainFrame.BorderSizePixel = 0
    MainFrame.Size = UDim2.new(1, 0, 1, 0)
    MainFrame.Parent = ScreenGui
    
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 8)
    UICorner.Parent = MainFrame
    
    -- Header
    local Header = Instance.new("Frame")
    Header.BackgroundColor3 = Theme.Primary
    Header.BorderSizePixel = 0
    Header.Size = UDim2.new(1, 0, 0.08, 0)
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
    TabContainer.BackgroundColor3 = Theme.Secondary
    TabContainer.BorderSizePixel = 0
    TabContainer.Size = UDim2.new(1, 0, 0.06, 0)
    TabContainer.Position = UDim2.new(0, 0, 0.08, 0)
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
    ContentFrame.Size = UDim2.new(1, 0, 0.86, 0)
    ContentFrame.Position = UDim2.new(0, 0, 0.14, 0)
    ContentFrame.ScrollBarThickness = 8
    ContentFrame.ScrollBarImageColor3 = Theme.Primary
    ContentFrame.CanvasSize = UDim2.new(0, 0, 2, 0)
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
    
    -- Create tabs content
    CreateMainTabContent(ContentFrame)
    CreateAutomationTabContent(ContentFrame)
    CreateQuestTabContent(ContentFrame)
    CreateShopTabContent(ContentFrame)
    CreatePremiumTabContent(ContentFrame)
    CreateSettingsTabContent(ContentFrame)
    
    return {
        ScreenGui = ScreenGui,
        MainFrame = MainFrame,
        ContentFrame = ContentFrame,
        TabContainer = TabContainer,
    }
end

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

local function CreateMainTabContent(Parent)
    local Tab = Instance.new("Frame")
    Tab.Name = "MainTab"
    Tab.BackgroundTransparency = 1
    Tab.Size = UDim2.new(1, 0, 0.5, 0)
    Tab.Parent = Parent
    
    -- Local Player Section
    local PlayerSection = CreateSection("Local Player", Tab)
    CreateToggleButton("WalkSpeed", PlayerSection, function(value)
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.WalkSpeed = value and 30 or 16
        end
    end)
    
    CreateToggleButton("JumpPower", PlayerSection, function(value)
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.JumpPower = value and 100 or 50
        end
    end)
    
    CreateToggleButton("Freeze Position", PlayerSection, function(value)
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            LocalPlayer.Character.HumanoidRootPart.CanCollide = not value
        end
    end)
    
    -- Location Saver Section
    local LocationSection = CreateSection("Location Saver", Tab)
    CreateButton("Save Spot", LocationSection, function()
        local Position = LocalPlayer.Character.HumanoidRootPart.Position
        ConfigModule.SaveLocation("CustomSpot", Position)
    end)
    
    CreateButton("Load Spot", LocationSection, function()
        local Position = ConfigModule.LoadLocation("CustomSpot")
        if Position then
            LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Position)
        end
    end)
    
    CreateButton("Delete Spot", LocationSection, function()
        ConfigModule.DeleteLocation("CustomSpot")
    end)
    
    -- Teleport Section
    local TeleportSection = CreateSection("Teleport", Tab)
    local Locations = {"Island 1", "Island 2", "Island 3", "Fishing Spot", "Shop", "Custom Spot"}
    
    for _, Location in ipairs(Locations) do
        CreateButton("TP: " .. Location, TeleportSection, function() end)
    end
end

local function CreateAutomationTabContent(Parent)
    local Tab = Instance.new("Frame")
    Tab.Name = "AutomationTab"
    Tab.BackgroundTransparency = 1
    Tab.Size = UDim2.new(1, 0, 1, 0)
    Tab.Parent = Parent
    Tab.Visible = false
    
    -- Auto Fishing Section
    local FishingSection = CreateSection("Auto Fishing", Tab)
    
    local Modes = {"Instant", "Legit", "Blatant"}
    for _, Mode in ipairs(Modes) do
        CreateToggleButton(Mode .. " Mode", FishingSection, function(value)
            if value then
                AutomationModule.FishingMode = Mode
                AutomationModule.FishingActive = true
            else
                AutomationModule.FishingActive = false
            end
        end)
    end
    
    CreateToggleButton("1 Second 5 Fish Mode", FishingSection, function(value)
        AutomationModule.FishingConfig.OneSecondFiveFish = value
    end)
    
    CreateToggleButton("Auto Farming", Tab, function(value)
        AutomationModule.FarmingActive = value
    end)
    
    CreateToggleButton("Auto Totems", Tab, function(value)
        AutomationModule.TotemActive = value
    end)
    
    CreateToggleButton("Auto Favorite/Unfavorite", Tab, function(value) end)
    CreateToggleButton("Auto Trade", Tab, function(value)
        AutomationModule.TradeActive = value
    end)
    
    CreateToggleButton("Auto Enchants 1", Tab, function(value) end)
    CreateToggleButton("Auto Enchants 2", Tab, function(value) end)
    CreateToggleButton("Auto Claim Battlepass", Tab, function(value) end)
end

local function CreateQuestTabContent(Parent)
    local Tab = Instance.new("Frame")
    Tab.Name = "QuestTab"
    Tab.BackgroundTransparency = 1
    Tab.Size = UDim2.new(1, 0, 0.3, 0)
    Tab.Parent = Parent
    Tab.Visible = false
    
    CreateToggleButton("Auto Quest: Lever Task", Tab, function(value) end)
    CreateToggleButton("Auto Quest: Ruin Task", Tab, function(value) end)
    CreateToggleButton("Auto Quest: Ghostfinn Rod", Tab, function(value) end)
    CreateToggleButton("Auto Quest: Element Rod", Tab, function(value) end)
end

local function CreateShopTabContent(Parent)
    local Tab = Instance.new("Frame")
    Tab.Name = "ShopTab"
    Tab.BackgroundTransparency = 1
    Tab.Size = UDim2.new(1, 0, 0.5, 0)
    Tab.Parent = Parent
    Tab.Visible = false
    
    CreateToggleButton("Auto Buy Rod", Tab, function(value) end)
    CreateToggleButton("Auto Buy Bobbers", Tab, function(value) end)
    CreateToggleButton("Auto Buy Traveling Merchant", Tab, function(value) end)
    CreateToggleButton("Auto Buy Tix Shop", Tab, function(value) end)
    CreateToggleButton("Auto Sell", Tab, function(value) end)
    CreateToggleButton("Auto Sell Enchant Stone", Tab, function(value) end)
    CreateToggleButton("Auto Weather", Tab, function(value) end)
end

local function CreatePremiumTabContent(Parent)
    local Tab = Instance.new("Frame")
    Tab.Name = "PremiumTab"
    Tab.BackgroundTransparency = 1
    Tab.Size = UDim2.new(1, 0, 0.3, 0)
    Tab.Parent = Parent
    Tab.Visible = false
    
    CreateTextInput("Minimum Rod Config", Tab, "")
    CreateTextInput("Target Rod to Buy", Tab, "")
    CreateTextInput("Target Bait to Buy", Tab, "")
    CreateToggleButton("MFS Mode", Tab, function(value) end)
end

local function CreateSettingsTabContent(Parent)
    local Tab = Instance.new("Frame")
    Tab.Name = "SettingsTab"
    Tab.BackgroundTransparency = 1
    Tab.Size = UDim2.new(1, 0, 0.5, 0)
    Tab.Parent = Parent
    Tab.Visible = false
    
    CreateTextInput("Discord Webhook URL", Tab, "")
    CreateToggleButton("Notifications", Tab, function(value) end)
    CreateToggleButton("FPS Unlock", Tab, function(value)
        if value then
            setfpscap(999)
        else
            setfpscap(60)
        end
    end)
    
    CreateToggleButton("Low Graphics", Tab, function(value) end)
    CreateButton("Save Config", Tab, function()
        ConfigModule.Save("default")
    end)
    CreateButton("Load Config", Tab, function()
        ConfigModule.Load("default")
    end)
    CreateButton("Auto Update Check", Tab, function() end)
end

local function CreateSection(Title, Parent)
    local Section = Instance.new("Frame")
    Section.BackgroundColor3 = Color3.fromRGB(52, 73, 94)
    Section.BorderSizePixel = 0
    Section.Size = UDim2.new(1, 0, 0.2, 0)
    Section.Parent = Parent
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 6)
    Corner.Parent = Section
    
    local Title_Label = Instance.new("TextLabel")
    Title_Label.Text = Title
    Title_Label.BackgroundTransparency = 1
    Title_Label.TextColor3 = Color3.fromRGB(26, 188, 156)
    Title_Label.TextSize = 14
    Title_Label.Font = Enum.Font.GothamBold
    Title_Label.Size = UDim2.new(1, 0, 0.3, 0)
    Title_Label.TextXAlignment = Enum.TextXAlignment.Left
    Title_Label.Parent = Section
    
    local Layout = Instance.new("UIListLayout")
    Layout.FillDirection = Enum.FillDirection.Vertical
    Layout.SortOrder = Enum.SortOrder.LayoutOrder
    Layout.Padding = UDim.new(0, 4)
    Layout.Parent = Section
    
    return Section
end

local function CreateToggleButton(Label, Parent, Callback)
    local Container = Instance.new("Frame")
    Container.BackgroundColor3 = Color3.fromRGB(44, 62, 80)
    Container.BorderSizePixel = 0
    Container.Size = UDim2.new(1, 0, 0.08, 0)
    Container.Parent = Parent
    
    local Label_Text = Instance.new("TextLabel")
    Label_Text.Text = Label
    Label_Text.BackgroundTransparency = 1
    Label_Text.TextColor3 = Color3.fromRGB(236, 240, 241)
    Label_Text.TextSize = 11
    Label_Text.Font = Enum.Font.Gotham
    Label_Text.Size = UDim2.new(0.7, 0, 1, 0)
    Label_Text.TextXAlignment = Enum.TextXAlignment.Left
    Label_Text.Parent = Container
    
    local ToggleButton = Instance.new("TextButton")
    ToggleButton.Text = "OFF"
    ToggleButton.BackgroundColor3 = Color3.fromRGB(192, 57, 43)
    ToggleButton.TextColor3 = Color3.fromRGB(236, 240, 241)
    ToggleButton.TextSize = 10
    ToggleButton.Font = Enum.Font.GothamBold
    ToggleButton.Size = UDim2.new(0.25, -5, 1, 0)
    ToggleButton.Position = UDim2.new(0.75, 0, 0, 0)
    ToggleButton.BorderSizePixel = 0
    ToggleButton.Parent = Container
    
    local State = false
    ToggleButton.MouseButton1Click:Connect(function()
        State = not State
        ToggleButton.Text = State and "ON" or "OFF"
        ToggleButton.BackgroundColor3 = State and Color3.fromRGB(39, 174, 96) or Color3.fromRGB(192, 57, 43)
        if Callback then
            Callback(State)
        end
    end)
    
    return Container
end

local function CreateButton(Label, Parent, Callback)
    local Button = Instance.new("TextButton")
    Button.Text = Label
    Button.BackgroundColor3 = Color3.fromRGB(26, 188, 156)
    Button.TextColor3 = Color3.fromRGB(236, 240, 241)
    Button.TextSize = 11
    Button.Font = Enum.Font.GothamBold
    Button.Size = UDim2.new(1, 0, 0.08, 0)
    Button.BorderSizePixel = 0
    Button.Parent = Parent
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 4)
    Corner.Parent = Button
    
    Button.MouseButton1Click:Connect(function()
        if Callback then
            Callback()
        end
    end)
    
    return Button
end

local function CreateTextInput(Label, Parent, DefaultValue)
    local Container = Instance.new("Frame")
    Container.BackgroundTransparency = 1
    Container.Size = UDim2.new(1, 0, 0.1, 0)
    Container.Parent = Parent
    
    local Label_Text = Instance.new("TextLabel")
    Label_Text.Text = Label
    Label_Text.BackgroundTransparency = 1
    Label_Text.TextColor3 = Color3.fromRGB(236, 240, 241)
    Label_Text.TextSize = 11
    Label_Text.Font = Enum.Font.Gotham
    Label_Text.Size = UDim2.new(1, 0, 0.4, 0)
    Label_Text.TextXAlignment = Enum.TextXAlignment.Left
    Label_Text.Parent = Container
    
    local InputBox = Instance.new("TextBox")
    InputBox.BackgroundColor3 = Color3.fromRGB(52, 73, 94)
    InputBox.TextColor3 = Color3.fromRGB(236, 240, 241)
    InputBox.TextSize = 11
    InputBox.Font = Enum.Font.Gotham
    InputBox.Size = UDim2.new(1, 0, 0.6, 0)
    InputBox.Position = UDim2.new(0, 0, 0.4, 0)
    InputBox.PlaceholderText = DefaultValue
    InputBox.BorderSizePixel = 0
    InputBox.Parent = Container
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 4)
    Corner.Parent = InputBox
    
    return InputBox
end

local function SwitchTab(TabName, TabContainer, TabButton)
    local ContentFrame = TabContainer.Parent.ContentFrame
    for _, Tab in ipairs(ContentFrame:GetChildren()) do
        if Tab:IsA("Frame") then
            Tab.Visible = Tab.Name == TabName .. "Tab"
        end
    end
    
    for _, btn in ipairs(TabContainer:GetChildren()) do
        if btn:IsA("TextButton") then
            btn.BackgroundColor3 = btn.Name == TabName .. "Tab" and Theme.Primary or Theme.Secondary
        end
    end
end

local function ToggleMode(Mode)
    UIModule.CurrentMode = Mode
    local GUI = UIModule.GUI
    if GUI then
        if Mode == "close" then
            GUI.ScreenGui.Enabled = false
            UIModule.UIVisible = false
        elseif Mode == "minimize" then
            GUI.MainFrame.Size = UDim2.new(1, 0, 0.12, 0)
            GUI.ContentFrame.Visible = false
        elseif Mode == "full" then
            GUI.MainFrame.Size = UDim2.new(1, 0, 1, 0)
            GUI.ContentFrame.Visible = true
            GUI.ScreenGui.Enabled = true
            UIModule.UIVisible = true
        end
    end
end

-- ===================== MAIN SCRIPT =====================

local function Initialize()
    -- Load config
    ConfigModule.Load("default")
    
    -- Create UI
    UIModule.GUI = CreateUI()
    
    -- Setup connections
    SetupConnections()
    
    -- Show notification
    local NotificationGui = LocalPlayer:WaitForChild("PlayerGui")
    local Notification = Instance.new("TextLabel")
    Notification.Name = "Notification"
    Notification.Text = "✅ Script Loaded v" .. GameVersion
    Notification.BackgroundColor3 = Theme.Success
    Notification.TextColor3 = Theme.TextColor
    Notification.TextSize = 16
    Notification.Font = Enum.Font.GothamBold
    Notification.Size = UDim2.new(0.3, 0, 0.08, 0)
    Notification.Position = UDim2.new(0.35, 0, 0.95, 0)
    Notification.BorderSizePixel = 0
    Notification.Parent = NotificationGui
    
    local NotifCorner = Instance.new("UICorner")
    NotifCorner.CornerRadius = UDim.new(0, 6)
    NotifCorner.Parent = Notification
    
    game:GetService("Debris"):AddItem(Notification, 3)
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
        if Input.KeyCode == Enum.KeyCode.F1 then
            UIModule.GUI.ScreenGui.Enabled = not UIModule.GUI.ScreenGui.Enabled
        end
    end)
end

local function UpdateScript()
    if AutomationModule.FishingActive then
        -- Fishing logic
    end
    
    if AutomationModule.FarmingActive then
        -- Farming logic
    end
    
    if AutomationModule.TotemActive then
        -- Totem logic
    end
end

-- Wait for game to load
wait(2)
Initialize()

-- Keep script running
while ScriptEnabled do
    wait(0.1)
end
