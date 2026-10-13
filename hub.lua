-- LUMINA V6.0 | Full Updated (Custom Script Support)
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local ContentProvider = game:GetService("ContentProvider")
local Lighting = game:GetService("Lighting")
local VirtualUser = game:GetService("VirtualUser")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local previous = playerGui:FindFirstChild("LuminaV3")
if previous then previous:Destroy() end

local LUMINA_ICON = "rbxassetid://88371014112910"
local SUGGESTION_LINK = "https://docs.google.com/forms/d/e/1FAIpQLSepvUPQYTxdqGM-QzwF852YiY-uV61PVSJX-_ZcGXY00BX7LQ/viewform"

local THEME = {
    bg = Color3.fromRGB(13, 12, 18),
    panel = Color3.fromRGB(21, 20, 28),
    card = Color3.fromRGB(29, 27, 38),
    cardHover = Color3.fromRGB(39, 35, 51),
    purple = Color3.fromRGB(164, 119, 255),
    purpleDark = Color3.fromRGB(78, 54, 120),
    white = Color3.fromRGB(245, 243, 250),
    muted = Color3.fromRGB(154, 149, 168),
    line = Color3.fromRGB(57, 52, 69),
    green = Color3.fromRGB(112, 220, 171),
    red = Color3.fromRGB(200, 60, 60),
}

local function make(className, props, parent)
    local obj = Instance.new(className)
    for k, v in pairs(props or {}) do obj[k] = v end
    obj.Parent = parent
    return obj
end
local function corner(obj, px)
    make("UICorner", {CornerRadius = UDim.new(0, px or 10)}, obj)
end
local function stroke(obj, color, transparency)
    make("UIStroke", {Color = color or THEME.line, Transparency = transparency or 0.3, Thickness = 1}, obj)
end
local function tween(obj, seconds, props)
    local t = TweenService:Create(obj, TweenInfo.new(seconds, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), props)
    t:Play()
    return t
end
local function label(parent, value, size, color, font)
    return make("TextLabel", {
        BackgroundTransparency = 1, Text = value, TextSize = size or 12,
        TextColor3 = color or THEME.white, Font = font or Enum.Font.Gotham,
        TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Center,
        Size = UDim2.new(1, 0, 0, (size or 12) + 8),
    }, parent)
end

-- ==========================================
-- SCRIPT URL MAPPING (KEYLESS)
-- ==========================================
local scriptURLs = {
    ["Blox Fruits"] = "https://raw.githubusercontent.com/Kenniel123/BloxFruits/refs/heads/main/BloxFruits",
    ["Pet Simulator 99"] = "https://raw.githubusercontent.com/SlamminPig/6FootScripts/main/Scripts/PetSimulator99.lua",
    ["Arsenal"] = "https://raw.githubusercontent.com/Luigi4k85/Arsenal-v5.3/refs/heads/main/Arsenal%20v5.3",
    ["Da Hood"] = "https://raw.githubusercontent.com/bbbbbbbbbbbbbb121/Roblox/refs/heads/main/Sylex",
    ["Jailbreak"] = "https://raw.githubusercontent.com/veloxides/Jailbreak/refs/heads/main/VeloxideLoader",
    ["Murder Mystery 2"] = "https://pastebin.com/raw/YpNGWssv",
    ["Blade Ball"] = "https://raw.githubusercontent.com/Doortthemort/676/refs/heads/main/Main.lua",
    ["Grow a Garden"] = "https://raw.githubusercontent.com/depthso/Grow-a-Garden/refs/heads/main/autofarm.lua",
    ["Blue Lock: Rivals"] = "https://raw.githubusercontent.com/TheDarkoneMarcillisePex/Other-Scripts/refs/heads/main/Blue%20Lock%20Rivals%20GUI",
    ["Adopt Me!"] = "https://raw.githubusercontent.com/bytelaunch-germany/adoptme-candyegg-farmer2026/main/loader.lua",
    ["Brookhaven RP"] = "https://raw.githubusercontent.com/Bliqe/Upload/refs/heads/main/Games/BR/87347759111.lua",
    ["Tower of Hell"] = "https://raw.githubusercontent.com/formidy/TowerOfHellAutofarm/refs/heads/main/main.lua",
    ["Natural Disaster Survival"] = "https://raw.githubusercontent.com/KaterHub-Inc/NaturalDisasterSurvival/refs/heads/main/main.lua",
    ["DOORS"] = "https://raw.githubusercontent.com/bocaj111004/Abysall/refs/heads/main/Loader.luau",
    ["The Strongest Battlegrounds"] = "https://raw.githubusercontent.com/Bliqe/Upload/refs/heads/main/Games/TSB/23217845477.lua",
}

