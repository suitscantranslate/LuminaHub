-- ==========================================
-- LUMINA HUB - MAIN SCRIPT
-- ==========================================

local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")

-- ==========================================
-- PART 1: THE KEY SYSTEM
-- ==========================================
local function LoadKeySystem()
    local ScreenGui = Instance.new("ScreenGui", CoreGui)
    ScreenGui.Name = "LuminaKeySystem"
    ScreenGui.ResetOnSpawn = false

    local Frame = Instance.new("Frame", ScreenGui)
    Frame.Size = UDim2.new(0, 300, 0, 220)
    Frame.Position = UDim2.new(0.5, -150, 0.5, -110)
    Frame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
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
    Submit.BackgroundColor3 = Color3.fromRGB(220, 220, 220)
    Submit.TextColor3 = Color3.fromRGB(15, 15, 15)
    Submit.Text = "Verify Key"
    Submit.Font = Enum.Font.GothamBold
    Submit.TextSize = 14
    local BtnCorner = Instance.new("UICorner", Submit)
    BtnCorner.CornerRadius = UDim.new(0, 5)

    Submit.MouseButton1Click:Connect(function()
        -- Change "LUMINA-VIP-2024" to whatever key you want!
        if TextBox.Text == "LUMINA-VIP-2024" then 
            ScreenGui:Destroy()
            _G.LuminaPassed = true -- Saves it in memory
            LoadMainHub() -- Loads the hub directly
        else
            Submit.Text = "Invalid Key!"
            wait(2)
            Submit.Text = "Verify Key"
        end
    end)
end

-- ==========================================
-- PART 2: THE MAIN HUB UI
-- ==========================================
local function LoadMainHub()
    local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

    local Window = Rayfield:CreateWindow({
        Name = "Lumina Hub",
        LoadingTitle = "Lumina",
        LoadingSubtitle = "Premium Script Hub",
        ConfigurationSaving = {
            Enabled = true,
            FolderName = "LuminaHub",
            FileName = "LuminaConfig"
        },
        KeySystem = false -- Key system is handled above
    })

    -- Create Tabs for different games
    local UniversalTab = Window:CreateTab("Universal", 4483362458) 
    local BloxFruitsTab = Window:CreateTab("Blox Fruits", 4483362458)
    local PetSimTab = Window:CreateTab("Pet Simulator 99", 4483362458)
    local ArsenalTab = Window:CreateTab("Arsenal", 4483362458)

    -- Universal Scripts
    UniversalTab:CreateSection("Universal Features")
    UniversalTab:CreateButton({
        Name = "Infinite Yield (Admin)",
        Callback = function()
            loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
        end,
    })

    -- Blox Fruits Scripts
    BloxFruitsTab:CreateSection("Blox Fruits Auto Farm")
    BloxFruitsTab:CreateButton({
        Name = "Load Auto Farm",
        Callback = function()
            -- Put your Blox Fruits script loadstring here
            Rayfield:Notify({Title = "Lumina", Content = "Loading Blox Fruits Script...", Duration = 3})
        end,
    })

    -- Arsenal Scripts
    ArsenalTab:CreateSection("Arsenal Aimbot")
    ArsenalTab:CreateButton({
        Name = "Load Aimbot",
        Callback = function()
            -- Put your Arsenal script loadstring here
            Rayfield:Notify({Title = "Lumina", Content = "Loading Arsenal Aimbot...", Duration = 3})
        end,
    })
end

-- ==========================================
-- START THE HUB
-- ==========================================

if game:GetService("RunService"):IsStudio() == false then
    if not _G.LuminaPassed then
        LoadKeySystem()
    else
        LoadMainHub()
    end
end
