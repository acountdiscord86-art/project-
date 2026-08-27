-- [FIX] guard IsLoaded — beberapa executor tidak punya method ini
if game.IsLoaded then
    if not game:IsLoaded() then game.Loaded:Wait() end
else
    -- fallback: tunggu sampai workspace selesai replicate
    local ok = pcall(function() game:GetService("ContentProvider"):PreloadAsync({}) end)
    task.wait(1)
end
local Players=game:GetService("Players")
while not Players.LocalPlayer do task.wait() end
while not workspace.CurrentCamera do task.wait() end
local cloneref=(cloneref or clonereference or function(v)return v end)
local RunService=cloneref(game:GetService("RunService"))
local UserInputService=cloneref(game:GetService("UserInputService"))
local Lighting=cloneref(game:GetService("Lighting"))
local Stats=cloneref(game:GetService("Stats"))
local VirtualInputManager=cloneref(game:GetService("VirtualInputManager"))
local CoreGui=cloneref(game:GetService("CoreGui"))
local GuiService=cloneref(game:GetService("GuiService"))
local ReplicatedStorage=cloneref(game:GetService("ReplicatedStorage"))
local PathfindingService=cloneref(game:GetService("PathfindingService"))
local ProximityPromptService=cloneref(game:GetService("ProximityPromptService"))
local HttpService=cloneref(game:GetService("HttpService"))
local LocalPlayer=Players.LocalPlayer
local PlayerGui=LocalPlayer:WaitForChild("PlayerGui")

-- =========================================================
-- UI PARENT
-- =========================================================

local function GetUIParent()
    local ok,res=pcall(function()
        if gethui then
            return gethui()
        end
        if syn and syn.protect_gui then
            local gui=Instance.new("ScreenGui")
            syn.protect_gui(gui)
            gui.Parent=CoreGui
            return gui
        end
        return CoreGui
    end)
    return ok and res or CoreGui
end
local TargetGui=GetUIParent()

-- =========================================================
-- SAFE HTTPGET
-- =========================================================

local function SafeHttpGet(url)
    local ok,res=pcall(function()
        if game.HttpGet then
            return game:HttpGet(url)
        end
        if syn and syn.request then
            return syn.request({
                Url=url,
                Method="GET"
            }).Body
        end
        if http_request then
            return http_request({
                Url=url,
                Method="GET"
            }).Body
        end
        error("HttpGet unsupported")
    end)
    return ok and res or nil
end

-- =========================================================
-- LOAD MACLIB (PENGGANTI WINDUI)
-- =========================================================

-- MacLib dimuat dengan benar (URL tetap MacLib, API sudah dikonversi)
local MacLib
do
    local ok,res=pcall(function()
        return loadstring(game:HttpGet(
            "https://raw.githubusercontent.com/shlexware/Orion/main/source"
        ))()
    end)
    if ok and res then
        MacLib=res
    end
end

if MacLib then
    print("[RYEENZY] OrionLib Loaded")
else
    warn("[RYEENZY] Failed Load OrionLib")
    pcall(function()
        game:GetService("StarterGui"):SetCore(
            "SendNotification",
            {
                Title="RYEENZY | HUB",
                Text="Failed loading UI Library"
            }
        )
    end)
    return
end

-- =========================================================
-- WINDUI COMPATIBILITY SHIM
-- Agar semua WindUI:Notify() tetap bisa dipanggil tanpa ganti satu-satu
-- =========================================================
local WindUI = {}
function WindUI:Notify(t)
    -- [FIX] OrionLib pakai MakeNotification, bukan Notify
    pcall(function()
        Window:Notify({
            Title = t.Title   or "RYEENZY",
            Description = t.Content or t.Text or "",
            Lifetime = t.Duration or 3,
        })
    end)
end
function WindUI:SetNotificationLower() end

-- =========================================================
-- ANTI MEMORY LEAK
-- =========================================================

getgenv().RYEENZY_CONNECTIONS=
    getgenv().RYEENZY_CONNECTIONS or {}
for _,conn in ipairs(getgenv().RYEENZY_CONNECTIONS) do
    pcall(function()
        RunService:UnbindFromRenderStep(
            "SmoothFOV"
        )
        if conn and conn.Disconnect then
            conn:Disconnect()
        end
    end)
end

table.clear(getgenv().RYEENZY_CONNECTIONS)
----------------------------------------------------------------
-- ESP COLORS (Pengganti Config Manual)
----------------------------------------------------------------
local ESP_COLORS = {
    Killer = Color3.fromRGB(255, 93, 108), 
    Survivor = Color3.fromRGB(0, 255, 34),
    Generator = Color3.fromRGB(200, 100, 0), 
    Gate = Color3.fromRGB(255, 255, 255),
    Pallet = Color3.fromRGB(53, 189, 166), 
    Hook = Color3.fromRGB(252, 116, 116)
}
local MaskNames = {
    ["Abysswalker"] = "ABYSSWALKER",
    ["Cure"]        = "CURE",
    ["Hidden"]      = "HIDDEN",
    ["Killer"]      = "THE KILLER",
    ["Masked"]      = "PALA AYAM",
    ["Stalker"]     = "STALKER",
    ["Veil"]        = "VEIL",
    ["Slasher"]     = "SLASHER",
}

local MaskColors = {
    ["Abysswalker"] = Color3.fromRGB(110, 20, 255),
    ["Cure"]        = Color3.fromRGB(0, 54, 156),
    ["Hidden"]      = Color3.fromRGB(170, 170, 170),
    ["Killer"]      = Color3.fromRGB(255, 40, 40),
    ["Masked"]      = Color3.fromRGB(255, 90, 20),
    ["Stalker"]     = Color3.fromRGB(255, 0, 140),
    ["Veil"]        = Color3.fromRGB(0, 140, 255),
    ["Slasher"]     = Color3.fromRGB(180, 0, 255),
}
local CachedMapObjects = {
    Generators = {},
    Pallets = {},
    Hooks = {},
    Gates = {}
}
local SpoofData = {
    Gears = 0,
    Screws = 0,
    Level = 0
}
local PrevESPState = { Generator = false, Hook = false, Pallet = false, Gate = false }
-- =========================================================
-- [NATIVE CACHE] MEMPERCEPAT KECEPATAN EKSEKUSI HINGGA 30%
-- =========================================================
local v3 = Vector3.new
local v2 = Vector2.new
local cnew = CFrame.new
local cangles = CFrame.Angles
local t_insert = table.insert
local t_remove = table.remove
local m_floor = math.floor
local m_round = math.round
local s_format = string.format

local function UpdateMapCache()
    local map = workspace:FindFirstChild("Map")
    if not map then return end
    
    CachedMapObjects.Generators = {}
    CachedMapObjects.Pallets = {}
    CachedMapObjects.Hooks = {}
    CachedMapObjects.Gates = {}
    
    local descendants = map:GetDescendants()
    for i = 1, #descendants do
        local obj = descendants[i]
        
        local n = obj.Name
        if n == "Generator" then 
            t_insert(CachedMapObjects.Generators, obj)
        elseif n == "Hook" then  
            t_insert(CachedMapObjects.Hooks, obj)
        elseif n == "Gate" then 
            t_insert(CachedMapObjects.Gates, obj)
        elseif n == "Pallet" or n == "Palletwrong" then 
            t_insert(CachedMapObjects.Pallets, obj)
        end
        
        if i % 500 == 0 then task.wait() end 
    end

    if PrevESPState then
        PrevESPState.Generator = false
        PrevESPState.Hook = false
        PrevESPState.Pallet = false
        PrevESPState.Gate = false
    end
end

-- =========================================================
-- [OPTIMASI] LITE MAP DETECTOR (STREAMING-ENABLED FIX)
-- =========================================================
task.spawn(function() 
    local mapWasEmpty = true 
    local descendantConn = nil 
    
    while task.wait(2) do 
        if not getgenv().RYEENZY_RUNNING then 
            if descendantConn then descendantConn:Disconnect() end
            break 
        end
        
        local currentMap = workspace:FindFirstChild("Map")
        local hasContents = currentMap and #currentMap:GetChildren() > 0
        
        if hasContents and mapWasEmpty then
            mapWasEmpty = false 
            
            task.delay(8, function()
                if currentMap and #currentMap:GetChildren() > 0 then
                    cachedChar = nil; cachedRoot = nil
                    UpdateMapCache() 
                    
                    if descendantConn then descendantConn:Disconnect() end
                    descendantConn = currentMap.DescendantAdded:Connect(function(obj)
                        local n = obj.Name
                        if n == "Generator" then 
                            t_insert(CachedMapObjects.Generators, obj)
                        elseif n == "Hook" then 
                            t_insert(CachedMapObjects.Hooks, obj)
                        elseif n == "Gate" then 
                            t_insert(CachedMapObjects.Gates, obj)
                        elseif n == "Pallet" or n == "Palletwrong" then 
                            t_insert(CachedMapObjects.Pallets, obj)
                        end
                    end)
                    
                    local palletCount = CachedMapObjects.Pallets and #CachedMapObjects.Pallets or 0
                    local genCount = CachedMapObjects.Generators and #CachedMapObjects.Generators or 0
                    
                    WindUI:Notify({ 
                        Title = "Map Loaded", 
                        Description = "Menemukan " .. palletCount .. " Pallet & " .. genCount .. " Gen. Radar Aktif!", 
                    })
                end
            end)
            
        elseif not hasContents and not mapWasEmpty then
            mapWasEmpty = true 
            
            if descendantConn then 
                descendantConn:Disconnect() 
                descendantConn = nil 
            end
            
            CachedMapObjects.Generators = {}
            CachedMapObjects.Pallets = {}
            CachedMapObjects.Hooks = {}
            CachedMapObjects.Gates = {}
            if ActiveGenerators then table.clear(ActiveGenerators) end
            
            if PrevESPState then
                PrevESPState.Generator = false; PrevESPState.Hook = false
                PrevESPState.Pallet = false; PrevESPState.Gate = false
            end
        end
    end 
end)
getgenv().AutoFarmSpeed=17
getgenv().MoonwalkZigzagSpeed=11
getgenv().MoonwalkBoostPower=1.08
getgenv().ParryMatchup="Auto"
getgenv().AimStrictness=1.3
getgenv().ParryDelayOffset=0
getgenv().RYEENZY_RUNNING=true
getgenv().RYEENZY_ACTIVE=true
getgenv().AimbotSmoothness=8
getgenv().AimbotPart = "Torso"
getgenv().AimbotTrigger = "Hold to Lock"

local SelfHeal=false
local MoonwalkEnabled=false
local MoonwalkConnection=nil
local KEY_TOGGLE=Enum.KeyCode.R

getgenv().GeneratorPerfectOffsetStart=102
getgenv().GeneratorPerfectOffsetEnd=108
local AutoGenerator=false
local AutoGeneratorMode="Perfect"

local AutoParry=false
local ParryDistance=10

local ExactParryRemote
local LastParryTick=0

local CFG_AimPrediction=true
local CFG_BurstAmount=8
local CFG_ParryCooldown=0.45
local CFG_MaxVelocity=32

local GenConnection=nil
local FailThread=nil
local SpeedBoost=false

local Aimbot=false
local TargetPartCache={}
local WallCheck=true
local ShowFOVCircle=false

local CustomCameraFOV=false
local CameraFOVValue=100

local AimRadius=getgenv().AimRadius or 60
local AimDistance=getgenv().AimDistance or 80
local AimKey=Enum.KeyCode.Q

local BoostSpeed=30
local CachedTarget
local LastTargetCheck=0

local cachedChar,cachedRoot,cachedHum=nil,nil,nil

local AutoAttack=false
local AttackRange=10
local WarnKiller=true
local ActiveGenerators={}
local ThemeName="RYEENZY | HUB"
local Refreshing=false
local AutoFarmBot=false

local SilentAimPistol=false
local SilentAimFOV=180
local SilentTarget=nil
local LastSilentCheck=0
local LastSilentShot=0

local DoubleDamageGen=false
local MobileRotateBtn=nil

local HitboxExpander=false
local HitboxSize=15

local aimRayParams=RaycastParams.new()
aimRayParams.FilterType=Enum.RaycastFilterType.Blacklist

local SilentActions=false
local AntiFallDamage=false
local AntiLogger=true
local NotifyStun=false

local ESP_Survivor_Name=false
local ESP_Survivor_Highlight=false
local ESP_Killer_Name=false
local ESP_Killer_Highlight=false
local ESP_Generator=false
local ESP_Gate=false
local ESP_Pallet=false
local ESP_Hook=false

local ActiveESP={}
local LastKillerWarnCheck=0
local closestKillerDist=999
local LastUpdateTick=0
local LastESPRefresh=0

local TouchID=8822
local FOVCircle=nil

local lastTouchCheck=0
local cachedTouches={}
local lastRenderCheck = 0
local cachedIsCarrying = false

-- 1. SETUP FOV CIRCLE
local IndicatorGui = TargetGui:FindFirstChild("RYEENZY_Indicator") or Instance.new("ScreenGui")
IndicatorGui.Name = "RYEENZY_Indicator" 
IndicatorGui.IgnoreGuiInset = true 
IndicatorGui.ResetOnSpawn = false
IndicatorGui.Parent = TargetGui

