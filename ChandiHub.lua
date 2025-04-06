-- ChandiHub with Anti-Cheat Bypass (Basic)
-- Made by Chandieswar

-- // Basic Anti-Cheat & Kick Protection
pcall(function()
    local mt = getrawmetatable(game)
    setreadonly(mt, false)
    local old = mt.__namecall

    mt.__namecall = newcclosure(function(self, ...)
        local method = getnamecallmethod()
        if method == "Kick" or method == "kick" then
            return warn("[ChandiHub] Kick prevented!")
        end
        return old(self, ...)
    end)

    hookfunction(game.Players.LocalPlayer.Kick, function()
        return warn("[ChandiHub] Kick blocked!")
    end)
end)

-- // GUI Creation
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local KillAura = Instance.new("TextButton")
local ShopBuy = Instance.new("TextButton")

ScreenGui.Parent = game.CoreGui
ScreenGui.Name = "ChandiHub"
Frame.Parent = ScreenGui
Frame.Position = UDim2.new(0.3, 0, 0.3, 0)
Frame.Size = UDim2.new(0, 200, 0, 120)
Frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Frame.BorderSizePixel = 0
Frame.Active = true
Frame.Draggable = true

KillAura.Parent = Frame
KillAura.Text = "Kill Aura (Raids)"
KillAura.Position = UDim2.new(0, 10, 0, 10)
KillAura.Size = UDim2.new(0, 180, 0, 40)
KillAura.BackgroundColor3 = Color3.fromRGB(90, 90, 90)
KillAura.MouseButton1Click:Connect(function()
    pcall(function()
        while true do
            task.wait(0.2)
            for _, npc in pairs(workspace.Enemies:GetDescendants()) do
                if npc:FindFirstChild("Humanoid") and (npc:FindFirstChild("HumanoidRootPart") or npc.PrimaryPart) then
                    local hrp = npc:FindFirstChild("HumanoidRootPart") or npc.PrimaryPart
                    if (hrp.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude < 100 then
                        npc.Humanoid.Health = 0
                    end
                end
            end
        end
    end)
end)

ShopBuy.Parent = Frame
ShopBuy.Text = "Buy All Fighting Styles"
ShopBuy.Position = UDim2.new(0, 10, 0, 65)
ShopBuy.Size = UDim2.new(0, 180, 0, 40)
ShopBuy.BackgroundColor3 = Color3.fromRGB(90, 90, 90)
ShopBuy.MouseButton1Click:Connect(function()
    local events = {
        "CombatStyle1", "CombatStyle2", "Electric", "WaterKungFu", "DragonBreath", "SuperHuman"
    }
    for _, v in pairs(events) do
        local remote = game:GetService("ReplicatedStorage").Remotes:FindFirstChild(v)
        if remote then
            pcall(function()
                remote:FireServer()
            end)
        end
    end
end)
