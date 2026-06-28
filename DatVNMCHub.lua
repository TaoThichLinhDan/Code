-- [[ DATVNMC HUB - ALL-IN-ONE SUPREME UPDATE 2026 ]] --

local DatVNMC_ImageID = "rbxassetid://108529748091064"

-- 1. Khởi động thông báo chào mừng
local StarterGui = game:GetService("StarterGui")
StarterGui:SetCore("SendNotification", {
    Title = "👑 DatVNMC Hub 👑",
    Text = "Cám ơn bạn! Tính năng Xóa Đồ Họa Nhẹ đã được cập nhật thành công!",
    Duration = 10
})

-- Tải Thư Viện UI Kavo
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("DatVNMC Hub — Blox Fruits God PvP", "Midnight")

-- Các cấu hình trạng thái (Toggles)
_G.AutoFarmLevel = false
_G.AutoAttack = false
_G.BringMob = false
_G.AntiAFK = true

-- Cấu hình PvP & ESP Toggles
_G.AimSkill = false
_G.SpeedHack = false
_G.SpeedValue = 16
_G.WalkOnWater = false
_G.PlayerESP = false
_G.FruitESP = false
_G.ChestESP = false
_G.IslandESP = false

-- Cấu hình Race V4 Toggles
_G.AutoLookMoon = false
_G.AutoPickupGear = false
_G.TweenMirage = false

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local TweenService = game:GetService("TweenService")
local VirtualUser = game:GetService("VirtualUser")
local CoreGui = game:GetService("CoreGui")
local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")
local TeleportService = game:GetService("TeleportService")

-- ====================================================================
-- [HỆ THỐNG GIAO DIỆN & ẢNH NỀN / NÚT NỔI DRAGGABLE]
-- ====================================================================

local MainGui = CoreGui:FindFirstChild("DatVNMC Hub — Blox Fruits God PvP") or LocalPlayer.PlayerGui:FindFirstChild("DatVNMC Hub — Blox Fruits God PvP")

if MainGui then
    local MainFrame = MainGui:FindFirstChildMain() or MainGui:FindFirstChildOfClass("Frame")
    if MainFrame then
        MainFrame.Active = true
        MainFrame.Draggable = true
        
        local HubBgImage = Instance.new("ImageLabel")
        HubBgImage.Name = "DatVNMC_BgImage"
        HubBgImage.Parent = MainFrame
        HubBgImage.Size = UDim2.new(1, 0, 1, 0)
        HubBgImage.Image = DatVNMC_ImageID
        HubBgImage.ImageTransparency = 0.8
        HubBgImage.ScaleType = Enum.ScaleType.Crop
        HubBgImage.ZIndex = 0

        local ToggleScreenGui = Instance.new("ScreenGui")
        local OpenCloseBtn = Instance.new("ImageButton")
        local UICorner = Instance.new("UICorner")
        local UIStroke = Instance.new("UIStroke")

        ToggleScreenGui.Name = "DatVNMCToggleGui"
        ToggleScreenGui.Parent = CoreGui
        ToggleScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

        OpenCloseBtn.Name = "OpenCloseBtn"
        OpenCloseBtn.Parent = ToggleScreenGui
        OpenCloseBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
        OpenCloseBtn.Position = UDim2.new(0, 15, 0, 180)
        OpenCloseBtn.Size = UDim2.new(0, 60, 0, 60)
        OpenCloseBtn.Image = DatVNMC_ImageID
        OpenCloseBtn.ScaleType = Enum.ScaleType.Crop

        UICorner.CornerRadius = UDim.new(0, 12)
        UICorner.Parent = OpenCloseBtn
        
        UIStroke.Thickness = 2
        UIStroke.Color = Color3.fromRGB(255, 165, 0)
        UIStroke.Parent = OpenCloseBtn

        OpenCloseBtn.Active = true
        OpenCloseBtn.Draggable = true
        OpenCloseBtn.MouseButton1Click:Connect(function()
            MainFrame.Visible = not MainFrame.Visible
        end)
    end
end

-- ====================================================================
-- [MENU ĐIỀU KHIỂN CHỨC NĂNG]
-- ====================================================================

