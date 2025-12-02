--[[ 
    UI Module - Fish It Script (FIXED VERSION)
    Support: Mobile, Desktop
    Modes: Full, Minimize, Close
    Version: 1.0.1

    FIXES:
    - Function order corrected (helpers before usage)
    - Tab sizing fixed (full height + AutomaticSize)
    - Section sizing fixed (AutomaticSize)
    - MainFrame sizing improved (larger fixed size)
    - Dynamic CanvasSize
    - All rendering issues resolved
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
UIModule.IsMobile = UserInputService.TouchEnabled and not UserInputService.MouseEnabled


-- Theme
local Theme = {
    Primary = Color3.fromRGB(26, 188, 156),
    Secondary = Color3.fromRGB(52, 73, 94),
    Background = Color3.fromRGB(44, 62, 80),
    TextColor = Color3.fromRGB(236, 240, 241),
    Danger = Color3.fromRGB(231, 76, 60),
    Success = Color3.fromRGB(39, 174, 96),
}


-- ===================== HELPER FUNCTIONS (DEFINED FIRST) =====================


-- Helper: Create Section
local function CreateSection(Title, Parent)
    local Section = Instance.new("Frame")
    Section.Name = Title .. "Section"
    Section.BackgroundColor3 = Color3.fromRGB(52, 73, 94)
    Section.BorderSizePixel = 0
    Section.Size = UDim2.new(1, 0, 0, 0)
    Section.AutomaticSize = Enum.AutomaticSize.Y  -- FIXED: Auto resize
    Section.Parent = Parent

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 6)
    Corner.Parent = Section

    local Title_Label = Instance.new("TextLabel")
    Title_Label.Name = "SectionTitle"
    Title_Label.Text = "  " .. Title
    Title_Label.BackgroundTransparency = 1
    Title_Label.TextColor3 = Color3.fromRGB(26, 188, 156)
    Title_Label.TextSize = 14
    Title_Label.Font = Enum.Font.GothamBold
    Title_Label.Size = UDim2.new(1, 0, 0, 30)
    Title_Label.TextXAlignment = Enum.TextXAlignment.Left
    Title_Label.Parent = Section

    local Layout = Instance.new("UIListLayout")
    Layout.FillDirection = Enum.FillDirection.Vertical
    Layout.SortOrder = Enum.SortOrder.LayoutOrder
    Layout.Padding = UDim.new(0, 4)
    Layout.Parent = Section

    local Padding = Instance.new("UIPadding")
    Padding.PaddingLeft = UDim.new(0, 8)
    Padding.PaddingRight = UDim.new(0, 8)
    Padding.PaddingTop = UDim.new(0, 4)
    Padding.PaddingBottom = UDim.new(0, 8)
    Padding.Parent = Section

    return Section
end


-- Helper: Create Toggle Button
local function CreateToggleButton(Label, Parent, Callback)
    local Container = Instance.new("Frame")
    Container.Name = Label .. "Toggle"
    Container.BackgroundColor3 = Color3.fromRGB(44, 62, 80)
    Container.BorderSizePixel = 0
    Container.Size = UDim2.new(1, 0, 0, 35)
    Container.Parent = Parent

    local ContainerCorner = Instance.new("UICorner")
    ContainerCorner.CornerRadius = UDim.new(0, 4)
    ContainerCorner.Parent = Container

    local Label_Text = Instance.new("TextLabel")
    Label_Text.Text = "  " .. Label
    Label_Text.BackgroundTransparency = 1
    Label_Text.TextColor3 = Color3.fromRGB(236, 240, 241)
    Label_Text.TextSize = UIModule.IsMobile and 10 or 11
    Label_Text.Font = Enum.Font.Gotham
    Label_Text.Size = UDim2.new(0.65, 0, 1, 0)
    Label_Text.TextXAlignment = Enum.TextXAlignment.Left
    Label_Text.Parent = Container

    local ToggleButton = Instance.new("TextButton")
    ToggleButton.Name = "Toggle"
    ToggleButton.Text = "OFF"
    ToggleButton.BackgroundColor3 = Color3.fromRGB(192, 57, 43)
    ToggleButton.TextColor3 = Color3.fromRGB(236, 240, 241)
    ToggleButton.TextSize = UIModule.IsMobile and 9 or 10
    ToggleButton.Font = Enum.Font.GothamBold
    ToggleButton.Size = UDim2.new(0.3, -8, 0.7, 0)
    ToggleButton.Position = UDim2.new(0.68, 0, 0.15, 0)
    ToggleButton.BorderSizePixel = 0
    ToggleButton.Parent = Container

    local ToggleCorner = Instance.new("UICorner")
    ToggleCorner.CornerRadius = UDim.new(0, 4)
    ToggleCorner.Parent = ToggleButton

    local State = false
    ToggleButton.MouseButton1Click:Connect(function()
        State = not State
        ToggleButton.Text = State and "ON" or "OFF"
        ToggleButton.BackgroundColor3 = State and Color3.fromRGB(39, 174, 96) or Color3.fromRGB(192, 57, 43)
        if Callback then
            pcall(function()
                Callback(State)
            end)
        end
    end)

    return Container
end


-- Helper: Create Button
local function CreateButton(Label, Parent, Callback)
    local Button = Instance.new("TextButton")
    Button.Name = Label .. "Button"
    Button.Text = Label
    Button.BackgroundColor3 = Color3.fromRGB(26, 188, 156)
    Button.TextColor3 = Color3.fromRGB(236, 240, 241)
    Button.TextSize = UIModule.IsMobile and 10 or 11
    Button.Font = Enum.Font.GothamBold
    Button.Size = UDim2.new(1, 0, 0, 35)
    Button.BorderSizePixel = 0
    Button.Parent = Parent

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 4)
    Corner.Parent = Button

    Button.MouseButton1Click:Connect(function()
        if Callback then
            pcall(function()
                Callback()
            end)
        end
    end)

    return Button
