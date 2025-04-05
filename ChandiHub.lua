-- ChandiHub: Fighting Styles Shop + Instant Kill Aura
local player = game.Players.LocalPlayer

-- Create ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "ChandiHub"
screenGui.Parent = player:WaitForChild("PlayerGui")

-- Create Frame
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 300, 0, 150)
frame.Position = UDim2.new(0.5, -150, 0.5, -75)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
frame.Parent = screenGui

-- Create Title Label
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 40)
title.Text = "ChandiHub"
title.Font = Enum.Font.SourceSansBold
title.TextColor3 = Color3.new(1, 1, 1)
title.BackgroundTransparency = 1
title.TextSize = 24
title.Parent = frame

-- Create "Buy Fighting Styles" Button
local buyStylesButton = Instance.new("TextButton")
buyStylesButton.Size = UDim2.new(0.8, 0, 0, 40)
buyStylesButton.Position = UDim2.new(0.1, 0, 0.3, 0)
buyStylesButton.Text = "Buy Fighting Styles"
buyStylesButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
buyStylesButton.TextColor3 = Color3.new(1, 1, 1)
buyStylesButton.Parent = frame

-- Create "Enable Kill Aura" Button
local killAuraButton = Instance.new("TextButton")
killAuraButton.Size = UDim2.new(0.8, 0, 0, 40)
killAuraButton.Position = UDim2.new(0.1, 0, 0.7, 0)
killAuraButton.Text = "Enable Kill Aura"
killAuraButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
killAuraButton.TextColor3 = Color3.new(1, 1, 1)
killAuraButton.Parent = frame

-- Function to handle "Buy Fighting Styles" button click
buyStylesButton.MouseButton1Click:Connect(function()
    local styles = {"Superhuman", "Dragon Talon", "Electric Claw", "Sharkman Karate", "Death Step"}
    for _, style in ipairs(styles) do
        local remote = game:GetService("ReplicatedStorage"):FindFirstChild("Remotes"):FindFirstChild("BuyFightingStyle")
        if remote then
            remote:InvokeServer(style)
        else
            warn("Buy Remote not found for " .. style)
        end
    end
end)

-- Function to handle "Enable Kill Aura" button click
killAuraButton.MouseButton1Click:Connect(function()
    spawn(function()
        while wait(0.3) do
            for _, enemy in pairs(workspace.Enemies:GetChildren()) do
                if enemy:FindFirstChild("Humanoid") and enemy:FindFirstChild("HumanoidRootPart") then
                    local dist = (player.Character.HumanoidRootPart.Position - enemy.HumanoidRootPart.Position).Magnitude
                    if dist < 100 then
                        enemy.Humanoid.Health = 0
                        enemy:MoveTo(Vector3.new(9e9, 9e9, 9e9))
                    end
                end
            end
        end
    end)
end)