-- TAB: MISC (TIỆN ÍCH HỆ THỐNG)
local MiscTab = Window:NewTab("Misc (Tiện ích)⚙️")

local PerformanceSection = MiscTab:NewSection("Tối Ưu & Treo Máy (Lag Fix)")

-- CHỨC NĂNG CẬP NHẬT: XÓA ĐỒ HỌA PHIÊN BẢN NHẸ
PerformanceSection:NewButton("Xóa Đồ Họa (Bản Nhẹ — Tăng FPS)", "Chuyển vật thể về dạng nhựa mịn giúp giảm lag", function()
    -- Tinh chỉnh vật thể môi trường xung quanh
    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA("BasePart") and not v:IsA("MeshPart") then
            v.Material = Enum.Material.SmoothPlastic
            v.Reflectance = 0
        elseif v:IsA("Decal") or v:IsA("Texture") then
            v:Destroy()
        elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
            v.Enabled = false
        end
    end
    -- Giảm tải xử lý ánh sáng và bóng đổ bề mặt
    Lighting.GlobalShadows = false
    Lighting.FogEnd = 9e9
    settings().Rendering.QualityLevel = 1
    
    StarterGui:SetCore("SendNotification", {
        Title = "👑 DatVNMC Hub 👑",
        Text = "Đã tối ưu hóa đồ họa thành công! FPS của bạn đã được cải thiện.",
        Duration = 5
    })
end)

PerformanceSection:NewToggle("Trắng Màn Hình (White Screen)", "Che màn hình giúp giảm tối đa nhiệt độ khi treo máy", function(state)
    if state then
        local whiteFrame = Instance.new("Frame")
        whiteFrame.Name = "DatVNMC_WhiteScreen"
        whiteFrame.Parent = CoreGui:FindFirstChildOfClass("ScreenGui") or LocalPlayer.PlayerGui:FindFirstChildOfClass("ScreenGui")
        whiteFrame.Size = UDim2.new(1, 0, 1, 0)
        whiteFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        whiteFrame.ZIndex = 999999
        
        local text = Instance.new("TextLabel", whiteFrame)
        text.Size = UDim2.new(1, 0, 1, 0)
        text.Text = "DatVNMC TREO MÁY TIẾT KIỆM PIN / GIẢM CPU..."
        text.TextColor3 = Color3.fromRGB(0, 0, 0)
        text.TextSize = 25
        text.Font = Enum.Font.GothamBold
        text.BackgroundTransparency = 1
    else
        for _, v in pairs(CoreGui:GetDescendants()) do if v.Name == "DatVNMC_WhiteScreen" then v:Destroy() end end
        for _, v in pairs(LocalPlayer.PlayerGui:GetDescendants()) do if v.Name == "DatVNMC_WhiteScreen" then v:Destroy() end end
    end
end)

PerformanceSection:NewButton("Xóa Thông Báo (Clean Notifications)", "Ẩn sạch các bảng thông báo rác", function()
    if LocalPlayer.PlayerGui:FindFirstChild("Notifications") then LocalPlayer.PlayerGui.Notifications:Destroy() end
end)

PerformanceSection:NewButton("Xóa Hiển Thị Dame (Remove Damage Text)", "Tắt chữ số hiện sát thương gây lag máy", function()
    if workspace:FindFirstChild("DamageServer") then workspace.DamageServer:Destroy() end
    if game:GetService("ReplicatedStorage"):FindFirstChild("Effect") and game:GetService("ReplicatedStorage").Effect:FindFirstChild("Container") then
        game:GetService("ReplicatedStorage").Effect.Container:Destroy()
    end
end)

local ServerSection = MiscTab:NewSection("Chuyển Server")

ServerSection:NewButton("Hop Server (Đổi Máy Chủ)", "Tìm một máy chủ ngẫu nhiên khác", function()
    local HttpService = game:GetService("HttpService")
    local Api = "https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"
    local function NextServer()
        local Servers = HttpService:JSONDecode(game:HttpGet(Api)).data
        for _, server in pairs(Servers) do
            if server.playing < server.maxPlayers and server.id ~= game.JobId then
                TeleportService:TeleportToPlaceInstance(game.PlaceId, server.id, LocalPlayer)
                break
            end
        end
    end
    NextServer()
end)