end


-- Helper: Create Text Input
local function CreateTextInput(Label, Parent, DefaultValue)
    local Container = Instance.new("Frame")
    Container.Name = Label .. "Input"
    Container.BackgroundTransparency = 1
    Container.Size = UDim2.new(1, 0, 0, 60)
    Container.Parent = Parent

    local Label_Text = Instance.new("TextLabel")
    Label_Text.Text = "  " .. Label
    Label_Text.BackgroundTransparency = 1
    Label_Text.TextColor3 = Color3.fromRGB(236, 240, 241)
    Label_Text.TextSize = UIModule.IsMobile and 10 or 11
    Label_Text.Font = Enum.Font.Gotham
    Label_Text.Size = UDim2.new(1, 0, 0, 25)
    Label_Text.TextXAlignment = Enum.TextXAlignment.Left
    Label_Text.Parent = Container

    local InputBox = Instance.new("TextBox")
    InputBox.Name = "Input"
    InputBox.BackgroundColor3 = Color3.fromRGB(52, 73, 94)
    InputBox.TextColor3 = Color3.fromRGB(236, 240, 241)
    InputBox.TextSize = UIModule.IsMobile and 9 or 10
    InputBox.Font = Enum.Font.Gotham
    InputBox.Size = UDim2.new(1, 0, 0, 30)
    InputBox.Position = UDim2.new(0, 0, 0, 28)
    InputBox.PlaceholderText = DefaultValue or "Enter value..."
    InputBox.Text = ""
    InputBox.ClearTextOnFocus = false
    InputBox.BorderSizePixel = 0
    InputBox.Parent = Container

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 4)
    Corner.Parent = InputBox

    local Padding = Instance.new("UIPadding")
    Padding.PaddingLeft = UDim.new(0, 8)
    Padding.Parent = InputBox

    return InputBox
end


-- ===================== TAB CONTENT FUNCTIONS =====================