if IndicatorGui:FindFirstChild("FOVCircle") then IndicatorGui.FOVCircle:Destroy() end
FOVCircle = Instance.new("Frame", IndicatorGui)
FOVCircle.Name = "FOVCircle"
FOVCircle.Size = UDim2.new(0, AimRadius * 2, 0, AimRadius * 2)
FOVCircle.AnchorPoint = v2(0.5, 0.5)
FOVCircle.Position = UDim2.new(0.5, 0, 0.5, 0)
FOVCircle.BackgroundTransparency = 1
FOVCircle.Visible = ShowFOVCircle

local corner = Instance.new("UICorner", FOVCircle) 
corner.CornerRadius = UDim.new(1, 0)
local stroke = Instance.new("UIStroke", FOVCircle) 
stroke.Color = Color3.new(1, 1, 1)
stroke.Transparency = 0.5
stroke.Thickness = 1.5

ESP_SCP=ESP_SCP or false

local SCPFolder=CoreGui:FindFirstChild("SCP_ESP") or Instance.new("Folder")
SCPFolder.Name="SCP_ESP"
SCPFolder.Parent=CoreGui

local SCPCache={}
local SCPConnection=nil

local function IsSCP(v)
    if not(v and v:IsA("Model")) then
        return false
    end
    local n=v.Name:lower()
    return
        n=="scp"
        or n:match("^scp%d*$")
        or n:match("^scp[%-%_]?%d+$")
        or n:find("zombie")
        or n:find("monster")
        or n:find("infected")
        or n:find("mutant")
end

local function RemoveSCP(v)
    local h=SCPCache[v]
    if h then
        pcall(function()
            h:Destroy()
        end)
    end
    SCPCache[v]=nil
end

local function CreateSCP(v)
    if not ESP_SCP
    or SCPCache[v]
    or not(v and v.Parent)
    or not IsSCP(v) then
        return
    end

    local root=
        v:FindFirstChild("HumanoidRootPart",true)
        or v.PrimaryPart
        or v:FindFirstChildWhichIsA("BasePart",true)

    if not root then return end

    local h=Instance.new("Highlight")
    h.Name="SCP_H"
    h.Adornee=v
    h.FillColor=Color3.fromRGB(255,0,0)
    h.OutlineColor=Color3.fromRGB(255,80,80)
    h.FillTransparency=0.78
    h.OutlineTransparency=0.03
    h.DepthMode=Enum.HighlightDepthMode.AlwaysOnTop
    h.Parent=SCPFolder

    SCPCache[v]=h
end

local function ScanSCP()
    for _,v in ipairs(workspace:GetDescendants()) do
        CreateSCP(v)
    end
end

t_insert(getgenv().RYEENZY_CONNECTIONS,
    RunService.Heartbeat:Connect(function()
        if not ESP_SCP then
            if next(SCPCache) then
                for v in pairs(SCPCache) do
                    RemoveSCP(v)
                end
            end
        else
            for v,h in pairs(SCPCache) do
                if not(v and v.Parent and h and h.Parent) then
                    RemoveSCP(v)
                else
                    if h.Adornee~=v then
                        h.Adornee=v
                    end
                    if h.FillTransparency~=0.78 then
                        h.FillTransparency=0.78
                    end
                    if h.OutlineTransparency~=0.03 then
                        h.OutlineTransparency=0.03
                    end
                end
            end
            ScanSCP()
        end
    end)
)

-- // UI MOBILE (RYEENZY-STYLE)
local MoonwalkUI = Instance.new("ScreenGui")
local MoonwalkBtn = Instance.new("TextButton")
local UICorner = Instance.new("UICorner")
local UIStroke = Instance.new("UIStroke")

