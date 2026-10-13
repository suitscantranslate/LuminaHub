-- ==========================================
-- LUMINA HUB - KEY SYSTEM (main.lua)
-- ==========================================

local CoreGui = game:GetService("CoreGui")

local function LoadKeySystem()
    local ScreenGui = Instance.new("ScreenGui", CoreGui)
    ScreenGui.Name = "LuminaKeySystem"
    ScreenGui.ResetOnSpawn = false

    local Frame = Instance.new("Frame", ScreenGui)
    Frame.Size = UDim2.new(0, 300, 0, 220)
    Frame.Position = UDim2.new(0.5, -150, 0.5, -110)
    Frame.BackgroundColor3 = Color3.fromRGB(15, 15, 15) -- Matches your UI
    Frame.BorderSizePixel = 0
    local UICorner = Instance.new("UICorner", Frame)
    UICorner.CornerRadius = UDim.new(0, 10)

    local Title = Instance.new("TextLabel", Frame)
    Title.Size = UDim2.new(1, 0, 0, 50)
    Title.Text = "Lumina Key System"
    Title.TextColor3 = Color3.fromRGB(220, 220, 220)
    Title.BackgroundTransparency = 1
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 20

    local TextBox = Instance.new("TextBox", Frame)
    TextBox.Size = UDim2.new(0, 250, 0, 40)
    TextBox.Position = UDim2.new(0.5, -125, 0.4, 0)
    TextBox.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    TextBox.TextColor3 = Color3.fromRGB(200, 200, 200)
    TextBox.PlaceholderText = "Enter Key Here..."
    TextBox.Font = Enum.Font.Gotham
    TextBox.TextSize = 14
    local BoxCorner = Instance.new("UICorner", TextBox)
    BoxCorner.CornerRadius = UDim.new(0, 5)

    local Submit = Instance.new("TextButton", Frame)
    Submit.Size = UDim2.new(0, 250, 0, 40)
    Submit.Position = UDim2.new(0.5, -125, 0.7, 0)
    Submit.BackgroundColor3 = Color3.fromRGB(164, 119, 255) -- Your purple theme
    Submit.TextColor3 = Color3.fromRGB(255, 255, 255)
    Submit.Text = "Verify Key"
    Submit.Font = Enum.Font.GothamBold
    Submit.TextSize = 14
    local BtnCorner = Instance.new("UICorner", Submit)
    BtnCorner.CornerRadius = UDim.new(0, 5)

    Submit.MouseButton1Click:Connect(function()
        -- Change "LUMINA-VIP-2024" to whatever key you want!
        if TextBox.Text == "LUMINA-VIP-2024" then 
            ScreenGui:Destroy()
            
            -- THIS IS THE IMPORTANT PART: It loads your hub.lua
            -- Replace the URL below with the RAW link of your hub.lua
            loadstring(game:HttpGet("https://raw.githubusercontent.com/suitscantranslate/LuminaHub/main/hub.lua"))() 
            
        else
            Submit.Text = "Invalid Key!"
            task.wait(2)
            Submit.Text = "Verify Key"
        end
    end)
end

if game:GetService("RunService"):IsStudio() == false then
    LoadKeySystem()
end