-- Create Main Tab Content
local function CreateMainTabContent()
    local Tab = Instance.new("Frame")
    Tab.Name = "MainTab"
    Tab.BackgroundTransparency = 1
    Tab.Size = UDim2.new(1, 0, 1, 0)  -- FIXED: Full height
    Tab.AutomaticSize = Enum.AutomaticSize.Y  -- ADDED

    local Layout = Instance.new("UIListLayout")
    Layout.FillDirection = Enum.FillDirection.Vertical
    Layout.SortOrder = Enum.SortOrder.LayoutOrder
    Layout.Padding = UDim.new(0, 10)
    Layout.Parent = Tab

    -- Local Player Section
    local PlayerSection = CreateSection("🎮 Local Player", Tab)
    PlayerSection.LayoutOrder = 1

    CreateToggleButton("WalkSpeed Boost", PlayerSection, function(value)
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.WalkSpeed = value and 30 or 16
        end
    end)

    CreateToggleButton("JumpPower Boost", PlayerSection, function(value)
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.JumpPower = value and 100 or 50
        end
    end)

    CreateToggleButton("Freeze Position", PlayerSection, function(value)
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            LocalPlayer.Character.HumanoidRootPart.Anchored = value
        end
    end)

    -- Location Saver Section
    local LocationSection = CreateSection("📍 Location Saver", Tab)
    LocationSection.LayoutOrder = 2

    CreateButton("💾 Save Current Position", LocationSection, function()
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            local Position = LocalPlayer.Character.HumanoidRootPart.Position
            print("Position saved:", Position)
            -- Save to config here
        end
    end)

    CreateButton("📤 Load Saved Position", LocationSection, function()
        print("Loading saved position...")
        -- Load from config here
    end)

    CreateButton("🗑️ Delete Saved Position", LocationSection, function()
        print("Position deleted")
    end)

    -- Teleport Section
    local TeleportSection = CreateSection("🌍 Teleport", Tab)
    TeleportSection.LayoutOrder = 3

    local Locations = {
        "🏝️ Island 1",
        "🏝️ Island 2", 
        "🏝️ Island 3",
        "🎣 Fishing Spot",
        "🛒 Shop",
        "⭐ Custom Spot"
    }

    for _, Location in ipairs(Locations) do
        CreateButton("TP: " .. Location, TeleportSection, function()
            print("Teleporting to:", Location)
        end)
    end

    return Tab
end


-- Create Automation Tab Content
local function CreateAutomationTabContent()
    local Tab = Instance.new("Frame")
    Tab.Name = "AutomationTab"
    Tab.BackgroundTransparency = 1
    Tab.Size = UDim2.new(1, 0, 1, 0)  -- FIXED
    Tab.AutomaticSize = Enum.AutomaticSize.Y  -- ADDED

    local Layout = Instance.new("UIListLayout")
    Layout.FillDirection = Enum.FillDirection.Vertical
    Layout.SortOrder = Enum.SortOrder.LayoutOrder
    Layout.Padding = UDim.new(0, 10)
    Layout.Parent = Tab

    -- Auto Fishing Section
    local FishingSection = CreateSection("🎣 Auto Fishing", Tab)
    FishingSection.LayoutOrder = 1

    CreateToggleButton("Instant Mode", FishingSection, function(value)
        print("Instant Mode:", value)
    end)

    CreateToggleButton("Legit Mode", FishingSection, function(value)
        print("Legit Mode:", value)
    end)

    CreateToggleButton("Blatant Mode", FishingSection, function(value)
        print("Blatant Mode:", value)
    end)

    CreateToggleButton("1 Second 5 Fish Mode", FishingSection, function(value)
        print("1s5f Mode:", value)
    end)

    -- Auto Farming Section
    local FarmingSection = CreateSection("🌾 Auto Farming", Tab)
    FarmingSection.LayoutOrder = 2

    CreateToggleButton("Auto Farming", FarmingSection, function(value)
        print("Auto Farming:", value)
    end)

    CreateToggleButton("Auto Totems", FarmingSection, function(value)
        print("Auto Totems:", value)
    end)

    CreateToggleButton("Auto Favorite/Unfavorite", FarmingSection, function(value)
        print("Auto Favorite:", value)
    end)

    -- Auto Trading Section
    local TradingSection = CreateSection("💰 Trading & Enchants", Tab)
    TradingSection.LayoutOrder = 3

    CreateToggleButton("Auto Trade", TradingSection, function(value)
        print("Auto Trade:", value)
    end)

    CreateToggleButton("Auto Enchants 1", TradingSection, function(value)
        print("Auto Enchants 1:", value)
    end)

    CreateToggleButton("Auto Enchants 2", TradingSection, function(value)
        print("Auto Enchants 2:", value)
    end)

    CreateToggleButton("Auto Claim Battlepass", TradingSection, function(value)
        print("Auto Battlepass:", value)
    end)

    return Tab