pcall(function()
    MoonwalkUI.Name = "RYEENZY_MoonwalkUI"
    MoonwalkUI.Enabled = false
    MoonwalkUI.Parent = (game:GetService("CoreGui") or game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"))
    MoonwalkUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
end)

MoonwalkBtn.Name = "MoonwalkBtn"
MoonwalkBtn.Parent = MoonwalkUI
MoonwalkBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MoonwalkBtn.Position = UDim2.new(1, -95, 0.5, -35)
MoonwalkBtn.Size = UDim2.new(0, 65, 0, 65)
MoonwalkBtn.Font = Enum.Font.GothamBold
MoonwalkBtn.Text = "MW: OFF"
MoonwalkBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MoonwalkBtn.TextSize = 14
MoonwalkBtn.Draggable = true 

UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = MoonwalkBtn

UIStroke.Color = Color3.fromRGB(100, 100, 100)
UIStroke.Thickness = 2
UIStroke.Parent = MoonwalkBtn

local function ToggleMoonwalk()
    getgenv().MoonwalkEnabled = not getgenv().MoonwalkEnabled
    
    if getgenv().MoonwalkEnabled then
        MoonwalkBtn.Text = "MW: ON"
        MoonwalkBtn.TextColor3 = Color3.fromRGB(247, 107, 28)
        UIStroke.Color = Color3.fromRGB(247, 107, 28)
    else
        MoonwalkBtn.Text = "MW: OFF"
        MoonwalkBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        UIStroke.Color = Color3.fromRGB(100, 100, 100)
        
        local char = game.Players.LocalPlayer.Character
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        if hum then hum.AutoRotate = true end
    end
end

MoonwalkBtn.MouseButton1Click:Connect(ToggleMoonwalk)

game:GetService("UserInputService").InputBegan:Connect(function(input, processed)
    if processed then return end
    if input.KeyCode == KEY_TOGGLE then
        ToggleMoonwalk()
    end
end)

--// CROSSHAIR SETUP
if TargetGui:FindFirstChild("VeilCrosshair") then
    TargetGui.VeilCrosshair:Destroy()
end

getgenv().CrosshairGui = Instance.new("ScreenGui")
getgenv().CrosshairGui.Name = "VeilCrosshair"
getgenv().CrosshairGui.IgnoreGuiInset = true
getgenv().CrosshairGui.ResetOnSpawn = false
getgenv().CrosshairGui.Enabled = false
getgenv().CrosshairGui.Parent = TargetGui

local crosshair = Instance.new("ImageLabel")
crosshair.Name = "Crosshair"
crosshair.Parent = getgenv().CrosshairGui
crosshair.AnchorPoint = Vector2.new(0.5,0.5)
crosshair.Position = UDim2.new(0.5,0,0.5,0)
crosshair.Size = UDim2.new(0,28,0,28)
crosshair.BackgroundTransparency = 1
crosshair.ImageColor3 = Color3.fromRGB(255,255,255)
crosshair.Image = "rbxassetid://9943168532"
local CrosshairImages = {
    Dot = "rbxassetid://9943168532",
    Scope = "rbxassetid://131437991032048",
    Circle = "rbxassetid://13441606488",
    Plus = "rbxassetid://125143421594685",
    Cross = "rbxassetid://139654963330788"
}

-- 3. SETUP PARRY RING
local oldRing = TargetGui:FindFirstChild("RYEENZY_ParryRing")
if oldRing then oldRing:Destroy() end
local ParryRing =
    Instance.new("CylinderHandleAdornment")
ParryRing.Name = "RYEENZY_ParryRing"
ParryRing.Color3 = Color3.fromRGB(170,40,255)
ParryRing.Transparency = 0.7
ParryRing.AlwaysOnTop = true
ParryRing.ZIndex = 10
ParryRing.Height = 0.05

local radius = tonumber(ParryDistance) or 10
ParryRing.Radius = radius
ParryRing.CFrame = CFrame.new(0,-2.8,0) * CFrame.Angles(math.rad(90),0,0)
-- [FIX] HumanoidRootPart tidak terdefinisi di scope ini — ambil dari character
do
    local _char = LocalPlayer.Character
    ParryRing.Adornee = _char and _char:FindFirstChild("HumanoidRootPart") or nil
end
ParryRing.Parent = TargetGui

-- [FIX] Keep ParryRing.Adornee updated setiap respawn
LocalPlayer.CharacterAdded:Connect(function(char)
    local hrp = char:WaitForChild("HumanoidRootPart", 5)
    if hrp then ParryRing.Adornee = hrp end
end)

----------------------------------------------------------------
-- UTILITY FUNCTIONS (ESP LOGIC) - OPTIMIZED
----------------------------------------------------------------
local function GetGameValue(obj, name)
    if typeof(obj) ~= "Instance" then return nil end 
    
    local attr = obj:GetAttribute(name)
    if attr ~= nil then return attr end
    local child = obj:FindFirstChild(name)
    if child then
        if child:IsA("ValueBase") then 
            return child.Value 
        end
    end
    
    return nil
end

local function CreateBillboardTag(text, color, size, textSize)
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "TagESP"
    billboard.AlwaysOnTop = true
    billboard.Size = size or UDim2.new(0, 150, 0, 40)
    billboard.LightInfluence = 0 
    billboard.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    local label = Instance.new("TextLabel")
    label.Name = "Label"
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = color
    label.Font = Enum.Font.GothamBold
    label.TextSize = textSize or 12
    label.TextWrapped = true
    label.RichText = true 
    
    local stroke = Instance.new("UIStroke")
    stroke.Thickness = 1.2
    stroke.Color = Color3.new(0, 0, 0)
    stroke.Transparency = 0.2
    stroke.Parent = label
    
    label.Parent = billboard
    
    return billboard
end
local isFPP = false
local fppHideConn = nil 
local function SwitchCameraMode(toFPP)
    local lp = Players.LocalPlayer
    
    if toFPP then
        lp.CameraMode = Enum.CameraMode.LockFirstPerson
        
        if not fppHideConn then
            fppHideConn = RunService.RenderStepped:Connect(function()
                local char = lp.Character
                if char then
                    local head = char:FindFirstChild("Head")
                    if head then head.LocalTransparencyModifier = 1 end
                    
                    for _, obj in ipairs(char:GetChildren()) do
                        if obj:IsA("Accessory") then
                            local handle = obj:FindFirstChild("Handle")
                            if handle then handle.LocalTransparencyModifier = 1 end
                        end
                    end
                    
                    local hrp = char:FindFirstChild("HumanoidRootPart")
                    local hum = char:FindFirstChild("Humanoid")
                    local cam = workspace.CurrentCamera
                    
                    if hrp and hum and cam then
                        hum.AutoRotate = false 
                        
                        local lookY = select(2, cam.CFrame:ToEulerAnglesYXZ())
                        local currentLook = hrp.Orientation.Y
                        local targetLook = math.deg(lookY)
                        
                        if math.abs(currentLook - targetLook) > 1 then
                            hrp.CFrame = cnew(hrp.Position) * cangles(0, lookY, 0)
                        end
                    end
                end
            end)
        end
    else
        lp.CameraMode = Enum.CameraMode.Classic
        lp.CameraMaxZoomDistance = 128 
        
        local char = lp.Character
        local hum = char and char:FindFirstChild("Humanoid")
        if hum then hum.AutoRotate = true end
        
        if fppHideConn then
            fppHideConn:Disconnect()
            fppHideConn = nil
        end
        
        local char = lp.Character
        if char then
            local head = char:FindFirstChild("Head")
            if head then
                head.LocalTransparencyModifier = 0
            end
        
            for _, obj in ipairs(char:GetChildren()) do
                if obj:IsA("Accessory") then
                    local handle = obj:FindFirstChild("Handle")
                    if handle then
                        handle.LocalTransparencyModifier = 0
                    end
                end
            end
        end
    end
end
local function ApplyHighlight(object,color)
    local h=object:FindFirstChild("H")
    if not h then
        h=Instance.new("Highlight")
        h.Name="H"
        h.Adornee=object
        h.DepthMode=Enum.HighlightDepthMode.AlwaysOnTop
        h.FillTransparency=0.82
        h.OutlineTransparency=0.03
        h.LineThickness=2
        h.Parent=object
    end
    if h.FillColor~=color then
        h.FillColor=color
        h.OutlineColor=color:Lerp(Color3.new(1,1,1),0.15)
    end
    local root=
        object:FindFirstChild("HumanoidRootPart")
        or object.PrimaryPart

    local myRoot=
        LocalPlayer.Character
        and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")

    if root and myRoot then
        local dist=(root.Position-myRoot.Position).Magnitude
        if dist>120 then
            h.FillTransparency=0.92
            h.OutlineTransparency=0
        elseif dist>70 then
            h.FillTransparency=0.88
            h.OutlineTransparency=0.02
        else
            h.FillTransparency=0.82
            h.OutlineTransparency=0.05
        end
    end
    if not h.Enabled then
        h.Enabled=true
    end
end

local function RemoveHighlight(object)
    if object then
        local h = object:FindFirstChild("H")
        if h then h:Destroy() end
    end
end

local ESP_PlayerCache = {}

local function RemovePlayerESP(player)
    if player and player.Character then
        local root = player.Character:FindFirstChild("HumanoidRootPart")
        if root then
            local tag = root:FindFirstChild("TagESP")
            if tag then tag:Destroy() end
        end
        RemoveHighlight(player.Character)
    end
    if ESP_PlayerCache then
        ESP_PlayerCache[player.UserId] = nil
    end
end

local function CreatePlayerESP(player,isKiller)
    local char=player.Character
    local root=char and char:FindFirstChild("HumanoidRootPart")
    local hum=char and char:FindFirstChild("Humanoid")

    if not root or not hum or hum.Health<=0 then
        RemovePlayerESP(player)
        ESP_PlayerCache[player.UserId]=nil
        return
    end

    local myRoot=LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not myRoot then
        return
    end

    local dist=m_floor((root.Position-myRoot.Position).Magnitude)
    local color=isKiller and ESP_COLORS.Killer or ESP_COLORS.Survivor
    local statusText=""

    if isKiller then
        local detectedMask=
            char:GetAttribute("CachedMask")
            or char:GetAttribute("KillerType")
            or char:GetAttribute("SelectedKiller")
            or GetGameValue(char,"SelectedKiller")
            or GetGameValue(player,"SelectedKiller")
            or GetGameValue(char,"Mask")
            or GetGameValue(player,"Mask")
            or char.Name
    
        if detectedMask then
            char:SetAttribute("CachedMask",detectedMask)
        end
    
        statusText=MaskNames[detectedMask] or "KILLER"
        color=MaskColors[detectedMask] or color
    
    else
        local function IsActive(v)
            return v==true or (type(v)=="number" and v>0)
        end
    
        local hooked=
            IsActive(GetGameValue(char,"IsHooked"))
            or IsActive(GetGameValue(player,"IsHooked"))
    
        local carried=
            IsActive(GetGameValue(char,"Carried"))
            or IsActive(GetGameValue(char,"IsCarried"))
            or IsActive(GetGameValue(char,"Grabbed"))
            or IsActive(GetGameValue(player,"Carried"))
    
        local knocked=
            IsActive(GetGameValue(char,"Knocked"))
            or IsActive(GetGameValue(char,"IsKnocked"))
    
        if hooked then
            color=Color3.fromRGB(255,70,140)
            statusText="HOOKED"
        elseif carried then
            color=Color3.fromRGB(190,90,255)
            statusText="CARRIED"
        elseif knocked then
            color=Color3.fromRGB(255,170,0)
            statusText="KNOCKED"
        elseif hum.Health<hum.MaxHealth then
            color=Color3.fromRGB(255,225,80)
            statusText="INJURED"
        else
            statusText=nil
            color=ESP_COLORS.Survivor
        end
    end
    
    local bottomText

    if isKiller then
        bottomText=s_format(
            '<font color="#DCDCDC">%dm</font> • <font color="#%s">[%s]</font>',
            dist,
            color:ToHex(),
            string.upper(statusText)
        )
    elseif statusText then
        bottomText=s_format(
            '<font color="#DCDCDC">%dm</font> • <font color="#%s">%s</font>',
            dist,
            color:ToHex(),
            statusText
        )
    else
        bottomText=s_format(
            '<font color="#DCDCDC">%dm</font>',
            dist
        )
    end
    
    local finalName=s_format(
        '<b>@%s</b>\n%s',
        player.Name,
        bottomText
    )
    
    ESP_PlayerCache[player.UserId]={
        dist=dist,
        status=statusText
    }

    local showName=
        isKiller and ESP_Killer_Name
        or ESP_Survivor_Name

    local showHighlight=
        isKiller and ESP_Killer_Highlight
        or ESP_Survivor_Highlight

    if showHighlight then
        ApplyHighlight(char,color)
    else
        RemoveHighlight(char)
    end

    local bg=root:FindFirstChild("TagESP")

    if showName then
        if not bg then
            bg=Instance.new("BillboardGui")
            bg.Name="TagESP"
            bg.Parent=root
            bg.Adornee=root
            bg.AlwaysOnTop=true
            bg.LightInfluence=0
            bg.ResetOnSpawn=false
            bg.MaxDistance=1800
            bg.Size=UDim2.new(0,165,0,34)
            bg.StudsOffset=v3(0,3.8,0)
        
            local lbl=Instance.new("TextLabel")
            lbl.Name="Label"
            lbl.Parent=bg
            lbl.Size=UDim2.new(1,0,1,0)
            lbl.BackgroundTransparency=1
            lbl.Font=Enum.Font.GothamBold
            lbl.TextSize=13
            lbl.RichText=true
            lbl.TextColor3=color
            lbl.TextWrapped=true
        
            local labelStroke=Instance.new("UIStroke")
            labelStroke.Thickness=1.2
            labelStroke.Color=Color3.new(0,0,0)
            labelStroke.Transparency=0.2
            labelStroke.Parent=lbl
        end
    
        local lbl=bg:FindFirstChild("Label")
        if lbl then
            lbl.Text=finalName
            lbl.TextColor3=color
        end
    else
        if bg then bg:Destroy() end
    end
end

local function updateGeneratorProgress(obj)
    if not(obj and obj.Parent) then return true end
    
    local progress=
        GetGameValue(obj,"Progress")
        or GetGameValue(obj,"GeneratorProgress")
        or GetGameValue(obj,"Charges")
        or GetGameValue(obj,"Value")
        or 0
    
    local maxProg=
        GetGameValue(obj,"MaxProgress")
        or GetGameValue(obj,"MaxCharges")
        or 100
    
    local pct=math.clamp(progress/math.max(maxProg,1)*100,0,100)
    
    local finished=(pct>=99.5)
    
    if finished then
        RemoveHighlight(obj)
        local b=obj:FindFirstChild("GenBitchHook")
        if b then b:Destroy() end
        return true
    end
    
    local finalColor
    if pct<33 then
        finalColor=Color3.fromRGB(255,60,60)
    elseif pct<66 then
        finalColor=Color3.fromRGB(255,200,0)
    else
        finalColor=Color3.fromRGB(80,220,80)
    end
    
    ApplyHighlight(obj,finalColor)
    
    local percentStr=s_format("<b>%d%%</b>",m_round(pct))
    
    local billboard=obj:FindFirstChild("GenBitchHook")
    
    if not billboard then
        billboard=Instance.new("BillboardGui")
        billboard.Name="GenBitchHook"
        billboard.AlwaysOnTop=true
        billboard.LightInfluence=0
        billboard.MaxDistance=200
        billboard.ZIndexBehavior=Enum.ZIndexBehavior.Sibling
        
        local lbl=Instance.new("TextLabel")
        lbl.Name="Label"
        lbl.Size=UDim2.new(1,0,1,0)
        lbl.BackgroundTransparency=1
        lbl.Font=Enum.Font.GothamBold
        lbl.TextSize=14
        lbl.RichText=true
        lbl.TextWrapped=true
        lbl.Parent=billboard
        
        local s2=Instance.new("UIStroke")
        s2.Thickness=1.5
        s2.Color=Color3.new(0,0,0)
        s2.Transparency=0.2
        s2.Parent=lbl
        
        billboard.Parent=obj
    end
    
    local targetPart=
        (obj:IsA("Model") and obj.PrimaryPart)
        or obj:FindFirstChildWhichIsA("BasePart",true)
        or (obj:IsA("BasePart") and obj)
    
    if targetPart then
        billboard.Adornee=targetPart
        
        local yOffset=pcall(function()
            return targetPart.Size.Y/2+
                math.random(
                    2.8*10,
                    4.2*10
                )/10
        end)
        
        billboard.StudsOffset=v3(0,4,0)
    
        local lbl=billboard:FindFirstChild("Label")
    
        if lbl then
            lbl.Text=percentStr
            lbl.TextColor3=finalColor
        end
    end
    return false
end
local function RefreshESP()
    if not workspace.CurrentCamera then
        return
    end
    local players = Players:GetPlayers()
    for _, p in ipairs(players) do
        if p ~= LocalPlayer then
            local team = p.Team
            local isKiller = false
            if team and team.Name then
                isKiller = string.find(string.lower(team.Name), "killer") ~= nil
            end
            local shouldESP = false
            if isKiller and (ESP_Killer_Name or ESP_Killer_Highlight) then
                shouldESP = true
            elseif not isKiller and (ESP_Survivor_Name or ESP_Survivor_Highlight) then
                shouldESP = true
            end
            
            if shouldESP then
                CreatePlayerESP(p, isKiller)
            else
                RemovePlayerESP(p)
            end
        end
    end

    if not CachedMapObjects then return end
    
    if ESP_Generator then
        if not PrevESPState.Generator then PrevESPState.Generator = true end
        local gens = CachedMapObjects.Generators
        
        local newActiveGens = {} 
        for i = 1, #gens do
            local obj = gens[i]
            if obj and obj.Parent then
                local isFinished = updateGeneratorProgress(obj)
                if not isFinished then
                    t_insert(newActiveGens, obj)
                end
            end
        end
        CachedMapObjects.Generators = newActiveGens
        ActiveGenerators = newActiveGens
    elseif PrevESPState.Generator then 
        local gens = CachedMapObjects.Generators
        for _, obj in ipairs(gens) do
            if obj and obj.Parent then
                RemoveHighlight(obj)
                local b = obj:FindFirstChild("GenBitchHook")
                if b then b:Destroy() end
                if obj:GetAttribute("LastESPPercent") then obj:SetAttribute("LastESPPercent", nil) end
            end
        end
        PrevESPState.Generator = false
    end
    
    if ESP_Pallet then
        if not PrevESPState.Pallet then PrevESPState.Pallet = true end 
        local pallets = CachedMapObjects.Pallets
        local MAX_DISTANCE = 140

        for i = #pallets, 1, -1 do 
            local pallet = pallets[i]
            local isValid = pallet and pallet.Parent and pallet:IsDescendantOf(workspace)
            
            if isValid then
                local targetPart = (pallet:IsA("Model") and pallet.PrimaryPart) 
                                or pallet:FindFirstChildWhichIsA("BasePart", true) 
                                or (pallet:IsA("BasePart") and pallet)
                
                local hasVisibleParts = false
                if targetPart then
                    if pallet:IsA("BasePart") then
                        hasVisibleParts = pallet.Transparency < 1
                    else
                        local parts = pallet:GetDescendants()
                        for j = 1, #parts do
                            local p = parts[j]
                            if p:IsA("BasePart") and p.Transparency < 1 then
                                hasVisibleParts = true
                                break
                            end
                        end
                    end
                end
                
                local nLower = string.lower(pallet.Name)
                local function IsActive(val) return val == true or (type(val) == "number" and val > 0) end
                
                local isDropped = IsActive(GetGameValue(pallet, "Dropped")) or IsActive(GetGameValue(pallet, "IsDropped"))
                local isBroken = IsActive(GetGameValue(pallet, "Broken")) or IsActive(GetGameValue(pallet, "IsBroken")) or IsActive(GetGameValue(pallet, "Destroyed"))
                local isFake = string.find(nLower, "fake") or string.find(nLower, "broken") or string.find(nLower, "destroyed")
                
                if isDropped or isBroken or isFake or not hasVisibleParts or not targetPart then
                    local tag = pallet:FindFirstChild("PalletTag")
                    if tag then tag:Destroy() end 
                    
                    if isDropped or isBroken or isFake then
                        t_remove(pallets, i)
                    end
                else
                    local tag = pallet:FindFirstChild("PalletTag")
                    if not tag then 
                        local b = CreateBillboardTag("<b>[PALLET]</b>", ESP_COLORS.Pallet, UDim2.new(0, 50, 0, 18), 6)
                        b.Name = "PalletTag"
                        b.Parent = pallet
                        b.Adornee = targetPart
                        b.MaxDistance = MAX_DISTANCE 
                    else
                        if not tag.Adornee then tag.Adornee = targetPart end
                        local lbl = tag:FindFirstChild("Label")
                        if lbl and lbl.TextColor3 ~= ESP_COLORS.Pallet then
                            lbl.TextColor3 = ESP_COLORS.Pallet
                        end
                    end
                end
            else
                if pallet then
                    local tag = pallet:FindFirstChild("PalletTag")
                    if tag then tag:Destroy() end
                end
                t_remove(pallets, i) 
            end
        end 
    elseif PrevESPState.Pallet then 
        for _, pallet in ipairs(CachedMapObjects.Pallets) do 
            if pallet then 
                local tag = pallet:FindFirstChild("PalletTag")
                if tag then tag:Destroy() end 
            end 
        end
        PrevESPState.Pallet = false
    end

    if ESP_Gate then
        if not PrevESPState.Gate then PrevESPState.Gate = true end
        local gates = CachedMapObjects.Gates
        for i = #gates, 1, -1 do 
            local gate = gates[i]
            if gate and gate.Parent then
                ApplyHighlight(gate, ESP_COLORS.Gate) 
            else
                t_remove(gates, i)
            end
        end 
    elseif PrevESPState.Gate then 
        for _, gate in ipairs(CachedMapObjects.Gates) do if gate and gate.Parent then RemoveHighlight(gate) end end
        PrevESPState.Gate = false
    end

    if ESP_Hook then
        if not PrevESPState.Hook then PrevESPState.Hook = true end
        local hooks = CachedMapObjects.Hooks
        for i = #hooks, 1, -1 do 
            local hook = hooks[i]
            if hook and hook.Parent then
                local m = hook:FindFirstChild("Model") 
                if m then 
                    for _, p in ipairs(m:GetDescendants()) do 
                        if p:IsA("MeshPart") then ApplyHighlight(p, ESP_COLORS.Hook) end 
                    end 
                else
                    ApplyHighlight(hook, ESP_COLORS.Hook)
                end
            else
                t_remove(hooks, i)
            end
        end 
    elseif PrevESPState.Hook then 
        for _, hook in ipairs(CachedMapObjects.Hooks) do 
            if hook and hook.Parent then 
                local m = hook:FindFirstChild("Model") 
                if m then 
                    for _, p in ipairs(m:GetDescendants()) do 
                        if p:IsA("MeshPart") then RemoveHighlight(p) end 
                    end 
                else
                    RemoveHighlight(hook)
                end
            end 
        end
        PrevESPState.Hook = false
    end
end

local cachedRayFilter = {}

local function IsVisible(targetPart)
    if not WallCheck then return true end
    
    local cam = workspace.CurrentCamera
    local origin = cam.CFrame.Position
    local direction = (targetPart.Position - origin)
    local myChar = LocalPlayer.Character
    
    table.clear(cachedRayFilter)
    if cam then table.insert(cachedRayFilter, cam) end
    if myChar then table.insert(cachedRayFilter, myChar) end
    
    aimRayParams.FilterDescendantsInstances = cachedRayFilter
    
    local result = workspace:Raycast(origin, direction, aimRayParams)
    
    if result then 
        return result.Instance:IsDescendantOf(targetPart.Parent) 
    end
    
    return true
end
local function ResetScope()
    local char=LocalPlayer.Character
    if not char then return end
    local hum=char:FindFirstChild("Humanoid")
    if hum then
        for _,track in ipairs(hum:GetPlayingAnimationTracks()) do
            local anim=track.Animation
            local name=((anim and anim.Name) or ""):lower()
            if name:find("aim") or name:find("scope") or name:find("gun") then
                pcall(function() track:Stop(0) end)
            end
        end
    end
    workspace.CurrentCamera.FieldOfView=70
end

----------------------------------------------------------------
-- TARGET FINDER
----------------------------------------------------------------

local function GetClosestSilentTarget()
    local camera=workspace.CurrentCamera
    local center=camera.ViewportSize*0.5
    local closest=nil
    local shortest=SilentAimFOV or 250

    local myTeam=(LocalPlayer.Team and LocalPlayer.Team.Name:lower()) or ""
    local survivor=not myTeam:find("killer")

    if not survivor then return nil end

    for _,p in ipairs(Players:GetPlayers()) do
        if p==LocalPlayer or not p.Character then continue end

        local enemyTeam=(p.Team and p.Team.Name:lower()) or ""
        if not enemyTeam:find("killer") then continue end

        local char=p.Character
        local root=char:FindFirstChild("HumanoidRootPart")
        local hum=char:FindFirstChildOfClass("Humanoid")

        if not (root and hum and hum.Health>0) then continue end

        local pos,visible=camera:WorldToViewportPoint(root.Position)
        if not visible then continue end

        if WallCheck and not IsVisible(root) then continue end

        local dist=(Vector2.new(pos.X,pos.Y)-center).Magnitude
        if dist<shortest then
            shortest=dist
            closest=root
        end
    end

    return closest
end

local function GetClosestPlayer(currentTarget)
    local camera = workspace.CurrentCamera
    local center = camera.ViewportSize * 0.5
    local shortest = AimRadius
    local myTeam=(LocalPlayer.Team and LocalPlayer.Team.Name:lower()) or ""
    local isKiller = myTeam:find("killer")
    local camPos = camera.CFrame.Position

    if currentTarget and currentTarget.Parent then
        local hum=currentTarget.Parent:FindFirstChildOfClass("Humanoid")
        if hum and hum.Health > 0 then
            local pos,visible=camera:WorldToViewportPoint(currentTarget.Position)
            if visible then
                local dist=(Vector2.new(pos.X,pos.Y)-center).Magnitude
                if dist<=AimRadius then
                    if not WallCheck or IsVisible(currentTarget) then
                        return currentTarget
                    end
                end
            end
        end
    end

    for _,p in ipairs(Players:GetPlayers()) do
        if p == LocalPlayer or not p.Character then continue end

        local char = p.Character
        local hum = char:FindFirstChild("Humanoid")
        if not hum or hum.Health <= 0 then continue end

        local enemyTeam=(p.Team and p.Team.Name:lower()) or ""
        local enemyKiller=enemyTeam:find("killer")

        if isKiller and enemyKiller then continue end
        if not isKiller and not enemyKiller then continue end

        if isKiller then
            if GetGameValue(char,"Knocked") or GetGameValue(char,"IsHooked") then continue end
        end

        local targetPart=TargetPartCache[char]
        
        if not targetPart or not targetPart.Parent then
            targetPart=
                (getgenv().AimbotPart=="Head" and char:FindFirstChild("Head"))
                or (getgenv().AimbotPart=="Body (RootPart)" and char:FindFirstChild("HumanoidRootPart"))
                or char:FindFirstChild("UpperTorso")
                or char:FindFirstChild("Torso")
                or char:FindFirstChild("HumanoidRootPart")
                or char.PrimaryPart
            TargetPartCache[char]=targetPart
        end

        if not targetPart then continue end

        if (targetPart.Position - camPos).Magnitude > AimDistance then continue end

        local pos,visible=camera:WorldToViewportPoint(targetPart.Position)
        if not visible then continue end

        local dist=(Vector2.new(pos.X,pos.Y)-center).Magnitude
        if dist<shortest then
            if not WallCheck or IsVisible(targetPart) then
                shortest=dist
                CachedTarget=targetPart
            end
        end
    end

    return CachedTarget
end

----------------------------------------------------------------
-- PLATFORM
----------------------------------------------------------------

local IsMobile =
    UserInputService.TouchEnabled
    and not UserInputService.KeyboardEnabled

----------------------------------------------------------------
-- PRESS SKILL
----------------------------------------------------------------

local LastTriggerTick=0

local function PressSkill()
    if tick()-LastTriggerTick<0.08 then return end
    LastTriggerTick=tick()

    if IsMobile then
        local btn=PlayerGui:FindFirstChild("check",true)
        if btn and btn:IsA("GuiObject") then
            local pos=btn.AbsolutePosition
            local size=btn.AbsoluteSize
            local inset=GuiService:GetGuiInset()
            local x=pos.X+(size.X/2)+inset.X
            local y=pos.Y+(size.Y/2)+inset.Y

            pcall(function()
                VirtualInputManager:SendTouchEvent(8822,Enum.UserInputState.Begin.Value,x,y)
                task.wait()
                VirtualInputManager:SendTouchEvent(8822,Enum.UserInputState.End.Value,x,y)
            end)

            pcall(function()
                if firesignal and btn.MouseButton1Click then
                    firesignal(btn.MouseButton1Click)
                end
            end)
        end
    else
        pcall(function()
            VirtualInputManager:SendKeyEvent(true,Enum.KeyCode.Space,false,game)
            task.wait()
            VirtualInputManager:SendKeyEvent(false,Enum.KeyCode.Space,false,game)
        end)
    end
end

----------------------------------------------------------------
-- GET ACTIVE SKILLCHECK
----------------------------------------------------------------

local function GetSkillCheck()
    for _,guiName in ipairs({"SkillCheckPromptGui","SkillCheckPromptGui-con"}) do
        local gui=PlayerGui:FindFirstChild(guiName,true)
        if gui then
            local check=gui:FindFirstChild("Check",true)
            if check and check.Visible then
                local line=check:FindFirstChild("Line",true)
                local goal=check:FindFirstChild("Goal",true)
                if line and goal then
                    return line,goal
                end
            end
        end
    end
end

----------------------------------------------------------------
-- AUTO GENERATOR MAIN
----------------------------------------------------------------

local LastSkillHit=0
local LastGoalRotation=0
local HeartbeatConnections={}

local function ForceUnstuck()
    local char=workspace:FindFirstChild(LocalPlayer.Name) or LocalPlayer.Character
    local hum=char and char:FindFirstChildOfClass("Humanoid")
    local root=char and char:FindFirstChild("HumanoidRootPart")

    if not(char and hum and root) then return end

    for _,track in ipairs(hum:GetPlayingAnimationTracks()) do
        local anim=track.Animation
        local name=((anim and anim.Name) or ""):lower()
        if name:find("repair") or name:find("generator") or name:find("fix") or name:find("interaction") then
            pcall(function() track:Stop(0) end)
        end
    end

    for _,v in ipairs({"Repairing","IsRepairing","Interacting","Busy","Action","Using"}) do
        pcall(function()
            if char:GetAttribute(v)~=nil then char:SetAttribute(v,false) end
            local obj=char:FindFirstChild(v)
            if obj and obj:IsA("ValueBase") then
                if typeof(obj.Value)=="boolean" then obj.Value=false
                elseif typeof(obj.Value)=="number" then obj.Value=0 end
            end
        end)
    end

    root.Anchored=false
    hum.PlatformStand=false
    hum.AutoRotate=true
    hum.Sit=false
    hum:ChangeState(Enum.HumanoidStateType.Running)
end

if GenConnection then GenConnection:Disconnect() end

GenConnection=RunService.Heartbeat:Connect(function()
    if not AutoGenerator then return end

    local line,goal=GetSkillCheck()
    if not(line and goal) then return end

    local lr=line.Rotation%360
    local gr=goal.Rotation%360

    local goalVelocity=math.abs(gr-LastGoalRotation)
    LastGoalRotation=gr

    local dynamicOffset=math.clamp(goalVelocity*0.35,0,8)

    local startPos,endPos

    if AutoGeneratorMode=="Neutral" then
        startPos=(gr+96-dynamicOffset)%360
        endPos=(gr+122+dynamicOffset)%360
    else
        startPos=(gr+(getgenv().GeneratorPerfectOffsetStart or 102)-dynamicOffset)%360
        endPos=(gr+(getgenv().GeneratorPerfectOffsetEnd or 109)+dynamicOffset)%360
    end

    local inside=false
    if startPos>endPos then
        inside=(lr>=startPos or lr<=endPos)
    else
        inside=(lr>=startPos and lr<=endPos)
    end

    if inside then
        LastSkillHit=tick()
        PressSkill()
    end
end)

task.spawn(function()
    while task.wait(0.25) do
        if not AutoGenerator then continue end
        local line=GetSkillCheck()
        if not line and tick()-LastSkillHit>1.1 then
            pcall(function() ForceUnstuck() end)
        end
    end
end)

local function TriggerAntiStuck()
    pcall(function()
        local char=workspace:FindFirstChild(LocalPlayer.Name) or LocalPlayer.Character
        local hum=char and char:FindFirstChildOfClass("Humanoid")
        local root=char and char:FindFirstChild("HumanoidRootPart")
        local cam=workspace.CurrentCamera

        pcall(function()
            local remotes=ReplicatedStorage:FindFirstChild("Remotes")
            if not remotes then return end
            local healing=remotes:FindFirstChild("Healing")
            local reset=healing and healing:FindFirstChild("Reset")
            if reset then reset:FireServer() end
        end)

        if hum and root then
            root.Anchored=false
            hum.PlatformStand=false
            hum.AutoRotate=true
            hum.Sit=false
            hum:ChangeState(Enum.HumanoidStateType.GettingUp)
            hum.WalkSpeed=SpeedBoost and (17+(17*((tonumber(BoostSpeed) or 0)/100))) or 17

            for _,track in ipairs(hum:GetPlayingAnimationTracks()) do
                pcall(function() track:Stop(0) end)
            end

            local badStates={"Stunned","IsStunned","Healing","IsHealing","Repairing","IsRepairing","Interacting","Attacking","Using","Busy","Action"}
            for _,v in ipairs(badStates) do
                if char:GetAttribute(v)~=nil then char:SetAttribute(v,false) end
                local obj=char:FindFirstChild(v)
                if obj and obj:IsA("ValueBase") then
                    pcall(function()
                        if typeof(obj.Value)=="boolean" then obj.Value=false
                        elseif typeof(obj.Value)=="number" then obj.Value=0 end
                    end)
                end
            end

            local map=workspace:FindFirstChild("Map")
            if map then
                local genFolder=map:FindFirstChild("new Generators") or map:FindFirstChild("Generators")
                if genFolder then
                    local nearestGen,nearestDist
                    for _,gen in ipairs(genFolder:GetChildren()) do
                        local part=gen:FindFirstChildWhichIsA("BasePart",true)
                        if part then
                            local dist=(root.Position-part.Position).Magnitude
                            if not nearestDist or dist<nearestDist then
                                nearestDist=dist
                                nearestGen=part
                            end
                        end
                    end

                    if nearestGen and nearestDist<=15 then
                        local dir=(root.Position-nearestGen.Position).Unit
                        if dir.Magnitude<=0 then dir=root.CFrame.LookVector end
                        local escapePos=root.Position+(dir*20)
                        root.CFrame=CFrame.new(escapePos,escapePos+root.CFrame.LookVector)
                    end
                end
            end

            task.wait()
            hum:ChangeState(Enum.HumanoidStateType.Running)
            hum.Jump=true

            if cam and cam.CameraType~=Enum.CameraType.Custom then
                cam.CameraType=Enum.CameraType.Custom
                cam.CameraSubject=hum
            end
        end

        WindUI:Notify({Title="Anti-Stuck Triggered",Content="Character released from generator/stuck state!"})
    end)
end

-- =========================================================
-- ============================================================
-- MACLIB UI — PENGGANTI TOTAL WINDUI
-- ============================================================
-- =========================================================

local Window = MacLib:Window({
    Title    = "RYEENZY | HUB",
    Subtitle = "by Ryeenzydevs",
    Size     = UDim2.fromOffset(868, 650),
    DragStyle = 2,
    ShowUserInfo = false,
    Keybind  = Enum.KeyCode.RightControl,
})
local _TabGroup = Window:TabGroup()

-- =========================================================
-- TAB SETUP
-- =========================================================
local TabProfile = _TabGroup:Tab({ Name = "Profile", Image = "" })
local _s_TabProfile = TabProfile:Section({ Side = "Left" })
local TabExtras = _TabGroup:Tab({ Name = "Extras", Image = "" })
local _s_TabExtras = TabExtras:Section({ Side = "Left" })
local TabGen = _TabGroup:Tab({ Name = "Generator", Image = "" })
local _s_TabGen = TabGen:Section({ Side = "Left" })
local TabSurvivor = _TabGroup:Tab({ Name = "Survivor", Image = "" })
local _s_TabSurvivor = TabSurvivor:Section({ Side = "Left" })
local TabKiller = _TabGroup:Tab({ Name = "Killer", Image = "" })
local _s_TabKiller = TabKiller:Section({ Side = "Left" })
local TabCombat = _TabGroup:Tab({ Name = "Combat", Image = "" })
local _s_TabCombat = TabCombat:Section({ Side = "Left" })
local TabVisuals = _TabGroup:Tab({ Name = "Visuals", Image = "" })
local _s_TabVisuals = TabVisuals:Section({ Side = "Left" })
local TabSpoof = _TabGroup:Tab({ Name = "Spoofing", Image = "" })
local _s_TabSpoof = TabSpoof:Section({ Side = "Left" })
local TabSettings = _TabGroup:Tab({ Name = "Settings", Image = "" })
local _s_TabSettings = TabSettings:Section({ Side = "Left" })

-- =========================================================
-- TAB: PROFILE
-- =========================================================
local _s_TabProfile_1 = TabProfile:Section({ Side = "Left" })
_s_TabProfile_1:Label({ Text = "Profile Dashboard" })

local executorName =
    (identifyexecutor and identifyexecutor()) or
    (getexecutorname and getexecutorname()) or
    "Unknown"
local deviceType =
    (UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled)
    and "Mobile" or "PC"

_s_TabProfile_1:Label({ Text = "User: " .. LocalPlayer.DisplayName .. " (@" .. LocalPlayer.Name .. ")" })
_s_TabProfile_3:Label({ Text = "User ID: " .. tostring(LocalPlayer.UserId) })
_s_TabProfile_3:Label({ Text = "Account Age: " .. tostring(LocalPlayer.AccountAge) .. " Days" })

local _s_TabProfile_2 = TabProfile:Section({ Side = "Left" })
_s_TabProfile_2:Label({ Text = "System Info" })
_s_TabProfile_2:Label({ Text = "Key: RYEENZY" })
_s_TabProfile_2:Label({ Text = "License: RYEENZY" })
_s_TabProfile_3:Label({ Text = "Device: " .. deviceType })
_s_TabProfile_3:Label({ Text = "Executor: " .. executorName })

local _s_TabProfile_3 = TabProfile:Section({ Side = "Left" })
_s_TabProfile_3:Label({ Text = "Credits" })
_s_TabProfile_3:Label({ Text = "RYEENZYEXP — Script Creator" })
_s_TabProfile_3:Button({
    Name     = "Copy Discord Link",
    Callback = function()
        local success = pcall(function()
            setclipboard("https://discord.gg/wCVUTHgsQV")
        end)
        WindUI:Notify({
            Title   = success and "Success" or "Clipboard Failed",
            Content = success and "Discord link copied!" or "Executor tidak support clipboard.",
        })
    end
})

-- =========================================================
-- TAB: EXTRAS (VIP — Automation, Moonwalk, Defense)
-- =========================================================
local _s_TabExtras_4 = TabExtras:Section({ Side = "Left" })
_s_TabExtras_4:Label({ Text = "Automatic System" })

_s_TabExtras_4:Toggle({
    Name    = "Auto Play (Smart AI)",
    Default = false,
    Callback = function(v)
        AutoFarmBot = v
        if v then
            AutoGenerator = true
            AutoGeneratorMode = "Perfect"
            WindUI:Notify({ Title = "AI Enabled", Content = "Smart survivor bot berhasil diaktifkan." })
        else
            local char = LocalPlayer.Character
            local hum = char and char:FindFirstChildOfClass("Humanoid")
            local root = char and char:FindFirstChild("HumanoidRootPart")
            if hum and root then hum:MoveTo(root.Position) end
            WindUI:Notify({ Title = "AI Disabled", Content = "Smart AI berhasil dimatikan." })
        end
    end
})

local _s_TabExtras_5 = TabExtras:Section({ Side = "Left" })
_s_TabExtras_5:Label({ Text = "MoonWalk" })

_s_TabExtras_5:Toggle({
    Name    = "Moonwalk",
    Default = false,
    Callback = function(v)
        getgenv().MoonwalkEnabled = v
        if MoonwalkUI then MoonwalkUI.Enabled = v end
        if not v and cachedHum then cachedHum.AutoRotate = true end
        WindUI:Notify({
            Title   = v and "Moonwalk Enabled" or "Moonwalk Disabled",
            Content = v and "Tekan R untuk zigzag." or "Moonwalk dimatikan.",
        })
    end
})

_s_TabExtras_5:Slider({
    Name    = "MoonWalk Intensity",
    Minimum = 5,
    Maximum = 50,
    Default = 11,
    Increment = 1,
    ValueName = "x",
    Callback = function(v)
        getgenv().MoonwalkZigzagSpeed = v
    end
})

_s_TabExtras_5:Slider({
    Name      = "Speed Boost MoonWalk",
    Minimum = 100,
    Maximum = 150,
    Default   = 108,
    Increment = 1,
    ValueName = "%",
    Callback  = function(v)
        getgenv().MoonwalkBoostPower = v / 100
    end
})

local _s_TabExtras_6 = TabExtras:Section({ Side = "Left" })
_s_TabExtras_6:Label({ Text = "Item VIP" })

_s_TabExtras_6:Toggle({
    Name    = "Silent Aim Pistol",
    Default = false,
    Callback = function(v)
        SilentAimPistol = v
        if not v then SilentTarget = nil; ResetScope() end
        WindUI:Notify({
            Title   = v and "Silent Aim Enabled" or "Silent Aim Disabled",
            Content = v and "Auto lock aktif." or "Silent Aim dimatikan.",
        })
    end
})

_s_TabExtras_6:Toggle({
    Name    = "Auto Dagger",
    Default = false,
    Callback = function(v)
        AutoParry = v
        WindUI:Notify({ Title = "Auto Dagger", Content = v and "Enabled" or "Disabled" })
    end
})

_s_TabExtras_6:Dropdown({
    Name    = "Killer Matchup",
    Default = "Auto",
    Options = {"Auto","Abysswalker","Hidden","Killer","Masked","Stalker","Veil","Slasher","Cure"},
    Callback = function(v)
        getgenv().ParryMatchup = v
    end
})

_s_TabExtras_6:Slider({
    Name      = "Parry Distance",
    Minimum = 3,
    Maximum = 25,
    Default   = 10,
    Increment = 1,
    ValueName = " studs",
    Callback  = function(v)
        ParryDistance = math.clamp(v, 3, 20)
        local ring = TargetGui:FindFirstChild("RYEENZY_ParryRing")
        if ring then ring.Radius = ParryDistance end
    end
})

_s_TabExtras_6:Slider({
    Name      = "Aim Strictness",
    Minimum = 5,
    Maximum = 30,
    Default   = 13,
    Increment = 1,
    ValueName = "x0.1",
    Callback  = function(v)
        getgenv().AimStrictness = math.clamp(v / 10, 0.5, 3)
    end
})

_s_TabExtras_6:Slider({
    Name      = "Parry Delay (ms)",
    Minimum = -150,
    Maximum = 1000,
    Default   = 0,
    Increment = 10,
    ValueName = "ms",
    Callback  = function(v)
        getgenv().ParryDelayOffset = math.clamp(v, -150, 1000) / 1000
    end
})

local _s_TabExtras_7 = TabExtras:Section({ Side = "Left" })
_s_TabExtras_7:Label({ Text = "Survivor VIP" })

_s_TabExtras_7:Toggle({
    Name    = "Self Heal",
    Default = false,
    Callback = function(v)
        SelfHeal = v
        WindUI:Notify({
            Title   = v and "Self Heal Enabled" or "Self Heal Disabled",
            Content = v and "Heal remote diarahkan ke diri sendiri." or "Self Heal dimatikan.",
        })
    end
})

-- =========================================================
-- TAB: GENERATOR
-- =========================================================
local _s_TabGen_8 = TabGen:Section({ Side = "Left" })
_s_TabGen_8:Label({ Text = "Generator Logic" })

_s_TabGen_8:Toggle({
    Name    = "Auto Generator",
    Default = false,
    Callback = function(v)
        AutoGenerator = v
        if not v then
            for _, con in pairs(HeartbeatConnections) do
                pcall(function() con:Disconnect() end)
            end
            table.clear(HeartbeatConnections)
        end
    end
})

_s_TabGen_8:Dropdown({
    Name    = "SkillCheck Mode",
    Default = "Perfect",
    Options = {"Perfect","Neutral"},
    Callback = function(option)
        AutoGeneratorMode = option
        if option == "Perfect" then
            getgenv().GeneratorPerfectOffsetStart = 102
            getgenv().GeneratorPerfectOffsetEnd   = 108
        else
            getgenv().GeneratorPerfectOffsetStart = 102
            getgenv().GeneratorPerfectOffsetEnd   = 114
        end
    end
})

-- =========================================================
-- TAB: SURVIVOR
-- =========================================================
local _s_TabSurvivor_9 = TabSurvivor:Section({ Side = "Left" })
_s_TabSurvivor_9:Label({ Text = "Movement Modification" })

_s_TabSurvivor_9:Toggle({
    Name    = "Speed Boost",
    Default = false,
    Callback = function(v)
        SpeedBoost = v
    end
})

_s_TabSurvivor_9:Slider({
    Name      = "Speed Boost Power",
    Minimum = 0,
    Maximum = 150,
    Default   = 8,
    Increment = 1,
    ValueName = "%",
    Callback  = function(v)
        BoostSpeed = tonumber(v) or 0
    end
})

local _s_TabSurvivor_10 = TabSurvivor:Section({ Side = "Left" })
_s_TabSurvivor_10:Label({ Text = "More" })

_s_TabSurvivor_10:Toggle({
    Name    = "Silent Actions (Anti-Noise)",
    Default = false,
    Callback = function(v) SilentActions = v end
})

_s_TabSurvivor_10:Toggle({
    Name    = "Anti Fall Slow",
    Default = false,
    Callback = function(v) AntiFallDamage = v end
})

_s_TabSurvivor_10:Toggle({
    Name    = "Anti Aura (No Detect)",
    Default = false,
    Callback = function(v) getgenv().AntiAura = v end
})

_s_TabSurvivor_10:Toggle({
    Name    = "Notify Killer Stun",
    Default = false,
    Callback = function(v) NotifyStun = v end
})

_s_TabSurvivor_10:Button({
    Name     = "Force Reset State (Anti-Stuck)",
    Callback = function()
        TriggerAntiStuck()
    end
})

TabSurvivor:AddKeybind({
    Name    = "Anti-Stuck Hotkey",
    Default = "L",
    Callback = function()
        TriggerAntiStuck()
    end
})

-- =========================================================
-- TAB: KILLER
-- =========================================================
local _s_TabKiller_11 = TabKiller:Section({ Side = "Left" })
_s_TabKiller_11:Label({ Text = "Killer Advantages" })

_s_TabKiller_11:Toggle({
    Name    = "Double Damage Generator",
    Default = false,
    Callback = function(v) DoubleDamageGen = v end
})

_s_TabKiller_11:Button({
    Name     = "Activate Killer Power",
    Callback = function()
        pcall(function() ReplicatedStorage.Remotes.Killers.Killer.ActivatePower:FireServer() end)
    end
})

local _s_TabKiller_12 = TabKiller:Section({ Side = "Left" })
_s_TabKiller_12:Label({ Text = "Auto Attack" })

_s_TabKiller_12:Toggle({
    Name    = "Enable Auto Attack",
    Default = false,
    Callback = function(v) AutoAttack = v end
})

_s_TabKiller_12:Slider({
    Name      = "Attack Range (Studs)",
    Minimum = 5,
    Maximum = 25,
    Default   = 10,
    Increment = 1,
    ValueName = " studs",
    Callback  = function(v)
        AttackRange = tonumber(v) or 10
    end
})

-- =========================================================
-- TAB: COMBAT
-- =========================================================
local _s_TabCombat_13 = TabCombat:Section({ Side = "Left" })
_s_TabCombat_13:Label({ Text = "Targeting System" })

_s_TabCombat_13:Toggle({
    Name    = "Aimbot",
    Default = false,
    Callback = function(v)
        Aimbot = v
        if not v then CachedTarget = nil end
    end
})

_s_TabCombat_13:Dropdown({
    Name    = "Aimbot Target",
    Default = "Torso",
    Options = {"Head","Torso","Body (RootPart)"},
    Callback = function(v)
        getgenv().AimbotPart = v
    end
})

_s_TabCombat_13:Dropdown({
    Name    = "Aimbot Trigger",
    Default = "Hold to Lock",
    Options = {"Hold to Lock","Auto Lock (Always)"},
    Callback = function(v)
        getgenv().AimbotTrigger = v
    end
})

_s_TabCombat_13:Slider({
    Name      = "Aim Radius",
    Minimum = 30,
    Maximum = 150,
    Default   = 55,
    Increment = 5,
    ValueName = "px",
    Callback  = function(v)
        AimRadius = v
        if FOVCircle then
            FOVCircle.Size = UDim2.new(0, v*2, 0, v*2)
        end
    end
})

_s_TabCombat_13:Toggle({
    Name    = "Show Aim Radius",
    Default = false,
    Callback = function(v)
        ShowFOVCircle = v
        if FOVCircle then FOVCircle.Visible = v end
    end
})

local _s_TabCombat_14 = TabCombat:Section({ Side = "Left" })
_s_TabCombat_14:Label({ Text = "Killer Hitbox Modification" })

_s_TabCombat_14:Toggle({
    Name    = "Killer Hitbox",
    Default = false,
    Callback = function(v)
        HitboxExpander = v
        if not v then
            for _,p in ipairs(Players:GetPlayers()) do
                if p~=LocalPlayer and p.Character then
                    local hb=p.Character:FindFirstChild("RYEENZY_HITBOX")
                    if hb then hb:Destroy() end
                end
            end
        end
    end
})

_s_TabCombat_14:Slider({
    Name      = "Hitbox Size",
    Minimum = 2,
    Maximum = 50,
    Default   = 15,
    Increment = 1,
    ValueName = " studs",
    Callback  = function(v)
        HitboxSize = tonumber(v) or 15
    end
})

-- =========================================================
-- TAB: VISUALS
-- =========================================================
local _s_TabVisuals_15 = TabVisuals:Section({ Side = "Left" })
_s_TabVisuals_15:Label({ Text = "Camera Settings" })

_s_TabVisuals_15:Toggle({
    Name    = "Custom FOV",
    Default = false,
    Callback = function(v) CustomCameraFOV = v end
})

_s_TabVisuals_15:Slider({
    Name      = "Field Of View",
    Minimum = 70,
    Maximum = 120,
    Default   = 100,
    Increment = 1,
    ValueName = "°",
    Callback  = function(v)
        CameraFOVValue = tonumber(v) or 100
    end
})

_s_TabVisuals_15:Toggle({
    Name    = "FPP / TPP Mode",
    Default = false,
    Callback = function(v)
        local isMobileDevice = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled
        if isMobileDevice then
            if MobileRotateBtn then
                MobileRotateBtn.Visible = v
                if not v then
                    isFPP = false
                    SwitchCameraMode(false)
                    MobileRotateBtn.BackgroundColor3 = Color3.fromRGB(75,150,255)
                    MobileRotateBtn.Text = "TPP"
                end
            end
        else
            isFPP = v
            SwitchCameraMode(v)
        end
    end
})

local _s_TabVisuals_16 = TabVisuals:Section({ Side = "Left" })
_s_TabVisuals_16:Label({ Text = "Crosshair Settings" })

_s_TabVisuals_16:Toggle({
    Name    = "Crosshair",
    Default = false,
    Callback = function(v)
        local gui = getgenv().CrosshairGui
        if gui then gui.Enabled = v end
    end
})

_s_TabVisuals_16:Dropdown({
    Name    = "Crosshair Style",
    Default = "Dot",
    Options = {"Dot","Scope","Circle","Plus","Cross"},
    Callback = function(v)
        local gui = getgenv().CrosshairGui
        if gui and gui:FindFirstChild("Crosshair") then
            gui.Crosshair.Image = CrosshairImages[v]
        end
    end
})

_s_TabVisuals_16:Slider({
    Name      = "Crosshair Size",
    Minimum = 10,
    Maximum = 80,
    Default   = 28,
    Increment = 1,
    ValueName = "px",
    Callback  = function(v)
        local size = tonumber(v) or 28
        local gui = getgenv().CrosshairGui
        if gui and gui:FindFirstChild("Crosshair") then
            gui.Crosshair.Size = UDim2.new(0,size,0,size)
        end
    end
})

local _s_TabVisuals_17 = TabVisuals:Section({ Side = "Left" })
_s_TabVisuals_17:Label({ Text = "Player & Entity Visuals" })

_s_TabVisuals_17:Toggle({
    Name    = "ESP Survivor (Name)",
    Default = false,
    Callback = function(v) ESP_Survivor_Name = v; RefreshESP() end
})

_s_TabVisuals_17:Toggle({
    Name    = "ESP Survivor (Highlight)",
    Default = false,
    Callback = function(v) ESP_Survivor_Highlight = v; RefreshESP() end
})

_s_TabVisuals_17:Toggle({
    Name    = "ESP Killer (Name)",
    Default = false,
    Callback = function(v) ESP_Killer_Name = v; RefreshESP() end
})

_s_TabVisuals_17:Toggle({
    Name    = "ESP Killer (Highlight)",
    Default = false,
    Callback = function(v) ESP_Killer_Highlight = v; RefreshESP() end
})

_s_TabVisuals_17:Toggle({
    Name    = "ESP SCP/Zombie",
    Default = false,
    Callback = function(v) ESP_SCP = v end
})

local _s_TabVisuals_18 = TabVisuals:Section({ Side = "Left" })
_s_TabVisuals_18:Label({ Text = "Object Visuals" })

_s_TabVisuals_18:Toggle({
    Name    = "ESP Generator",
    Default = false,
    Callback = function(v) ESP_Generator = v; RefreshESP() end
})

_s_TabVisuals_18:Toggle({
    Name    = "ESP Pallet",
    Default = false,
    Callback = function(v) ESP_Pallet = v; RefreshESP() end
})

_s_TabVisuals_18:Toggle({
    Name    = "ESP Exit Gate",
    Default = false,
    Callback = function(v) ESP_Gate = v; RefreshESP() end
})

_s_TabVisuals_18:Toggle({
    Name    = "ESP Hook",
    Default = false,
    Callback = function(v) ESP_Hook = v; RefreshESP() end
})

local _s_TabVisuals_19 = TabVisuals:Section({ Side = "Left" })
_s_TabVisuals_19:Label({ Text = "World Optimization" })

_s_TabVisuals_19:Toggle({
    Name    = "Remove All Visual Effects",
    Default = false,
    Callback = function(v)
        if v then
            getgenv().RYEENZY_HiddenEffects = getgenv().RYEENZY_HiddenEffects or {}
            table.clear(getgenv().RYEENZY_HiddenEffects)
            
            local function hideEffects(parent)
                for _, effect in ipairs(parent:GetDescendants()) do
                    local n = string.lower(effect.Name)
                    if effect:IsA("PostEffect") or effect:IsA("Clouds") or effect:IsA("Atmosphere") or n:find("bloom") or n:find("dof") or n:find("sunray") or n:find("blur") then
                        if effect:IsA("Atmosphere") then
                            t_insert(getgenv().RYEENZY_HiddenEffects, {Obj = effect, OldParent = effect.Parent})
                            effect.Parent = nil
                        else
                            pcall(function()
                                if effect.Enabled then
                                    t_insert(getgenv().RYEENZY_HiddenEffects, {Obj = effect, WasEnabled = true})
                                    effect.Enabled = false
                                end
                            end)
                        end
                    end
                end
            end

            hideEffects(Lighting)
            hideEffects(workspace.CurrentCamera)
            
            getgenv().RYEENZY_OldFogStart = Lighting.FogStart
            getgenv().RYEENZY_OldFogEnd = Lighting.FogEnd
            Lighting.FogStart = 9e9
            Lighting.FogEnd = 9e9
            
            WindUI:Notify({ Title = "Vision Cleared", Content = "Semua filter layar dan kabut disembunyikan!" })
        else
            if getgenv().RYEENZY_HiddenEffects then
                for _, data in ipairs(getgenv().RYEENZY_HiddenEffects) do
                    if data.Obj then
                        if data.OldParent then data.Obj.Parent = data.OldParent
                        elseif data.WasEnabled then pcall(function() data.Obj.Enabled = true end) end
                    end
                end
                table.clear(getgenv().RYEENZY_HiddenEffects)
            end
            
            if getgenv().RYEENZY_OldFogStart then
                Lighting.FogStart = getgenv().RYEENZY_OldFogStart
                Lighting.FogEnd   = getgenv().RYEENZY_OldFogEnd
            end
            WindUI:Notify({ Title = "Vision Restored", Content = "Efek visual bawaan game dikembalikan." })
        end
    end
})

_s_TabVisuals_19:Button({
    Name     = "Force Fullbright",
    Callback = function()
        Lighting.Ambient = Color3.fromRGB(170, 170, 170)
        Lighting.OutdoorAmbient = Color3.fromRGB(170, 170, 170)
        Lighting.ColorShift_Bottom = Color3.new(0, 0, 0)
        Lighting.ColorShift_Top = Color3.new(0, 0, 0)
        Lighting.Brightness = 1.9
        Lighting.ClockTime = 12
        Lighting.GlobalShadows = false 
        Lighting.FogStart = 9e9
        Lighting.FogEnd = 9e9
        for _, effect in ipairs(Lighting:GetDescendants()) do 
            if effect:IsA("Atmosphere") or effect:IsA("Sky") then
                pcall(function() effect:Destroy() end)
            elseif effect:IsA("PostEffect") or effect:IsA("Clouds") then 
                pcall(function() effect.Enabled = false end)
            end 
        end
    end
})

_s_TabVisuals_19:Button({
    Name     = "Potato Mode",
    Callback = function()
        WindUI:Notify({ Title = "Potato Mode", Content = "Mengoptimalkan map... jangan tutup game!" })
        task.spawn(function()
            Lighting.GlobalShadows = false
            Lighting.ShadowSoftness = 0
            Lighting.FogEnd = 9e9
            Lighting.EnvironmentDiffuseScale = 0
            Lighting.EnvironmentSpecularScale = 0
            for _, effect in ipairs(Lighting:GetDescendants()) do 
                if effect:IsA("PostEffect") or effect:IsA("Atmosphere") or effect:IsA("Clouds") then 
                    pcall(function() effect.Enabled = false end)
                end 
            end

            local terrain = workspace.Terrain
            if terrain then
                pcall(function()
                    terrain.WaterWaveSize = 0
                    terrain.WaterWaveSpeed = 0
                    terrain.WaterReflectance = 0
                    terrain.WaterTransparency = 0
                    terrain.Decoration = false
                end)
            end

            local descendants=workspace:GetDescendants()
            for i=1,#descendants do
                local v=descendants[i]
                local class=v.ClassName
                if class=="Part" or class=="MeshPart" or class=="UnionOperation" then
                    pcall(function()
                        if v.Material~=Enum.Material.SmoothPlastic then v.Material=Enum.Material.SmoothPlastic end
                        if v.Reflectance~=0 then v.Reflectance=0 end
                        if v.CastShadow then v.CastShadow=false end
                    end)
                elseif class=="Decal" or class=="Texture" or class=="SurfaceAppearance" then
                    pcall(function() if v.Parent then v:Destroy() end end)
                elseif class=="ParticleEmitter" or class=="Trail" or class=="Beam" or class=="Smoke" or class=="Fire" or class=="Sparkles" or class=="BloomEffect" or class=="BlurEffect" or class=="SunRaysEffect" or class=="ColorCorrectionEffect" or class=="DepthOfFieldEffect" then
                    pcall(function() if v.Enabled then v.Enabled=false end end)
                end
                if i%300==0 then task.wait() end
            end
            WindUI:Notify({ Title = "Optimization Complete!", Content = "Potato Mode diterapkan. FPS Boosted!" })
        end)
    end
})

-- =========================================================
-- TAB: SPOOFING
-- =========================================================
local _s_TabSpoof_20 = TabSpoof:Section({ Side = "Left" })
_s_TabSpoof_20:Label({ Text = "Client-Sided (Visual Only)" })

_s_TabSpoof_20:Input({
    Name        = "Custom Gears",
    Placeholder = "",
    AcceptedCharacters = "Numeric",
    Callback    = function(text)
        SpoofData.Gears = tonumber(text) or 0
    end
})

_s_TabSpoof_20:Input({
    Name        = "Custom Screws",
    Placeholder = "",
    AcceptedCharacters = "Numeric",
    Callback    = function(text)
        SpoofData.Screws = tonumber(text) or 0
    end
})

_s_TabSpoof_20:Input({
    Name        = "Custom Level",
    Placeholder = "",
    AcceptedCharacters = "Numeric",
    Callback    = function(text)
        SpoofData.Level = tonumber(text) or 0
    end
})

_s_TabSpoof_20:Button({
    Name     = "Apply Spoof Data",
    Callback = function()
        local p = game.Players.LocalPlayer
        if not p then return end

        local function InjectValue(targetName, amount)
            if not amount or amount <= 0 then return end
            local targetLower = string.lower(targetName)

            pcall(function() p:SetAttribute(targetName, amount) end)
            pcall(function() p:SetAttribute(targetName.."s", amount) end)

            for _, obj in ipairs(p:GetDescendants()) do
                if obj:IsA("IntValue") or obj:IsA("NumberValue") or obj:IsA("StringValue") then
                    local n = string.lower(obj.Name)
                    if string.find(n, targetLower) then
                        if obj:IsA("StringValue") then
                            pcall(function() obj.Value = tostring(amount) end)
                        else
                            pcall(function() obj.Value = amount end)
                        end
                    end
                end
            end

            local pGui = p:FindFirstChild("PlayerGui")
            if pGui then
                for _, ui in ipairs(pGui:GetDescendants()) do
                    if ui:IsA("TextLabel") or ui:IsA("TextButton") then
                        local uiName = string.lower(ui.Name)
                        if string.find(uiName, targetLower) and (string.find(uiName, "amount") or string.find(uiName, "count") or string.find(uiName, "text") or uiName == targetLower) then
                            pcall(function() ui.Text = tostring(amount) end)
                        end
                    end
                end
            end
        end

        InjectValue("Gear", SpoofData.Gears)
        InjectValue("Screw", SpoofData.Screws)
        InjectValue("Level", SpoofData.Level)

        WindUI:Notify({ Title = "Spoof Applied!", Content = "Data berhasil dimanipulasi secara visual!" })
    end
})

-- =========================================================
-- TAB: SETTINGS
-- =========================================================
local _s_TabSettings_21 = TabSettings:Section({ Side = "Left" })
_s_TabSettings_21:Label({ Text = "Security & Protection" })

_s_TabSettings_21:Toggle({
    Name    = "Anti-Logger (Bypass Anti-Cheat)",
    Default = true,
    Callback = function(v) AntiLogger = v end
})

local _s_TabSettings_22 = TabSettings:Section({ Side = "Left" })
_s_TabSettings_22:Label({ Text = "Actions" })

_s_TabSettings_22:Button({
    Name     = "Unload RYEENZY | HUB",
    Callback = function()
        getgenv().RYEENZY_RUNNING = false
        pcall(function() Window:Destroy() end)
        pcall(function() RunService:UnbindFromRenderStep("SmoothFOV") end)
        
        if getgenv().RYEENZY_CONNECTIONS then
            for _, conn in ipairs(getgenv().RYEENZY_CONNECTIONS) do
                if conn.Disconnect then conn:Disconnect() end
            end
            table.clear(getgenv().RYEENZY_CONNECTIONS)
        end

        pcall(function() if getgenv().CrosshairGui then getgenv().CrosshairGui:Destroy() end end)
        pcall(function() if ParryRing then ParryRing:Destroy() end end)
        pcall(function() if IndicatorGui then IndicatorGui:Destroy() end end)

        for _, p in ipairs(Players:GetPlayers()) do
            if p.Character then
                local h = p.Character:FindFirstChild("H")
                if h then h:Destroy() end
                local root = p.Character:FindFirstChild("HumanoidRootPart")
                if root then
                    local tag = root:FindFirstChild("TagESP")
                    if tag then tag:Destroy() end
                end
            end
        end

        if CachedMapObjects then
            for _, list in pairs(CachedMapObjects) do
                for _, obj in ipairs(list) do
                    local h = obj:FindFirstChild("H")
                    if h then h:Destroy() end
                end
            end
        end
    end
})

-- =========================================================
-- [PREMIUM MOBILE UI] TOMBOL STATIS (ANTI-HILANG)
-- =========================================================
local isMobileDevice = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled

if isMobileDevice then
    local coreSuccess, coreResult = pcall(function() return cloneref(game:GetService("CoreGui")) end)
    local SafeGuiFolder = coreSuccess and coreResult or PlayerGui

    local combatGui = SafeGuiFolder:FindFirstChild("RYEENZY_MobileButtons") or Instance.new("ScreenGui")
    combatGui.Name = "RYEENZY_MobileButtons"
    combatGui.ResetOnSpawn = false
    combatGui.IgnoreGuiInset = true
    combatGui.Parent = SafeGuiFolder

    MobileRotateBtn = combatGui:FindFirstChild("RotateBtn") or Instance.new("TextButton")
    MobileRotateBtn.Name = "RotateBtn"
    MobileRotateBtn.Size = UDim2.new(0, 65, 0, 65) 
    MobileRotateBtn.Position = UDim2.new(1, -85, 0.5, 30) 
    MobileRotateBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 35) 
    MobileRotateBtn.BackgroundTransparency = 0.15
    MobileRotateBtn.AutoButtonColor = false 
    MobileRotateBtn.Text = "TPP"
    MobileRotateBtn.TextColor3 = Color3.new(1, 1, 1)
    MobileRotateBtn.Font = Enum.Font.GothamBlack
    MobileRotateBtn.TextSize = 16 
    MobileRotateBtn.Visible = false 
    MobileRotateBtn.Parent = combatGui

    for _, child in ipairs(MobileRotateBtn:GetChildren()) do child:Destroy() end

    local corner = Instance.new("UICorner", MobileRotateBtn)
    corner.CornerRadius = UDim.new(1, 0)

    local stroke = Instance.new("UIStroke", MobileRotateBtn)
    stroke.Thickness = 2.5
    stroke.Color = Color3.fromRGB(75, 150, 255) 

    local gradient = Instance.new("UIGradient", MobileRotateBtn)
    gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(150, 150, 150))
    })
    gradient.Rotation = 45

    MobileRotateBtn.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            MobileRotateBtn.Size = UDim2.new(0, 58, 0, 58)
        end
    end)

    MobileRotateBtn.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            MobileRotateBtn.Size = UDim2.new(0, 65, 0, 65)
            isFPP = not isFPP
            SwitchCameraMode(isFPP)
            stroke.Color = isFPP and Color3.fromRGB(255, 100, 50) or Color3.fromRGB(75, 150, 255)
            MobileRotateBtn.Text = isFPP and "FPP" or "TPP"
        end
    end)