local catalog = {
    {name="Brookhaven RP", genre="Roleplay", id=4924922222, description="Live your own story in a city."},
    {name="Adopt Me!", genre="Roleplay", id=920587237, description="Raise pets, decorate homes, and explore."},
    {name="Blox Fruits", genre="Adventure", id=2753915549, description="Explore islands, battle enemies, and discover powers."},
    {name="Murder Mystery 2", genre="Horror", id=142823291, description="Solve the mystery and survive each round."},
    {name="Jailbreak", genre="Action", id=606849621, description="Plan escapes, chase criminals, and explore the city."},
    {name="Welcome to Bloxburg", genre="Roleplay", id=185655149, description="Build homes and create your own life."},
    {name="Tower of Hell", genre="Obby", id=1962086868, description="Climb challenging obstacle towers."},
    {name="Natural Disaster Survival", genre="Survival", id=189707, description="Survive dangerous natural disasters."},
    {name="Build A Boat For Treasure", genre="Building", id=537413528, description="Build a boat and sail for treasure."},
    {name="Piggy", genre="Horror", id=4623386862, description="Solve puzzles and escape the danger."},
    {name="Pet Simulator 99", genre="Simulator", id=8737899170, description="Collect pets and explore different worlds."},
    {name="DOORS", genre="Horror", id=6516141723, description="Explore mysterious rooms and survive."},
    {name="Slap Battles", genre="Fighting", id=6403373529, description="Battle players with unique gloves."},
    {name="BedWars", genre="Strategy", id=6872265039, description="Protect your bed and defeat rival teams."},
    {name="Tower Defense Simulator", genre="Strategy", id=3260590327, description="Build defenses against waves of enemies."},
    {name="The Strongest Battlegrounds", genre="Fighting", id=10449761463, description="Fight players in an action-packed arena."},
    {name="Blade Ball", genre="Action", id=13772394625, description="Deflect a deadly ball and outlast opponents."},
    {name="Dress to Impress", genre="Fashion", id=15118820047, description="Create outfits and compete on the runway."},
    {name="Grow a Garden", genre="Simulator", id=7436755782, description="Plant seeds and grow your garden."},
    {name="Steal a Brainrot", genre="Simulator", id=109983668079237, description="Collect brainrots and compete with other players."},
    {name="99 Nights in the Forest", genre="Survival", id=79546208627805, description="Survive the forest and make it through the nights."},
    {name="Fisch", genre="Adventure", id=10118587496, description="Fish, explore, and discover rare catches."},
    {name="Anime Vanguards", genre="Anime", id=16146832113, description="Collect anime units and defend against enemies."},
    {name="Blue Lock: Rivals", genre="Sports", id=18668065416, description="Compete in anime-inspired soccer matches."},
    {name="Volleyball Legends", genre="Sports", id=73956553001240, description="Play volleyball with powerful abilities."},
    {name="Jujutsu Shenanigans", genre="Anime", id=9391468976, description="Battle players with anime-inspired combat."},
    {name="Grand Piece Online", genre="Adventure", id=1730877806, description="Explore the seas and discover powerful abilities."},
    {name="Survive the Killer", genre="Horror", id=3580192325, description="Escape the killer or hunt the survivors."},
    {name="Berry Avenue RP", genre="Roleplay", id=1629781183, description="Customize your character and roleplay."},
    {name="Apocalypse Rising 2", genre="Survival", id=1512009297, description="Survive a dangerous open-world apocalypse."},
    {name="Creatures of Sonaria", genre="Adventure", id=13635741423, description="Discover creatures and survive in the wild."},
    {name="Ragdoll Engine", genre="Social", id=1467750038, description="Play around with physics and ragdolls."},
    {name="MeepCity", genre="Social", id=370731277, description="Socialize, decorate, and explore."},
    {name="Royale High", genre="Fashion", id=735030788, description="Explore a fantasy school and customize outfits."},
    {name="Work at a Pizza Place", genre="Simulator", id=192800, description="Work together to run a pizza restaurant."},
    {name="Flee the Facility", genre="Horror", id=893973440, description="Hack computers and escape the Beast."},
    {name="Epic Minigames", genre="Party", id=277751860, description="Compete in a collection of minigames."},
    {name="Theme Park Tycoon 2", genre="Tycoon", id=69184822, description="Build and manage your own theme park."},
    {name="Bee Swarm Simulator", genre="Simulator", id=1537690962, description="Grow your bee swarm and collect pollen."},
    {name="Vehicle Simulator", genre="Racing", id=258323320, description="Drive vehicles and explore the open world."},
    {name="Da Hood", genre="Action", id=2788229376, description="Explore an urban roleplay environment."},
    {name="Counter Blox", genre="FPS", id=301549746, description="Play tactical team-based shooter rounds."},
    {name="Phantom Forces", genre="FPS", id=292439477, description="Compete in multiplayer shooter battles."},
    {name="Arsenal", genre="FPS", id=286090429, description="Fight through fast-paced weapon challenges."},
    {name="Strucid", genre="Action", id=679715388, description="Battle opponents in a competitive arena."},
    {name="Big Paintball", genre="FPS", id=4621440333, description="Compete in colorful paintball battles."},
    {name="Booga Booga", genre="Survival", id=232022539, description="Gather resources and survive on an island."},
    {name="Islands", genre="Building", id=4872321990, description="Build, farm, craft, and expand your island."},
    {name="Pet Simulator X", genre="Simulator", id=6284583030, description="Collect pets and unlock new areas."},
    {name="Anime Adventures", genre="Anime", id=11226167217, description="Collect anime characters and defend your base."},
}

local favorites = {}
local customScripts = {} -- session memory for custom scripts
local currentPage = "Home"
local activeCategory = "All"
local searchQuery = ""
local selectedGame
local accentOptions = {
    Color3.fromRGB(164,119,255), Color3.fromRGB(83,155,255),
    Color3.fromRGB(255,103,177), Color3.fromRGB(94,220,179),
}
local accentIndex = 1

-- Universal state
local uni = {
    infJump = false,
    infJumpConn = nil,
    speed = false,
    speedValue = 100,
    fullbright = false,
    antiAfk = false,
    antiAfkConn = nil,
}

local gui = make("ScreenGui", {
    Name="LuminaV3", ResetOnSpawn=false, IgnoreGuiInset=true,
    DisplayOrder=50, ZIndexBehavior=Enum.ZIndexBehavior.Sibling,
}, playerGui)

-- LOADING SCREEN
local intro = make("Frame", {Size=UDim2.fromScale(1,1), BackgroundColor3=THEME.bg, ZIndex=100, Visible=true}, gui)
local introIcon = make("ImageLabel", {
    AnchorPoint=Vector2.new(.5,.5), Position=UDim2.fromScale(.5,.4), Size=UDim2.fromOffset(120,120),
    BackgroundTransparency=1, Image=LUMINA_ICON, ImageColor3=THEME.white
}, intro)
local introSub = label(intro, "LOADING YOUR LIBRARY...", 10, THEME.muted, Enum.Font.GothamMedium)
introSub.AnchorPoint=Vector2.new(.5,.5); introSub.Position=UDim2.fromScale(.5,.58)
introSub.Size=UDim2.fromOffset(300,24); introSub.TextXAlignment=Enum.TextXAlignment.Center
local barBack=make("Frame",{AnchorPoint=Vector2.new(.5,.5),Position=UDim2.fromScale(.5,.65),Size=UDim2.fromOffset(165,3),BackgroundColor3=THEME.card,ZIndex=101},intro); corner(barBack,4)
local bar=make("Frame",{Size=UDim2.new(0,0,1,0),BackgroundColor3=THEME.purple,ZIndex=102},barBack); corner(bar,4)