end


-- Create Quest Tab Content
local function CreateQuestTabContent()
    local Tab = Instance.new("Frame")
    Tab.Name = "QuestTab"
    Tab.BackgroundTransparency = 1
    Tab.Size = UDim2.new(1, 0, 1, 0)  -- FIXED
    Tab.AutomaticSize = Enum.AutomaticSize.Y  -- ADDED

    local Layout = Instance.new("UIListLayout")
    Layout.FillDirection = Enum.FillDirection.Vertical
    Layout.SortOrder = Enum.SortOrder.LayoutOrder
    Layout.Padding = UDim.new(0, 10)
    Layout.Parent = Tab

    local QuestSection = CreateSection("📋 Quest Automation", Tab)
    QuestSection.LayoutOrder = 1

    CreateToggleButton("Auto Quest: Lever Task", QuestSection, function(value)
        print("Lever Task:", value)
    end)

    CreateToggleButton("Auto Quest: Ruin Task", QuestSection, function(value)
        print("Ruin Task:", value)
    end)

    CreateToggleButton("Auto Quest: Ghostfinn Rod", QuestSection, function(value)
        print("Ghostfinn Rod:", value)
    end)

    CreateToggleButton("Auto Quest: Element Rod", QuestSection, function(value)
        print("Element Rod:", value)
    end)

    return Tab
end


-- Create Shop Tab Content
local function CreateShopTabContent()
    local Tab = Instance.new("Frame")
    Tab.Name = "ShopTab"
    Tab.BackgroundTransparency = 1
    Tab.Size = UDim2.new(1, 0, 1, 0)  -- FIXED
    Tab.AutomaticSize = Enum.AutomaticSize.Y  -- ADDED

    local Layout = Instance.new("UIListLayout")
    Layout.FillDirection = Enum.FillDirection.Vertical
    Layout.SortOrder = Enum.SortOrder.LayoutOrder
    Layout.Padding = UDim.new(0, 10)
    Layout.Parent = Tab

    local ShopSection = CreateSection("🛒 Shop Automation", Tab)
    ShopSection.LayoutOrder = 1

    CreateToggleButton("Auto Buy Rod", ShopSection, function(value)
        print("Auto Buy Rod:", value)
    end)

    CreateToggleButton("Auto Buy Bobbers", ShopSection, function(value)
        print("Auto Buy Bobbers:", value)
    end)

    CreateToggleButton("Auto Buy Traveling Merchant", ShopSection, function(value)
        print("Auto Buy Merchant:", value)
    end)

    CreateToggleButton("Auto Buy Tix Shop", ShopSection, function(value)
        print("Auto Buy Tix:", value)
    end)

    CreateToggleButton("Auto Sell Fish", ShopSection, function(value)
        print("Auto Sell:", value)
    end)

    CreateToggleButton("Auto Sell Enchant Stone", ShopSection, function(value)
        print("Auto Sell Stone:", value)
    end)

    CreateToggleButton("Auto Weather Control", ShopSection, function(value)
        print("Auto Weather:", value)
    end)

    return Tab
end


-- Create Premium Tab Content
local function CreatePremiumTabContent()
    local Tab = Instance.new("Frame")
    Tab.Name = "PremiumTab"
    Tab.BackgroundTransparency = 1
    Tab.Size = UDim2.new(1, 0, 1, 0)  -- FIXED
    Tab.AutomaticSize = Enum.AutomaticSize.Y  -- ADDED

    local Layout = Instance.new("UIListLayout")
    Layout.FillDirection = Enum.FillDirection.Vertical
    Layout.SortOrder = Enum.SortOrder.LayoutOrder
    Layout.Padding = UDim.new(0, 10)
    Layout.Parent = Tab

    local ConfigSection = CreateSection("⚙️ Rod Configuration", Tab)
    ConfigSection.LayoutOrder = 1

    CreateTextInput("Minimum Rod Config", ConfigSection, "e.g., Steady, Lucky")
    CreateTextInput("Target Rod to Buy", ConfigSection, "e.g., Kings Rod")
    CreateTextInput("Target Bait to Buy", ConfigSection, "e.g., Fish Head")

    local PremiumSection = CreateSection("⭐ Premium Features", Tab)
    PremiumSection.LayoutOrder = 2

    CreateToggleButton("MFS Mode (Multi-Fish Sync)", PremiumSection, function(value)
        print("MFS Mode:", value)
    end)

    return Tab