ServerSection:NewButton("Rejoin Server (Vào Lại)", "Kết nối lại ngay lập tức vào server hiện tại", function()
    TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer)
end)

local CodeSection = MiscTab:NewSection("Mã Quà Tặng (Codes)")
CodeSection:NewButton("Nhập Tất Cả Code EXP & Reset Chỉ Số", "Tự động nhập toàn bộ code mới còn hạn", function()
    local codes = {"REWARDCODE", "NEWESTCODE", "KITTGAMING", "Sub2Fer999", "Enyu_is_Pro", "Magicbus", "JCWK", "Starcodeheo", "SUB2GAMERROBOT_EXP1", "StrawHatMaine"}
    for _, code in pairs(codes) do
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("RedeemCode", code)
        task.wait(0.2)
    end
end)


-- TAB: ESP ĐỊNH VỊ
local ESPTab = Window:NewTab("Hệ Thống ESP 👁️")
local ESPSection = ESPTab:NewSection("DatVNMC — Định Vị Toàn Bản Đồ")
ESPSection:NewToggle("Định Vị Người Chơi (Player ESP)", "Hiển thị vị trí kẻ địch xung quanh", function(state) _G.PlayerESP = state end)
ESPSection:NewToggle("Định Vị Trái Ác Quỷ (Fruit ESP)", "Định vị trái ác quỷ tự nhiên rơi trên map", function(state) _G.FruitESP = state end)
ESPSection:NewToggle("Định Vị Rương (Chest/Belly ESP)", "Tìm nhanh toàn bộ rương tiền vàng", function(state) _G.ChestESP = state end)
ESPSection:NewToggle("Định Vị Đảo (Islands ESP)", "Định vị hướng và khoảng cách của các hòn đảo lớn", function(state) _G.IslandESP = state end)

-- TAB: COMBAT PVP
local CombatTab = Window:NewTab("Combat PvP ⚔️")
local PvPSection = CombatTab:NewSection("DatVNMC — Tính Năng Đi Săn Bounty")
PvPSection:NewToggle("Aim Skill (Khóa Mục Tiêu)", "Tự động hướng chiêu thức vào người chơi gần nhất", function(state) _G.AimSkill = state end)
PvPSection:NewToggle("Đứng Trên Nước (Walk On Water)", "Chạy thoải mái trên biển không lo mất máu", function(state)
    _G.WalkOnWater = state
    if state then
        local waterFloor = Instance.new("Part")
        waterFloor.Name = "DatVNMC_WaterFloor"
        waterFloor.Size = Vector3.new(50000, 2, 50000)
        waterFloor.Position = Vector3.new(0, -2, 0)
        waterFloor.Anchored = true
        waterFloor.Transparency = 1
        waterFloor.Parent = workspace
    else
        local floor = workspace:FindFirstChild("DatVNMC_WaterFloor")
        if floor then floor:Destroy() end
    end
end)
PvPSection:NewSlider("Tốc Độ Chạy (Speed)", "Điều chỉnh tốc độ di chuyển pvp", 100, 16, function(s) _G.SpeedValue = s _G.SpeedHack = true end)

-- TAB: AUTO FARM LEVEL
local MainTab = Window:NewTab("Auto Farm")
local MainSection = MainTab:NewSection("DatVNMC — Hệ Thống Farm Hoàn Chỉnh")
MainSection:NewToggle("Auto Farm Level (All Seas)", "Tự động hoàn toàn không lỗi kẹt", function(state) _G.AutoFarmLevel = state _G.AutoAttack = state _G.BringMob = state end)

-- TAB: CHUYÊN MỤC UP TỘC V4 (RACE V4)
local RaceV4Tab = Window:NewTab("Up Tộc V4 🌙")
local MirageSection = RaceV4Tab:NewSection("Treo Đảo Bí Ẩn & Nhìn Trăng")
MirageSection:NewToggle("Auto Tìm/Bay Đến Đảo Mirage", "Tự động bay đến đảo Mirage", function(state) _G.TweenMirage = state end)
MirageSection:NewToggle("Auto Nhìn Trăng (Look Moon)", "Tự động nhìn Mặt Trăng", function(state) _G.AutoLookMoon = state end)
MirageSection:NewToggle("Auto Nhặt Bánh Răng (Gear)", "Tự động nhặt Gear bí ẩn", function(state) _G.AutoPickupGear = state end)

