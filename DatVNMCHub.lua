-- [[ DATVNMC HUB - BLOX FRUITS ULTRA UPDATE 2026 ]] --

-- 1. Hiển thị chữ Đăng Kí Cho DatVNMC khi vừa bật Script
local StarterGui = game:GetService("StarterGui")
StarterGui:SetCore("SendNotification", {
    Title = "👑 DatVNMC Hub 👑",
    Text = "Cảm ơn bạn đã sử dụng! Hãy Đăng Kí Cho DatVNMC để ủng hộ kênh nhé!",
    Icon = "rbxassetid://108529748091064", -- Bạn có thể thay ID ảnh nếu muốn
    Duration = 10
})

-- Tải Thư Viện UI Kavo và Đổi Tên Thành DatVNMC
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("DatVNMC Hub — Blox Fruits Advanced", "Midnight")

-- Cấu hình trạng thái (Toggles)
_G.AutoFarmLevel = false
_G.AutoMasteryFruit = false
_G.FruitHasM1 = true
_G.AutoKatakuri = false
_G.AutoBone = false
_G.AutoAttack = false
_G.BringMob = false
_G.AntiAFK = true
_G.MobHealthPercentToSwitch = 30

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local TweenService = game:GetService("TweenService")
local VirtualUser = game:GetService("VirtualUser")

-- ====================================================================
-- [HÀM BỔ TRỢ - UTILS]
-- ====================================================================

task.spawn(function()
    LocalPlayer.Idled:Connect(function()
        if _G.AntiAFK then
            VirtualUser:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
            task.wait(1)
            VirtualUser:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        end
    end)
end)

function TweenTo(cframe, speed)
    local character = LocalPlayer.Character
    if character and character:FindFirstChild("HumanoidRootPart") then
        local distance = (character.HumanoidRootPart.Position - cframe.Position).magnitude
        local duration = distance / speed
        local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Linear)
        local tween = TweenService:Create(character.HumanoidRootPart, tweenInfo, {CFrame = cframe})
        tween:Play()
        return tween
    end
end

function getWeapon(toolType)
    for _, tool in pairs(LocalPlayer.Backpack:GetChildren()) do
        if tool:IsA("Tool") and tool.ToolTip == toolType then return tool.Name end
    end
    for _, tool in pairs(LocalPlayer.Character:GetChildren()) do
        if tool:IsA("Tool") and tool.ToolTip == toolType then return tool.Name end
    end
    return nil
end

function equipWeapon(toolType)
    local weaponName = getWeapon(toolType)
    if weaponName then
        local tool = LocalPlayer.Backpack:FindFirstChild(weaponName)
        if tool then LocalPlayer.Character.Humanoid:EquipTool(tool) end
    end
end

function useFruitSkills()
    local VirtualInputManager = game:GetService("VirtualInputManager")
    local skills = {"Z", "X", "C", "V", "F"}
    for _, skill in pairs(skills) do
        VirtualInputManager:SendKeyEvent(true, Enum.KeyCode[skill], false, game)
        task.wait(0.05)
        VirtualInputManager:SendKeyEvent(false, Enum.KeyCode[skill], false, game)
    end
end

function getQuestData()
    local level = LocalPlayer.Data.Level.Value
    if level >= 1 and level < 10 then
        return "Bandit Quest [Lv. 5]", "Bandit", 1, CFrame.new(1059, 16, -1525)
    elseif level >= 10 and level < 15 then
        return "Monkey Quest [Lv. 10]", "Monkey", 1, CFrame.new(-1598, 37, 154)
    elseif level >= 15 and level < 30 then
        return "Gorilla Quest [Lv. 15]", "Gorilla", 2, CFrame.new(-1240, 6, -500)
    else
        return "Bandit Quest [Lv. 5]", "Bandit", 1, CFrame.new(1059, 16, -1525)
    end
end

-- ====================================================================
-- [GIAO DIỆN MENU DATVNMC]
-- ====================================================================

-- TAB 1: MAIN FARM
local MainTab = Window:NewTab("Main Farm")
local MainSection = MainTab:NewSection("DatVNMC — Farm Level & Mastery")

MainSection:NewToggle("Auto Farm Level", "Farm Level bằng vũ khí thông thường", function(state)
    _G.AutoFarmLevel = state
    _G.AutoAttack = state
    _G.BringMob = state
    if state then _G.AutoMasteryFruit = false end
end)

MainSection:NewToggle("Auto Farm Mastery Blox Fruit", "Farm kinh nghiệm cho Trái Ác Quỷ", function(state)
    _G.AutoMasteryFruit = state
    _G.AutoAttack = state
    _G.BringMob = state
    if state then _G.AutoFarmLevel = false end
end)