end

-- =========================================================
-- OMNI NETWORK HOOK (FIXED + STABLE)
-- =========================================================

local oldNamecall

oldNamecall=hookmetamethod(
    game,
    "__namecall",
    newcclosure(function(self,...)

    local method=getnamecallmethod()

    if checkcaller() or method~="FireServer" or typeof(self)~="Instance" then
        return oldNamecall(self,...)
    end

    local args={...}
    local n=tostring(self):lower()
    
    -- SELF HEAL
    if SelfHeal and n:find("healevent") then
        local char=LocalPlayer.Character
        local myRoot=char and char:FindFirstChild("HumanoidRootPart")
        if myRoot then
            local myHum=char:FindFirstChild("Humanoid")
            if myHum and myHum.Health < myHum.MaxHealth then
                pcall(function() self:FireServer(LocalPlayer.Character, 100) end)
                pcall(function() self:FireServer(LocalPlayer.Character, true) end)
            end
        end
        return oldNamecall(self,...)
    end

    -- DOUBLE DAMAGE GENERATOR
    if DoubleDamageGen and (n:find("damagegen") or n:find("kickgen") or n:find("generator")) and method=="FireServer" then
        for i=1,2 do
            pcall(function() oldNamecall(self,...) end)
        end
        return
    end

    -- NOTIFY STUN
    if NotifyStun and (n:find("stun") or n:find("pallet") or n:find("dagger")) and method=="FireServer" then
        WindUI:Notify({ Title="Killer Stunned!", Content="Killer kena Stun — kesempatan lari!" })
    end

    -- SILENT ACTIONS
    if SilentActions then
        for _,w in ipairs({"noise","scream","vaultalert","spotted","alert","ping","loud","notify","notification","sound"}) do
            local firstArg=typeof(args[1])=="string" and args[1]:lower() or ""
            if n:find(w) or firstArg:find(w) then return end
        end
    end

    -- ANTI LOGGER
    if AntiLogger and (n:find("log") or n:find("error") or n:find("report") or n:find("anticheat") or n:find("ban")) then
        return
    end

    -- ANTI FALL
    if AntiFallDamage and (n:find("falldamage") or n:find("fall") or n:find("ragdollfall")) then
        return
    end

    -- ANTI AURA
    if getgenv().AntiAura then
        getgenv().AuraRemoteCache=getgenv().AuraRemoteCache or {}
        local cache=getgenv().AuraRemoteCache
        local key=tostring(self)

        if cache[key]==nil then
            local score=0
            for _,w in ipairs({"aura","reveal","highlight","sense","spotted","vision","radar","detect","tracking","hunter"}) do
                if n:find(w) then score+=2 end
            end
            local mentions=false
            for i=1,math.min(3,#args) do
                if args[i]==LocalPlayer or args[i]==LocalPlayer.Character then
                    mentions=true; break
                end
            end
            cache[key]=score>=4 and mentions
        end
        if cache[key] then return end
    end
    
    -- SILENT AIM PISTOL
    if SilentAimPistol and method=="FireServer" and n:find("fire") then
        local team=LocalPlayer.Team
        local survivor=not(team and team.Name:lower():find("killer"))

        if survivor then
            local char=LocalPlayer.Character
            local myRoot=char and char:FindFirstChild("HumanoidRootPart")
            local tool=char and char:FindFirstChildOfClass("Tool")

            if not(myRoot and tool) then
                return oldNamecall(self,...)
            end

            local firing=UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1)
                or (UserInputService.TouchEnabled and getgenv().isMobileFiring)

            if not firing then
                return oldNamecall(self,...)
            end

            local target=GetClosestSilentTarget()

            if target and target.Parent then
                local vel=target.AssemblyLinearVelocity or Vector3.zero
                if vel.Magnitude>45 then vel=vel.Unit*45 end

                local ping=0.08
                pcall(function()
                    ping=Stats.Network.ServerStatsItem["Data Ping"]:GetValue()/1000
                end)
                ping=math.clamp(ping,0.05,0.18)

                local predicted=target.Position+(vel*(0.11+ping))

                local origin=workspace.CurrentCamera.CFrame.Position
                local dir=(predicted-origin).Unit*1000

                for i,v in ipairs(args) do
                    if typeof(v)=="Vector3" then
                        args[i]=dir
                        break
                    end
                end

                task.spawn(function()
                    pcall(function()
                        workspace.CurrentCamera.CFrame=CFrame.lookAt(workspace.CurrentCamera.CFrame.Position,predicted)
                    end)
                end)

                return oldNamecall(self,unpack(args))
            end
        end
    end

    return oldNamecall(self,...)
end))

