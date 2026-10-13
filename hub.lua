-- LUMINA V3.3 | Roblox game discovery + script hub
-- Put this LocalScript in StarterPlayer > StarterPlayerScripts in a Roblox experience you own.

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local TeleportService = game:GetService("TeleportService")
local UserInputService = game:GetService("UserInputService")
local ContentProvider = game:GetService("ContentProvider")
local GuiService = game:GetService("GuiService")

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
-- SCRIPT URL MAPPING (49 GAMES)
-- ==========================================
local scriptURLs = {
    ["Brookhaven RP"] = "https://raw.githubusercontent.com/nxvap/Hexagon/refs/heads/main/brookhaven",
    ["Adopt Me!"] = "https://raw.githubusercontent.com/eIysia-dev/best/refs/heads/main/loader",
    ["Blox Fruits"] = "https://raw.githubusercontent.com/ShowScript79/cokkahub/refs/heads/main/cokkahub",
    ["Murder Mystery 2"] = "https://raw.githubusercontent.com/xv3gasx/Murder-Mystery-2/refs/heads/main/Release.lua",
    ["Jailbreak"] = "https://raw.githubusercontent.com/veloxides/Jailbreak/refs/heads/main/VeloxideLoader",
    ["Welcome to Bloxburg"] = "https://azurix.vercel.app/",
    ["Tower of Hell"] = "https://gist.githubusercontent.com/successful0999777-lab/c84bf42a29cf2559cb6ee5dfcb25f528/raw/43d65eca843b9d5bd72fc26ad8870795575f678a/Applehub.lua",
    ["Natural Disaster Survival"] = "https://pastebin.com/raw/8XCgheRD",
    ["Build A Boat For Treasure"] = "https://raw.githubusercontent.com/scarabhub/buildaboatAutoFarm/refs/heads/main/main.lua",
    ["Piggy"] = "https://raw.githubusercontent.com/StarHackScripts/StarHack-Hub-Deepstar-Hub/refs/heads/main/StarHackHub_PiggyV2release",
    ["Pet Simulator 99"] = "https://raw.githubusercontent.com/REDzHUB/PetSimulator99/main/redz9999.lua",
    ["DOORS"] = "https://raw.githubusercontent.com/bocaj111004/Abysall/refs/heads/main/Loader.luau",
    ["Slap Battles"] = "https://raw.githubusercontent.com/joyfulpizza/Joyful_pizzapartyl-scripts/refs/heads/main/Slapplefarmer.lua",
    ["BedWars"] = "https://raw.githubusercontent.com/VapeVoidware/vapevoidware/main/NewMainScript.lua",
    ["Tower Defense Simulator"] = "https://raw.githubusercontent.com/Nanana291/Kronos/refs/heads/main/Loader.lua",
    ["The Strongest Battlegrounds"] = "https://raw.githubusercontent.com/0mam0ri/KittyWare/refs/heads/main/obf.lua",
    ["Blade Ball"] = "https://raw.githubusercontent.com/Doortthemort/676/refs/heads/main/Main.lua",
    ["Dress to Impress"] = "https://raw.githubusercontent.com/ToraScript/Script/main/DressToImpress",
    ["Grow a Garden"] = "https://raw.githubusercontent.com/depthso/Grow-a-Garden/refs/heads/main/autofarm.lua",
    ["Steal a Brainrot"] = "https://pastefy.app/V0blGtti/raw",
    ["99 Nights in the Forest"] = "https://raw.githubusercontent.com/wehibuyfgyuwe/99nights.github.io/refs/heads/main/ringta.lua",
    ["Fisch"] = "https://raw.githubusercontent.com/xataxell/fisch/refs/heads/main/script.lua",
    ["Anime Vanguards"] = "https://dollarhub.space/script/loader.lua",
    ["Blue Lock: Rivals"] = "https://raw.githubusercontent.com/TheDarkoneMarcillisePex/Other-Scripts/refs/heads/main/Blue%20Lock%20Rivals%20GUI",
    ["Volleyball Legends"] = "https://raw.githubusercontent.com/M1zard/LokisVoley/refs/heads/main/VolleyBallLegendsScript.lua",
    ["Jujutsu Shenanigans"] = "https://raw.githubusercontent.com/samuiex/samui/refs/heads/main/samui%20menu",
    ["Grand Piece Online"] = "https://raw.githubusercontent.com/Jakekill871/public-scripts/master/GrandPieceOnlineGUI",
    ["Survive the Killer"] = "https://raw.githubusercontent.com/Biskus0/SurviveTheKiller/refs/heads/main/Loading.lua",
    ["Berry Avenue RP"] = "https://pastefy.app/mW58xZvr/raw",
    ["Apocalypse Rising 2"] = "https://pastebin.com/raw/B2NP4x8w",
    ["Creatures of Sonaria"] = "https://raw.githubusercontent.com/Mangnex/Lunar-Hub/refs/heads/main/FreeLoader.lua",
    ["Ragdoll Engine"] = "https://pastebin.com/raw/NkTcjSS7",
    ["MeepCity"] = "https://raw.githubusercontent.com/ToraScript/Script/main/MeepCity",
    ["Royale High"] = "https://pastes.io/raw/rh-30329-3",
    ["Work at a Pizza Place"] = "https://raw.githubusercontent.com/Hm5011/hussain/refs/heads/main/Work%20at%20a%20pizza%20place",
    ["Flee the Facility"] = "https://pastebin.com/raw/VBQjCrST",
    ["Epic Minigames"] = "https://raw.githubusercontent.com/SlamminPig/rblxgames/main/Epic%20Minigames/EpicMinigamesGUI",
    ["Theme Park Tycoon 2"] = "https://pastebin.com/raw/289f79g7060gjl28487294", -- Placeholder
    ["Bee Swarm Simulator"] = "https://raw.githubusercontent.com/VerbalHubz/Verbal-Hub/refs/heads/main/Bee%20Swarm%20Sim.Lua",
    ["Vehicle Simulator"] = "https://raw.githubusercontent.com/CasperFlyModz/discord.gg-rips/main/VehicleSimulator.lua",
    ["Da Hood"] = "https://raw.githubusercontent.com/xulfo/Oxide-Loader/main/Main.lua",
    ["Counter Blox"] = "https://raw.githubusercontent.com/yyeptech/thebighubs/refs/heads/main/cbro.lua",
    ["Phantom Forces"] = "https://raw.githubusercontent.com/Nickk-GG/Phantom-Force-NickHub/refs/heads/main/sc.lua",
    ["Arsenal"] = "https://raw.githubusercontent.com/blackowl1231/Z3US/refs/heads/main/main.lua",
    ["Strucid"] = "https://polyethelene.pages.dev/Strucid.luau",
    ["Big Paintball"] = "https://raw.githubusercontent.com/ZaRdoOx/Fazium-files/main/Loader",
    ["Booga Booga"] = "https://raw.githubusercontent.com/Yousuck780/Nebula-Hub/refs/heads/main/boogaboogareborn",
    ["Islands"] = "https://system-exodus.com/scripts/Islands/Islands.lua",
    ["Pet Simulator X"] = "https://raw.githubusercontent.com/RobloxGPT/chatgpt-scripts/refs/heads/main/fly%20gui%20v2",
    ["Anime Adventures"] = "https://raw.githubusercontent.com/ArponAG/Scripts/main/AnimeAdventures.lua",
}

