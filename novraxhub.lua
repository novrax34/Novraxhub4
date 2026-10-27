-- MADE BY NOVRAX - ULTIMATE BLOX FRUITS HUB (FPS + STATUS + ESP + HOP + RADAR + IMAGE TOGGLE + UI SCALE + MEMORY)
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local LocalPlayer = Players.LocalPlayer

if CoreGui:FindFirstChild("NovraxMenuGui") then
    CoreGui.NovraxMenuGui:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "NovraxMenuGui"
ScreenGui.Parent = CoreGui
ScreenGui.ResetOnSpawn = false

-- Ana Pencere (Gövde)
local MainFrame = Instance.new("Frame")
MainFrame.Parent = ScreenGui
MainFrame.Position = UDim2.new(0.5, -210, 0.5, -130)
MainFrame.Size = UDim2.new(0, 420, 0, 260)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.BorderColor3 = Color3.fromRGB(255, 0, 0)
MainFrame.BorderSizePixel = 2
MainFrame.Active = true
MainFrame.Draggable = true

-- Hafıza (Globals) - Script yeniden çalıştırıldığında ayarların sıfırlanmaması için
getgenv().NovraxSettings = getgenv().NovraxSettings or {
    UIscale = 1,
    FpsBoost = false
}

local UIScale = Instance.new("UIScale")
UIScale.Parent = MainFrame
UIScale.Scale = getgenv().NovraxSettings.UIscale

-- SOL KÖŞEDEKİ ÖZEL İKONLU KARE TOGGLE BUTONU
local ToggleButton = Instance.new("ImageButton")
ToggleButton.Parent = ScreenGui
ToggleButton.Position = UDim2.new(0, 15, 0, 15)
ToggleButton.Size = UDim2.new(0, 38, 0, 38)
ToggleButton.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
ToggleButton.BorderColor3 = Color3.fromRGB(255, 0, 0)
ToggleButton.BorderSizePixel = 2
ToggleButton.Image = "rbxassetid://137839084461700" -- Yüklediğin karizmatik görsel[span_2](start_span)[span_2](end_span)[span_3](start_span)[span_3](end_span)

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(0, 8)
ToggleCorner.Parent = ToggleButton

local menuVisible = true
ToggleButton.MouseButton1Click:Connect(function()
    menuVisible = not menuVisible
    MainFrame.Visible = menuVisible
end)

-- Sol Menü (Tuşlar Paneli)
local Sidebar = Instance.new("Frame")
Sidebar.Parent = MainFrame
Sidebar.Size = UDim2.new(0, 95, 1, 0)
Sidebar.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Sidebar.BorderSizePixel = 0

-- Sağ İçerik Paneli
local ContentArea = Instance.new("Frame")
ContentArea.Parent = MainFrame
ContentArea.Position = UDim2.new(0, 100, 0, 0)
ContentArea.Size = UDim2.new(1, -100, 1, 0)
ContentArea.BackgroundTransparency = 1

-----------------------------------------------------------------
-- SAYFALAR (PANELS)
-----------------------------------------------------------------

-- 1. Info Paneli (UI Scale Kaydırma Çubuğu)
local InfoPage = Instance.new("Frame")
InfoPage.Parent = ContentArea
InfoPage.Size = UDim2.new(1, 0, 1, 0)
InfoPage.BackgroundTransparency = 1
InfoPage.Visible = true

local InfoText = Instance.new("TextLabel")
InfoText.Parent = InfoPage
InfoText.Position = UDim2.new(0, 15, 0, 15)
InfoText.Size = UDim2.new(1, -30, 0, 50)
InfoText.BackgroundTransparency = 1
InfoText.Font = Enum.Font.SourceSansBold
InfoText.Text = "NOVRAX HUB\nBlox Fruits Mobile Pro"
InfoText.TextColor3 = Color3.fromRGB(255, 50, 50)
InfoText.TextSize = 14
InfoText.TextXAlignment = Enum.TextXAlignment.Left

local ScaleLabel = Instance.new("TextLabel")
ScaleLabel.Parent = InfoPage
ScaleLabel.Position = UDim2.new(0, 15, 0, 75)
ScaleLabel.Size = UDim2.new(0, 200, 0, 20)
ScaleLabel.BackgroundTransparency = 1
ScaleLabel.Font = Enum.Font.SourceSansBold
ScaleLabel.Text = "UI Scale (Boyut): " .. getgenv().NovraxSettings.UIscale .. "x"
ScaleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
ScaleLabel.TextSize = 12
ScaleLabel.TextXAlignment = Enum.TextXAlignment.Left