----------------------------------------------------------------
-- KILLER: AUTO ATTACK LOGIC
----------------------------------------------------------------
local CachedBasicAttack = nil
local SearchedAttackRemote = false
local lastAttackStrike = 0

task.spawn(function()
    while task.wait(0.15) do 
        if not getgenv().RYEENZY_RUNNING then break end 
        if not AutoAttack then continue end
        
        local myChar = LocalPlayer.Character
        local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
        local myHum  = myChar and myChar:FindFirstChild("Humanoid")

        if not(myRoot and myHum and myHum.Health > 0) then continue end

        local myTeam = (LocalPlayer.Team and LocalPlayer.Team.Name:lower()) or ""
        if not myTeam:find("killer") then continue end

        for _,p in ipairs(Players:GetPlayers()) do
            if p == LocalPlayer or not p.Character then continue end

            local char  = p.Character
            local root  = char:FindFirstChild("HumanoidRootPart")
            local hum   = char:FindFirstChild("Humanoid")

            if not(root and hum and hum.Health > 0) then continue end

            local pTeam = (p.Team and p.Team.Name:lower()) or ""
            if pTeam:find("killer") then continue end

            local dist = (root.Position - myRoot.Position).Magnitude
            if dist <= AttackRange then
                if tick() - lastAttackStrike > 0.5 then
                    lastAttackStrike = tick()

                    if not SearchedAttackRemote then
                        SearchedAttackRemote = true
                        local remotes = ReplicatedStorage:FindFirstChild("Remotes")
                        if remotes then
                            CachedBasicAttack =
                                remotes:FindFirstChild("BasicAttack", true)
                                or remotes:FindFirstChild("Attack", true)
                                or remotes:FindFirstChild("HitEvent", true)
                        end
                    end

                    if CachedBasicAttack then
                        pcall(function()
                            CachedBasicAttack:FireServer(char, root.Position)
                        end)
                    end
                end
            end
        end
    end
end)