MainSection:NewToggle("Trái Có Đánh Thường (M1 Mượt)", "Bật nếu dùng Buddha, Kitsune, Leopard... để chém M1 siêu tốc", function(state)
    _G.FruitHasM1 = state
end)

-- TAB 2: BOSS & EVENT
local EventTab = Window:NewTab("Boss & Event")
local KatakuriSection = EventTab:NewSection("Farm Katakuri (Sea 3)")
KatakuriSection:NewToggle("Auto Farm Katakuri", "Diệt Cake Prince / Dough King", function(state) _G.AutoKatakuri = state _G.AutoAttack = state end)

local BoneSection = EventTab:NewSection("Farm Xương")
BoneSection:NewToggle("Auto Farm Quái Xương", "Diệt Reborn Skeleton", function(state) _G.AutoBone = state _G.AutoAttack = state _G.BringMob = state end)

-- TAB 3: SHOP
local ShopTab = Window:NewTab("Cửa Hàng (Shop)")
local AbilitySection = ShopTab:NewSection("Mua Kỹ Năng Cơ Bản")
AbilitySection:NewButton("Mua Skyjump (Geppo) - $10,000", "Mua kỹ năng nhảy trên không", function() game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyHaki", "SkyJump") end)
AbilitySection:NewButton("Mua Buso Haki (Enhancement) - $25,000", "Mua Haki vũ trang tăng sát thương", function() game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyHaki", "Buso") end)
AbilitySection:NewButton("Mua Soru (Flash Step) - $100,000", "Mua kỹ năng dịch chuyển nhanh", function() game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyHaki", "Step") end)

local GachaSection = ShopTab:NewSection("Gacha & Tiện Ích")
GachaSection:NewButton("Gacha Trái Áquỷ (Random Fruit)", "Tự động mua trái ngẫu nhiên", function() game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Cousin", "Buy") end)

-- ====================================================================
-- [VÒNG LẶP LOGIC CORE]
-- ====================================================================

task.spawn(function()
    while true do
        task.wait(0.1)
        if (_G.AutoFarmLevel or _G.AutoMasteryFruit) and not _G.AutoKatakuri and not _G.AutoBone then
            pcall(function()
                local questName, mobName, questId, npcPos = getQuestData()
                local hasQuest = LocalPlayer.PlayerGui.Main.Quest.Visible
                
                if not hasQuest then
                    local distance = (LocalPlayer.Character.HumanoidRootPart.Position - npcPos.Position).magnitude
                    if distance > 15 then TweenTo(npcPos, 300) else
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest", questName, questId)
                    end
                else
                    for _, enemy in pairs(workspace.Enemies:GetChildren()) do
                        if enemy.Name == mobName and enemy:FindFirstChild("Humanoid") and enemy.Humanoid.Health > 0 then
                            
                            if _G.BringMob and enemy:FindFirstChild("HumanoidRootPart") then
                                enemy.HumanoidRootPart.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, -5)
                                enemy.HumanoidRootPart.CanCollide = false
                            end
                            
                            repeat
                                task.wait()
                                if enemy:FindFirstChild("HumanoidRootPart") and enemy:FindFirstChild("Humanoid") then
                                    LocalPlayer.Character.HumanoidRootPart.CFrame = enemy.HumanoidRootPart.CFrame * CFrame.new(0, 4, 0)
                                    
                                    if _G.AutoMasteryFruit then
                                        if _G.FruitHasM1 then
                                            equipWeapon("Blox Fruit")
                                            useFruitSkills()
                                        else
                                            local maxHealth = enemy.Humanoid.MaxHealth
                                            local currentHealth = enemy.Humanoid.Health
                                            if (currentHealth / maxHealth) * 100 > _G.MobHealthPercentToSwitch then
                                                equipWeapon("Melee")
                                            else
                                                equipWeapon("Blox Fruit")
                                                useFruitSkills()
                                            end
                                        end
                                    else
                                        local currentWeapon = getWeapon("Melee") or getWeapon("Sword")
                                        if currentWeapon then equipWeapon(LocalPlayer.Backpack:FindFirstChild(currentWeapon) and LocalPlayer.Backpack:FindFirstChild(currentWeapon).ToolTip or "Melee") end
                                    end
                                end
                            until not (_G.AutoFarmLevel or _G.AutoMasteryFruit) or not enemy:Parent() or enemy.Humanoid.Health <= 0
                        end
                    end
                end
            end)
        end
    end
end)

-- VÒNG LẶP FAST ATTACK
task.spawn(function()
    while true do
        task.wait()
        if _G.AutoAttack and (_G.AutoFarmLevel or _G.AutoMasteryFruit or _G.AutoKatakuri or _G.AutoBone) then
            pcall(function()
                VirtualUser:CaptureController()
                VirtualUser:ClickButton1(Vector2.new(851, 520))
            end)
        end
    end
end)
