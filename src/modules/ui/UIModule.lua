--[[ 
    UI Module - Fish It Script
    Support: Mobile, Desktop
    Modes: Full, Minimize, Close
]]

local UIModule = {}
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local UserGui = LocalPlayer:WaitForChild("PlayerGui")

-- UI State
UIModule.UIVisible = true
UIModule.CurrentMode = "full" -- full, minimize, close
UIModule.CurrentTab = "Main"
UIModule.IsMobile = LocalPlayer:FindFirstChild("DeviceType") and LocalPlayer.DeviceType.Value == "Mobile"

-- Theme
local Theme = {
    Primary = Color3.fromRGB(26, 188, 156),
    Secondary = Color3.fromRGB(52, 73, 94),
    Background = Color3.fromRGB(44, 62, 80),
    TextColor = Color3.fromRGB(236, 240, 241),
    Danger = Color3.fromRGB(231, 76, 60),
    Success = Color3.fromRGB(39, 174, 96),
}

-- Create Main GUI
local function CreateMainGui()
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "FishItGui"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    if UIModule.IsMobile then
        ScreenGui.Size = UDim2.new(1, 0, 1, 0)
    else
        ScreenGui.Size = UDim2.new(0.4, 0, 0.6, 0)
        ScreenGui.Position = UDim2.new(0, 10, 0, 10)
    end
    
    ScreenGui.Parent = UserGui
    
    -- Create Main Frame
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.BackgroundColor3 = Theme.Background
    MainFrame.BorderSizePixel = 0
    MainFrame.Size = UDim2.new(1, 0, 1, 0)
    MainFrame.Parent = ScreenGui
    
    -- Corner rounding
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 8)
    UICorner.Parent = MainFrame
    
    -- Header
    local Header = Instance.new("Frame")
    Header.Name = "Header"
    Header.BackgroundColor3 = Theme.Primary
    Header.BorderSizePixel = 0
    Header.Size = UDim2.new(1, 0, 0.08, 0)
    Header.Parent = MainFrame
    
    local HeaderCorner = Instance.new("UICorner")
    HeaderCorner.CornerRadius = UDim.new(0, 8)
    HeaderCorner.Parent = Header
    
    -- Title
    local Title = Instance.new("TextLabel")
    Title.Name = "Title"
    Title.Text = "🐟 FISH IT v1.0.0"
    Title.BackgroundTransparency = 1
    Title.TextColor3 = Theme.TextColor
    Title.TextSize = UIModule.IsMobile and 18 or 14
    Title.Font = Enum.Font.GothamBold
    Title.Size = UDim2.new(0.7, 0, 1, 0)
    Title.Position = UDim2.new(0.02, 0, 0, 0)
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Parent = Header
    
    -- Mode buttons (Full, Minimize, Close)
    local ModeContainer = Instance.new("Frame")
    ModeContainer.Name = "ModeContainer"
    ModeContainer.BackgroundTransparency = 1
    ModeContainer.Size = UDim2.new(0.25, 0, 1, 0)
    ModeContainer.Position = UDim2.new(0.75, 0, 0, 0)
    ModeContainer.Parent = Header
    
    -- Minimize button
    local MinButton = Instance.new("TextButton")
    MinButton.Name = "MinButton"
    MinButton.Text = "−"
    MinButton.BackgroundColor3 = Color3.fromRGB(149, 165, 166)
    MinButton.TextColor3 = Theme.TextColor
    MinButton.TextSize = 18
    MinButton.Font = Enum.Font.GothamBold
    MinButton.Size = UDim2.new(0.33, -2, 1, 0)
    MinButton.Position = UDim2.new(0, 0, 0, 0)
    MinButton.BorderSizePixel = 0
    MinButton.Parent = ModeContainer
    
    -- Full button
    local FullButton = Instance.new("TextButton")
    FullButton.Name = "FullButton"
    FullButton.Text = "⬜"
    FullButton.BackgroundColor3 = Theme.Success
    FullButton.TextColor3 = Theme.TextColor
    FullButton.TextSize = 12
    FullButton.Font = Enum.Font.Gotham
    FullButton.Size = UDim2.new(0.33, -2, 1, 0)
    FullButton.Position = UDim2.new(0.33, 2, 0, 0)
    FullButton.BorderSizePixel = 0
    FullButton.Parent = ModeContainer
    
    -- Close button
    local CloseButton = Instance.new("TextButton")
    CloseButton.Name = "CloseButton"
    CloseButton.Text = "✕"
    CloseButton.BackgroundColor3 = Theme.Danger
    CloseButton.TextColor3 = Theme.TextColor
    CloseButton.TextSize = 14
    CloseButton.Font = Enum.Font.GothamBold
    CloseButton.Size = UDim2.new(0.34, 0, 1, 0)
    CloseButton.Position = UDim2.new(0.66, 2, 0, 0)
    CloseButton.BorderSizePixel = 0
    CloseButton.Parent = ModeContainer
    
    -- Tab Navigation
    local TabContainer = Instance.new("Frame")
    TabContainer.Name = "TabContainer"
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
        TabButton.TextSize = UIModule.IsMobile and 10 or 12
        TabButton.Font = Enum.Font.Gotham
        TabButton.Size = UDim2.new(1 / #Tabs, -2, 1, 0)
        TabButton.BorderSizePixel = 0
        TabButton.LayoutOrder = i
        TabButton.Parent = TabContainer
        
        TabButton.MouseButton1Click:Connect(function()
            UIModule.SwitchTab(TabName)
            -- Update tab colors
            for _, btn in ipairs(TabContainer:GetChildren()) do
                if btn:IsA("TextButton") then
                    btn.BackgroundColor3 = btn.Name == TabName .. "Tab" and Theme.Primary or Theme.Secondary
                end
            end
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
    
    -- Padding
    local Padding = Instance.new("UIPadding")
    Padding.PaddingLeft = UDim.new(0, 10)
    Padding.PaddingRight = UDim.new(0, 10)
    Padding.PaddingTop = UDim.new(0, 10)
    Padding.PaddingBottom = UDim.new(0, 10)
    Padding.Parent = ContentFrame
    
    -- Button connections
    MinButton.MouseButton1Click:Connect(function()
        UIModule.SetMode("minimize")
    end)
    
    FullButton.MouseButton1Click:Connect(function()
        UIModule.SetMode("full")
    end)
    
    CloseButton.MouseButton1Click:Connect(function()
        UIModule.SetMode("close")
    end)
    
    return {
        ScreenGui = ScreenGui,
        MainFrame = MainFrame,
        Header = Header,
        ContentFrame = ContentFrame,
        TabContainer = TabContainer,
    }
end

-- Create tabs content
local function CreateTabContent(ContentFrame)
    -- Main Tab
    local MainTab = CreateMainTabContent()
    MainTab.Parent = ContentFrame
    
    -- Automation Tab
    local AutomationTab = CreateAutomationTabContent()
    AutomationTab.Parent = ContentFrame
    AutomationTab.Visible = false
    
    -- Quest Tab
    local QuestTab = CreateQuestTabContent()
    QuestTab.Parent = ContentFrame
    QuestTab.Visible = false
    
    -- Shop Tab
    local ShopTab = CreateShopTabContent()
    ShopTab.Parent = ContentFrame
    ShopTab.Visible = false
    
    -- Premium Tab
    local PremiumTab = CreatePremiumTabContent()
    PremiumTab.Parent = ContentFrame
    PremiumTab.Visible = false
    
    -- Settings Tab
    local SettingsTab = CreateSettingsTabContent()
    SettingsTab.Parent = ContentFrame
    SettingsTab.Visible = false
    
    return {
        Main = MainTab,
        Automation = AutomationTab,
        Quest = QuestTab,
        Shop = ShopTab,
        Premium = PremiumTab,
        Settings = SettingsTab,
    }
end

-- Create Main Tab Content
local function CreateMainTabContent()
    local Tab = Instance.new("Frame")
    Tab.Name = "MainTab"
    Tab.BackgroundTransparency = 1
    Tab.Size = UDim2.new(1, 0, 0.5, 0)
    
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
        local Config = require(game.ServerScriptService:WaitForChild("ConfigModule"))
        Config.SaveLocation("CustomSpot", Position)
    end)
    
    CreateButton("Load Spot", LocationSection, function()
        local Config = require(game.ServerScriptService:WaitForChild("ConfigModule"))
        local Position = Config.LoadLocation("CustomSpot")
        if Position then
            LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Position)
        end
    end)
    
    -- Teleport Section
    local TeleportSection = CreateSection("Teleport", Tab)
    local Locations = {
        "Island 1", "Island 2", "Island 3",
        "Fishing Spot", "Shop", "Custom Spot"
    }
    
    for _, Location in ipairs(Locations) do
        CreateButton("TP: " .. Location, TeleportSection, function()
            -- Teleport logic
        end)
    end
    
    return Tab