local pulseTween = TweenService:Create(introIcon, TweenInfo.new(1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {Size = UDim2.fromOffset(135, 135)})
pulseTween:Play()

-- MAIN WINDOW
local main=make("Frame",{Name="Main",AnchorPoint=Vector2.new(.5,.5),Position=UDim2.fromScale(.5,.53),Size=UDim2.fromScale(.88,.82),BackgroundColor3=THEME.bg,Visible=false,ClipsDescendants=true},gui)
corner(main,17); stroke(main,THEME.line,.1)
make("UISizeConstraint",{MinSize=Vector2.new(320,400),MaxSize=Vector2.new(1050,760)},main)
local header=make("Frame",{Size=UDim2.new(1,0,0,58),BackgroundColor3=THEME.panel,BorderSizePixel=0},main)

local moonLogo=make("ImageLabel",{Position=UDim2.fromOffset(14,10), Size=UDim2.fromOffset(38,38), BackgroundTransparency=1, Image=LUMINA_ICON, ImageColor3=THEME.purple}, header)
local brand=label(header,"LUMINA",15,THEME.white,Enum.Font.GothamBold); brand.Position=UDim2.fromOffset(54,6); brand.Size=UDim2.fromOffset(105,23)
local brandSub=label(header,"GAME LIBRARY",9,THEME.muted,Enum.Font.GothamMedium); brandSub.Position=UDim2.fromOffset(55,28); brandSub.Size=UDim2.fromOffset(110,16)

local function headerButton(caption, rightOffset)
    local b=make("TextButton",{Text=caption,TextSize=caption=="×" and 22 or 17,TextColor3=THEME.white,Font=Enum.Font.Gotham,BackgroundColor3=THEME.card,Position=UDim2.new(1,rightOffset,0,12),Size=UDim2.fromOffset(34,34),AutoButtonColor=false},header)
    corner(b,9); return b
end
local minimize=headerButton("—",-78)
local close=headerButton("×",-39)

local sidebar=make("Frame",{Position=UDim2.fromOffset(0,58),Size=UDim2.new(0,136,1,-58),BackgroundColor3=THEME.panel,BorderSizePixel=0},main)
local navList=make("Frame",{Position=UDim2.fromOffset(10,16),Size=UDim2.new(1,-20,0,220),BackgroundTransparency=1},sidebar)
make("UIListLayout",{Padding=UDim.new(0,7),SortOrder=Enum.SortOrder.LayoutOrder},navList)
local body=make("Frame",{Position=UDim2.new(0,136,0,58),Size=UDim2.new(1,-136,1,-58),BackgroundTransparency=1},main)
local heading=label(body,"Discover your next adventure",21,THEME.white,Enum.Font.GothamBold); heading.Position=UDim2.fromOffset(19,12); heading.Size=UDim2.new(1,-38,0,31)
local subheading=label(body,"A world of games, all in one place.",11,THEME.muted); subheading.Position=UDim2.fromOffset(20,42); subheading.Size=UDim2.new(1,-40,0,22)
local searchFrame=make("Frame",{Position=UDim2.fromOffset(19,73),Size=UDim2.new(1,-38,0,37),BackgroundColor3=THEME.panel},body); corner(searchFrame,9); stroke(searchFrame,THEME.line,.35)
local searchBox=make("TextBox",{Position=UDim2.fromOffset(11,0),Size=UDim2.new(1,-22,1,0),BackgroundTransparency=1,PlaceholderText="Search 49 games...",PlaceholderColor3=THEME.muted,Text="",TextColor3=THEME.white,TextSize=12,Font=Enum.Font.Gotham,ClearTextOnFocus=false,TextXAlignment=Enum.TextXAlignment.Left},searchFrame)
local categories=make("ScrollingFrame",{Position=UDim2.fromOffset(19,118),Size=UDim2.new(1,-38,0,32),BackgroundTransparency=1,BorderSizePixel=0,ScrollBarThickness=0,ScrollingDirection=Enum.ScrollingDirection.X,AutomaticCanvasSize=Enum.AutomaticSize.X,CanvasSize=UDim2.new()},body)
make("UIListLayout",{FillDirection=Enum.FillDirection.Horizontal,Padding=UDim.new(0,6),SortOrder=Enum.SortOrder.LayoutOrder},categories)
local cards=make("ScrollingFrame",{Position=UDim2.fromOffset(19,159),Size=UDim2.new(1,-38,1,-176),BackgroundTransparency=1,BorderSizePixel=0,ScrollBarThickness=3,ScrollBarImageColor3=THEME.purple,AutomaticCanvasSize=Enum.AutomaticSize.Y,CanvasSize=UDim2.new()},body)
local grid=make("UIGridLayout",{CellSize=UDim2.fromOffset(160,158),CellPadding=UDim2.fromOffset(10,10),SortOrder=Enum.SortOrder.LayoutOrder},cards)

-- DETAILS PANEL
local details=make("ScrollingFrame",{Name="Details",Position=UDim2.fromScale(1,0),Size=UDim2.fromScale(1,1),BackgroundColor3=THEME.bg,Visible=false,ZIndex=20,CanvasSize=UDim2.new(0,0,0,820),ScrollBarThickness=3,ScrollBarImageColor3=THEME.purple},body)
local back=make("TextButton",{Text="←  BACK TO LIBRARY",TextSize=11,TextColor3=THEME.muted,Font=Enum.Font.GothamMedium,BackgroundTransparency=1,Position=UDim2.fromOffset(19,12),Size=UDim2.fromOffset(190,31),ZIndex=21},details)
local detailImage=make("ImageLabel",{Position=UDim2.fromOffset(19,53),Size=UDim2.new(1,-38,0,160),BackgroundColor3=THEME.card,Image="",ScaleType=Enum.ScaleType.Crop,ZIndex=21},details); corner(detailImage,12)
local detailName=label(details,"Game name",23,THEME.white,Enum.Font.GothamBold); detailName.Position=UDim2.fromOffset(19,222); detailName.Size=UDim2.new(1,-38,0,34); detailName.ZIndex=21
local detailGenre=label(details,"GENRE",10,THEME.purple,Enum.Font.GothamBold); detailGenre.Position=UDim2.fromOffset(20,256); detailGenre.Size=UDim2.new(1,-40,0,22); detailGenre.ZIndex=21
local detailDescription=label(details,"",12,THEME.muted); detailDescription.Position=UDim2.fromOffset(20,284); detailDescription.Size=UDim2.new(1,-40,0,58); detailDescription.TextWrapped=true; detailDescription.TextYAlignment=Enum.TextYAlignment.Top; detailDescription.ZIndex=21
local detailFavorite=make("TextButton",{Text="☆  ADD TO FAVORITES",TextSize=11,TextColor3=THEME.white,Font=Enum.Font.GothamBold,BackgroundColor3=THEME.purpleDark,Position=UDim2.fromOffset(19,335),Size=UDim2.new(1,-38,0,39),ZIndex=21},details); corner(detailFavorite,9)
local playButton=make("TextButton",{Text="COPY PLACE ID",TextSize=11,TextColor3=THEME.white,Font=Enum.Font.GothamBold,BackgroundColor3=THEME.card,Position=UDim2.fromOffset(19,380),Size=UDim2.new(1,-38,0,39),ZIndex=21},details); corner(playButton,9); stroke(playButton,THEME.line,.25)
local detailId=label(details,"Place ID",10,THEME.muted); detailId.Position=UDim2.fromOffset(20,425); detailId.Size=UDim2.new(1,-40,0,22); detailId.ZIndex=21

-- UNIVERSAL TAB
local universalPanel=make("Frame",{Position=UDim2.fromOffset(19,73),Size=UDim2.new(1,-38,1,-73),BackgroundColor3=THEME.bg,Visible=false},body)
local universalScroll=make("ScrollingFrame",{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,BorderSizePixel=0,ScrollBarThickness=3,ScrollBarImageColor3=THEME.purple,CanvasSize=UDim2.new(0,0,0,400)},universalPanel)
make("UIListLayout",{Padding=UDim.new(0,10),SortOrder=Enum.SortOrder.LayoutOrder},universalScroll)

local function makeUniversalBtn(name, callback)
    local btn = make("TextButton",{
        Text = name, TextSize = 12, TextColor3 = THEME.white, Font = Enum.Font.GothamBold,
        BackgroundColor3 = THEME.card, Size = UDim2.new(1,0,0,40), AutoButtonColor = false
    }, universalScroll)
    corner(btn, 8); stroke(btn, THEME.line, 0.4)
    btn.MouseEnter:Connect(function() tween(btn, .12, {BackgroundColor3 = THEME.cardHover}) end)
    btn.MouseLeave:Connect(function() tween(btn, .12, {BackgroundColor3 = THEME.card}) end)
    btn.MouseButton1Click:Connect(function()
        local ok, err = pcall(callback, btn)
        if not ok then
            warn("[Lumina Universal]", err)
            btn.Text = "ERROR"
            btn.BackgroundColor3 = THEME.red
            task.delay(2, function()
                if btn and btn.Parent then
                    btn.Text = name
                    btn.BackgroundColor3 = THEME.card
                end
            end)
        end
    end)
    return btn
end

local function applySpeed()
    local char = player.Character
    if char then
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then
            hum.WalkSpeed = uni.speed and uni.speedValue or 16
        end
    end
end

player.CharacterAdded:Connect(function()
    task.wait(0.3)
    if uni.speed then applySpeed() end
end)

makeUniversalBtn("Infinite Jump (Toggle)", function(btn)
    uni.infJump = not uni.infJump
    if uni.infJump then
        if uni.infJumpConn then uni.infJumpConn:Disconnect() end
        uni.infJumpConn = UserInputService.JumpRequest:Connect(function()
            local char = player.Character
            if char then
                local hum = char:FindFirstChildOfClass("Humanoid")
                if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
            end
        end)
        btn.Text = "Infinite Jump: ON"
        btn.BackgroundColor3 = THEME.green
    else
        if uni.infJumpConn then uni.infJumpConn:Disconnect(); uni.infJumpConn = nil end
        btn.Text = "Infinite Jump (Toggle)"
        btn.BackgroundColor3 = THEME.card
    end
end)

makeUniversalBtn("Speed Hack (Toggle 100)", function(btn)
    uni.speed = not uni.speed
    applySpeed()
    if uni.speed then
        btn.Text = "Speed Hack: ON (100)"
        btn.BackgroundColor3 = THEME.green
    else
        btn.Text = "Speed Hack (Toggle 100)"
        btn.BackgroundColor3 = THEME.card
    end
end)

makeUniversalBtn("Fullbright (Toggle)", function(btn)
    uni.fullbright = not uni.fullbright
    if uni.fullbright then
        Lighting.Brightness = 3
        Lighting.ClockTime = 14
        Lighting.FogEnd = 100000
        Lighting.GlobalShadows = false
        Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
        btn.Text = "Fullbright: ON"
        btn.BackgroundColor3 = THEME.green
    else
        Lighting.Brightness = 1
        Lighting.FogEnd = 1000
        Lighting.GlobalShadows = true
        btn.Text = "Fullbright (Toggle)"
        btn.BackgroundColor3 = THEME.card
    end
end)

makeUniversalBtn("Reset WalkSpeed", function(btn)
    uni.speed = false
    applySpeed()
    btn.Text = "RESET DONE"
    btn.BackgroundColor3 = THEME.green
    task.delay(1.5, function()
        if btn and btn.Parent then
            btn.Text = "Reset WalkSpeed"
            btn.BackgroundColor3 = THEME.card
        end
    end)
end)

makeUniversalBtn("Anti-AFK (Toggle)", function(btn)
    uni.antiAfk = not uni.antiAfk
    if uni.antiAfk then
        if uni.antiAfkConn then uni.antiAfkConn:Disconnect() end
        uni.antiAfkConn = player.Idled:Connect(function()
            VirtualUser:CaptureController()
            VirtualUser:ClickButton2(Vector2.new())
        end)
        btn.Text = "Anti-AFK: ON"
        btn.BackgroundColor3 = THEME.green
    else
        if uni.antiAfkConn then uni.antiAfkConn:Disconnect(); uni.antiAfkConn = nil end
        btn.Text = "Anti-AFK (Toggle)"
        btn.BackgroundColor3 = THEME.card
    end
end)

local settingsPanel=make("Frame",{Position=UDim2.fromOffset(19,73),Size=UDim2.new(1,-38,0,185),BackgroundColor3=THEME.panel,Visible=false},body); corner(settingsPanel,12); stroke(settingsPanel,THEME.line,.35)
local settingsTitle=label(settingsPanel,"Appearance",15,THEME.white,Enum.Font.GothamBold); settingsTitle.Position=UDim2.fromOffset(14,10)
local settingsInfo=label(settingsPanel,"Customize Lumina's accent color.",11,THEME.muted); settingsInfo.Position=UDim2.fromOffset(14,40); settingsInfo.Size=UDim2.new(1,-28,0,25)
local settingsNote=label(settingsPanel,"Favorites & custom scripts are session only.",11,THEME.muted); settingsNote.Position=UDim2.fromOffset(14,67); settingsNote.Size=UDim2.new(1,-28,0,25)
local accentButton=make("TextButton",{Text="CHANGE ACCENT COLOR",TextSize=10,TextColor3=THEME.white,Font=Enum.Font.GothamBold,BackgroundColor3=THEME.purpleDark,Position=UDim2.fromOffset(14,112),Size=UDim2.new(1,-28,0,34)},settingsPanel); corner(accentButton,8)

-- SUGGESTION BAR
local suggestFrame = make("Frame", { Position = UDim2.new(0, 10, 1, -110), Size = UDim2.new(1, -20, 0, 100), BackgroundColor3 = THEME.card, BorderSizePixel = 0 }, sidebar)
corner(suggestFrame, 10); stroke(suggestFrame, THEME.line, 0.4)
local suggestTitle = label(suggestFrame, "SUGGEST A GAME", 10, THEME.white, Enum.Font.GothamBold); suggestTitle.Position = UDim2.fromOffset(10, 8); suggestTitle.Size = UDim2.new(1, -20, 0, 18)
local suggestDesc = label(suggestFrame, "Have an idea for a game?", 9, THEME.muted, Enum.Font.Gotham); suggestDesc.Position = UDim2.fromOffset(10, 28); suggestDesc.Size = UDim2.new(1, -20, 0, 14)
local suggestLinkBox = make("TextBox", { Position = UDim2.fromOffset(10, 46), Size = UDim2.new(1, -20, 0, 24), BackgroundColor3 = THEME.bg, Text = SUGGESTION_LINK, TextSize = 8, TextColor3 = THEME.muted, Font = Enum.Font.Gotham, TextXAlignment = Enum.TextXAlignment.Center, ClearTextOnFocus = false, TextEditable = false }, suggestFrame); corner(suggestLinkBox, 6)
local copyButton = make("TextButton", { Text = "COPY LINK", TextSize = 9, TextColor3 = THEME.white, Font = Enum.Font.GothamBold, BackgroundColor3 = THEME.purpleDark, Position = UDim2.fromOffset(10, 76), Size = UDim2.new(1, -20, 0, 20), AutoButtonColor = false }, suggestFrame); corner(copyButton, 6)

local function copyToClipboard(text)
    if setclipboard then setclipboard(text); return true
    elseif toclipboard then toclipboard(text); return true
    elseif syn and syn.write_clipboard then syn.write_clipboard(text); return true end
    return false
end
copyButton.MouseButton1Click:Connect(function()
    local success = copyToClipboard(SUGGESTION_LINK)
    if success then
        copyButton.Text = "COPIED!"; copyButton.BackgroundColor3 = THEME.green
        task.delay(2, function() if copyButton and copyButton.Parent then copyButton.Text = "COPY LINK"; copyButton.BackgroundColor3 = THEME.purpleDark end end)
    else
        copyButton.Text = "COPY FAILED"; copyButton.BackgroundColor3 = THEME.red
        task.delay(2, function() if copyButton and copyButton.Parent then copyButton.Text = "COPY LINK"; copyButton.BackgroundColor3 = THEME.purpleDark end end)
    end
end)

local categoriesByName={}
local navButtons={}
local function setAccent(color)
    THEME.purple=color; moonLogo.ImageColor3=color; bar.BackgroundColor3=color; grid.ScrollBarImageColor3=color
    for _,b in pairs(categoriesByName) do if b.Name==activeCategory then b.BackgroundColor3=color end end
end
accentButton.MouseButton1Click:Connect(function() accentIndex=accentIndex%#accentOptions+1; setAccent(accentOptions[accentIndex]); accentButton.BackgroundColor3=THEME.purple end)

local function resizeGrid()
    local width=cards.AbsoluteSize.X
    if width<=0 then return end
    local columns=math.max(1,math.floor((width+10)/170))
    grid.CellSize=UDim2.fromOffset(math.floor((width-10*(columns-1))/columns),158)
end
cards:GetPropertyChangedSignal("AbsoluteSize"):Connect(resizeGrid)

local render
local function clearCards()
    for _,child in ipairs(cards:GetChildren()) do if child:IsA("Frame") or child:IsA("TextLabel") then child:Destroy() end end
end

local function showDetails(item)
    selectedGame = item
    detailName.Text = item.name
    detailGenre.Text = item.genre:upper()
    detailDescription.Text = item.description
    detailId.Text = "Place ID: " .. tostring(item.id)
    detailImage.Image = "rbxthumb://type=GameIcon&id=" .. tostring(item.id) .. "&w=512&h=512"
    detailFavorite.Text = favorites[item.name] and "★  REMOVE FROM FAVORITES" or "☆  ADD TO FAVORITES"
    details.Visible = true
    details.Position = UDim2.fromScale(1, 0)
    tween(details, .28, {Position = UDim2.fromScale(0, 0)})

    -- Clear previous dynamic buttons
    for _, child in ipairs(details:GetChildren()) do
        if child.Name == "ScriptButton" or child.Name == "CustomFrame" then
            child:Destroy()
        end
    end

    local yPos = 470

    -- Official mapped script button
    local scriptUrl = scriptURLs[item.name]
    if scriptUrl then
        local scriptBtn = make("TextButton", {
            Name = "ScriptButton", Text = "LOAD SCRIPT (KEYLESS)", TextSize = 11, TextColor3 = THEME.white,
            Font = Enum.Font.GothamBold, BackgroundColor3 = THEME.green,
            Position = UDim2.fromOffset(19, yPos), Size = UDim2.new(1, -38, 0, 39), ZIndex = 21
        }, details)
        corner(scriptBtn, 9)

        scriptBtn.MouseButton1Click:Connect(function()
            scriptBtn.Text = "LOADING..."
            scriptBtn.BackgroundColor3 = THEME.purpleDark
            local success, err = pcall(function()
                loadstring(game:HttpGet(scriptUrl))()
            end)
            if success then
                scriptBtn.Text = "SCRIPT LOADED!"
                scriptBtn.BackgroundColor3 = THEME.green
            else
                scriptBtn.Text = "FAILED - TRY AGAIN"
                scriptBtn.BackgroundColor3 = THEME.red
                warn("Lumina script load failed:", err)
            end
            task.delay(2.5, function()
                if scriptBtn and scriptBtn.Parent then
                    scriptBtn.Text = "LOAD SCRIPT (KEYLESS)"
                    scriptBtn.BackgroundColor3 = THEME.green
                end
            end)
        end)
        yPos = yPos + 50
    else
        local noScriptBtn = make("TextButton", {
            Name = "ScriptButton", Text = "NO PUBLIC KEYLESS SCRIPT", TextSize = 11, TextColor3 = THEME.white,
            Font = Enum.Font.GothamBold, BackgroundColor3 = THEME.red,
            Position = UDim2.fromOffset(19, yPos), Size = UDim2.new(1, -38, 0, 39), ZIndex = 21
        }, details)
        corner(noScriptBtn, 9)
        yPos = yPos + 50
    end

    -- ========== CUSTOM SCRIPT SECTION ==========
    local customFrame = make("Frame", {
        Name = "CustomFrame",
        Position = UDim2.fromOffset(19, yPos),
        Size = UDim2.new(1, -38, 0, 160),
        BackgroundColor3 = THEME.panel,
        ZIndex = 21
    }, details)
    corner(customFrame, 10)
    stroke(customFrame, THEME.line, 0.35)

    local customTitle = label(customFrame, "CUSTOM SCRIPT (Paste your own)", 12, THEME.white, Enum.Font.GothamBold)
    customTitle.Position = UDim2.fromOffset(12, 8)
    customTitle.Size = UDim2.new(1, -24, 0, 22)

    local customBox = make("TextBox", {
        Position = UDim2.fromOffset(12, 36),
        Size = UDim2.new(1, -24, 0, 50),
        BackgroundColor3 = THEME.bg,
        Text = customScripts[item.name] or "",
        PlaceholderText = "Paste loadstring(...) or raw URL here...",
        PlaceholderColor3 = THEME.muted,
        TextColor3 = THEME.white,
        TextSize = 11,
        Font = Enum.Font.Gotham,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Top,
        ClearTextOnFocus = false,
        MultiLine = true,
        TextWrapped = true,
        ZIndex = 22
    }, customFrame)
    corner(customBox, 6)

    local loadCustomBtn = make("TextButton", {
        Text = "LOAD CUSTOM",
        TextSize = 11,
        TextColor3 = THEME.white,
        Font = Enum.Font.GothamBold,
        BackgroundColor3 = THEME.purpleDark,
        Position = UDim2.fromOffset(12, 96),
        Size = UDim2.new(0.48, -6, 0, 34),
        ZIndex = 22
    }, customFrame)
    corner(loadCustomBtn, 8)

    local saveCustomBtn = make("TextButton", {
        Text = "SAVE FOR GAME",
        TextSize = 11,
        TextColor3 = THEME.white,
        Font = Enum.Font.GothamBold,
        BackgroundColor3 = THEME.card,
        Position = UDim2.new(0.52, 6, 0, 96),
        Size = UDim2.new(0.48, -18, 0, 34),
        ZIndex = 22
    }, customFrame)
    corner(saveCustomBtn, 8)

    local statusLabel = label(customFrame, "", 10, THEME.muted)
    statusLabel.Position = UDim2.fromOffset(12, 136)
    statusLabel.Size = UDim2.new(1, -24, 0, 18)

    loadCustomBtn.MouseButton1Click:Connect(function()
        local text = customBox.Text:gsub("^%s*(.-)%s*$", "%1") -- trim
        if text == "" then
            statusLabel.Text = "Paste something first"
            statusLabel.TextColor3 = THEME.red
            return
        end

        loadCustomBtn.Text = "LOADING..."
        loadCustomBtn.BackgroundColor3 = THEME.purple

        local success, err = pcall(function()
            if text:find("loadstring") or text:find("HttpGet") then
                -- Full loadstring provided
                loadstring(text)()
            else
                -- Assume it's a raw URL
                loadstring(game:HttpGet(text))()
            end
        end)

        if success then
            loadCustomBtn.Text = "LOADED!"
            loadCustomBtn.BackgroundColor3 = THEME.green
            statusLabel.Text = "Custom script executed successfully"
            statusLabel.TextColor3 = THEME.green
        else
            loadCustomBtn.Text = "FAILED"
            loadCustomBtn.BackgroundColor3 = THEME.red
            statusLabel.Text = "Error: " .. tostring(err):sub(1, 60)
            statusLabel.TextColor3 = THEME.red
            warn("Custom script error:", err)
        end

        task.delay(2.5, function()
            if loadCustomBtn and loadCustomBtn.Parent then
                loadCustomBtn.Text = "LOAD CUSTOM"
                loadCustomBtn.BackgroundColor3 = THEME.purpleDark
            end
        end)
    end)

    saveCustomBtn.MouseButton1Click:Connect(function()
        local text = customBox.Text:gsub("^%s*(.-)%s*$", "%1")
        if text == "" then
            statusLabel.Text = "Nothing to save"
            statusLabel.TextColor3 = THEME.red
            return
        end
        customScripts[item.name] = text
        saveCustomBtn.Text = "SAVED!"
        saveCustomBtn.BackgroundColor3 = THEME.green
        statusLabel.Text = "Saved for " .. item.name .. " (this session)"
        statusLabel.TextColor3 = THEME.green
        task.delay(1.8, function()
            if saveCustomBtn and saveCustomBtn.Parent then
                saveCustomBtn.Text = "SAVE FOR GAME"
                saveCustomBtn.BackgroundColor3 = THEME.card
            end
        end)
    end)
end

local function makeCard(item, order)
    local card=make("Frame",{Name="GameCard",LayoutOrder=order,BackgroundColor3=THEME.card,BorderSizePixel=0},cards)
    corner(card,11); stroke(card,THEME.line,.38)
    local thumb=make("ImageLabel",{Position=UDim2.fromOffset(7,7),Size=UDim2.new(1,-14,0,88),BackgroundColor3=Color3.fromRGB(48,39,67),Image="rbxthumb://type=GameIcon&id="..tostring(item.id).."&w=256&h=256",ScaleType=Enum.ScaleType.Crop},card); corner(thumb,8)
    local name=label(card,item.name,11,THEME.white,Enum.Font.GothamSemibold); name.Position=UDim2.fromOffset(9,98); name.Size=UDim2.new(1,-39,0,20); name.TextTruncate=Enum.TextTruncate.AtEnd
    local genre=label(card,item.genre,9,THEME.muted); genre.Position=UDim2.fromOffset(9,117); genre.Size=UDim2.new(1,-18,0,15)
    local fav=make("TextButton",{Text=favorites[item.name] and "★" or "☆",TextColor3=THEME.purple,TextSize=18,Font=Enum.Font.Gotham,BackgroundTransparency=1,Position=UDim2.new(1,-31,0,94),Size=UDim2.fromOffset(25,25),AutoButtonColor=false},card)
    fav.MouseButton1Click:Connect(function() favorites[item.name]=not favorites[item.name]; fav.Text=favorites[item.name] and "★" or "☆"; if currentPage=="Favorites" then render() end end)
    local open=make("TextButton",{Text="VIEW DETAILS  →",TextColor3=THEME.white,TextSize=9,Font=Enum.Font.GothamBold,BackgroundColor3=THEME.purpleDark,Position=UDim2.new(0,7,1,-27),Size=UDim2.new(1,-14,0,21),AutoButtonColor=false},card); corner(open,6)
    open.MouseEnter:Connect(function() tween(card,.12,{BackgroundColor3=THEME.cardHover}) end)
    open.MouseLeave:Connect(function() tween(card,.12,{BackgroundColor3=THEME.card}) end)
    open.MouseButton1Click:Connect(function() showDetails(item) end)
end

render=function()
    clearCards()
    for name,button in pairs(categoriesByName) do
        local active=activeCategory==name
        button.BackgroundColor3=active and THEME.purple or THEME.panel
        button.TextColor3=active and THEME.white or THEME.muted
    end
    heading.Text=({Home="Discover your next adventure",Games="Game library",Universal="Universal Utilities",Favorites="Your favorites",Settings="Settings"})[currentPage] or "Discover"
    subheading.Text=({Home="A world of games, all in one place.",Games="Browse all 49 experiences.",Universal="Keyless scripts that work in most games.",Favorites="Your saved games, all together.",Settings="Make Lumina feel like yours."})[currentPage] or "Discover games."
    local count=0
    for _,item in ipairs(catalog) do
        local searchable=string.lower(item.name.." "..item.genre)
        local queryMatch=searchQuery=="" or string.find(searchable,searchQuery,1,true)\~=nil
        local categoryMatch=activeCategory=="All" or item.genre==activeCategory
        local favoriteMatch=currentPage\~="Favorites" or favorites[item.name]==true
        if queryMatch and categoryMatch and favoriteMatch then
            count = count + 1
            makeCard(item,count)
        end
    end
    if count==0 then
        local empty=label(cards,currentPage=="Favorites" and "No favorites yet — tap ☆ on a game card." or "No games found. Try another search.",12,THEME.muted)
        empty.Name="EmptyState"; empty.Size=UDim2.new(1,0,0,50); empty.LayoutOrder=9999
    end
    resizeGrid()
end

local categoryNames={"All","Action","Adventure","Anime","Building","Fashion","Fighting","FPS","Horror","Obby","Party","Racing","Roleplay","Simulator","Social","Sports","Strategy","Survival","Tycoon"}
for _,name in ipairs(categoryNames) do
    local width=math.max(45,#name*7+18)
    local b=make("TextButton",{Name=name,Text=name,TextSize=10,TextColor3=name=="All" and THEME.white or THEME.muted,Font=Enum.Font.GothamMedium,BackgroundColor3=name=="All" and THEME.purple or THEME.panel,Size=UDim2.fromOffset(width,29),AutoButtonColor=false},categories)
    corner(b,8); categoriesByName[name]=b
    b.MouseButton1Click:Connect(function() activeCategory=name; render() end)
end

local navEntries={{"Home","⌂"},{"Games","▦"},{"Universal","⚡"},{"Favorites","☆"},{"Settings","⚙"}}
local function navigate(page)
    currentPage=page; details.Visible=false
    searchFrame.Visible=page\~="Settings" and page\~="Universal"
    categories.Visible=page\~="Settings" and page\~="Universal"
    cards.Visible=page\~="Settings" and page\~="Universal"
    settingsPanel.Visible=page=="Settings"
    universalPanel.Visible=page=="Universal"
    
    for name,button in pairs(navButtons) do
        local active=name==page
        button.BackgroundColor3=active and THEME.purpleDark or THEME.panel
        button.BackgroundTransparency=active and 0 or 1
    end
    render()
end
for i,entry in ipairs(navEntries) do
    local name,icon=entry[1],entry[2]
    local b=make("TextButton",{Name=name,LayoutOrder=i,Text="",BackgroundColor3=THEME.panel,BackgroundTransparency=name=="Home" and 0 or 1,Size=UDim2.new(1,0,0,39),AutoButtonColor=false},navList)
    corner(b,9)
    local ico=label(b,icon,17,THEME.white); ico.Position=UDim2.fromOffset(7,4); ico.Size=UDim2.fromOffset(24,30); ico.TextXAlignment=Enum.TextXAlignment.Center
    local txt=label(b,name,11,THEME.muted,Enum.Font.GothamMedium); txt.Position=UDim2.fromOffset(38,4); txt.Size=UDim2.new(1,-42,0,30)
    navButtons[name]=b
    b.MouseButton1Click:Connect(function() navigate(name) end)
end
searchBox:GetPropertyChangedSignal("Text"):Connect(function() searchQuery=string.lower(searchBox.Text); render() end)
back.MouseButton1Click:Connect(function() tween(details,.2,{Position=UDim2.fromScale(1,0)}); task.delay(.21,function() details.Visible=false end) end)
detailFavorite.MouseButton1Click:Connect(function()
    if not selectedGame then return end
    favorites[selectedGame.name]=not favorites[selectedGame.name]
    detailFavorite.Text=favorites[selectedGame.name] and "★  REMOVE FROM FAVORITES" or "☆  ADD TO FAVORITES"
    if currentPage=="Favorites" then render() end
end)
playButton.MouseButton1Click:Connect(function()
    if not selectedGame then return end
    local success = copyToClipboard(tostring(selectedGame.id))
    if success then
        playButton.Text="COPIED! JOIN MANUALLY"
        playButton.BackgroundColor3=THEME.green
        task.delay(3,function() 
            if playButton.Parent then 
                playButton.Text="COPY PLACE ID"
                playButton.BackgroundColor3=THEME.card
            end 
        end)
    else
        playButton.Text="COPY FAILED"
        playButton.BackgroundColor3=THEME.red
        task.delay(3,function() 
            if playButton.Parent then 
                playButton.Text="COPY PLACE ID"
                playButton.BackgroundColor3=THEME.card
            end 
        end)
    end
end)

local reopen=make("TextButton",{Name="LuminaReopen",AnchorPoint=Vector2.new(0,.5),Position=UDim2.new(0,-65,.5,0),Size=UDim2.fromOffset(52,52),Text="",BackgroundColor3=THEME.panel,Visible=false,AutoButtonColor=false},gui)
corner(reopen,15); stroke(reopen,THEME.purple,.2)
make("ImageLabel", {Size=UDim2.fromScale(0.7, 0.7), Position=UDim2.fromScale(0.5, 0.5), AnchorPoint=Vector2.new(0.5, 0.5), BackgroundTransparency=1, Image=LUMINA_ICON, ImageColor3=THEME.purple}, reopen)

minimize.MouseButton1Click:Connect(function()
    tween(main,.2,{Size=UDim2.fromScale(.72,.66),BackgroundTransparency=1})
    task.delay(.21,function() main.Visible=false; main.BackgroundTransparency=0; reopen.Visible=true; tween(reopen,.24,{Position=UDim2.new(0,12,.5,0)}) end)
end)
reopen.MouseButton1Click:Connect(function()
    tween(reopen,.15,{Position=UDim2.new(0,-65,.5,0)})
    task.delay(.16,function() reopen.Visible=false; main.Visible=true; main.Size=UDim2.fromScale(.72,.66); tween(main,.28,{Size=UDim2.fromScale(.88,.82)}) end)
end)
close.MouseButton1Click:Connect(function() tween(main,.18,{Size=UDim2.fromScale(.72,.66),BackgroundTransparency=1}); task.delay(.2,function() gui:Destroy() end) end)

local dragging=false
local dragStart, startPosition
header.InputBegan:Connect(function(input)
    if input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch then dragging=true; dragStart=input.Position; startPosition=main.Position end
end)
UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType==Enum.UserInputType.MouseMovement or input.UserInputType==Enum.UserInputType.Touch) then
        local delta=input.Position-dragStart
        main.Position=UDim2.new(startPosition.X.Scale,startPosition.X.Offset+delta.X,startPosition.Y.Scale,startPosition.Y.Offset+delta.Y)
    end
end)
UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch then dragging=false end
end)

-- INITIALIZATION
navigate("Home")
render()

task.spawn(function()
    local preloadAssets = {}
    for i, item in ipairs(catalog) do
        if i > 12 then break end
        table.insert(preloadAssets, "rbxthumb://type=GameIcon&id="..tostring(item.id).."&w=256&h=256")
    end
    pcall(function() ContentProvider:PreloadAsync(preloadAssets) end)
    for i = 1, 100 do
        bar.Size = UDim2.new(i/100, 0, 1, 0)
        task.wait(0.015) 
    end
    task.wait(0.3)
    introSub.Text = "READY."
    tween(intro, 0.6, {BackgroundTransparency = 1})
    tween(introIcon, 0.6, {ImageTransparency = 1})
    tween(introSub, 0.6, {TextTransparency = 1})
    tween(barBack, 0.6, {BackgroundTransparency = 1})
    tween(bar, 0.6, {BackgroundTransparency = 1})
    task.wait(0.65)
    intro:Destroy()
    main.Visible = true
    main.Size = UDim2.fromScale(.75, .70)
    tween(main, .38, {Size = UDim2.fromScale(.88, .82)})
end)