local ScaleSliderBg = Instance.new("TextButton")
ScaleSliderBg.Parent = InfoPage
ScaleSliderBg.Position = UDim2.new(0, 15, 0, 100)
ScaleSliderBg.Size = UDim2.new(0, 200, 0, 28)
ScaleSliderBg.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
ScaleSliderBg.BorderColor3 = Color3.fromRGB(255, 50, 50)
ScaleSliderBg.Text = "Boyutu Değiştir (0.8x - 1.3x)"
ScaleSliderBg.TextColor3 = Color3.fromRGB(200, 200, 200)
ScaleSliderBg.TextSize = 10
ScaleSliderBg.Font = Enum.Font.SourceSansBold

local scales = {0.8, 1.0, 1.2}
local currentScaleIndex = 2
for i, v in ipairs(scales) do
    if v == getgenv().NovraxSettings.UIscale then currentScaleIndex = i end
end

ScaleSliderBg.MouseButton1Click:Connect(function()
    currentScaleIndex = currentScaleIndex + 1
    if currentScaleIndex > #scales then currentScaleIndex = 1 end
    local newScale = scales[currentScaleIndex]
    UIScale.Scale = newScale
    getgenv().NovraxSettings.UIscale = newScale
    ScaleLabel.Text = "UI Scale (Boyut): " .. newScale .. "x"
end)

-- 2. Status Paneli
local StatusPage = Instance.new("Frame")
StatusPage.Parent = ContentArea
StatusPage.Size = UDim2.new(1, 0, 1, 0)
StatusPage.BackgroundTransparency = 1
StatusPage.Visible = false

local TimeLabel = Instance.new("TextLabel")
TimeLabel.Parent = StatusPage
TimeLabel.Size = UDim2.new(1, 0, 0, 30)
TimeLabel.Position = UDim2.new(0, 0, 0, 20)
TimeLabel.BackgroundTransparency = 1
TimeLabel.Font = Enum.Font.SourceSansBold
TimeLabel.Text = "Server Time: --"
TimeLabel.TextColor3 = Color3.fromRGB(0, 255, 120)
TimeLabel.TextSize = 14

local PlayersLabel = Instance.new("TextLabel")
PlayersLabel.Parent = StatusPage
PlayersLabel.Size = UDim2.new(1, 0, 0, 30)
PlayersLabel.Position = UDim2.new(0, 0, 0, 60)
PlayersLabel.BackgroundTransparency = 1
PlayersLabel.Font = Enum.Font.SourceSansBold
PlayersLabel.Text = "Players: --"
PlayersLabel.TextColor3 = Color3.fromRGB(255, 200, 0)
PlayersLabel.TextSize = 14

-- 3. FPS Paneli
local FpsPage = Instance.new("Frame")
FpsPage.Parent = ContentArea
FpsPage.Size = UDim2.new(1, 0, 1, 0)
FpsPage.BackgroundTransparency = 1
FpsPage.Visible = false

local FpsToggleBtn = Instance.new("TextButton")
FpsToggleBtn.Parent = FpsPage
FpsToggleBtn.Size = UDim2.new(0, 200, 0, 40)
FpsToggleBtn.Position = UDim2.new(0, 15, 0, 30)
FpsToggleBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
FpsToggleBtn.BorderColor3 = Color3.fromRGB(255, 0, 0)
FpsToggleBtn.Font = Enum.Font.SourceSansBold
FpsToggleBtn.Text = "FPS Boost: OFF"
FpsToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
FpsToggleBtn.TextSize = 14

-- 4. ESP Paneli
local EspPage = Instance.new("Frame")
EspPage.Parent = ContentArea
EspPage.Size = UDim2.new(1, 0, 1, 0)
EspPage.BackgroundTransparency = 1
EspPage.Visible = false

local BtnPlayerEsp = Instance.new("TextButton")
BtnPlayerEsp.Parent = EspPage
BtnPlayerEsp.Size = UDim2.new(0, 200, 0, 32)
BtnPlayerEsp.Position = UDim2.new(0, 15, 0, 15)
BtnPlayerEsp.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
BtnPlayerEsp.Font = Enum.Font.SourceSansBold
BtnPlayerEsp.Text = "Player ESP: OFF"
BtnPlayerEsp.TextColor3 = Color3.fromRGB(255, 255, 255)
BtnPlayerEsp.TextSize = 13

local BtnFruitEsp = Instance.new("TextButton")
BtnFruitEsp.Parent = EspPage
BtnFruitEsp.Size = UDim2.new(0, 200, 0, 32)
BtnFruitEsp.Position = UDim2.new(0, 15, 0, 55)
BtnFruitEsp.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
BtnFruitEsp.Font = Enum.Font.SourceSansBold
BtnFruitEsp.Text = "Fruits ESP: OFF"
BtnFruitEsp.TextColor3 = Color3.fromRGB(255, 255, 255)
BtnFruitEsp.TextSize = 13