-- =========================================================
-- AIMBOT RENDERSTEPPED
-- =========================================================
t_insert(getgenv().RYEENZY_CONNECTIONS, RunService.RenderStepped:Connect(function()
    if not Aimbot then return end

    local trigger = getgenv().AimbotTrigger or "Hold to Lock"
    local shouldAim = false

    if trigger == "Hold to Lock" then
        shouldAim = UserInputService:IsKeyDown(AimKey)
    else
        shouldAim = true
    end

    if not shouldAim then return end

    local target = GetClosestPlayer(CachedTarget)
    if not(target and target.Parent) then return end

    local cam = workspace.CurrentCamera
    local smoothness = getgenv().AimbotSmoothness or 8

    cam.CFrame = cam.CFrame:Lerp(
        CFrame.lookAt(cam.CFrame.Position, target.Position),
        1 / smoothness
    )
end))

-- =========================================================
-- HITBOX EXPANDER RENDERSTEPPED
-- =========================================================
t_insert(getgenv().RYEENZY_CONNECTIONS, RunService.Heartbeat:Connect(function()
    if not HitboxExpander then return end

    for _,p in ipairs(Players:GetPlayers()) do
        if p == LocalPlayer or not p.Character then continue end

        local char = p.Character
        local pTeam = (p.Team and p.Team.Name:lower()) or ""
        if not pTeam:find("killer") then continue end

        local hb = char:FindFirstChild("RYEENZY_HITBOX")
        if not hb then
            hb = Instance.new("Part")
            hb.Name = "RYEENZY_HITBOX"
            hb.Transparency = 1
            hb.CanCollide = false
            hb.Anchored = false
            hb.Size = Vector3.new(HitboxSize, HitboxSize, HitboxSize)
            hb.Parent = char

            local weld = Instance.new("WeldConstraint")
            weld.Part0 = hb
            weld.Part1 = char:FindFirstChild("HumanoidRootPart") or char.PrimaryPart
            weld.Parent = hb
        else
            hb.Size = Vector3.new(HitboxSize, HitboxSize, HitboxSize)
        end
    end
end))