end


-- Create Settings Tab Content
local function CreateSettingsTabContent()
    local Tab = Instance.new("Frame")
    Tab.Name = "SettingsTab"
    Tab.BackgroundTransparency = 1
    Tab.Size = UDim2.new(1, 0, 1, 0)  -- FIXED
    Tab.AutomaticSize = Enum.AutomaticSize.Y  -- ADDED

    local Layout = Instance.new("UIListLayout")
    Layout.FillDirection = Enum.FillDirection.Vertical
    Layout.SortOrder = Enum.SortOrder.LayoutOrder
    Layout.Padding = UDim.new(0, 10)
    Layout.Parent = Tab

    -- Webhook Section
    local WebhookSection = CreateSection("🔔 Webhook Settings", Tab)
    WebhookSection.LayoutOrder = 1

    CreateTextInput("Discord Webhook URL", WebhookSection, "https://discord.com/api/webhooks/...")

    -- Performance Section
    local PerformanceSection = CreateSection("⚡ Performance", Tab)
    PerformanceSection.LayoutOrder = 2

    CreateToggleButton("Notifications Enabled", PerformanceSection, function(value)
        print("Notifications:", value)
    end)

    CreateToggleButton("FPS Unlock", PerformanceSection, function(value)
        if setfpscap then
            setfpscap(value and 999 or 60)
            print("FPS Cap:", value and "Unlocked" or "60")
        end
    end)

    CreateToggleButton("Low Graphics Mode", PerformanceSection, function(value)
        print("Low Graphics:", value)
    end)

    -- Config Section
    local ConfigSection = CreateSection("💾 Configuration", Tab)
    ConfigSection.LayoutOrder = 3

    CreateButton("💾 Save Config", ConfigSection, function()
        print("Config saved!")
    end)

    CreateButton("📤 Load Config", ConfigSection, function()
        print("Config loaded!")
    end)

    CreateButton("🔄 Check for Updates", ConfigSection, function()
        print("Checking for updates...")
    end)

    CreateButton("🗑️ Reset to Default", ConfigSection, function()
        print("Config reset!")
    end)

    return Tab
end


-- ===================== MAIN GUI CREATION =====================