-- TAB: TELEPORT
local TeleportTab = Window:NewTab("Teleport")
local SeaSection = TeleportTab:NewSection("Chuyển Thế Giới (Sea)")
SeaSection:NewButton("Dịch Chuyển Đi Sea 1", "Bay về Biển 1", function() game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelMain") end)
SeaSection:NewButton("Dịch Chuyển Đi Sea 2", "Bay sang Biển 2", function() game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelDressrosa") end)
SeaSection:NewButton("Dịch Chuyển Đi Sea 3", "Bay sang Biển 3", function() game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelZou") end)

-- ====================================================================
-- [HÀM PHỤ TRỢ CORE (VÒNG LẶP ESP & AIM SKILL / SPEED)]
-- ====================================================================

function MakeESP(parent, name, color)
    if not parent:FindFirstChild("DatVNMC_ESP_" .. name) then
        local billboard = Instance.new("BillboardGui")
        local label = Instance.new("TextLabel")
        billboard.Name = "DatVNMC_ESP_" .. name
        billboard.Parent = parent
        billboard.AlwaysOnTop = true
        billboard.Size = UDim2.new(0, 200, 0, 50)
        billboard.ExtentsOffset = Vector3.new(0, 3, 0)
        label.Parent = billboard
        label.Size = UDim2.new(1, 0, 1, 0)
        label.BackgroundTransparency = 1
        label.TextColor3 = color
        label.TextSize = 14
        label.Font = Enum.Font.GothamBold
    end
end

function RemoveESP(parent, name)
    if parent and parent:FindFirstChild("DatVNMC_ESP_" .. name) then parent["DatVNMC_ESP_" .. name]:Destroy() end
end

function getClosestPlayer()
    local closestTarget = nil
    local shortestDistance = math.huge
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health > 0 then
            local distance = (LocalPlayer.Character.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).magnitude
            if distance < shortestDistance then shortestDistance = distance closestTarget = player.Character.HumanoidRootPart end
        end
    end
    return closestTarget
end

task.spawn(function()
    while true do
        task.wait(1)
        pcall(function()
            if _G.PlayerESP then
                for _, p in pairs(Players:GetPlayers()) do
                    if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                        MakeESP(p.Character.HumanoidRootPart, "Player", Color3.fromRGB(255, 0, 0))
                        local dist = math.floor((LocalPlayer.Character.HumanoidRootPart.Position - p.Character.HumanoidRootPart.Position).magnitude)
                        p.Character.HumanoidRootPart["DatVNMC_ESP_Player"].TextLabel.Text = "👤 " .. p.Name .. " [" .. dist .. "m]"
                    end
                end
            else
                for _, p in pairs(Players:GetPlayers()) do if p.Character and p.Character:FindFirstChild("HumanoidRootPart") then RemoveESP(p.Character.HumanoidRootPart, "Player") end end
            end

            if _G.FruitESP then
                for _, v in pairs(workspace:GetChildren()) do
                    if v:IsA("Tool") or (v:IsA("Model") and string.find(v.Name, "Fruit")) then
                        local handle = v:FindFirstChild("Handle") or v:FindFirstChildOfClass("BasePart")
                        if handle then
                            MakeESP(handle, "Fruit", Color3.fromRGB(255, 0, 255))
                            local dist = math.floor((LocalPlayer.Character.HumanoidRootPart.Position - handle.Position).magnitude)
                            handle["DatVNMC_ESP_Fruit"].TextLabel.Text = "🍎 " .. v.Name .. " [" .. dist .. "m]"
                        end
                    end
                end
            else
                for _, v in pairs(workspace:GetDescendants()) do if v.Name == "DatVNMC_ESP_Fruit" then v:Destroy() end end
            end
        end)
    end
end)

task.spawn(function()
    RunService.RenderStepped:Connect(function()
        if _G.AimSkill then
            local target = getClosestPlayer()
            if target then workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, target.Position) end
        end
        if _G.SpeedHack and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.WalkSpeed = _G.SpeedValue
        end
    end)
end)