-- =========================================================
-- CUSTOM FOV RENDERSTEPPED
-- =========================================================
t_insert(getgenv().RYEENZY_CONNECTIONS, RunService.RenderStepped:Connect(function()
    if CustomCameraFOV then
        workspace.CurrentCamera.FieldOfView = CameraFOVValue
    end
end))

-- =========================================================
-- ESP REFRESH LOOP
-- =========================================================
t_insert(getgenv().RYEENZY_CONNECTIONS, RunService.Heartbeat:Connect(function()
    local now = tick()
    if now - LastESPRefresh < 0.1 then return end
    LastESPRefresh = now
    RefreshESP()
end))

-- =========================================================
-- MOONWALK SYSTEM
-- =========================================================
t_insert(getgenv().RYEENZY_CONNECTIONS, RunService.Heartbeat:Connect(function()
    if not getgenv().MoonwalkEnabled then return end

    local char = LocalPlayer.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    local root = char and char:FindFirstChild("HumanoidRootPart")

    if not(char and hum and root and hum.Health > 0) then return end

    local zigzagSpeed = getgenv().MoonwalkZigzagSpeed or 11
    local boostPower = getgenv().MoonwalkBoostPower or 1.08

    local t = os.clock() * zigzagSpeed
    local side = math.sin(t)

    local cam = workspace.CurrentCamera
    local camLook = cam.CFrame.LookVector
    local camRight = cam.CFrame.RightVector

    local moveDir = (camLook * -1 + camRight * side).Unit

    hum.AutoRotate = false
    root.CFrame = CFrame.new(root.Position, root.Position + camLook)

    hum:Move(moveDir * boostPower, false)
end))