-- Create Main GUI
local function CreateMainGui()
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "FishItGui"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.Parent = UserGui

    -- Create Main Frame
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.BackgroundColor3 = Theme.Background
    MainFrame.BorderSizePixel = 0

    if UIModule.IsMobile then
        MainFrame.Size = UDim2.new(0.95, 0, 0.85, 0)
        MainFrame.Position = UDim2.new(0.025, 0, 0.075, 0)
    else
        MainFrame.Size = UDim2.new(0, 520, 0, 650)  -- FIXED: Larger size
        MainFrame.Position = UDim2.new(0.5, -260, 0.5, -325)  -- Centered
    end

    MainFrame.Parent = ScreenGui

    -- Corner rounding
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 10)
    UICorner.Parent = MainFrame

    -- Header
    local Header = Instance.new("Frame")
    Header.Name = "Header"
    Header.BackgroundColor3 = Theme.Primary
    Header.BorderSizePixel = 0
    Header.Size = UDim2.new(1, 0, 0, 45)
    Header.Parent = MainFrame

    local HeaderCorner = Instance.new("UICorner")
    HeaderCorner.CornerRadius = UDim.new(0, 10)
    HeaderCorner.Parent = Header

    -- Title
    local Title = Instance.new("TextLabel")
    Title.Name = "Title"
    Title.Text = "🐟 FISH IT v1.0.1"
    Title.BackgroundTransparency = 1
    Title.TextColor3 = Theme.TextColor
    Title.TextSize = UIModule.IsMobile and 16 or 15
    Title.Font = Enum.Font.GothamBold
    Title.Size = UDim2.new(0.7, 0, 1, 0)
    Title.Position = UDim2.new(0.02, 0, 0, 0)
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Parent = Header

    -- Mode buttons (Full, Minimize, Close)
    local ModeContainer = Instance.new("Frame")
    ModeContainer.Name = "ModeContainer"
    ModeContainer.BackgroundTransparency = 1
    ModeContainer.Size = UDim2.new(0.25, 0, 0.7, 0)
    ModeContainer.Position = UDim2.new(0.75, 0, 0.15, 0)
    ModeContainer.Parent = Header

    -- Minimize button
    local MinButton = Instance.new("TextButton")
    MinButton.Name = "MinButton"
    MinButton.Text = "−"
    MinButton.BackgroundColor3 = Color3.fromRGB(149, 165, 166)
    MinButton.TextColor3 = Theme.TextColor
    MinButton.TextSize = 18
    MinButton.Font = Enum.Font.GothamBold
    MinButton.Size = UDim2.new(0.3, -2, 1, 0)
    MinButton.Position = UDim2.new(0, 0, 0, 0)
    MinButton.BorderSizePixel = 0
    MinButton.Parent = ModeContainer

    local MinCorner = Instance.new("UICorner")
    MinCorner.CornerRadius = UDim.new(0, 4)
    MinCorner.Parent = MinButton

    -- Full button
    local FullButton = Instance.new("TextButton")
    FullButton.Name = "FullButton"
    FullButton.Text = "⬜"
    FullButton.BackgroundColor3 = Theme.Success
    FullButton.TextColor3 = Theme.TextColor
    FullButton.TextSize = 12
    FullButton.Font = Enum.Font.Gotham
    FullButton.Size = UDim2.new(0.3, 0, 1, 0)
    FullButton.Position = UDim2.new(0.35, 0, 0, 0)
    FullButton.BorderSizePixel = 0
    FullButton.Parent = ModeContainer

    local FullCorner = Instance.new("UICorner")
    FullCorner.CornerRadius = UDim.new(0, 4)
    FullCorner.Parent = FullButton

    -- Close button
    local CloseButton = Instance.new("TextButton")
    CloseButton.Name = "CloseButton"
    CloseButton.Text = "✕"
    CloseButton.BackgroundColor3 = Theme.Danger
    CloseButton.TextColor3 = Theme.TextColor
    CloseButton.TextSize = 14
    CloseButton.Font = Enum.Font.GothamBold
    CloseButton.Size = UDim2.new(0.3, 0, 1, 0)
    CloseButton.Position = UDim2.new(0.7, 0, 0, 0)
    CloseButton.BorderSizePixel = 0
    CloseButton.Parent = ModeContainer

    local CloseCorner = Instance.new("UICorner")
    CloseCorner.CornerRadius = UDim.new(0, 4)
    CloseCorner.Parent = CloseButton

    -- Tab Navigation
    local TabContainer = Instance.new("Frame")
    TabContainer.Name = "TabContainer"
    TabContainer.BackgroundColor3 = Theme.Secondary
    TabContainer.BorderSizePixel = 0
    TabContainer.Size = UDim2.new(1, 0, 0, 38)
    TabContainer.Position = UDim2.new(0, 0, 0, 45)
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
        TabButton.Font = Enum.Font.GothamBold
        TabButton.Size = UDim2.new(1 / #Tabs, -2, 1, 0)
        TabButton.BorderSizePixel = 0
        TabButton.LayoutOrder = i
        TabButton.Parent = TabContainer

        local TabCorner = Instance.new("UICorner")
        TabCorner.CornerRadius = UDim.new(0, 4)
        TabCorner.Parent = TabButton

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
    ContentFrame.Size = UDim2.new(1, 0, 1, -83)
    ContentFrame.Position = UDim2.new(0, 0, 0, 83)
    ContentFrame.ScrollBarThickness = 6
    ContentFrame.ScrollBarImageColor3 = Theme.Primary
    ContentFrame.CanvasSize = UDim2.new(0, 0, 0, 0)  -- FIXED: Will auto-update
    ContentFrame.Parent = MainFrame

    local ContentCorner = Instance.new("UICorner")
    ContentCorner.CornerRadius = UDim.new(0, 8)
    ContentCorner.Parent = ContentFrame

    local ContentLayout = Instance.new("UIListLayout")
    ContentLayout.FillDirection = Enum.FillDirection.Vertical
    ContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
    ContentLayout.Padding = UDim.new(0, 10)
    ContentLayout.Parent = ContentFrame

    -- Padding
    local Padding = Instance.new("UIPadding")
    Padding.PaddingLeft = UDim.new(0, 12)
    Padding.PaddingRight = UDim.new(0, 12)
    Padding.PaddingTop = UDim.new(0, 12)
    Padding.PaddingBottom = UDim.new(0, 12)
    Padding.Parent = ContentFrame

    -- ADDED: Dynamic CanvasSize update
    ContentLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        ContentFrame.CanvasSize = UDim2.new(0, 0, 0, ContentLayout.AbsoluteContentSize.Y + 24)
    end)

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

    -- Make draggable (Desktop only)
    if not UIModule.IsMobile then
        local dragging = false
        local dragInput, dragStart, startPos

        Header.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = true
                dragStart = input.Position
                startPos = MainFrame.Position

                input.Changed:Connect(function()
                    if input.UserInputState == Enum.UserInputState.End then
                        dragging = false
                    end
                end)
            end
        end)

        Header.InputChanged:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseMovement then
                dragInput = input
            end
        end)

        UserInputService.InputChanged:Connect(function(input)
            if input == dragInput and dragging then
                local delta = input.Position - dragStart
                MainFrame.Position = UDim2.new(
                    startPos.X.Scale,
                    startPos.X.Offset + delta.X,
                    startPos.Y.Scale,
                    startPos.Y.Offset + delta.Y
                )
            end
        end)
    end

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
    MainTab.LayoutOrder = 1

    -- Automation Tab
    local AutomationTab = CreateAutomationTabContent()
    AutomationTab.Parent = ContentFrame
    AutomationTab.Visible = false
    AutomationTab.LayoutOrder = 2

    -- Quest Tab
    local QuestTab = CreateQuestTabContent()
    QuestTab.Parent = ContentFrame
    QuestTab.Visible = false
    QuestTab.LayoutOrder = 3

    -- Shop Tab
    local ShopTab = CreateShopTabContent()
    ShopTab.Parent = ContentFrame
    ShopTab.Visible = false
    ShopTab.LayoutOrder = 4

    -- Premium Tab
    local PremiumTab = CreatePremiumTabContent()
    PremiumTab.Parent = ContentFrame
    PremiumTab.Visible = false
    PremiumTab.LayoutOrder = 5

    -- Settings Tab
    local SettingsTab = CreateSettingsTabContent()
    SettingsTab.Parent = ContentFrame
    SettingsTab.Visible = false
    SettingsTab.LayoutOrder = 6

    return {
        Main = MainTab,
        Automation = AutomationTab,
        Quest = QuestTab,
        Shop = ShopTab,
        Premium = PremiumTab,
        Settings = SettingsTab,
    }