end

-- Create Automation Tab Content
local function CreateAutomationTabContent()
    local Tab = Instance.new("Frame")
    Tab.Name = "AutomationTab"
    Tab.BackgroundTransparency = 1
    Tab.Size = UDim2.new(1, 0, 1, 0)
    
    -- Auto Fishing Section
    local FishingSection = CreateSection("Auto Fishing", Tab)
    
    local Modes = {"Instant", "Legit", "Blatant"}
    for _, Mode in ipairs(Modes) do
        local ModeFrame = Instance.new("Frame")
        ModeFrame.BackgroundColor3 = Color3.fromRGB(52, 73, 94)
        ModeFrame.BorderSizePixel = 0
        ModeFrame.Size = UDim2.new(1, 0, 0.08, 0)
        ModeFrame.Parent = FishingSection
        
        local Label = Instance.new("TextLabel")
        Label.Text = Mode .. " Mode"
        Label.BackgroundTransparency = 1
        Label.TextColor3 = Color3.fromRGB(236, 240, 241)
        Label.TextSize = 12
        Label.Size = UDim2.new(0.5, 0, 1, 0)
        Label.TextXAlignment = Enum.TextXAlignment.Left
        Label.Parent = ModeFrame
        
        CreateToggleButton("Auto Fish", ModeFrame, function(value) end)
        CreateToggleButton("Complete Delay", ModeFrame, function(value) end)
        CreateToggleButton("Cancel Delay", ModeFrame, function(value) end)
    end
    
    CreateToggleButton("1 Second 5 Fish Mode", FishingSection, function(value) end)
    
    -- Auto Farming
    CreateToggleButton("Auto Farming", Tab, function(value) end)
    CreateToggleButton("Auto Totems", Tab, function(value) end)
    CreateToggleButton("Auto Favorite/Unfavorite", Tab, function(value) end)
    CreateToggleButton("Auto Trade", Tab, function(value) end)
    CreateToggleButton("Auto Enchants 1", Tab, function(value) end)
    CreateToggleButton("Auto Enchants 2", Tab, function(value) end)
    CreateToggleButton("Auto Claim Battlepass", Tab, function(value) end)
    
    return Tab