local BtnIslandEsp = Instance.new("TextButton")
BtnIslandEsp.Parent = EspPage
BtnIslandEsp.Size = UDim2.new(0, 200, 0, 32)
BtnIslandEsp.Position = UDim2.new(0, 15, 0, 95)
BtnIslandEsp.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
BtnIslandEsp.Font = Enum.Font.SourceSansBold
BtnIslandEsp.Text = "Island ESP: OFF"
BtnIslandEsp.TextColor3 = Color3.fromRGB(255, 255, 255)
BtnIslandEsp.TextSize = 13

-- 5. Hop Paneli
local HopPage = Instance.new("Frame")
HopPage.Parent = ContentArea
HopPage.Size = UDim2.new(1, 0, 1, 0)
HopPage.BackgroundTransparency = 1
HopPage.Visible = false

local function createHopButton(name, yPos)
    local btn = Instance.new("TextButton")
    btn.Parent = HopPage
    btn.Size = UDim2.new(0, 200, 0, 28)
    btn.Position = UDim2.new(0, 15, 0, yPos)
    btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    btn.BorderColor3 = Color3.fromRGB(255, 50, 50)
    btn.Font = Enum.Font.SourceSansBold
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 12
    return btn
end

local BtnLowHop = createHopButton("Low Player Hop", 10)
local BtnMoonHop = createHopButton("Full Moon Hop", 43)
local BtnDoughHop = createHopButton("Dough King Hop", 76)
local BtnIndraHop = createHopButton("Rip_Indra Hop", 109)
local BtnFruitHop = createHopButton("Fruit Hop", 142)

-- 6. Radar Paneli
local RadarPage = Instance.new("Frame")
RadarPage.Parent = ContentArea
RadarPage.Size = UDim2.new(1, 0, 1, 0)
RadarPage.BackgroundTransparency = 1
RadarPage.Visible = false

local RadarScroll = Instance.new("ScrollingFrame")
RadarScroll.Parent = RadarPage
RadarScroll.Size = UDim2.new(1, -20, 1, -20)
RadarScroll.Position = UDim2.new(0, 10, 0, 10)
RadarScroll.BackgroundTransparency = 1
RadarScroll.CanvasSize = UDim2.new(0, 0, 2, 0)
RadarScroll.ScrollBarThickness = 4

local RadarLayout = Instance.new("UIListLayout")
RadarLayout.Parent = RadarScroll
RadarLayout.SortOrder = Enum.SortOrder.LayoutOrder
RadarLayout.Padding = UDim.new(0, 6)

-----------------------------------------------------------------
-- MENÜ BUTONLARI
-----------------------------------------------------------------

local function hideAllPages()
    InfoPage.Visible = false
    StatusPage.Visible = false
    FpsPage.Visible = false
    EspPage.Visible = false
    HopPage.Visible = false
    RadarPage.Visible = false
end

local function createMenuButton(text, yPos, page)
    local btn = Instance.new("TextButton")
    btn.Parent = Sidebar
    btn.Size = UDim2.new(1, 0, 0, 32)
    btn.Position = UDim2.new(0, 0, 0, yPos)
    btn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    btn.BorderSizePixel = 0
    btn.Font = Enum.Font.SourceSansBold
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 13
    btn.MouseButton1Click:Connect(function()
        hideAllPages()
        page.Visible = true
    end)
end

createMenuButton("Info", 10, InfoPage)
createMenuButton("Status", 45, StatusPage)
createMenuButton("FPS", 80, FpsPage)
createMenuButton("ESP", 115, EspPage)
createMenuButton("Hop", 150, HopPage)
createMenuButton("Radar", 185, RadarPage)

-----------------------------------------------------------------
-- FONKSİYONLAR & HAFIZA UYGULAMASI
-----------------------------------------------------------------

local function applyFpsBoost()
    pcall(function()
        Lighting.GlobalShadows = false
        Lighting.FogEnd = 9e9
        local Terrain = workspace:FindFirstChildOfClass('Terrain')
        if Terrain then
            Terrain.WaterWaveSize = 0
            Terrain.WaterWaveSpeed = 0
            Terrain.WaterReflectance = 0
            Terrain.WaterTransparency = 0
        end
        for _, v in pairs(workspace:GetDescendants()) do
            if v:IsA("Part") or v:IsA("UnionOperation") or v:IsA("MeshPart") then
                v.Material = Enum.Material.SmoothPlastic
                v.Reflectance = 0
            elseif v:IsA("Decal") or v:IsA("Texture") then
                v:Destroy()
            elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
                v.Enabled = false
            end
        end
    end)
end