-- ==========================================
-- CATALOG (Same as before)
-- ==========================================
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
local currentPage = "Home"
local activeCategory = "All"
local searchQuery = ""
local selectedGame
local accentOptions = {
    Color3.fromRGB(164,119,255), Color3.fromRGB(83,155,255),
    Color3.fromRGB(255,103,177), Color3.fromRGB(94,220,179),
}
local accentIndex = 1

local gui = make("ScreenGui", {
    Name="LuminaV3", ResetOnSpawn=false, IgnoreGuiInset=true,
    DisplayOrder=50, ZIndexBehavior=Enum.ZIndexBehavior.Sibling,
}, playerGui)

-- ... (LOADING SCREEN, MAIN WINDOW, SIDEBAR, SUGGESTION BAR, ALL REMAIN THE SAME) ...

-- ==========================================
-- UPDATED DETAILS PANEL WITH LOAD SCRIPT BUTTON
-- ==========================================
local function showDetails(item)
    selectedGame=item
    detailName.Text=item.name
    detailGenre.Text=item.genre:upper()
    detailDescription.Text=item.description
    detailId.Text="Place ID: "..tostring(item.id)
    detailImage.Image="rbxthumb://type=GameIcon&id="..tostring(item.id).."&w=512&h=512"
    detailFavorite.Text=favorites[item.name] and "★  REMOVE FROM FAVORITES" or "☆  ADD TO FAVORITES"
    details.Visible=true
    details.Position=UDim2.fromScale(1,0)
    tween(details,.28,{Position=UDim2.fromScale(0,0)})

    -- Remove old script button if it exists
    local existingScriptBtn = details:FindFirstChild("ScriptButton")
    if existingScriptBtn then existingScriptBtn:Destroy() end

    -- Add the LOAD SCRIPT button
    local scriptUrl = scriptURLs[item.name]
    if scriptUrl then
        local scriptBtn = make("TextButton", {
            Name = "ScriptButton",
            Text = "LOAD SCRIPT",
            TextSize = 11,
            TextColor3 = THEME.white,
            Font = Enum.Font.GothamBold,
            BackgroundColor3 = THEME.green,
            Position = UDim2.fromOffset(19, 450),
            Size = UDim2.new(1, -38, 0, 39),
            ZIndex = 21
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
                scriptBtn.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
                warn("Lumina script load failed: ", err)
            end
            task.delay(2, function()
                if scriptBtn and scriptBtn.Parent then
                    scriptBtn.Text = "LOAD SCRIPT"
                    scriptBtn.BackgroundColor3 = THEME.green
                end
            end)
        end)
    end
end

-- ... (REST OF THE CODE: CARDS, CATEGORIES, NAVIGATION, MINIMIZE/CLOSE, DRAG, INITIALIZATION) ...