end

-- Create Quest Tab Content
local function CreateQuestTabContent()
    local Tab = Instance.new("Frame")
    Tab.Name = "QuestTab"
    Tab.BackgroundTransparency = 1
    Tab.Size = UDim2.new(1, 0, 0.3, 0)
    
    CreateToggleButton("Auto Quest: Lever Task", Tab, function(value) end)
    CreateToggleButton("Auto Quest: Ruin Task", Tab, function(value) end)
    CreateToggleButton("Auto Quest: Ghostfinn Rod", Tab, function(value) end)
    CreateToggleButton("Auto Quest: Element Rod", Tab, function(value) end)
    
    return Tab
end

-- Create Shop Tab Content
local function CreateShopTabContent()
    local Tab = Instance.new("Frame")
    Tab.Name = "ShopTab"
    Tab.BackgroundTransparency = 1
    Tab.Size = UDim2.new(1, 0, 0.5, 0)
    
    CreateToggleButton("Auto Buy Rod", Tab, function(value) end)
    CreateToggleButton("Auto Buy Bobbers", Tab, function(value) end)
    CreateToggleButton("Auto Buy Traveling Merchant", Tab, function(value) end)
    CreateToggleButton("Auto Buy Tix Shop", Tab, function(value) end)
    CreateToggleButton("Auto Sell", Tab, function(value) end)
    CreateToggleButton("Auto Sell Enchant Stone", Tab, function(value) end)
    CreateToggleButton("Auto Weather", Tab, function(value) end)
    
    return Tab