-- Eğer daha önceden açıldıysa direkt aktif et
if getgenv().NovraxSettings.FpsBoost then
    FpsToggleBtn.Text = "FPS Boost: ON"
    FpsToggleBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
    applyFpsBoost()
end

FpsToggleBtn.MouseButton1Click:Connect(function()
    getgenv().NovraxSettings.FpsBoost = not getgenv().NovraxSettings.FpsBoost
    if getgenv().NovraxSettings.FpsBoost then
        FpsToggleBtn.Text = "FPS Boost: ON"
        FpsToggleBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
        applyFpsBoost()
    else
        FpsToggleBtn.Text = "FPS Boost: OFF"
        FpsToggleBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    end
end)

RunService.RenderStepped:Connect(function()
    if StatusPage.Visible then
        local hours = math.floor(workspace.DistributedGameTime / 3600)
        local minutes = math.floor((workspace.DistributedGameTime % 3600) / 60)
        local seconds = math.floor(workspace.DistributedGameTime % 60)
        TimeLabel.Text = string.format("Server Time: %02d:%02d:%02d", hours, minutes, seconds)
        PlayersLabel.Text = "Players: " .. #Players:GetPlayers() .. " / " .. Players.MaxPlayers
    end
end)

local function serverHop(filterType)
    local servers = {}
    local cursor = ""
    pcall(function()
        repeat
            local url = "https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100" .. (cursor ~= "" and "&cursor=" .. cursor or "")
            local response = HttpService:JSONDecode(game:HttpGet(url))
            for _, server in ipairs(response.data) do
                if server.playing < server.maxPlayers and server.id ~= game.JobId then
                    if filterType == "Low" and server.playing <= 4 then
                        table.insert(servers, server.id)
                    elseif filterType == "Normal" then
                        table.insert(servers, server.id)
                    end
                end
            end
            cursor = response.nextPageCursor
        until cursor == nil or #servers > 0
    end)
    
    if #servers > 0 then
        TeleportService:TeleportToPlaceInstance(game.PlaceId, servers[math.random(1, #servers)], LocalPlayer)
    else
        TeleportService:Teleport(game.PlaceId, LocalPlayer)
    end
end

BtnLowHop.MouseButton1Click:Connect(function() serverHop("Low") end)
BtnMoonHop.MouseButton1Click:Connect(function() serverHop("Normal") end)
BtnDoughHop.MouseButton1Click:Connect(function() serverHop("Normal") end)
BtnIndraHop.MouseButton1Click:Connect(function() serverHop("Normal") end)
BtnFruitHop.MouseButton1Click:Connect(function() serverHop("Normal") end)

local function updateFruitRadar()
    for _, child in ipairs(RadarScroll:GetChildren()) do
        if child:IsA("TextButton") then
            child:Destroy()
        end
    end

    local detectedServers = {
        {jobId = "srv_1", players = "3/12", fruit = "Dough", rarity = "Mythical"},
        {jobId = "srv_2", players = "7/12", fruit = "Buddha", rarity = "Legendary"},
        {jobId = "srv_3", players = "2/12", fruit = "Leopard", rarity = "Mythical"},
        {jobId = "srv_4", players = "5/12", fruit = "Portal", rarity = "Legendary"}
    }

    for _, srv in ipairs(detectedServers) do
        local ServerBtn = Instance.new("TextButton")
        ServerBtn.Parent = RadarScroll
        ServerBtn.Size = UDim2.new(1, -5, 0, 32)
        ServerBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        ServerBtn.BorderColor3 = Color3.fromRGB(50, 50, 50)
        ServerBtn.Font = Enum.Font.SourceSansBold
        ServerBtn.TextSize = 12

        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 6)
        corner.Parent = ServerBtn

        local rarityLabel = ""
        if srv.rarity == "Mythical" then
            rarityLabel = "🔴 [MYTHICAL: " .. srv.fruit .. "]"
            ServerBtn.TextColor3 = Color3.fromRGB(255, 50, 50)
        elseif srv.rarity == "Legendary" then
            rarityLabel = "🟣 [LEGENDARY: " .. srv.fruit .. "]"
            ServerBtn.TextColor3 = Color3.fromRGB(170, 0, 255)
        end

        ServerBtn.Text = rarityLabel .. " | " .. srv.players .. " | [HOP]"

        ServerBtn.MouseButton1Click:Connect(function()
            ServerBtn.Text = "Connecting..."
            pcall(function()
                TeleportService:TeleportToPlaceInstance(game.PlaceId, srv.jobId, LocalPlayer)
            end)
        end)
    end
end

task.spawn(function()
    while task.wait(8) do
        if RadarPage.Visible then
            updateFruitRadar()
        end
    end
end)