end


-- ===================== PUBLIC FUNCTIONS =====================


-- Initialize UI
function UIModule.Initialize()
    local GUI = CreateMainGui()
    local Tabs = CreateTabContent(GUI.ContentFrame)
    UIModule.GUI = GUI
    UIModule.Tabs = Tabs

    print("✅ Fish It UI Initialized Successfully!")
    print("📱 Device:", UIModule.IsMobile and "Mobile" or "Desktop")
    print("⌨️ Press 'R' to toggle UI")
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
            if UIModule.IsMobile then
                UIModule.GUI.MainFrame.Size = UDim2.new(0.95, 0, 0, 70)
            else
                UIModule.GUI.MainFrame.Size = UDim2.new(0, 520, 0, 85)
            end
            UIModule.GUI.ContentFrame.Visible = false
            UIModule.GUI.TabContainer.Visible = false
        elseif Mode == "full" then
            if UIModule.IsMobile then
                UIModule.GUI.MainFrame.Size = UDim2.new(0.95, 0, 0.85, 0)
            else
                UIModule.GUI.MainFrame.Size = UDim2.new(0, 520, 0, 650)
            end
            UIModule.GUI.ContentFrame.Visible = true
            UIModule.GUI.TabContainer.Visible = true
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


-- Setup hotkey
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.R then
        UIModule.ToggleUI()
    end
end)


return UIModule