end

-- Create Premium Tab Content
local function CreatePremiumTabContent()
    local Tab = Instance.new("Frame")
    Tab.Name = "PremiumTab"
    Tab.BackgroundTransparency = 1
    Tab.Size = UDim2.new(1, 0, 0.3, 0)
    
    CreateTextInput("Minimum Rod Config", Tab, "")
    CreateTextInput("Target Rod to Buy", Tab, "")
    CreateTextInput("Target Bait to Buy", Tab, "")
    CreateToggleButton("MFS Mode", Tab, function(value) end)
    
    return Tab
end

-- Create Settings Tab Content
local function CreateSettingsTabContent()
    local Tab = Instance.new("Frame")
    Tab.Name = "SettingsTab"
    Tab.BackgroundTransparency = 1
    Tab.Size = UDim2.new(1, 0, 0.5, 0)
    
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
    CreateButton("Save Config", Tab, function() end)
    CreateButton("Load Config", Tab, function() end)
    CreateButton("Auto Update Check", Tab, function() end)
    
    return Tab
end

-- Helper: Create Section
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

-- Helper: Create Toggle Button
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

-- Helper: Create Button
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

-- Helper: Create Text Input
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

-- Initialize UI
function UIModule.Initialize()
    local GUI = CreateMainGui()
    local Tabs = CreateTabContent(GUI.ContentFrame)
    UIModule.GUI = GUI
    UIModule.Tabs = Tabs
end

-- Switch Tab
function UIModule.SwitchTab(TabName)
    if UIModule.Tabs then
        for TabKey, Tab in pairs(UIModule.Tabs) do
            Tab.Visible = TabKey == TabName
        end
        UIModule.CurrentTab = TabName
    end
end

-- Set UI Mode
function UIModule.SetMode(Mode)
    UIModule.CurrentMode = Mode
    if UIModule.GUI then
        if Mode == "close" then
            UIModule.GUI.ScreenGui.Enabled = false
            UIModule.UIVisible = false
        elseif Mode == "minimize" then
            UIModule.GUI.MainFrame.Size = UDim2.new(1, 0, 0.12, 0)
            UIModule.GUI.ContentFrame.Visible = false
        elseif Mode == "full" then
            UIModule.GUI.MainFrame.Size = UDim2.new(1, 0, 1, 0)
            UIModule.GUI.ContentFrame.Visible = true
            UIModule.GUI.ScreenGui.Enabled = true
            UIModule.UIVisible = true
        end
    end
end

-- Toggle UI
function UIModule.ToggleUI()
    if UIModule.GUI then
        UIModule.GUI.ScreenGui.Enabled = not UIModule.GUI.ScreenGui.Enabled
        UIModule.UIVisible = UIModule.GUI.ScreenGui.Enabled
    end
end

return UIModule