-- =========================================================
-- SPEED BOOST LOOP
-- =========================================================
t_insert(getgenv().RYEENZY_CONNECTIONS, RunService.Heartbeat:Connect(function()
    if not SpeedBoost then return end

    local char = LocalPlayer.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    if not hum then return end

    local baseSpeed = 17
    local pct = tonumber(BoostSpeed) or 0
    local targetSpeed = baseSpeed + (baseSpeed * (pct / 100))

    if hum.WalkSpeed ~= targetSpeed then
        hum.WalkSpeed = targetSpeed
    end
end))

-- =========================================================
-- AUTO FARM BOT THREADS
-- =========================================================
task.spawn(function()
    while task.wait(0.25) do
        if not getgenv().RYEENZY_RUNNING then break end
        if not AutoFarmBot then continue end

        pcall(function()
            local myChar = LocalPlayer.Character
            local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
            local myHum  = myChar and myChar:FindFirstChild("Humanoid")

            if not(myRoot and myHum and myHum.Health > 0) then return end

            local myPos = myRoot.Position
            local myTeam = (LocalPlayer.Team and LocalPlayer.Team.Name:lower()) or ""
            if myTeam:find("killer") then return end

            local actionState = "Idle"
            local targetPos = nil

            -- Priority 1: Run from killer
            local killerDist = 999
            local killerPos = nil
            for _,p in ipairs(Players:GetPlayers()) do
                if p == LocalPlayer or not p.Character then continue end
                local pTeam = (p.Team and p.Team.Name:lower()) or ""
                if not pTeam:find("killer") then continue end
                local kRoot = p.Character:FindFirstChild("HumanoidRootPart")
                if kRoot then
                    local d = (kRoot.Position - myPos).Magnitude
                    if d < killerDist then
                        killerDist = d
                        killerPos = kRoot.Position
                    end
                end
            end

            if killerPos and killerDist < 30 then
                actionState = "Evading"
                local awayDir = (myPos - killerPos).Unit
                targetPos = myPos + awayDir * 60

            else
                -- Priority 2: Heal teammate
                local injuredTeammate = nil
                local CachedHealEvent = nil
                local SearchHealRemote = false

                for _,p in ipairs(Players:GetPlayers()) do
                    if p == LocalPlayer or not p.Character then continue end
                    local pTeam = (p.Team and p.Team.Name:lower()) or ""
                    if pTeam:find("killer") then continue end
                    local pHum = p.Character:FindFirstChild("Humanoid")
                    local pRoot = p.Character:FindFirstChild("HumanoidRootPart")
                    if pHum and pRoot and pHum.Health < pHum.MaxHealth and pHum.Health > 0 then
                        local d = (pRoot.Position - myPos).Magnitude
                        if d < 8 then
                            injuredTeammate = p.Character
                            break
                        end
                    end
                end

                if injuredTeammate then
                    actionState = "Healing"
                    if not SearchHealRemote then
                        SearchHealRemote = true
                        local remotes = ReplicatedStorage:FindFirstChild("Remotes")
                        CachedHealEvent = remotes and (remotes:FindFirstChild("HealEvent", true) or remotes:FindFirstChild("RequestHeal", true) or remotes:FindFirstChild("ReviveEvent", true))
                    end
                    if CachedHealEvent then
                        pcall(function() CachedHealEvent:FireServer(injuredTeammate, 100) end)
                        pcall(function() CachedHealEvent:FireServer(injuredTeammate, true) end)
                    end
                    getgenv().CachedWaypoints = nil
                    getgenv().AIFinalTarget = nil
                    if (myHum.WalkToPoint - myPos).Magnitude > 1 then myHum:MoveTo(myPos) end
                    return
                end

                -- Count completed gens
                local completedGens = 0
                local bestGenTarget = nil
                local bestGenDist = 9999
                for _,gen in ipairs(CachedMapObjects.Generators) do
                    if gen and gen.Parent then
                        local prog = GetGameValue(gen, "Progress") or GetGameValue(gen, "GeneratorProgress") or 0
                        local maxProg = GetGameValue(gen, "MaxProgress") or 100
                        local pct2 = prog / math.max(maxProg, 1) * 100
                        if pct2 >= 99.5 then
                            completedGens += 1
                        else
                            local genPos = gen:GetPivot and gen:GetPivot().Position or (gen.PrimaryPart and gen.PrimaryPart.Position) or myPos
                            local d = (genPos - myPos).Magnitude
                            if d < bestGenDist then
                                bestGenDist = d
                                bestGenTarget = genPos
                            end
                        end
                    end
                end

                if completedGens < 5 and bestGenTarget then
                    actionState = "Repairing"
                    targetPos = bestGenTarget
                elseif completedGens >= 5 then
                    if CachedMapObjects and CachedMapObjects.Gates then
                        local shortestGate = 9999
                        for _, gate in ipairs(CachedMapObjects.Gates) do
                            local gatePos = gate:GetPivot().Position
                            local dist = (gatePos - myPos).Magnitude
                            if dist < shortestGate then
                                shortestGate = dist; targetPos = gatePos
                            end
                        end
                    end
                    actionState = "Escaping"
                end
            end

            -- Notify on state change
            if getgenv().LastAIState ~= actionState then
                getgenv().LastAIState = actionState
                local notifIcons = {
                    ["Evading"] = "Evading",
                    ["Healing"] = "Healing",
                    ["Repairing"] = "Repairing",
                    ["Escaping"] = "Escaping",
                    ["Idle"] = "Idle"
                }
                if actionState ~= "Idle" then
                    WindUI:Notify({
                        Title   = "AI State: " .. string.upper(actionState),
                        Description = "Mengalihkan rute ke: " .. actionState,
                    })
                end
            end

            getgenv().AIFinalTarget = targetPos

            -- Pathfinding
            if targetPos then
                local now = os.clock()
                local lastPathCalc = getgenv().LastPathCalc or 0
                local lastTargetPos = getgenv().LastTargetPos or v3()

                if (targetPos - lastTargetPos).Magnitude > 5 or (now - lastPathCalc > 1.5) then
                    getgenv().LastPathCalc = now
                    getgenv().LastTargetPos = targetPos

                    task.spawn(function()
                        pcall(function()
                            local path = PathfindingService:CreatePath({
                                AgentRadius = 2.5,
                                AgentHeight = 5,
                                AgentCanJump = true,
                                WaypointSpacing = 4
                            })
                            path:ComputeAsync(myPos, targetPos)
                            if path.Status == Enum.PathStatus.Success then
                                getgenv().CachedWaypoints = path:GetWaypoints()
                                getgenv().CurrentWaypointIdx = 2
                            else
                                getgenv().CachedWaypoints = nil
                            end
                        end)
                    end)
                end
            else
                getgenv().CachedWaypoints = nil
                if (myHum.WalkToPoint - myPos).Magnitude > 1 then myHum:MoveTo(myPos) end
            end
        end)
    end
end)

-- THREAD 2: Movement executor
task.spawn(function()
    while task.wait(0.05) do
        if not getgenv().RYEENZY_RUNNING then break end
        if not AutoFarmBot then continue end

        pcall(function()
            local myChar = LocalPlayer.Character
            local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
            local myHum  = myChar and myChar:FindFirstChild("Humanoid")
            if not myRoot or not myHum or myHum.Health <= 0 then return end

            local waypoints = getgenv().CachedWaypoints
            local idx = getgenv().CurrentWaypointIdx
            local myPos = myRoot.Position

            if waypoints and idx and idx <= #waypoints then
                local nextPoint = waypoints[idx]
                local distToWaypoint = (v3(nextPoint.Position.X, myPos.Y, nextPoint.Position.Z) - myPos).Magnitude

                if distToWaypoint < 4.5 then
                    getgenv().CurrentWaypointIdx = idx + 1
                    if getgenv().CurrentWaypointIdx <= #waypoints then
                        nextPoint = waypoints[getgenv().CurrentWaypointIdx]
                    end
                end

                if nextPoint then
                    myHum:MoveTo(nextPoint.Position)
                    if nextPoint.Action == Enum.PathWaypointAction.Jump then
                        myHum.Jump = true
                    end
                end
            elseif getgenv().AIFinalTarget then
                myHum:MoveTo(getgenv().AIFinalTarget)
            end

            local nowTime = os.clock()
            local lastBotPos = getgenv().LastBotPos or myPos
            local lastBotTime = getgenv().LastBotTime or nowTime

            if getgenv().AIFinalTarget then
                if (myPos - lastBotPos).Magnitude < 0.5 then
                    if nowTime - lastBotTime > 1.0 then
                        myHum.Jump = true
                        myRoot.CFrame = myRoot.CFrame * cnew(math.random(-2,2), 0, math.random(1,3))
                        getgenv().LastBotTime = nowTime + 0.5
                    end
                else
                    getgenv().LastBotPos = myPos
                    getgenv().LastBotTime = nowTime
                end
            end
        end)
    end
end)

-- =========================================================
-- EKSEKUSI WIPER & SPEED SYNC SETIAP KALI RESPAWN
-- =========================================================
t_insert(getgenv().RYEENZY_CONNECTIONS, LocalPlayer.CharacterAdded:Connect(function(char)
    local hum = char:WaitForChild("Humanoid", 5)
    if hum and SpeedBoost then 
        local baseSpeed = 17
        local percentValue = tonumber(BoostSpeed) or 0
        hum.WalkSpeed = baseSpeed + (baseSpeed * (percentValue / 100))
    end
end))

-- =========================================================
-- [ANTI-MEMORY LEAK] PEMBERSIH CACHE OTOMATIS
-- =========================================================
t_insert(getgenv().RYEENZY_CONNECTIONS, Players.PlayerRemoving:Connect(function(player)
    SilentTarget=nil
    ResetScope()
    if ESP_PlayerCache and ESP_PlayerCache[player.UserId] then
        ESP_PlayerCache[player.UserId] = nil
    end

    if player.Character then
        local root = player.Character:FindFirstChild("HumanoidRootPart")
        if root then
            local tag = root:FindFirstChild("TagESP")
            if tag then tag:Destroy() end
        end
    end
end))

-- =========================================================
-- WELCOME NOTIFY
-- =========================================================
WindUI:Notify({
    Title   = "Welcome to RYEENZY | HUB!",
    Description = "Script siap! Tekan tombol [K] untuk buka/tutup UI.",
    Lifetime = 8,
})

print("[RYEENZY | HUB] MacLib Loaded — 6767")
