-- Rayfield Gen2
-- Copyright (c) 2026 Corridon Capital -- MPL-2.0 -- https://mozilla.org/MPL/2.0/
this rebuild file from the Src folder in the RayField Gen2 repo (Rebuild by StyearX) (original library made by Sirius and their contributors)

local CoreGui = game:GetService("CoreGui")
local GuiService = game:GetService("GuiService")
local HttpService = game:GetService("HttpService")
local LocalizationService = game:GetService("LocalizationService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TextService = game:GetService("TextService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")

local Root, Components, Themes, Utility = {}, {}, {}, {}
Root.Name, Root.Parent = "Rayfield", nil
Components.Name, Components.Parent, Root.components = "components", Root, Components
Themes.Name, Themes.Parent, Root.themes = "themes", Root, Themes
Utility.Name, Utility.Parent, Root.utility = "utility", Root, Utility
for _, f in ipairs({ Root, Components, Themes, Utility }) do
    f.FindFirstChild = function(self, k) return self[k] end
end

local function required(node)
    if node.__loaded then return node.__cache end
    if not node.__loader then error(tostring(node.Name).." is not a ModuleScript", 2) end
    node.__loaded = true
    node.__cache = node.__loader(node, required)
    return node.__cache
end

-- Services
Utility.services = { Name = "services", Parent = Utility }
Utility.services.FindFirstChild = function(self, k) return self[k] end
Utility.services.__loader = function(script, require)
    local services = {
        CoreGui = CoreGui, GuiService = GuiService, HttpService = HttpService,
        LocalizationService = LocalizationService, Players = Players,
        ReplicatedStorage = ReplicatedStorage, RunService = RunService,
        TextService = TextService, TweenService = TweenService,
        UserInputService = UserInputService, Workspace = Workspace,
    }
    function services.getService(name)
        local service = services[name] or game:GetService(name)
        return if cloneref then cloneref(service) else service
    end
    return services
end

-- Themes: default, amethyst, cobalt, ember, frost, rose
Themes.amethyst = { Name = "amethyst", Parent = Themes }
Themes.amethyst.FindFirstChild = function(self, k) return self[k] end
Themes.amethyst.__loader = function(script, require)
return {
    WindowColor = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(22, 16, 32)),
        ColorSequenceKeypoint.new(0.9999, Color3.fromRGB(30, 22, 46)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(38, 28, 56)),
    }),
    ShadowColor = Color3.fromRGB(12, 6, 22),

    ElementStroke = Color3.fromRGB(54, 42, 74),
    ElementGradient = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(32, 24, 48)),
        ColorSequenceKeypoint.new(0.9999, Color3.fromRGB(36, 28, 54)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(36, 28, 54)),
    }),
    ElementStrokeGradient = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(72, 58, 104)),
        ColorSequenceKeypoint.new(0.9999, Color3.fromRGB(88, 72, 124)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(72, 58, 104)),
    }),
    ElementStrokeHover = Color3.fromRGB(84, 68, 118),

    TabBackground = ColorSequence.new(Color3.fromRGB(54, 42, 80), Color3.fromRGB(34, 26, 52)),
    TabStroke = ColorSequence.new(Color3.fromRGB(88, 70, 128), Color3.fromRGB(54, 42, 80)),

    SliderBackground = Color3.fromRGB(46, 36, 68),
    SliderBackgroundHover = Color3.fromRGB(60, 48, 90),
    SliderProgress = ColorSequence.new(Color3.fromRGB(170, 112, 248), Color3.fromRGB(138, 80, 224)),

    AccentColor = Color3.fromRGB(168, 110, 246),
    AccentStroke = Color3.fromRGB(200, 154, 255),

    ToggleKnobOff = Color3.fromRGB(224, 214, 236),

    StatBackground = Color3.fromRGB(24, 18, 38),

    DropdownHighlight = Color3.fromRGB(168, 110, 246),

    NeutralButton = Color3.fromRGB(46, 36, 68),
    NeutralButtonHover = Color3.fromRGB(60, 48, 90),
    NeutralButtonStroke = Color3.fromRGB(140, 116, 190),
}
end

Themes.cobalt = { Name = "cobalt", Parent = Themes }
Themes.cobalt.FindFirstChild = function(self, k) return self[k] end
Themes.cobalt.__loader = function(script, require)
return {
    WindowColor = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(12, 16, 34)),
        ColorSequenceKeypoint.new(0.9999, Color3.fromRGB(20, 26, 50)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(28, 36, 66)),
    }),
    ShadowColor = Color3.fromRGB(6, 8, 20),

    ElementStroke = Color3.fromRGB(44, 52, 82),
    ElementGradient = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(26, 32, 58)),
        ColorSequenceKeypoint.new(0.9999, Color3.fromRGB(30, 38, 66)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(30, 38, 66)),
    }),
    ElementStrokeGradient = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(56, 66, 104)),
        ColorSequenceKeypoint.new(0.9999, Color3.fromRGB(70, 82, 124)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(56, 66, 104)),
    }),
    ElementStrokeHover = Color3.fromRGB(64, 76, 116),

    TabBackground = ColorSequence.new(Color3.fromRGB(48, 58, 92), Color3.fromRGB(30, 38, 64)),
    TabStroke = ColorSequence.new(Color3.fromRGB(78, 92, 140), Color3.fromRGB(48, 58, 92)),

    SliderBackground = Color3.fromRGB(40, 48, 78),
    SliderBackgroundHover = Color3.fromRGB(54, 64, 100),
    SliderProgress = ColorSequence.new(Color3.fromRGB(64, 132, 248), Color3.fromRGB(42, 104, 224)),

    AccentColor = Color3.fromRGB(48, 120, 240),
    AccentStroke = Color3.fromRGB(96, 164, 255),

    ToggleKnobOff = Color3.fromRGB(196, 206, 232),

    StatBackground = Color3.fromRGB(20, 26, 48),

    DropdownHighlight = Color3.fromRGB(48, 120, 240),

    NeutralButton = Color3.fromRGB(40, 48, 78),
    NeutralButtonHover = Color3.fromRGB(54, 64, 100),
    NeutralButtonStroke = Color3.fromRGB(120, 138, 195),
}
end

Themes.default = { Name = "default", Parent = Themes }
Themes.default.FindFirstChild = function(self, k) return self[k] end
Themes.default.__loader = function(script, require)
local variables = require(script.Parent.Parent.utility.variables)

return {
    CornerRoundness = UDim.new(0, 20),
    WindowColor = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(10, 10, 10)),
        ColorSequenceKeypoint.new(0.9999, Color3.fromRGB(25, 25, 25)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(35, 35, 35)),
    }),
    ShadowColor = Color3.fromRGB(20, 20, 20),

    ElementStroke = Color3.fromRGB(35, 35, 35),

    ElementGradient = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(30, 30, 30)),
        ColorSequenceKeypoint.new(0.9999, Color3.fromRGB(35, 35, 35)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(35, 35, 35)),
    }),

    ElementStrokeGradient = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(48, 48, 48)),
        ColorSequenceKeypoint.new(0.9999, Color3.fromRGB(58, 58, 58)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(48, 48, 48)),
    }),
    TabColor = Color3.fromRGB(255, 255, 255),
    TabBackground = ColorSequence.new(Color3.fromRGB(50, 50, 50), Color3.fromRGB(35, 35, 35)),
    TabStroke = ColorSequence.new(Color3.fromRGB(95, 95, 95), Color3.fromRGB(50, 50, 50)),
    SliderBackground = Color3.fromRGB(47, 47, 47),
    SliderBackgroundHover = Color3.fromRGB(60, 60, 60),
    SliderProgress = ColorSequence.new(Color3.fromRGB(0, 170, 127), Color3.fromRGB(0, 134, 98)),
    SliderStroke = Color3.fromRGB(255, 255, 255),
    ActionColor = Color3.fromRGB(255, 255, 255),
    TitleFont = variables.brandFont(Enum.FontWeight.SemiBold),
    Font = variables.brandFont(Enum.FontWeight.Medium),
    ContentColor = Color3.fromRGB(255, 255, 255),

    LiveAnimation = false,

    DarkToggleOverlay = true,
    ElementTransparency = 0,
    ElementStrokeTransparency = 0,
    ElementStrokeHoverTransparency = 0,
    ElementStrokeHover = Color3.fromRGB(50, 50, 50),
    ElementCornerRadius = UDim.new(0, 12),
    ElementTextHoverColor = Color3.fromRGB(255, 255, 255),
    TitlingColor = Color3.fromRGB(255, 255, 255),

    DropdownHighlight = Color3.fromRGB(255, 255, 255),

    AccentColor = Color3.fromRGB(23, 153, 110),
    AccentStroke = Color3.fromRGB(32, 201, 144),
    AccentGlow = 0.4,

    StatBackground = Color3.fromRGB(25, 25, 25),
    SliderHandle = Color3.fromRGB(255, 255, 255),
    PillCornerRadius = UDim.new(1, 0),

    ToggleTrack = Color3.fromRGB(0, 0, 0),
    ToggleTrackTransparency = 0.9,
    ToggleKnobOff = Color3.fromRGB(255, 255, 255),
    ToggleKnobOffTransparency = 0.8,

    FieldBackground = Color3.fromRGB(255, 255, 255),
    FieldTransparency = 0.9,
    FieldGlow = Color3.fromRGB(255, 255, 255),

    PlaceholderColor = Color3.fromRGB(178, 178, 178),
    SurfaceStroke = Color3.fromRGB(255, 255, 255),

    NeutralButton = Color3.fromRGB(38, 38, 38),
    NeutralButtonHover = Color3.fromRGB(54, 54, 54),
    NeutralButtonStroke = Color3.fromRGB(255, 255, 255),

    ErrorColor = Color3.fromRGB(185, 50, 50),
    ErrorStrokeColor = Color3.fromRGB(240, 75, 75),
}
end

Themes.ember = { Name = "ember", Parent = Themes }
Themes.ember.FindFirstChild = function(self, k) return self[k] end
Themes.ember.__loader = function(script, require)
return {
    WindowColor = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(22, 18, 16)),
        ColorSequenceKeypoint.new(0.9999, Color3.fromRGB(32, 27, 23)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(40, 33, 28)),
    }),
    ShadowColor = Color3.fromRGB(16, 12, 8),

    ElementStroke = Color3.fromRGB(54, 46, 40),
    ElementGradient = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(32, 27, 23)),
        ColorSequenceKeypoint.new(0.9999, Color3.fromRGB(38, 32, 27)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(38, 32, 27)),
    }),
    ElementStrokeGradient = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(72, 62, 52)),
        ColorSequenceKeypoint.new(0.9999, Color3.fromRGB(88, 76, 64)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(72, 62, 52)),
    }),
    ElementStrokeHover = Color3.fromRGB(84, 72, 60),

    TabBackground = ColorSequence.new(Color3.fromRGB(56, 47, 40), Color3.fromRGB(36, 30, 26)),
    TabStroke = ColorSequence.new(Color3.fromRGB(92, 78, 66), Color3.fromRGB(56, 47, 40)),

    SliderBackground = Color3.fromRGB(48, 40, 34),
    SliderBackgroundHover = Color3.fromRGB(62, 52, 44),
    SliderProgress = ColorSequence.new(Color3.fromRGB(244, 152, 44), Color3.fromRGB(220, 110, 24)),

    AccentColor = Color3.fromRGB(240, 142, 40),
    AccentStroke = Color3.fromRGB(255, 182, 92),

    ToggleKnobOff = Color3.fromRGB(232, 224, 214),

    StatBackground = Color3.fromRGB(26, 21, 18),

    DropdownHighlight = Color3.fromRGB(240, 142, 40),

    NeutralButton = Color3.fromRGB(48, 40, 34),
    NeutralButtonHover = Color3.fromRGB(64, 54, 46),
    NeutralButtonStroke = Color3.fromRGB(150, 128, 104),
}
end

Themes.frost = { Name = "frost", Parent = Themes }
Themes.frost.FindFirstChild = function(self, k) return self[k] end
Themes.frost.__loader = function(script, require)
local variables = require(script.Parent.Parent.utility.variables)

return {
    WindowColor = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(246, 249, 251)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(236, 241, 245)),
    }),

    ShadowColor = Color3.fromRGB(116, 124, 132),

    LiveAnimation = false,

    ElementTransparency = 0,
    ElementStroke = Color3.fromRGB(218, 224, 228),
    ElementGradient = ColorSequence.new(Color3.fromRGB(255, 255, 255)),
    ElementStrokeGradient = ColorSequence.new(Color3.fromRGB(224, 230, 234), Color3.fromRGB(232, 238, 242)),
    ElementStrokeTransparency = 0.1,
    ElementStrokeHoverTransparency = 0,
    ElementStrokeHover = Color3.fromRGB(0, 176, 208),
    DarkToggleOverlay = false,

    TabColor = Color3.fromRGB(38, 42, 46),
    TabBackground = ColorSequence.new(Color3.fromRGB(0, 176, 208), Color3.fromRGB(0, 150, 184)),
    TabStroke = ColorSequence.new(Color3.fromRGB(80, 206, 230), Color3.fromRGB(0, 160, 196)),

    SliderBackground = Color3.fromRGB(224, 230, 234),
    SliderBackgroundHover = Color3.fromRGB(212, 220, 224),
    SliderProgress = ColorSequence.new(Color3.fromRGB(0, 182, 214), Color3.fromRGB(0, 146, 182)),
    SliderStroke = Color3.fromRGB(200, 206, 210),

    AccentColor = Color3.fromRGB(0, 176, 208),
    AccentStroke = Color3.fromRGB(96, 210, 232),
    AccentGlow = 0.85,

    StatBackground = Color3.fromRGB(255, 255, 255),
    SliderHandle = Color3.fromRGB(60, 66, 72),

    ToggleTrack = Color3.fromRGB(198, 204, 210),
    ToggleTrackTransparency = 0,
    ToggleKnobOffTransparency = 0.05,

    FieldBackground = Color3.fromRGB(224, 230, 234),
    FieldTransparency = 0,
    FieldGlow = Color3.fromRGB(148, 154, 160),

    PlaceholderColor = Color3.fromRGB(138, 144, 150),
    SurfaceStroke = Color3.fromRGB(204, 210, 214),

    NeutralButton = Color3.fromRGB(224, 230, 234),
    NeutralButtonHover = Color3.fromRGB(212, 220, 224),
    NeutralButtonStroke = Color3.fromRGB(242, 246, 248),

    ActionColor = Color3.fromRGB(68, 74, 80),
    TitlingColor = Color3.fromRGB(26, 30, 34),
    TitleFont = variables.brandFont(Enum.FontWeight.SemiBold),
    Font = variables.brandFont(Enum.FontWeight.Medium),
    ContentColor = Color3.fromRGB(42, 46, 52),
    ElementTextHoverColor = Color3.fromRGB(18, 22, 26),

    DropdownHighlight = Color3.fromRGB(0, 176, 208),

    ErrorColor = Color3.fromRGB(200, 60, 55),
    ErrorStrokeColor = Color3.fromRGB(240, 80, 70),
}
end

Themes.rose = { Name = "rose", Parent = Themes }
Themes.rose.FindFirstChild = function(self, k) return self[k] end
Themes.rose.__loader = function(script, require)
return {
    WindowColor = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(26, 18, 22)),
        ColorSequenceKeypoint.new(0.9999, Color3.fromRGB(36, 26, 31)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(44, 32, 38)),
    }),
    ShadowColor = Color3.fromRGB(18, 10, 14),

    ElementStroke = Color3.fromRGB(58, 44, 50),
    ElementGradient = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(34, 25, 29)),
        ColorSequenceKeypoint.new(0.9999, Color3.fromRGB(40, 30, 34)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(40, 30, 34)),
    }),
    ElementStrokeGradient = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(76, 58, 66)),
        ColorSequenceKeypoint.new(0.9999, Color3.fromRGB(92, 70, 80)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(76, 58, 66)),
    }),
    ElementStrokeHover = Color3.fromRGB(88, 66, 74),

    TabBackground = ColorSequence.new(Color3.fromRGB(62, 46, 53), Color3.fromRGB(38, 29, 33)),
    TabStroke = ColorSequence.new(Color3.fromRGB(102, 78, 88), Color3.fromRGB(62, 46, 53)),

    SliderBackground = Color3.fromRGB(50, 38, 44),
    SliderBackgroundHover = Color3.fromRGB(64, 50, 56),
    SliderProgress = ColorSequence.new(Color3.fromRGB(244, 88, 140), Color3.fromRGB(220, 60, 116)),

    AccentColor = Color3.fromRGB(240, 82, 138),
    AccentStroke = Color3.fromRGB(255, 134, 178),

    ToggleKnobOff = Color3.fromRGB(236, 220, 226),

    StatBackground = Color3.fromRGB(28, 20, 24),

    DropdownHighlight = Color3.fromRGB(240, 82, 138),

    NeutralButton = Color3.fromRGB(50, 38, 44),
    NeutralButtonHover = Color3.fromRGB(64, 50, 56),
    NeutralButtonStroke = Color3.fromRGB(170, 122, 140),
}
end

-- Utility
Utility.HapticEngine = { Name = "HapticEngine", Parent = Utility }
Utility.HapticEngine.FindFirstChild = function(self, k) return self[k] end
Utility.HapticEngine.__loader = function(script, require)
local variables = require(script.Parent.variables)

local hapticEngine = {}

hapticEngine.enabled = false

type HapticTypes = {
    click: Enum.HapticEffectType?,
    notify: Enum.HapticEffectType?,
}

local types: HapticTypes = {}
local supported, resolvedTypes = pcall(function()
    Instance.new("HapticEffect"):Destroy()
    return {
        click = Enum.HapticEffectType.UIHover,
        notify = Enum.HapticEffectType.UIClick,
    }
end)
if supported then
    types = resolvedTypes
end

local effects: { [Enum.HapticEffectType]: Instance } = {}
local container: Instance? = nil

function hapticEngine.setContainer(target: Instance?)
    container = target
end

function hapticEngine.releaseContainer(target: Instance?)
    if target == nil or container == target then
        container = nil
    end
end

local function containerFor(): Instance
    if container and container.Parent then
        return container
    end
    return variables.guiContainer
end

local function effectFor(hapticType: Enum.HapticEffectType): Instance?
    local effect = effects[hapticType]

    if effect and effect.Parent then
        return effect
    end
    local ok, made = pcall(Instance.new, "HapticEffect")
    if not ok then
        return nil
    end
    local hapticEffect = made :: any
    hapticEffect.Type = hapticType
    local parented = pcall(function()
        made.Parent = containerFor()
    end)
    if not parented then
        made:Destroy()
        return nil
    end
    effects[hapticType] = made
    return made
end

local function play(hapticType: Enum.HapticEffectType?)
    if not hapticType or not hapticEngine.enabled then
        return
    end
    local effect = effectFor(hapticType)
    if effect then
        local hapticEffect = effect :: any
        pcall(hapticEffect.Play, effect)
    end
end

function hapticEngine.click()
    play(types.click)
end

function hapticEngine.notify()
    play(types.notify)
end

function hapticEngine.setEnabled(state: boolean?)
    hapticEngine.enabled = state and true or false
    if not hapticEngine.enabled then
        hapticEngine.teardown()
    end
end

function hapticEngine.teardown()
    for hapticType, effect in effects do
        pcall(effect.Destroy, effect)
        effects[hapticType] = nil
    end
end

return hapticEngine
end

Utility.assetResolver = { Name = "assetResolver", Parent = Utility }
Utility.assetResolver.FindFirstChild = function(self, k) return self[k] end
Utility.assetResolver.__loader = function(script, require)
local network = require(script.Parent.network)
local log = require(script.Parent.log)

export type AssetId = number | string
export type AssetDownloadUrl = string
export type CacheKey = AssetId
export type ResolvedAsset = AssetId
export type AssetRequestPayload = {
    Url: string,
    Method: string,
}
local assetResolver = {
    Enum = {
        AssetDownloadUrl = {
            RobloxDownloadUrl = "https://assetdelivery.roblox.com/v1/asset/?id=%d" :: AssetDownloadUrl,
            RoProxyDownloadUrl = "https://assetdelivery.roproxy.com/v1/asset?id=%d" :: AssetDownloadUrl,
        },
    },
}
assetResolver.__index = assetResolver
assetResolver.__type = "assetResolver"
type AssetResolverState = {
    contentCache: { [CacheKey]: string }?,
    contentCacheOrder: { CacheKey }?,
    contentDownloadUrl: AssetDownloadUrl,
    pendingRequests: { [CacheKey]: { thread } },
}
export type AssetResolver = AssetResolverState & {
    resolve: (self: AssetResolver, value: unknown) -> ResolvedAsset?,
    getAssetContentFromUrl: (self: AssetResolver, url: string, cacheKey: CacheKey?, forced: boolean?) -> string?,
    getAssetContentFromId: (self: AssetResolver, id: AssetId, forced: boolean?) -> string?,
}

local contentCacheLimit = 8

function assetResolver.new(useCache: boolean?, assetContentDownloadUrl: AssetDownloadUrl?): AssetResolver
    local contentCache: { [CacheKey]: string }? = if useCache then {} else nil
    local self = setmetatable(
        {
            contentCache = contentCache,
            contentCacheOrder = if useCache then {} :: { CacheKey } else nil,
            contentDownloadUrl = assetContentDownloadUrl or assetResolver.Enum.AssetDownloadUrl.RobloxDownloadUrl,
            pendingRequests = {},
        } :: AssetResolverState,
        assetResolver
    ) :: any
    return self
end

function assetResolver.resolve(_self: AssetResolver, value: unknown): ResolvedAsset?
    if type(value) == "number" then
        return value
    end

    if type(value) ~= "string" then
        return nil
    end

    if string.sub(value, 1, 11) == "rbxasset://" or string.sub(value, 1, 11) == "rbxthumb://" then
        return value
    end

    local id = tonumber(string.match(value, "^rbxassetid://(%d+)$"))
    if id then
        return id
    end

    return nil
end

local function isGoodResponse(response: unknown): boolean
    if type(response) ~= "table" then
        return false
    end
    local shaped = response :: { Body: unknown, StatusCode: unknown, Success: unknown }
    local body = shaped.Body
    if type(body) ~= "string" or #body == 0 then
        return false
    end
    if type(shaped.StatusCode) == "number" then
        local statusCode = shaped.StatusCode :: number
        return statusCode >= 200 and statusCode < 300
    end
    if type(shaped.Success) == "boolean" then
        return shaped.Success :: boolean
    end

    return false
end

function assetResolver.getAssetContentFromUrl(
    self: AssetResolver,
    url: string,
    cacheKey: CacheKey?,
    forced: boolean?
): string?

    local contentCache = self.contentCache
    if cacheKey ~= nil and contentCache and not forced then
        local cachedContent = contentCache[cacheKey]
        if cachedContent then
            return cachedContent
        end
    end

    local pendingRequests = self.pendingRequests
    if cacheKey ~= nil then
        local pending = pendingRequests[cacheKey]
        if pending then
            table.insert(pending, coroutine.running())
            return coroutine.yield()
        end
        pendingRequests[cacheKey] = {}
    end

    local content: string? = nil
    local requestFn = network.getRequestFn()
    if not requestFn then
        log.warn("No request function available to download asset content.")
    else
        local success, response = pcall(
            requestFn,
            {
                Url = url,
                Method = "GET",
            } :: AssetRequestPayload
        )
        if success and isGoodResponse(response) then
            local body = (response :: { Body: string }).Body
            content = body
            if cacheKey ~= nil and contentCache then
                local order = self.contentCacheOrder
                if order and contentCache[cacheKey] == nil then
                    table.insert(order, cacheKey)
                    local oldest = if #order > contentCacheLimit then table.remove(order, 1) else nil
                    if oldest ~= nil then
                        contentCache[oldest] = nil
                    end
                end
                contentCache[cacheKey] = body
            end
        elseif not forced then
            log.warn("Failed to download asset content for url: " .. tostring(url))
        end
    end

    if cacheKey ~= nil then
        local waiting = pendingRequests[cacheKey]
        pendingRequests[cacheKey] = nil
        if waiting then
            for _, thread in waiting do
                coroutine.resume(thread, content)
            end
        end
    end
    return content
end

function assetResolver.getAssetContentFromId(self: AssetResolver, id: AssetId, forced: boolean?): string?
    local resolvedId = self:resolve(id)

    if not resolvedId or type(resolvedId) ~= "number" then
        log.warn("Invalid asset id: " .. tostring(resolvedId))
        return nil
    end

    local downloadUrl = string.format(self.contentDownloadUrl, resolvedId)
    return self:getAssetContentFromUrl(downloadUrl, resolvedId, forced)
end

return assetResolver
end

Utility.colors = { Name = "colors", Parent = Utility }
Utility.colors.FindFirstChild = function(self, k) return self[k] end
Utility.colors.__loader = function(script, require)
local colors = {}

function colors.contrastColor(color: Color3): Color3
    local luminance = 0.299 * color.R + 0.587 * color.G + 0.114 * color.B
    return if luminance > 0.5 then Color3.fromRGB(0, 0, 0) else Color3.fromRGB(255, 255, 255)
end

function colors.toColorSequence(color: Color3 | ColorSequence): ColorSequence
    return if typeof(color) == "ColorSequence" then color else ColorSequence.new(color)
end

function colors.contrastText(color: Color3): Color3
    local luminance = 0.299 * color.R + 0.587 * color.G + 0.114 * color.B
    return if luminance > 0.6 then Color3.fromRGB(20, 20, 20) else Color3.fromRGB(255, 255, 255)
end

return colors
end

Utility.constants = { Name = "constants", Parent = Utility }
Utility.constants.FindFirstChild = function(self, k) return self[k] end
Utility.constants.__loader = function(script, require)
local constants = {}

constants.fontAsset = "rbxassetid://12187365364"

constants.pillResizeInfo = TweenInfo.new(0.4, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)

constants.icons = {
    close = 83277910885129,
    minimise = 108115485663409,
    maximise = 88738500661569,
    settings = 129180860773723,
    search = 100604009889706,
    chevron = 88479147175134,
    check = 125626312718314,
    dot = 91452555903853,
    colorpicker = 91452555903853,
    banner = 111263549366178,
    config = 125823673784681,
    rayfield = 80387863064905,
}

constants.accent = {
    on = Color3.fromRGB(23, 153, 110),
    onStroke = Color3.fromRGB(32, 201, 144),
}

constants.statAccents = {
    positive = {
        fill = ColorSequence.new(Color3.fromRGB(0, 170, 127), Color3.fromRGB(0, 134, 98)),
        stroke = ColorSequence.new(Color3.fromRGB(0, 213, 156), Color3.fromRGB(0, 189, 135)),
    },
    negative = {
        fill = ColorSequence.new(Color3.fromRGB(172, 47, 47), Color3.fromRGB(135, 37, 37)),
        stroke = ColorSequence.new(Color3.fromRGB(255, 75, 75), Color3.fromRGB(244, 67, 67)),
    },

    neutral = {
        fill = ColorSequence.new(Color3.fromRGB(0, 170, 127), Color3.fromRGB(0, 134, 98)),
        stroke = ColorSequence.new(Color3.fromRGB(0, 213, 156), Color3.fromRGB(0, 189, 135)),
    },
}

constants.zIndex = {

    elementLock = 60,
    elementLockContent = 65,
    bottomFade = 100,

    notification = 1500,
    drag = 1000,

    toast = 2000,
    toastContent = 2001,
    restoreContent = 100001,
    restoreInteract = 100002,
}

constants.displayOrder = {
    window = 99999,
    banner = 100000,

    popup = 100001,
}

return constants
end

Utility.enums = { Name = "enums", Parent = Utility }
Utility.enums.FindFirstChild = function(self, k) return self[k] end
Utility.enums.__loader = function(script, require)
local enums = {}

function enums.itemFromValue(enumType, value)
    local ok, item = pcall(function()
        return enumType:FromValue(value)
    end)
    if ok and item then
        return item
    end

    local itemsOk, items = pcall(function()
        return enumType:GetEnumItems()
    end)
    if not itemsOk then
        return nil
    end

    for _, enumItem in items do
        if enumItem.Value == value then
            return enumItem
        end
    end

    return nil
end

return enums
end

Utility.filesystem = { Name = "filesystem", Parent = Utility }
Utility.filesystem.FindFirstChild = function(self, k) return self[k] end
Utility.filesystem.__loader = function(script, require)
local services = require(script.Parent.services)

local filesystem = {}

local isStudio = services.getService("RunService"):IsStudio()

local hasNativeFS = not isStudio
    and typeof(writefile) == "function"
    and typeof(readfile) == "function"
    and typeof(isfile) == "function"
    and typeof(isfolder) == "function"
    and typeof(makefolder) == "function"
    and typeof(listfiles) == "function"
    and typeof(delfile) == "function"
    and typeof(delfolder) == "function"

if hasNativeFS then

    function filesystem.writefile(path: string, content: string)
        writefile(path, content)
    end

    function filesystem.readfile(path: string): string
        return readfile(path)
    end

    if typeof(appendfile) == "function" then
        function filesystem.appendfile(path: string, content: string)
            appendfile(path, content)
        end
    end

    function filesystem.isfile(path: string): boolean
        return isfile(path)
    end

    function filesystem.delfile(path: string)
        delfile(path)
    end

    function filesystem.listfiles(folder: string): { string }
        return listfiles(folder)
    end

    function filesystem.makefolder(path: string)
        makefolder(path)
    end

    function filesystem.isfolder(path: string): boolean
        return isfolder(path)
    end

    function filesystem.delfolder(path: string)
        delfolder(path)
    end
elseif isStudio then

    local root = Instance.new("Folder")
    root.Name = "Filesystem"
    root.Parent = services.getService("ReplicatedStorage")

    local function splitPath(path: string): { string }
        local parts = {}
        for part in string.gmatch(path, "[^/]+") do
            table.insert(parts, part)
        end
        return parts
    end

    local function resolveParent(parts: { string }, createMissing: boolean): Instance?
        local current: Instance = root
        for i = 1, #parts - 1 do
            local child = current:FindFirstChild(parts[i])
            if not child then
                if not createMissing then
                    return nil
                end
                local folder = Instance.new("Folder")
                folder.Name = parts[i]
                folder.Parent = current
                child = folder
            end
            current = child :: Instance
        end
        return current
    end

    local function fileFromInstance(instance: Instance?): StringValue?
        if instance and instance:IsA("StringValue") then
            return instance
        end
        return nil
    end

    function filesystem.writefile(path: string, content: string)
        local parts = splitPath(path)
        assert(#parts > 0, "Invalid path")

        local parent = resolveParent(parts, true)
        assert(parent, "Invalid path")
        local fileName = parts[#parts]

        local existing = parent:FindFirstChild(fileName)
        local existingFile = fileFromInstance(existing)
        if existingFile then
            existingFile.Value = content
        else
            if existing then
                existing:Destroy()
            end
            local file = Instance.new("StringValue")
            file.Name = fileName
            file.Value = content
            file.Parent = parent
        end
    end

    function filesystem.readfile(path: string): string
        local parts = splitPath(path)
        assert(#parts > 0, "Invalid path")

        local parent = resolveParent(parts, false)
        assert(parent, "File not found: " .. path)

        local file = parent:FindFirstChild(parts[#parts])
        local stringFile = fileFromInstance(file)
        assert(stringFile, "File not found: " .. path)

        return stringFile.Value
    end

    function filesystem.isfile(path: string): boolean
        local parts = splitPath(path)
        if #parts == 0 then
            return false
        end

        local parent = resolveParent(parts, false)
        if not parent then
            return false
        end

        return fileFromInstance(parent:FindFirstChild(parts[#parts])) ~= nil
    end

    function filesystem.listfiles(folder: string): { string }
        local parts = splitPath(folder)
        local current: Instance = root

        for _, part in parts do
            local child = current:FindFirstChild(part)
            if not child or not child:IsA("Folder") then
                error("Folder not found: " .. folder)
            end
            current = child
        end

        local results: { string } = {}
        for _, child in current:GetChildren() do
            table.insert(results, folder .. "/" .. child.Name)
        end
        return results
    end

    function filesystem.delfile(path: string)
        local parts = splitPath(path)
        assert(#parts > 0, "Invalid path")

        local parent = resolveParent(parts, false)
        assert(parent, "File not found: " .. path)

        local file = parent:FindFirstChild(parts[#parts])
        local stringFile = fileFromInstance(file)
        assert(stringFile, "File not found: " .. path)

        stringFile:Destroy()
    end

    function filesystem.makefolder(path: string)
        local parts = splitPath(path)
        if #parts == 0 then
            return
        end

        local current: Instance = root
        for _, part in parts do
            local child = current:FindFirstChild(part)
            if not child then
                local folder = Instance.new("Folder")
                folder.Name = part
                folder.Parent = current
                child = folder
            end
            current = child :: Instance
        end
    end

    function filesystem.isfolder(path: string): boolean
        local parts = splitPath(path)
        if #parts == 0 then
            return false
        end

        local current: Instance = root
        for _, part in parts do
            local child = current:FindFirstChild(part)
            if not child or not child:IsA("Folder") then
                return false
            end
            current = child
        end
        return true
    end

    function filesystem.delfolder(path: string)
        local parts = splitPath(path)
        assert(#parts > 0, "Invalid path")

        local parent = resolveParent(parts, false)
        assert(parent, "Folder not found: " .. path)

        local folder = parent:FindFirstChild(parts[#parts])
        assert(folder and folder:IsA("Folder"), "Folder not found: " .. path)

        folder:Destroy()
    end
end

if filesystem.writefile and not filesystem.appendfile then
    function filesystem.appendfile(path: string, content: string)
        local existing = if filesystem.isfile(path) then filesystem.readfile(path) else nil
        filesystem.writefile(path, if existing then existing .. content else content)
    end
end

function filesystem.ensureFolder(path: string)
    if not filesystem.isfolder(path) then
        filesystem.makefolder(path)
    end
end

function filesystem.ensureDir(dir: string)
    local built = ""
    for part in string.gmatch(dir, "[^/]+") do
        built = if built == "" then part else built .. "/" .. part
        if not filesystem.isfolder(built) then
            filesystem.makefolder(built)
        end
    end
end

return filesystem
end

Utility.filesystemManager = { Name = "filesystemManager", Parent = Utility }
Utility.filesystemManager.FindFirstChild = function(self, k) return self[k] end
Utility.filesystemManager.__loader = function(script, require)
local filesystem = require(script.Parent.filesystem)
local path = require(script.Parent.path)

local DEFAULT_ROOT_PATH = "Rayfield"

local fileSystemManager = {}
fileSystemManager.__index = fileSystemManager

export type FileSystemManager = {
    root: string,
    assets: string,
    getPath: (self: FileSystemManager, subpath: string?) -> string,
    getAssetsFolder: (self: FileSystemManager, subfolder: string?) -> string,
    getRootFolder: (self: FileSystemManager) -> string,
}

function fileSystemManager.new(name: string?): FileSystemManager

    local root = name or DEFAULT_ROOT_PATH
    local self = setmetatable({
        root = root,
        assets = root .. "/Assets",
    }, fileSystemManager) :: any
    pcall(filesystem.ensureFolder, self.root)
    pcall(filesystem.ensureFolder, self.assets)

    return self
end

function fileSystemManager:getPath(subpath: string?): string
    return path.join(self.root, subpath)
end

function fileSystemManager:getAssetsFolder(subfolder: string?): string
    if subfolder then
        local assetPath = path.join(self.assets, subfolder)
        pcall(filesystem.ensureFolder, assetPath)
        return assetPath
    end
    return self.assets
end

function fileSystemManager:getRootFolder(): string
    return self.root
end

return fileSystemManager
end

Utility.flagNames = { Name = "flagNames", Parent = Utility }
Utility.flagNames.FindFirstChild = function(self, k) return self[k] end
Utility.flagNames.__loader = function(script, require)
local flagNames = {}

local offsetBasis = 2166136261
local prime = 16777619

local function hashName(name: string): number
    local hash = offsetBasis
    for index = 1, #name do
        hash = bit32.bxor(hash, string.byte(name, index))

        local low = hash % 65536
        local high = (hash - low) / 65536
        hash = (((high * prime) % 65536) * 65536 + low * prime) % 4294967296
    end
    return hash
end

function flagNames.deriveFlagFromName(name: string): string
    local flag = name:gsub("(%S+)", function(w: string): string
        return w:sub(1, 1):upper() .. w:sub(2, -1)
    end):gsub("[^%w]", "")

    if flag == "" and name ~= "" then
        return string.format("Flag%08x", hashName(name))
    end

    return flag
end

return flagNames
end

Utility.fontManager = { Name = "fontManager", Parent = Utility }
Utility.fontManager.FindFirstChild = function(self, k) return self[k] end
Utility.fontManager.__loader = function(script, require)
local services = require(script.Parent.services)
local httpService = services.getService("HttpService")
local runService = services.getService("RunService")
local fileSystem = require(script.Parent.filesystem)
local assetResolver = require(script.Parent.assetResolver)
local log = require(script.Parent.log)
local path = require(script.Parent.path)

local function jsonEncode(data: unknown): string?
    local success, result = pcall(function()
        return httpService:JSONEncode(data)
    end)
    if success and type(result) == "string" then
        return result
    else
        log.warn("Failed to encode JSON:", result)
        return nil
    end
end

local function jsonDecode(jsonString: string): unknown?
    local success, result = pcall(function()
        return httpService:JSONDecode(jsonString)
    end)
    if success then
        return result
    else
        log.warn("Failed to decode JSON:", result)
        return nil
    end
end

local fontManager = {}
fontManager.__type = "fontManager"

export type FontFace = {
    name: string,
    family: string,
    weight: number,
    style: string,
    assetId: string,
}

export type FontManifest = {
    name: string,
    faces: { FontFace },
}

export type CachedFont = {
    customId: number | string,
    manifest: FontManifest,
    loadedFromDisk: boolean,
    variants: { [string]: Font },
}

export type FontCache = { [number]: CachedFont }

export type FontResolverOptions = {
    fallbackFont: Font?,
    saveToDisk: boolean?,
    skipCache: boolean?,
}

type FontManagerState = {
    _debug: boolean,
    _pendingLoads: { [string]: { thread } },
    rootFolder: string,
    assetResolver: assetResolver.AssetResolver,
    defaultOptions: FontResolverOptions,
    fontCache: FontCache?,
}

export type FontManager = FontManagerState & {
    resolve: (self: FontManager, id: number | string) -> Font?,
    loadFont: (
        self: FontManager,
        id: (number | string)?,
        fontWeight: Enum.FontWeight?,
        fontStyle: Enum.FontStyle?,
        saveToDisk: boolean?,
        skipCache: boolean?
    ) -> Font?,
    getFontFromId: (self: FontManager, id: number | string) -> Font?,
}

export type fontManager = FontManager

local function validateManifest(manifest: unknown): FontManifest?
    local candidate = manifest :: any
    if type(candidate) ~= "table" or type(candidate.name) ~= "string" or type(candidate.faces) ~= "table" then
        return nil
    end
    candidate.name = path.sanitizeFile(candidate.name)
    if #candidate.name == 0 or #candidate.faces == 0 then
        return nil
    end
    for _, face in candidate.faces do
        if type(face) ~= "table" or type(face.name) ~= "string" or type(face.assetId) ~= "string" then
            return nil
        end
        face.name = path.sanitizeFile(face.name)
        if #face.name == 0 then
            return nil
        end
    end
    return candidate :: FontManifest
end

local fontSignatures = { "\0\1\0\0", "OTTO", "true", "ttcf", "wOFF", "wOF2" }

local function isFontBody(body: string): boolean
    for _, signature in fontSignatures do
        if string.sub(body, 1, #signature) == signature then
            return true
        end
    end
    return false
end

local env = getfenv()

local function variantKey(fontWeight: Enum.FontWeight, fontStyle: Enum.FontStyle): string
    return tostring(fontWeight) .. "|" .. tostring(fontStyle)
end

local function resolveId(id: unknown): number?
    if type(id) == "number" then
        return id
    end

    if type(id) == "string" then
        return tonumber(id)
    end

    return nil
end

function fontManager.__index(self: FontManagerState, key: unknown): unknown
    local classMember = (fontManager :: any)[key]
    if classMember ~= nil then
        return classMember
    end

    local resolvedId = resolveId(key)
    if not resolvedId then
        return nil
    end

    local fontCache = self.fontCache
    if fontCache then
        local cached = fontCache[resolvedId]
        if cached then
            local regularKey = variantKey(Enum.FontWeight.Regular, Enum.FontStyle.Normal)
            local regularFont = cached.variants and cached.variants[regularKey]
            if regularFont then
                return regularFont
            end

            for _, font in pairs(cached.variants or {}) do
                return font
            end
        end
    end

    return nil
end

function fontManager.new(
    rootFolder: string,
    useDebug: boolean?,
    useCache: boolean?,
    assetContentDownloadUrl: assetResolver.AssetDownloadUrl?,
    defaultOptions: FontResolverOptions?
): FontManager
    local defaultResolverOptions = defaultOptions
        or {
            saveToDisk = true,
            skipCache = not useCache or false,
            fallbackFont = Font.fromEnum(Enum.Font.SourceSans),
        }
    local self = setmetatable(
        {
            rootFolder = rootFolder,
            fontCache = if useCache then {} :: FontCache else nil,
            assetResolver = assetResolver.new(useCache, assetContentDownloadUrl),
            defaultOptions = defaultResolverOptions,
            _debug = useDebug or runService:IsStudio() or false,
            _pendingLoads = {},
        } :: FontManagerState,
        fontManager
    ) :: any

    pcall(fileSystem.ensureFolder, rootFolder)
    return self
end

local function fetchFont(
    self: FontManager,
    resolvedId: number,
    requestedFontWeight: Enum.FontWeight,
    requestedFontStyle: Enum.FontStyle,
    cacheKey: string
): Font?
    local manifestPath = self.rootFolder .. "/" .. resolvedId .. ".json"

    if typeof(fileSystem.isfile) ~= "function" then
        return self.defaultOptions.fallbackFont
    end
    local possibleFontManifest: string? = nil
    local downloadedManifest = false
    if runService:IsStudio() and self._debug then
        log.warn("Font manifest loading is not supported in Studio. Using default font manifest for testing.")
        possibleFontManifest =
            '{"name":"Inter","faces":[{"name":"Thin","weight":100,"style":"normal","assetId":"rbxassetid://12187277209"},{"name":"Extra Light","weight":200,"style":"normal","assetId":"rbxassetid://12187293441"},{"name":"Light","weight":300,"style":"normal","assetId":"rbxassetid://12187268450"},{"name":"Regular","weight":400,"style":"normal","assetId":"rbxassetid://12187266066"},{"name":"Medium","weight":500,"style":"normal","assetId":"rbxassetid://12187336822"},{"name":"Semi Bold","weight":600,"style":"normal","assetId":"rbxassetid://12187254443"},{"name":"Bold","weight":700,"style":"normal","assetId":"rbxassetid://12187275575"},{"name":"Extra Bold","weight":800,"style":"normal","assetId":"rbxassetid://12187267750"},{"name":"Black","weight":900,"style":"normal","assetId":"rbxassetid://12187359223"}]}'
    elseif fileSystem.isfile(manifestPath) then
        local ok, contents = pcall(fileSystem.readfile, manifestPath)
        possibleFontManifest = ok and contents or nil
    else

        possibleFontManifest = self.assetResolver:getAssetContentFromId(resolvedId, false)
        downloadedManifest = possibleFontManifest ~= nil
    end
    local fontManifest: FontManifest? = nil
    if possibleFontManifest then
        local ok, parsedManifest = pcall(jsonDecode, possibleFontManifest)
        if ok and parsedManifest then
            fontManifest = validateManifest(parsedManifest)
        else
            if self._debug then
                log.warn(
                    "Failed to parse font manifest for font id: "
                        .. tostring(resolvedId)
                        .. ". Error: "
                        .. tostring(parsedManifest)
                )
            end
        end
    else
        return self.defaultOptions.fallbackFont
    end
    if not fontManifest then
        if self._debug then
            log.warn("Font manifest is nil for font id: " .. tostring(resolvedId))
        end

        pcall(fileSystem.delfile, manifestPath)
        return self.defaultOptions.fallbackFont
    end
    if downloadedManifest and possibleFontManifest then
        pcall(fileSystem.writefile, manifestPath, possibleFontManifest)
    end
    local fontDirectory = self.rootFolder .. "/" .. fontManifest.name
    local madeAllFontsLocal = true

    if not pcall(fileSystem.ensureFolder, fontDirectory) then
        return self.defaultOptions.fallbackFont
    end

    for i, face in ipairs(fontManifest.faces) do
        local fontFacePath = fontDirectory .. "/" .. face.name:gsub(" ", "-") .. ".ttf"

        if fileSystem.isfile(fontFacePath) then
            local readOk, existing = pcall(fileSystem.readfile, fontFacePath)
            if not readOk or type(existing) ~= "string" or not isFontBody(existing) then
                pcall(fileSystem.delfile, fontFacePath)
            end
        end
        if not fileSystem.isfile(fontFacePath) then
            local fontFaceId = self.assetResolver:resolve(face.assetId)
            local fontFaceContent = if fontFaceId ~= nil
                then self.assetResolver:getAssetContentFromId(fontFaceId, false)
                else nil
            if not fontFaceContent or not isFontBody(fontFaceContent) then
                madeAllFontsLocal = false
                if self._debug then
                    log.warn(
                        "Font face content is missing or not a font for font id: "
                            .. tostring(resolvedId)
                            .. ", face: "
                            .. face.name
                    )
                end
                continue
            end
            pcall(fileSystem.writefile, fontFacePath, fontFaceContent)
        end
        local ok, uri = pcall(env.getcustomasset, fontFacePath)
        if ok and type(uri) == "string" then
            fontManifest.faces[i].assetId = uri
            if self._debug then
                log.print("Loaded font face for id: " .. tostring(resolvedId) .. ", face: " .. face.name)
            end
        else
            madeAllFontsLocal = false
            if self._debug then
                log.warn("Failed to load font face for id: " .. tostring(resolvedId) .. ", face: " .. face.name)
            end
        end
    end

    if not madeAllFontsLocal then
        return self.defaultOptions.fallbackFont
    end

    local encodedManifest = jsonEncode(fontManifest)
    if not encodedManifest or not pcall(fileSystem.writefile, fontDirectory .. "/manifest.json", encodedManifest) then
        return self.defaultOptions.fallbackFont
    end
    local manifestOk, fontManifestId = pcall(env.getcustomasset, fontDirectory .. "/manifest.json")
    if not manifestOk or not fontManifestId then
        if self._debug then
            log.warn("Failed to load font manifest for id: " .. tostring(resolvedId))
        end
        return self.defaultOptions.fallbackFont
    end

    local ok, loadedFont = pcall(Font.new, fontManifestId :: any, requestedFontWeight, requestedFontStyle)
    if not ok or not loadedFont then
        if self._debug then
            log.warn("Failed to load font for id: " .. tostring(resolvedId))
        end
        return self.defaultOptions.fallbackFont
    end

    local fontCache = self.fontCache
    if fontCache then
        fontCache[resolvedId] = {
            customId = fontManifestId,
            manifest = fontManifest,
            loadedFromDisk = true,
            variants = {
                [cacheKey] = loadedFont,
            },
        }
        if self._debug then
            log.print("Cached font for id: " .. tostring(resolvedId))
        end
    end
    return loadedFont
end

function fontManager.loadFont(
    self: FontManager,
    id: (number | string)?,
    fontWeight: Enum.FontWeight?,
    fontStyle: Enum.FontStyle?,
    saveToDisk: boolean?,
    skipCache: boolean?
): Font?
    if saveToDisk == nil then
        saveToDisk = self.defaultOptions.saveToDisk
    end
    if skipCache == nil then
        skipCache = self.defaultOptions.skipCache
    end
    local requestedFontWeight = fontWeight or Enum.FontWeight.Regular
    local requestedFontStyle = fontStyle or Enum.FontStyle.Normal
    local cacheKey = variantKey(requestedFontWeight, requestedFontStyle)
    local rawId = self.assetResolver:resolve(id)
    local resolvedId = resolveId(rawId)
    if not resolvedId then
        log.warn("Invalid font id: " .. tostring(id))
        return self.defaultOptions.fallbackFont
    end

    local fontCache = self.fontCache
    if fontCache and not skipCache then
        local cachedFont = fontCache[resolvedId]
        if cachedFont then
            local cachedVariant = cachedFont.variants and cachedFont.variants[cacheKey]
            if cachedVariant then
                if self._debug then
                    log.print("Loaded font from cache for id: " .. tostring(resolvedId))
                end
                return cachedVariant
            end

            local ok, loadedFont = pcall(Font.new, cachedFont.customId :: any, requestedFontWeight, requestedFontStyle)
            if ok and loadedFont then
                cachedFont.variants = cachedFont.variants or {}
                cachedFont.variants[cacheKey] = loadedFont
                if self._debug then
                    log.print("Loaded font variant from cache for id: " .. tostring(resolvedId))
                end
                return loadedFont
            else
                if self._debug then
                    log.warn("Failed to load font from cache for id: " .. tostring(resolvedId))
                end
                fontCache[resolvedId] = nil
                return self.defaultOptions.fallbackFont
            end
        end
    end

    if not saveToDisk then
        if self._debug then
            log.warn("Font loading without saving to disk can be detected by Anti-cheats.")
        end

        return self.defaultOptions.fallbackFont
    end

    local pendingLoads = self._pendingLoads
    local pendingKey = tostring(resolvedId) .. "|" .. cacheKey
    local waiting = pendingLoads[pendingKey]
    if waiting then
        table.insert(waiting, coroutine.running())
        return coroutine.yield()
    end
    pendingLoads[pendingKey] = {}

    local ok, result = pcall(fetchFont, self, resolvedId, requestedFontWeight, requestedFontStyle, cacheKey)
    local loadedFont = if ok then result else self.defaultOptions.fallbackFont

    waiting = pendingLoads[pendingKey]
    pendingLoads[pendingKey] = nil
    if waiting then
        for _, thread in waiting do
            coroutine.resume(thread, loadedFont)
        end
    end
    return loadedFont
end

function fontManager.resolve(self: FontManager, id: number | string): Font?
    local resolvedId = resolveId(id)
    if not resolvedId then
        return nil
    end

    local fontCache = self.fontCache
    if fontCache then
        local cached = fontCache[resolvedId]
        if cached then
            if self._debug then
                log.print("Resolved font for id: " .. tostring(resolvedId))
            end
            for _, font in pairs(cached.variants or {}) do
                return font
            end
        end
    end

    return nil
end

function fontManager.getFontFromId(self: FontManager, id: number | string): Font?
    return self:resolve(id)
end

return fontManager
end

Utility.functions = { Name = "functions", Parent = Utility }
Utility.functions.FindFirstChild = function(self, k) return self[k] end
Utility.functions.__loader = function(script, require)
local functions = {}

local textMetrics = require(script.Parent.textMetrics)
local colors = require(script.Parent.colors)
local flags = require(script.Parent.flagNames)

functions.textWidth = textMetrics.textWidth
functions.textHeight = textMetrics.textHeight
functions.deriveFlagFromName = flags.deriveFlagFromName
functions.contrastColor = colors.contrastColor
functions.toColorSequence = colors.toColorSequence
functions.contrastText = colors.contrastText

return functions
end

Utility.image = { Name = "image", Parent = Utility }
Utility.image.FindFirstChild = function(self, k) return self[k] end
Utility.image.__loader = function(script, require)
local imageCache = require(script.Parent.imageCache)
local variables = require(script.Parent.variables)

type AvatarCallback = imageCache.AvatarCallback
type PreloadCallback = imageCache.PreloadCallback

local image = {}

image.rewrites = imageCache.rewrites
image.onBlock = nil :: ((unknown) -> ())?

type PendingProperties = { [string]: boolean }

image.pending = {} :: { [number]: { [Instance]: PendingProperties } }

local settled = false

local imageProperties: { [string]: boolean } = {
    Image = true,
    HoverImage = true,
    PressedImage = true,
}

local function idOf(value: unknown): number?
    if type(value) == "number" then
        return value
    elseif type(value) == "string" then
        return tonumber(string.match(value, "^rbxassetid://(%d+)$"))
    end
    return nil
end

local function blocked(value: unknown): string
    if image.onBlock then
        image.onBlock(value)
    end
    return ""
end

function image.preload(onSettled: PreloadCallback?): (boolean, number)
    settled = false
    return imageCache.preload(function(failed)

        settled = true
        table.clear(image.pending)
        if onSettled then
            onSettled(failed)
        end
    end)
end

function image.avatar(userId: number, onReady: AvatarCallback?): string
    if not variables.secureMode then
        return `rbxthumb://type=AvatarHeadShot&id={userId}&w=48&h=48`
    end

    return imageCache.avatar(userId, onReady)
end

function image.assign(instance: Instance, property: string, value: unknown)
    local target = instance :: any
    if not imageProperties[property] then
        target[property] = value
        return
    end
    target[property] = image.resolve(value)

    if variables.secureMode and not settled then
        local id = idOf(value)
        if id and not image.rewrites[id] then
            local waiting = image.pending[id]
            if not waiting then
                waiting = setmetatable({}, { __mode = "k" }) :: any
                image.pending[id] = waiting
            end
            local properties = waiting[instance]
            if not properties then
                properties = {}
                waiting[instance] = properties
            end
            properties[property] = true
        end
    end
end

imageCache.onCached = function(id: number)
    local waiting = image.pending[id]
    if not waiting then
        return
    end
    local uri = image.rewrites[id]
    if uri then
        for instance, properties in waiting do
            if instance.Parent then
                local target = instance :: any
                for property in properties do
                    target[property] = uri
                end
            end
        end
    end
    image.pending[id] = nil
end

function image.resolve(value: unknown): string
    if value == nil or value == 0 or value == "" then
        return ""
    end

    if type(value) == "string" then
        if string.sub(value, 1, 11) == "rbxasset://" then
            return value
        end
        if string.sub(value, 1, 11) == "rbxthumb://" then
            return if variables.secureMode then blocked(value) else value
        end
    end

    local id: number? = nil
    if type(value) == "number" then
        id = value
    elseif type(value) == "string" then
        id = tonumber(string.match(value, "^rbxassetid://(%d+)$"))
    end

    local rewrite = if id then image.rewrites[id] else nil
    if rewrite then
        return rewrite
    end

    if variables.secureMode then
        return blocked(value)
    end

    if type(value) == "number" then
        return "rbxassetid://" .. value
    end
    if type(value) == "string" then
        return value
    end

    return blocked(value)
end

return image
end

Utility.imageCache = { Name = "imageCache", Parent = Utility }
Utility.imageCache.FindFirstChild = function(self, k) return self[k] end
Utility.imageCache.__loader = function(script, require)
local filesystem = require(script.Parent.filesystem)
local path = require(script.Parent.path)
local variables = require(script.Parent.variables)
local constants = require(script.Parent.constants)

export type RewriteMap = { [number]: string }
export type CacheSettledCallback = (failed: number) -> ()
export type PreloadCallback = CacheSettledCallback
export type AvatarCallback = (uri: string) -> ()
export type OnCachedCallback = (id: number) -> ()
export type ThumbnailEntry = {
    state: string?,
    imageUrl: string?,
}
export type ThumbnailResponse = {
    data: { ThumbnailEntry }?,
}
local imageCache = {}

local cacheRoot = variables.fileSystemManager:getRootFolder()
local cacheFolder = variables.fileSystemManager:getAssetsFolder()
local assetResolver = variables.assetResolver

local assetBase = "https://raw.githubusercontent.com/SiriusSoftwareLtd/rayfield-gen2/main/assets/"
local headshotPx = 48
local thumbEndpoint =
    "https://thumbnails.roblox.com/v1/users/avatar-headshot?userIds=%d&size=%dx%d&format=Png&isCircular=false"

local manifest: { [number]: string } = {}
for _, id in constants.icons do
    local iconId = id :: number
    manifest[iconId] = assetBase .. tostring(iconId) .. ".png"
end
local manifestSize = 0
for _ in manifest do
    manifestSize += 1
end

imageCache.rewrites = {} :: RewriteMap
imageCache.onCached = nil :: OnCachedCallback?

local pngMagic = "\137PNG\r\n\26\n"

local function cacheFile(filePath: string, url: string): string?

    if type(getfenv().getcustomasset) ~= "function" or typeof(filesystem.isfile) ~= "function" then
        return nil
    end
    if not filesystem.isfile(filePath) then
        pcall(filesystem.ensureFolder, cacheRoot)
        pcall(filesystem.ensureFolder, cacheFolder)
        local body = assetResolver:getAssetContentFromUrl(url, filePath, false)

        if not body or string.sub(body, 1, 8) ~= pngMagic then
            return nil
        end
        if not pcall(filesystem.writefile, filePath, body) then
            return nil
        end
    end
    local ok, uri = pcall(getfenv().getcustomasset, filePath)
    return if ok and type(uri) == "string" then uri else nil
end

local function avatarPath(userId: number): string
    return path.join(cacheFolder, "avatar_" .. tostring(userId) .. ".png")
end

local function decodeThumbnailUrl(body: string): string?
    local decodeOk, parsed = pcall(function()
        return variables.httpService:JSONDecode(body)
    end)
    if not decodeOk or type(parsed) ~= "table" then
        return nil
    end

    local data = (parsed :: ThumbnailResponse).data
    if type(data) ~= "table" then
        return nil
    end

    local entry = data[1]
    if type(entry) ~= "table" then
        return nil
    end

    local thumbnail = entry :: ThumbnailEntry
    if thumbnail.state == "Completed" and type(thumbnail.imageUrl) == "string" then
        return thumbnail.imageUrl
    end

    return nil
end

local function fetchAvatar(userId: number): string?
    local cdnUrl: string? = nil
    for attempt = 1, 4 do

        local body = assetResolver:getAssetContentFromUrl(
            string.format(thumbEndpoint, userId, headshotPx, headshotPx),
            "avatar:" .. tostring(userId),
            attempt > 1
        )
        if body then
            local imageUrl = decodeThumbnailUrl(body)
            if imageUrl then
                cdnUrl = imageUrl
                break
            end
        end
        if attempt < 4 then
            task.wait(0.3)
        end
    end
    if not cdnUrl then
        return nil
    end

    return cacheFile(avatarPath(userId), cdnUrl)
end

local pendingAvatars: { [number]: { AvatarCallback } } = {}
local failedAvatars: { [number]: boolean } = {}

function imageCache.preload(onSettled: PreloadCallback?): (boolean, number)
    local env = getfenv()
    if type(env.getcustomasset) ~= "function" or typeof(filesystem.isfile) ~= "function" then
        if onSettled then

            task.defer(onSettled, manifestSize)
        end
        return false, manifestSize
    end

    local rewrites = imageCache.rewrites
    table.clear(rewrites)

    local function settle()
        if not onSettled then
            return
        end
        local failed = 0
        for id in manifest do
            if not rewrites[id] then
                failed += 1
            end
        end
        onSettled(failed)
    end

    local pending, missing = 0, 0
    local spawning = true
    for id, url in manifest do
        local filePath = path.join(cacheFolder, tostring(id) .. ".png")
        local uri: string? = nil
        if filesystem.isfile(filePath) then
            local ok, res = pcall(env.getcustomasset, filePath)
            uri = if ok and type(res) == "string" then res else nil
        end
        if uri then

            rewrites[id] = uri
        else

            missing += 1
            pending += 1
            task.spawn(function()
                local cached = cacheFile(filePath, url)
                if cached then
                    rewrites[id] = cached
                    if imageCache.onCached then

                        pcall(imageCache.onCached, id)
                    end
                end
                pending -= 1
                if pending == 0 and not spawning then
                    settle()
                end
            end)
        end
    end

    spawning = false
    if pending == 0 then
        settle()
    end

    return missing == 0, missing
end

function imageCache.avatar(userId: unknown, onReady: AvatarCallback?): string
    if type(userId) ~= "number" then
        return ""
    end

    if typeof(filesystem.isfile) ~= "function" then
        return ""
    end

    local filePath = avatarPath(userId)
    if filesystem.isfile(filePath) then
        local ok, uri = pcall(getfenv().getcustomasset, filePath)
        if ok and type(uri) == "string" then
            return uri
        end
    end

    if failedAvatars[userId] then
        return ""
    end

    local waiting = pendingAvatars[userId]
    if waiting then
        if onReady then
            table.insert(waiting, onReady)
        end
        return ""
    end

    if onReady then
        pendingAvatars[userId] = { onReady }
        task.spawn(function()
            local uri = fetchAvatar(userId)
            local callbacks = pendingAvatars[userId]
            pendingAvatars[userId] = nil
            if not uri then
                failedAvatars[userId] = true
                return
            end
            if callbacks then
                for _, callback in callbacks do

                    pcall(callback, uri)
                end
            end
        end)
    end

    return ""
end

return imageCache
end

Utility.layouts = { Name = "layouts", Parent = Utility }
Utility.layouts.FindFirstChild = function(self, k) return self[k] end
Utility.layouts.__loader = function(script, require)
local layouts = {}

local topbarHeight = 64

local tabStripTop = topbarHeight - 1
local tabStripHeight = 38
local tabStripGap = 3

export type Mode = "top" | "sidebar"

export type Layout = {
    mode: Mode,

    topbarHeight: number,
    chromeHeight: number,

    pageDirection: Enum.FillDirection,

    fadeSize: UDim2,
    fadeTransparency: NumberSequence,
    fadeCorners: { string }?,

    tabStripTop: number?,
    tabStripHeight: number?,

    railWidth: number?,
    railCollapsedWidth: number?,
    railCollapseBelow: number?,
    rowHeight: number?,
    rowCornerRadius: number?,
    rowSpacing: number?,
    railPadding: number?,
    rowInset: number?,
    rowPadding: number?,
    rowContentSpacing: number?,
    rowIconSize: number?,
    footerHeight: number?,
    avatarSize: number?,
    cardTransparency: number?,
    cardStrokeRotation: number?,
    cardStrokeTransparency: NumberSequence?,
    cardCorners: { string }?,
}

layouts.top = {
    mode = "top" :: Mode,

    topbarHeight = topbarHeight,
    chromeHeight = tabStripTop + tabStripHeight + tabStripGap,

    tabStripTop = tabStripTop,
    tabStripHeight = tabStripHeight,

    pageDirection = Enum.FillDirection.Horizontal,

    fadeSize = UDim2.new(1, 0, -0.093, 100),
    fadeTransparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0),
        NumberSequenceKeypoint.new(0.4414, 0),
        NumberSequenceKeypoint.new(0.7007, 0.631),
        NumberSequenceKeypoint.new(1, 1),
    }),
} :: Layout

layouts.sidebar = {
    mode = "sidebar" :: Mode,

    topbarHeight = topbarHeight,
    chromeHeight = topbarHeight,

    railWidth = 219,

    railCollapsedWidth = 64,
    railCollapseBelow = 589,

    rowHeight = 38,
    rowCornerRadius = 14,
    rowSpacing = 4,

    railPadding = 17,
    rowInset = 15,
    rowPadding = 10,
    rowContentSpacing = 6,
    rowIconSize = 20,

    footerHeight = 60,
    avatarSize = 34,

    pageDirection = Enum.FillDirection.Vertical,

    cardTransparency = 0.98,
    cardStrokeRotation = 55,

    cardCorners = { "TopLeftRadius", "BottomRightRadius" },
    cardStrokeTransparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0.9),
        NumberSequenceKeypoint.new(0.128, 0.95),
        NumberSequenceKeypoint.new(0.414, 0.985),
        NumberSequenceKeypoint.new(1, 1),
    }),

    fadeSize = UDim2.new(1, 0, 0, 55),
    fadeTransparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0),
        NumberSequenceKeypoint.new(0.377, 0),
        NumberSequenceKeypoint.new(1, 1),
    }),

    fadeCorners = { "BottomRightRadius" },
} :: Layout

function layouts.get(mode: unknown): Layout?
    if mode == "sidebar" then
        return layouts.sidebar
    elseif mode == "top" then
        return layouts.top
    end
    return nil
end

function layouts.railWidthFor(layout: Layout, windowWidth: number): number
    if layout.mode ~= "sidebar" then
        return 0
    end
    local full = layout.railWidth :: number
    if windowWidth < (layout.railCollapseBelow :: number) then
        return layout.railCollapsedWidth :: number
    end
    return full
end

return layouts
end

Utility.locale = { Name = "locale", Parent = Utility }
Utility.locale.FindFirstChild = function(self, k) return self[k] end
Utility.locale.__loader = function(script, require)
local variables = require(script.Parent.variables)
local log = require(script.Parent.log)

local locale = {}

export type LocaleToken = { [any]: string }
export type Translator = (source: string, localeId: string) -> string?
export type TranslationTables = { [string]: { [string]: string } }

locale.strings = {} :: TranslationTables

locale.current = "en"
locale.translator = nil :: Translator?

local tokenTag = {}

local function languageOf(id: string): string
    return string.match(id, "^(%a+)") or id
end

function locale.t(source: unknown): unknown
    if type(source) ~= "string" or source == "" then
        return source
    end
    return { [tokenTag] = source }
end

function locale.isToken(value: unknown): boolean
    return type(value) == "table" and type((value :: { [any]: unknown })[tokenTag]) == "string"
end

function locale.sourceOf(token: LocaleToken): string
    return token[tokenTag]
end

function locale.resolve(source: unknown): any
    if type(source) ~= "string" then
        return source
    end

    if locale.translator then
        local ok, translated = pcall(locale.translator, source, locale.current)
        if ok and type(translated) == "string" and translated ~= "" then
            return translated
        end
    end

    local exact = locale.strings[locale.current]
    if exact and exact[source] then
        return exact[source]
    end

    local language = locale.strings[languageOf(locale.current)]
    if language and language[source] then
        return language[source]
    end

    return source
end

function locale.register(tables: TranslationTables?)
    if type(tables) ~= "table" then
        return
    end
    for id, entries in tables do
        if type(id) == "string" and type(entries) == "table" then
            id = string.lower(id)
            local target = locale.strings[id]
            if not target then
                target = {}
                locale.strings[id] = target
            end
            for source, translated in entries do
                if type(source) == "string" and type(translated) == "string" then
                    target[source] = translated
                else
                    log.warn(`Rayfield: skipping a '{id}' translation, entries must be string to string.`)
                end
            end
        end
    end
end

function locale.setActive(localeId: string?): string
    locale.current = if type(localeId) == "string" and localeId ~= "" then string.lower(localeId) else "en"
    return locale.current
end

function locale.detect(): string
    local id = variables.localizationService.RobloxLocaleId
    if type(id) == "string" and id ~= "" then
        return string.lower(id)
    end
    return "en"
end

return locale
end

Utility.lockable = { Name = "lockable", Parent = Utility }
Utility.lockable.FindFirstChild = function(self, k) return self[k] end
Utility.lockable.__loader = function(script, require)
local function lockable<T>(class: T): T
    local target = class :: any

    function target:Lock(reason: string?)
        self.window:_setElementLocked(self, true, reason)
    end

    function target:Unlock()
        self.window:_setElementLocked(self, false)
    end

    function target:IsLocked(): boolean
        return self.locked == true
    end

    return class
end

return lockable
end

Utility.log = { Name = "log", Parent = Utility }
Utility.log.FindFirstChild = function(self, k) return self[k] end
Utility.log.__loader = function(script, require)
local runtime = require(script.Parent.runtime)

local log = {}

type SuppressPredicate = () -> boolean

local function defaultSecureModeSource(): boolean
    return runtime.secureMode
end

local secureModeSource: SuppressPredicate = defaultSecureModeSource
local suppressPredicate: SuppressPredicate? = nil

function log.setSecureModeSource(source: SuppressPredicate?)
    secureModeSource = if type(source) == "function" then source else defaultSecureModeSource
end

function log.setSuppressPredicate(predicate: SuppressPredicate?)
    suppressPredicate = if type(predicate) == "function" then predicate else nil
end

local function shouldSuppress(): boolean
    if suppressPredicate and suppressPredicate() then
        return true
    end
    return secureModeSource()
end

function log.warn(...)
    if shouldSuppress() then
        return
    end
    warn(...)
end

function log.print(...)
    if shouldSuppress() then
        return
    end
    print(...)
end

return log
end

Utility.moveable = { Name = "moveable", Parent = Utility }
Utility.moveable.FindFirstChild = function(self, k) return self[k] end
Utility.moveable.__loader = function(script, require)
local function moveable<T>(class: T): T
    local target = class :: any

    function target:MoveTo(index: number)
        self.tab:_moveElement(self, index)
    end

    function target:MoveToTop()
        self.tab:_moveElement(self, 1)
    end

    function target:MoveToBottom()
        self.tab:_moveElement(self, #self.tab.elements)
    end

    function target:MoveUp()
        local idx = table.find(self.tab.elements, self)
        if idx then
            self.tab:_moveElement(self, idx - 1)
        end
    end

    function target:MoveDown()
        local idx = table.find(self.tab.elements, self)
        if idx then
            self.tab:_moveElement(self, idx + 1)
        end
    end

    return class
end

return moveable
end

Utility.network = { Name = "network", Parent = Utility }
Utility.network.FindFirstChild = function(self, k) return self[k] end
Utility.network.__loader = function(script, require)
local network = {}
network.__index = network

export type RequestFn = (...any) -> any

function network.getRequestFn(env: any?): RequestFn?
    env = env or getfenv()
    return env.request
        or env.http_request
        or (env.http and env.http.request)
        or (env.syn and env.syn.request)
        or (env.fluxus and env.fluxus.request)
end

return network
end

Utility.odometer = { Name = "odometer", Parent = Utility }
Utility.odometer.FindFirstChild = function(self, k) return self[k] end
Utility.odometer.__loader = function(script, require)
local variables = require(script.Parent.variables)
local TextService = variables.textService

local odometer = {}
odometer.__index = odometer

local stripLength = 20

local function measure(font, size, text)
    local params = Instance.new("GetTextBoundsParams")
    params.Text = text
    params.Font = font
    params.Size = size
    params.Width = math.huge
    local ok, bounds = pcall(TextService.GetTextBoundsAsync, TextService, params)
    return if ok then bounds else Vector2.new(size * 0.6, size)
end

local metricsCache = {}
local function digitMetrics(font, size)

    local key = tostring(font.Family)
        .. "|"
        .. tostring(font.Weight)
        .. "|"
        .. tostring(font.Style)
        .. "|"
        .. tostring(size)
    local cached = metricsCache[key]
    if cached then
        return cached
    end

    local advance, maxWidth = {}, 0
    for d = 0, 9 do
        local w = math.ceil(measure(font, size, tostring(d)).X)
        advance[d] = w
        if w > maxWidth then
            maxWidth = w
        end
    end
    cached = { advance = advance, maxWidth = maxWidth }
    metricsCache[key] = cached
    return cached
end

function odometer.new(window, container, opts)
    opts = opts or {}
    local self = setmetatable({
        window = window,
        container = container,
        textSize = opts.textSize or 16,
        transparency = opts.transparency or 1,
        duration = opts.duration or 0.55,
        slots = {},
        length = 0,
    }, odometer)

    self.roll = TweenInfo.new(self.duration, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)

    self.zIndex = math.max(container.ZIndex + 1, 6)

    self.height = math.ceil(self.textSize)

    local metrics = digitMetrics(window.theme.Font, self.textSize)
    self.advance = metrics.advance
    self.maxWidth = metrics.maxWidth

    window:Create("UIListLayout", {
        FillDirection = Enum.FillDirection.Horizontal,
        VerticalAlignment = Enum.VerticalAlignment.Center,
        HorizontalAlignment = opts.alignment or Enum.HorizontalAlignment.Left,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, 0),

        Parent = container,
    })

    return self
end

function odometer:_reel(index)
    local slot = self.slots[index]
    if slot.reel then
        return slot.reel
    end

    local cell = self.window:Create("Frame", {
        Name = "Reel",
        Size = UDim2.fromOffset(self.maxWidth, self.height),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ClipsDescendants = true,
        ZIndex = self.zIndex,

        Parent = self.container,
    })

    local strip = self.window:Create("Frame", {
        Size = UDim2.fromOffset(self.maxWidth, self.height),
        AnchorPoint = Vector2.new(0.5, 0),
        Position = UDim2.new(0.5, 0, 0, 0),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ZIndex = self.zIndex,

        Parent = cell,
    })

    for i = 0, stripLength - 1 do
        self.window:Create("TextLabel", {
            Text = tostring(i % 10),
            Position = UDim2.fromOffset(0, i * self.height),
            Size = UDim2.fromOffset(self.maxWidth, self.height),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            TextSize = self.textSize,
            TextXAlignment = Enum.TextXAlignment.Center,
            TextYAlignment = Enum.TextYAlignment.Center,
            TextTransparency = self.transparency,
            ZIndex = self.zIndex,

            Parent = strip,
        }, { TextColor3 = "ContentColor", FontFace = "Font" })
    end

    local reel = { cell = cell, strip = strip, digit = 0, target = 0, stripTween = nil, sizeTween = nil }
    slot.reel = reel
    return reel
end

function odometer:_static(index)
    local slot = self.slots[index]
    if slot.static then
        return slot.static
    end

    local label = self.window:Create("TextLabel", {
        Name = "Static",
        Size = UDim2.fromOffset(0, self.height),
        AutomaticSize = Enum.AutomaticSize.X,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        TextSize = self.textSize,
        TextXAlignment = Enum.TextXAlignment.Center,
        TextYAlignment = Enum.TextYAlignment.Center,
        TextTransparency = self.transparency,
        ZIndex = self.zIndex,

        Parent = self.container,
    }, { TextColor3 = "ContentColor", FontFace = "Font" })

    slot.static = label
    return label
end

local function stopReel(reel)
    if reel.stripTween then
        reel.stripTween:Cancel()
        reel.stripTween = nil
    end
    if reel.sizeTween then
        reel.sizeTween:Cancel()
        reel.sizeTween = nil
    end
end

function odometer:_reelSnap(reel, digit)
    stopReel(reel)
    reel.cell.Size = UDim2.fromOffset(self.advance[digit], self.height)
    reel.strip.Position = UDim2.new(0.5, 0, 0, -digit * self.height)
    reel.digit = digit
    reel.target = digit
end

function odometer:_reelRoll(reel, digit, up)

    if reel.stripTween or reel.sizeTween then
        self:_reelSnap(reel, reel.target)
    end

    local a = reel.digit
    if a == digit then
        return
    end

    local startIndex, targetIndex
    if up then
        startIndex = a
        targetIndex = a + (digit - a) % 10
    else
        startIndex = a + 10
        targetIndex = startIndex - (a - digit) % 10
    end

    reel.strip.Position = UDim2.new(0.5, 0, 0, -startIndex * self.height)
    reel.target = digit

    local stripTween = variables.tweenService:Create(reel.strip, self.roll, {
        Position = UDim2.new(0.5, 0, 0, -targetIndex * self.height),
    })
    local sizeTween = variables.tweenService:Create(reel.cell, self.roll, {
        Size = UDim2.fromOffset(self.advance[digit], self.height),
    })
    reel.stripTween = stripTween
    reel.sizeTween = sizeTween
    stripTween.Completed:Connect(function(state)
        if state == Enum.PlaybackState.Completed and reel.stripTween == stripTween then
            self:_reelSnap(reel, digit)
        end
    end)
    stripTween:Play()
    sizeTween:Play()
    reel.digit = digit
end

function odometer:_putDigit(index, digit, up, animate)
    local reel = self:_reel(index)
    local wasHidden = not reel.cell.Visible
    reel.cell.Visible = true
    reel.cell.LayoutOrder = -index
    if self.slots[index].static then
        self.slots[index].static.Visible = false
    end
    if animate and not wasHidden then
        self:_reelRoll(reel, digit, up)
    else
        self:_reelSnap(reel, digit)
    end
end

function odometer:_putStatic(index, char)
    local label = self:_static(index)
    if not label.Visible then

        label.TextTransparency = self.transparency
    end
    label.Text = char
    label.Visible = true
    label.LayoutOrder = -index
    if self.slots[index].reel then
        self.slots[index].reel.cell.Visible = false
    end
end

function odometer:_hide(index)
    local slot = self.slots[index]
    if not slot then
        return
    end
    if slot.reel then
        slot.reel.cell.Visible = false
    end
    if slot.static then
        slot.static.Visible = false
    end
end

function odometer:_render(text, animate, up)
    text = tostring(text)

    if text == self._lastText then
        return
    end
    self._lastText = text

    local chars = {}
    for _, code in utf8.codes(text) do
        table.insert(chars, utf8.char(code))
    end

    local n = #chars
    for i = 0, math.max(n, self.length) - 1 do
        self.slots[i] = self.slots[i] or {}
        if i < n then
            local char = chars[n - i]
            if char:match("%d") then
                self:_putDigit(i, tonumber(char), up, animate)
            else
                self:_putStatic(i, char)
            end
        else
            self:_hide(i)
        end
    end
    self.length = n
end

function odometer:to(text, up)
    self:_render(text, true, up)
end

function odometer:snap(text)
    self:_render(text, false, true)
end

function odometer:reveal(target, animate, info)
    self.transparency = target
    for _, slot in self.slots do
        if slot.static and slot.static.Visible then
            self.window:_reveal(slot.static, { TextTransparency = target }, animate, info)
        end
        if slot.reel then
            for _, lbl in slot.reel.strip:GetChildren() do
                if lbl:IsA("TextLabel") then
                    self.window:_reveal(lbl, { TextTransparency = target }, animate, info)
                end
            end
        end
    end
end

return odometer
end

Utility.ordering = { Name = "ordering", Parent = Utility }
Utility.ordering.FindFirstChild = function(self, k) return self[k] end
Utility.ordering.__loader = function(script, require)
type OrderedElement = {
    main: GuiObject,
    descriptor: { main: GuiObject }?,
}

local function assignOrder(element: OrderedElement, order: number)
    element.main.LayoutOrder = order
    if element.descriptor then
        element.descriptor.main.LayoutOrder = order + 1
    end
end

return assignOrder
end

Utility.path = { Name = "path", Parent = Utility }
Utility.path.FindFirstChild = function(self, k) return self[k] end
Utility.path.__loader = function(script, require)
local path = {}

function path.join(basePath: string, childPath: string?): string
    if not childPath or childPath == "" then
        return basePath
    end

    return basePath .. "/" .. childPath
end

local function stripTraversal(text: string): string
    local previous
    repeat
        previous = text
        text = text:gsub("%.%.", "")
    until text == previous
    return text
end

function path.sanitizeFolder(value: unknown): string
    local text = tostring(value):gsub("\\", "/"):gsub('[:<>"|?*%c]', "")
    text = stripTraversal(text):gsub("/+", "/")
    return (text:gsub("^/+", ""))
end

function path.sanitizeFile(value: unknown): string
    local text = tostring(value):gsub("[/\\]", ""):gsub('[:<>"|?*%c]', "")
    return stripTraversal(text)
end

function path.basename(value: unknown): string
    return tostring(value):match("[^/\\]+$") or tostring(value)
end

function path.stripExtension(value: unknown, extension: string?): string
    if extension and extension ~= "" then
        local text = tostring(value)
        if text:sub(-#extension) == extension then
            return text:sub(1, -#extension - 1)
        end
        return text
    end

    local base = tostring(value):match("^(.+)%.%w+$")
    return base or tostring(value)
end

return path
end

Utility.persistence = { Name = "persistence", Parent = Utility }
Utility.persistence.FindFirstChild = function(self, k) return self[k] end
Utility.persistence.__loader = function(script, require)
local persistence = {}

local config = require(script.Parent.persistenceConfig)
local settings = require(script.Parent.persistenceSettings)

persistence.getPath = config.getPath
persistence.save = config.save
persistence.load = config.load
persistence.applyTo = config.applyTo
persistence.list = config.list
persistence.delete = config.delete
persistence.getSettingsPath = settings.getSettingsPath
persistence.saveSettings = settings.saveSettings
persistence.loadSettings = settings.loadSettings

return persistence
end

Utility.persistenceConfig = { Name = "persistenceConfig", Parent = Utility }
Utility.persistenceConfig.FindFirstChild = function(self, k) return self[k] end
Utility.persistenceConfig.__loader = function(script, require)
local variables = require(script.Parent.variables)
local filesystem = require(script.Parent.filesystem)
local log = require(script.Parent.log)
local path = require(script.Parent.path)
local paths = require(script.Parent.persistencePaths)
local atomic = require(script.Parent.persistenceWrite)

local persistenceConfig = {}

type PersistedControl = {
    value: unknown,
    flag: string?,
    _canBeNil: boolean?,
    _serialize: ((PersistedControl) -> unknown)?,
    _deserialize: ((PersistedControl, unknown) -> ())?,
    Set: (PersistedControl, unknown) -> (),
}

type ConfigWindow = {
    controls: { [string]: PersistedControl },
    configuration: {
        fileName: string?,
        customFolder: string?,
    },
    name: string,
    _loading: boolean?,
    _loadedConfig: { [string]: unknown }?,
    _loadedConfigPath: string?,
}

function persistenceConfig.getPath(window: ConfigWindow, name: unknown?): (string?, string?)
    return paths.getConfigPath(window, name)
end

function persistenceConfig.save(window: ConfigWindow, name: unknown?): boolean
    local dir, fullPath = persistenceConfig.getPath(window, name)
    if not dir or not fullPath then
        log.warn("Rayfield: configuration name '" .. tostring(name) .. "' has no usable characters")
        return false
    end

    if typeof(filesystem.writefile) ~= "function" then
        return false
    end

    local flags: { [string]: unknown } = {}
    for flag, control in window.controls do
        local ok, value = pcall(function()
            local serialize = control._serialize
            if serialize then
                return serialize(control)
            end
            return control.value
        end)
        if ok then
            flags[flag] = value
        else
            log.warn("Rayfield: Failed to serialize flag '" .. tostring(flag) .. "' - " .. tostring(value))
        end
    end

    local loadedConfig = window._loadedConfig
    if loadedConfig and window._loadedConfigPath == fullPath then
        for flag, value in loadedConfig do
            if window.controls[flag] == nil then
                flags[flag] = value
            end
        end
    end

    local encodeSuccess, encoded = pcall(variables.httpService.JSONEncode, variables.httpService, flags)
    if not encodeSuccess then
        log.warn("Rayfield: Failed to encode configuration - " .. tostring(encoded))
        return false
    end

    local ok, err = pcall(function()
        atomic.write(dir, fullPath, encoded)
    end)

    if not ok then
        log.warn("Rayfield: Failed to save configuration - " .. tostring(err))
        return false
    end

    if window._loadedConfigPath == nil or window._loadedConfigPath == fullPath then
        window._loadedConfig = flags
        window._loadedConfigPath = fullPath
    end

    return true
end

local function decodeFile(fullPath: string): ({ [string]: unknown }?, string?)
    if not filesystem.isfile(fullPath) then
        return nil, nil
    end

    local readOk, contents = pcall(filesystem.readfile, fullPath)
    if not readOk or type(contents) ~= "string" then
        log.warn("Rayfield: Failed to read configuration file")
        return nil, nil
    end

    local decodeOk, parsed = pcall(variables.httpService.JSONDecode, variables.httpService, contents)

    if not decodeOk or type(parsed) ~= "table" then
        return nil, contents
    end

    return parsed :: { [string]: unknown }, contents
end

local function backupPathFor(fullPath: string): string

    local stem = path.stripExtension(fullPath, ".rfld")
    local candidate = stem .. " (Incorrect Format).rfld"
    local index = 2
    while index <= 100 and filesystem.isfile(candidate) do
        candidate = stem .. " (Incorrect Format " .. index .. ").rfld"
        index += 1
    end
    return candidate
end

function persistenceConfig.load(window: ConfigWindow, name: unknown?): boolean
    local dir, fullPath = persistenceConfig.getPath(window, name)
    if not dir or not fullPath then
        log.warn("Rayfield: configuration name '" .. tostring(name) .. "' has no usable characters")
        return false
    end

    if typeof(filesystem.isfile) ~= "function" then
        return false
    end

    local parsedFlags, raw = decodeFile(fullPath)

    if not parsedFlags and filesystem.isfile(fullPath) then
        local parked, parkedRaw = decodeFile(atomic.tempPathFor(fullPath))
        if parked and parkedRaw then
            parsedFlags = parked

            pcall(atomic.write, dir, fullPath, parkedRaw)
        end
    end

    if not parsedFlags then
        if raw then
            log.warn("Rayfield: Configuration file has an invalid format, backing up and resetting")
            local backupPath = backupPathFor(fullPath)
            pcall(function()
                filesystem.ensureDir(dir)
                filesystem.writefile(backupPath, raw)
                filesystem.delfile(fullPath)
            end)
        end
        return false
    end

    local flags = parsedFlags :: { [string]: unknown }
    local wasLoading = window._loading
    window._loading = true

    local applyOk, applyErr = pcall(function()
        for flag, control in window.controls do
            persistenceConfig.applyTo(control, flags[flag])
        end
    end)

    window._loading = wasLoading
    if not applyOk then
        log.warn("Rayfield: Failed to apply configuration - " .. tostring(applyErr))
    end

    window._loadedConfig = flags
    window._loadedConfigPath = fullPath

    return true
end

function persistenceConfig.applyTo(control: PersistedControl, value: unknown)
    if value == nil and not control._canBeNil then
        return
    end
    local ok, err = pcall(function()
        local deserialize = control._deserialize
        if deserialize then
            deserialize(control, value)
        else
            control:Set(value)
        end
    end)
    if not ok then
        log.warn("Rayfield: Failed to restore flag '" .. tostring(control.flag) .. "' - " .. tostring(err))
    end
end

function persistenceConfig.list(window: ConfigWindow): { string }
    local dir = persistenceConfig.getPath(window)

    local names: { string } = {}

    if not dir then
        return names
    end
    local ok, files = pcall(filesystem.listfiles, dir)
    if not ok or type(files) ~= "table" then
        return names
    end

    for _, filePath in files do
        local file = path.basename(filePath)

        if file:sub(-5) == ".rfld" then
            local base = path.stripExtension(file, ".rfld")
            if base and base ~= "" and not base:find(" %(Incorrect Format[^%)]*%)$") then
                table.insert(names, base)
            end
        end
    end

    table.sort(names)
    return names
end

function persistenceConfig.delete(window: ConfigWindow, name: unknown): boolean
    if type(name) ~= "string" or name == "" then
        return false
    end

    local _, fullPath = persistenceConfig.getPath(window, name)
    if not fullPath then
        return false
    end
    if typeof(filesystem.isfile) ~= "function" or not filesystem.isfile(fullPath) then
        return false
    end

    pcall(filesystem.delfile, atomic.tempPathFor(fullPath))

    return (pcall(filesystem.delfile, fullPath))
end

return persistenceConfig
end

Utility.persistencePaths = { Name = "persistencePaths", Parent = Utility }
Utility.persistencePaths.FindFirstChild = function(self, k) return self[k] end
Utility.persistencePaths.__loader = function(script, require)
local variables = require(script.Parent.variables)
local path = require(script.Parent.path)

local paths = {}

type ConfigWindow = {
    configuration: {
        fileName: string?,
        customFolder: string?,
    },
    name: string,
}

function paths.getConfigPath(window: ConfigWindow, name: unknown?): (string?, string?)
    local dir = variables.fileSystemManager:getPath("Configurations")
    if window.configuration.customFolder then
        dir = path.join(dir, path.sanitizeFolder(window.configuration.customFolder))
    end
    if name ~= nil then

        local safe = path.sanitizeFile(name)
        if safe == "" then
            return nil, nil
        end
        return dir, path.join(dir, safe .. ".rfld")
    end
    local safe = path.sanitizeFile(window.configuration.fileName or window.name)
    if safe == "" then
        safe = path.sanitizeFile(window.name)
    end
    if safe == "" then
        safe = "Configuration"
    end
    return dir, path.join(dir, safe .. ".rfld")
end

function paths.getSettingsPath(): (string, string)
    local dir = variables.fileSystemManager:getPath("Settings")
    return dir, path.join(dir, "rayfield.rfld")
end

return paths
end

Utility.persistenceSettings = { Name = "persistenceSettings", Parent = Utility }
Utility.persistenceSettings.FindFirstChild = function(self, k) return self[k] end
Utility.persistenceSettings.__loader = function(script, require)
local variables = require(script.Parent.variables)
local filesystem = require(script.Parent.filesystem)
local paths = require(script.Parent.persistencePaths)
local atomic = require(script.Parent.persistenceWrite)
local enums = require(script.Parent.enums)

local persistenceSettings = {}

type SettingsWindow = {
    settings: {
        toggleKeybind: EnumItem,
        mouseOverride: boolean,
        keepOnScreen: boolean,
        welcomeToast: boolean,
        haptics: boolean,
        showProfile: boolean,
    },
}

type DecodedSettings = {
    toggleKeybind: { [number]: unknown }?,
    mouseOverride: unknown?,
    keepOnScreen: unknown?,
    welcomeToast: unknown?,
    haptics: unknown?,
    showProfile: unknown?,
}

function persistenceSettings.getSettingsPath(): (string, string)
    return paths.getSettingsPath()
end

function persistenceSettings.saveSettings(window: SettingsWindow): boolean
    local dir, fullPath = persistenceSettings.getSettingsPath()

    local data: { [string]: unknown } = {
        toggleKeybind = {
            tostring(window.settings.toggleKeybind.EnumType),
            window.settings.toggleKeybind.Value,
        } :: { unknown },
        mouseOverride = window.settings.mouseOverride,
        keepOnScreen = window.settings.keepOnScreen,
        welcomeToast = window.settings.welcomeToast,
        haptics = window.settings.haptics,
        showProfile = window.settings.showProfile,
    }

    local ok, encoded = pcall(variables.httpService.JSONEncode, variables.httpService, data)
    if not ok then
        return false
    end

    local writeOk = pcall(atomic.write, dir, fullPath, encoded)

    if not writeOk then
        return false
    end

    return true
end

local function decodeFile(fullPath: string): (DecodedSettings?, string?)
    local fileExists = false
    pcall(function()
        fileExists = filesystem.isfile(fullPath)
    end)
    if not fileExists then
        return nil, nil
    end

    local readOk, contents = pcall(filesystem.readfile, fullPath)
    if not readOk or type(contents) ~= "string" then
        return nil, nil
    end

    local decodeOk, parsed = pcall(variables.httpService.JSONDecode, variables.httpService, contents)

    if not decodeOk or type(parsed) ~= "table" then
        return nil, contents
    end

    return parsed :: DecodedSettings, contents
end

function persistenceSettings.loadSettings(window: SettingsWindow): boolean
    local dir, fullPath = persistenceSettings.getSettingsPath()

    local settings = decodeFile(fullPath)

    if not settings then
        local parked, parkedRaw = decodeFile(atomic.tempPathFor(fullPath))
        if parked and parkedRaw then
            settings = parked

            pcall(atomic.write, dir, fullPath, parkedRaw)
        end
    end

    if not settings then
        return false
    end

    if settings.toggleKeybind then
        pcall(function()
            local enumName = tostring(settings.toggleKeybind[1]):gsub("^Enum%.", "")
            local enumType = (Enum :: any)[enumName]
            if enumType then
                local enumItem = enums.itemFromValue(enumType, settings.toggleKeybind[2])
                if enumItem then
                    window.settings.toggleKeybind = enumItem
                end
            end
        end)
    end

    if type(settings.mouseOverride) == "boolean" then
        window.settings.mouseOverride = settings.mouseOverride
    end

    if type(settings.keepOnScreen) == "boolean" then
        window.settings.keepOnScreen = settings.keepOnScreen
    end

    if type(settings.welcomeToast) == "boolean" then
        window.settings.welcomeToast = settings.welcomeToast
    end

    if type(settings.haptics) == "boolean" then
        window.settings.haptics = settings.haptics
    end

    if type(settings.showProfile) == "boolean" then
        window.settings.showProfile = settings.showProfile
    end

    return true
end

return persistenceSettings
end

Utility.persistenceWrite = { Name = "persistenceWrite", Parent = Utility }
Utility.persistenceWrite.FindFirstChild = function(self, k) return self[k] end
Utility.persistenceWrite.__loader = function(script, require)
local filesystem = require(script.Parent.filesystem)

local persistenceWrite = {}

local parkedExtension = ".saving"

function persistenceWrite.tempPathFor(fullPath: string): string
    return fullPath .. parkedExtension
end

function persistenceWrite.write(dir: string, fullPath: string, contents: string)
    local tempPath = persistenceWrite.tempPathFor(fullPath)

    filesystem.ensureDir(dir)
    filesystem.writefile(tempPath, contents)

    if filesystem.readfile(tempPath) ~= contents then
        error("parked copy did not write cleanly")
    end

    filesystem.writefile(fullPath, contents)
    pcall(filesystem.delfile, tempPath)
end

return persistenceWrite
end

Utility.runtime = { Name = "runtime", Parent = Utility }
Utility.runtime.FindFirstChild = function(self, k) return self[k] end
Utility.runtime.__loader = function(script, require)
local services = require(script.Parent.services)

export type RuntimeState = {
    secureMode: boolean,
    coreGui: CoreGui,
    workspace: Workspace,
    runService: RunService,
    userInputService: UserInputService,
    guiService: GuiService,
    localPlayer: Player?,
    tweenService: TweenService,
    httpService: HttpService,
    textService: TextService,
    replicatedStorage: ReplicatedStorage,
    localizationService: LocalizationService,
    guiContainer: Instance,
}

local runtime = {} :: RuntimeState

runtime.secureMode = (function()

    if typeof(getgenv) ~= "function" then
        return false
    end
    local ok, val = pcall(function()
        return getgenv().RAYFIELD_SECURE
    end)
    return ok and val == true
end)()

runtime.coreGui = services.getService("CoreGui") :: CoreGui
runtime.workspace = services.getService("Workspace") :: Workspace
runtime.runService = services.getService("RunService") :: RunService
runtime.userInputService = services.getService("UserInputService") :: UserInputService
runtime.guiService = services.getService("GuiService") :: GuiService
runtime.localPlayer = (services.getService("Players") :: Players).LocalPlayer
runtime.tweenService = services.getService("TweenService") :: TweenService
runtime.httpService = services.getService("HttpService") :: HttpService
runtime.textService = services.getService("TextService") :: TextService
runtime.replicatedStorage = services.getService("ReplicatedStorage") :: ReplicatedStorage
runtime.localizationService = services.getService("LocalizationService") :: LocalizationService

runtime.guiContainer = (function(): Instance
    if runtime.runService:IsStudio() then

        local player = runtime.localPlayer
        if player then
            return player.PlayerGui
        end
        return runtime.coreGui
    end
    if typeof(gethui) == "function" then
        local ok, container = pcall(gethui)
        if ok and container then
            return container
        end
    end
    return runtime.coreGui
end)()

return runtime
end

Utility.textMetrics = { Name = "textMetrics", Parent = Utility }
Utility.textMetrics.FindFirstChild = function(self, k) return self[k] end
Utility.textMetrics.__loader = function(script, require)
local variables = require(script.Parent.variables)
local textService = variables.textService

local textMetrics = {}

local widthCache: { [string]: number } = {}
local widthCacheCount = 0
local widthCacheCap = 1024

local function getTextBounds(params: GetTextBoundsParams): unknown
    local ok, bounds = pcall(function()
        return textService:GetTextBoundsAsync(params)
    end)
    return if ok then bounds else nil
end

local function boundAxis(bounds: unknown, axis: "X" | "Y"): number?
    if typeof(bounds) == "Vector2" then
        return if axis == "X" then bounds.X else bounds.Y
    end
    if type(bounds) == "table" and type((bounds :: any)[axis]) == "number" then
        return (bounds :: any)[axis]
    end
    return nil
end

function textMetrics.textWidth(font: Font, size: number, text: any): number
    text = tostring(text)

    local key = tostring(font.Family)
        .. "|"
        .. tostring(font.Weight)
        .. "|"
        .. tostring(font.Style)
        .. "|"
        .. tostring(size)
        .. "|"
        .. text
    local cached = widthCache[key]
    if cached then
        return cached
    end

    local params = Instance.new("GetTextBoundsParams")
    params.Text = text
    params.Font = font
    params.Size = size
    params.Width = math.huge

    local measuredWidth = boundAxis(getTextBounds(params), "X")
    if not measuredWidth then

        local length = utf8.len(text) or #text
        return math.ceil(size * 0.55 * length)
    end

    local width = math.ceil(measuredWidth)
    if widthCacheCount >= widthCacheCap then
        widthCache = {}
        widthCacheCount = 0
    end
    widthCache[key] = width
    widthCacheCount += 1
    return width
end

function textMetrics.textHeight(font: Font, size: number, text: any, width: number): number
    local params = Instance.new("GetTextBoundsParams")
    params.Text = tostring(text)
    params.Font = font
    params.Size = size
    params.Width = width

    local measuredHeight = boundAxis(getTextBounds(params), "Y")
    return if measuredHeight then math.ceil(measuredHeight) else size
end

return textMetrics
end

Utility.variables = { Name = "variables", Parent = Utility }
Utility.variables.FindFirstChild = function(self, k) return self[k] end
Utility.variables.__loader = function(script, require)
local runtime = require(script.Parent.runtime)
local constants = require(script.Parent.constants)
local log = require(script.Parent.log)
local fileSystemManager = require(script.Parent.filesystemManager)
local assetResolver = require(script.Parent.assetResolver)
local fontManager = require(script.Parent.fontManager)

type RuntimeState = runtime.RuntimeState
type FileSystemManager = fileSystemManager.FileSystemManager
type AssetResolver = assetResolver.AssetResolver
type FontManager = fontManager.FontManager

export type VariablesState = RuntimeState & {
    fallbackFont: Font,
    fileSystemManager: FileSystemManager,
    assetResolver: AssetResolver,
    fontManager: FontManager,
    setFallbackFont: (font: Enum.Font | Font) -> (),
    brandFont: (weight: Enum.FontWeight?) -> Font,
}

local variables = table.clone(runtime) :: VariablesState
log.setSecureModeSource(function()
    return variables.secureMode
end)

variables.fallbackFont = Font.fromEnum(Enum.Font.BuilderSans)

variables.fileSystemManager = fileSystemManager.new()
variables.assetResolver =
    assetResolver.new(true, assetResolver.Enum.AssetDownloadUrl.RoProxyDownloadUrl) :: AssetResolver
variables.fontManager = fontManager.new(
    variables.fileSystemManager:getAssetsFolder("fonts"),
    false,
    true,
    assetResolver.Enum.AssetDownloadUrl.RoProxyDownloadUrl,
    {
        saveToDisk = true,
        skipCache = false,
        fallbackFont = variables.fallbackFont,
    }
) :: FontManager

function variables.setFallbackFont(font: Enum.Font | Font)
    if typeof(font) == "EnumItem" then
        font = Font.fromEnum(font)
    end
    if typeof(font) == "Font" then
        variables.fallbackFont = font
        variables.fontManager.defaultOptions.fallbackFont = font
    end
end

function variables.brandFont(weight: Enum.FontWeight?): Font
    if variables.secureMode then
        return Font.new(variables.fallbackFont.Family, weight)
    end
    return Font.new(constants.fontAsset, weight)
end

return variables
end

Utility.windowSizing = { Name = "windowSizing", Parent = Utility }
Utility.windowSizing.FindFirstChild = function(self, k) return self[k] end
Utility.windowSizing.__loader = function(script, require)
local layouts = require(script.Parent.layouts)

local windowSizing = {}

export type Profile = {

    defaultSize: Vector2,
    minSize: Vector2,

    maxOccupancyX: number,
    maxOccupancyY: number?,
    marginFloorX: number,
    marginFloorY: number,

    topbarClearance: number?,

    maxAspectRatio: number,
    minAspectRatio: number?,

    widthCompensation: number?,

    chromeHeight: number,
}

local minPlausibleViewport = 200

local profiles = {
    top = {
        defaultSize = Vector2.new(475, 500),
        minSize = Vector2.new(300, 285),

        maxOccupancyX = 0.86,
        topbarClearance = 36,
        marginFloorX = 24,
        marginFloorY = 28,

        maxAspectRatio = 2.3,
        widthCompensation = 130,

        chromeHeight = layouts.top.chromeHeight,
    } :: Profile,
    sidebar = {
        defaultSize = Vector2.new(685, 450),

        minSize = Vector2.new(560, 350),

        maxOccupancyX = 0.92,
        maxOccupancyY = 0.8,
        marginFloorX = 24,
        marginFloorY = 28,

        maxAspectRatio = 2.6,
        minAspectRatio = 1.2,

        chromeHeight = layouts.sidebar.chromeHeight,
    } :: Profile,
}

function windowSizing.profile(mode: layouts.Mode?): Profile
    if mode == "sidebar" then
        return profiles.sidebar
    end
    return profiles.top
end

function windowSizing.pageHeight(windowHeight: number?, mode: layouts.Mode?): number
    local profile = windowSizing.profile(mode)
    local height = if windowHeight and windowHeight > 0 then windowHeight else profile.minSize.Y
    return math.max(height - profile.chromeHeight, 0)
end

local function availableHeight(profile: Profile, viewportY: number): number
    local limit = viewportY - profile.marginFloorY
    if profile.topbarClearance then
        limit = math.min(limit, viewportY - profile.topbarClearance * 2)
    end
    if profile.maxOccupancyY then
        limit = math.min(limit, viewportY * profile.maxOccupancyY)
    end
    return limit
end

local function deficit(actual: number, ideal: number, floor: number): number
    return math.clamp((ideal - actual) / (ideal - floor), 0, 1)
end

local function fitVertical(profile: Profile, availableX: number, availableY: number): UDim2

    local height = math.floor(math.min(math.clamp(availableY, profile.minSize.Y, profile.defaultSize.Y), availableY))
    local lost = deficit(height, profile.defaultSize.Y, profile.minSize.Y)
    local width = math.max(profile.defaultSize.X + (profile.widthCompensation :: number) * lost, profile.minSize.X)

    return UDim2.fromOffset(math.floor(math.min(width, availableX, height * profile.maxAspectRatio)), height)
end

local function fitHorizontal(profile: Profile, availableX: number, availableY: number): UDim2
    local width = math.min(math.clamp(availableX, profile.minSize.X, profile.defaultSize.X), availableX)
    local height = math.min(math.clamp(availableY, profile.minSize.Y, profile.defaultSize.Y), availableY)

    height = math.floor(math.min(height, width / (profile.minAspectRatio :: number)))
    width = math.floor(math.min(width, height * profile.maxAspectRatio))

    return UDim2.fromOffset(width, height)
end

function windowSizing.fit(viewport: Vector2?, mode: layouts.Mode?): UDim2
    local profile = windowSizing.profile(mode)

    if not viewport or viewport.X < minPlausibleViewport or viewport.Y < minPlausibleViewport then
        return UDim2.fromOffset(profile.defaultSize.X, profile.defaultSize.Y)
    end

    local availableX = math.min(viewport.X * profile.maxOccupancyX, viewport.X - profile.marginFloorX)
    local availableY = availableHeight(profile, viewport.Y)

    if profile.minAspectRatio then
        return fitHorizontal(profile, availableX, availableY)
    end
    return fitVertical(profile, availableX, availableY)
end

return windowSizing
end

-- Components
Components.action = { Name = "action", Parent = Components }
Components.action.FindFirstChild = function(self, k) return self[k] end
Components.action.__loader = function(script, require)
local Action = {}
Action.__index = Action
Action.__type = "Action"

local utility = script.Parent.Parent.utility

local variables = require(utility.variables)
local log = require(utility.log)
local hapticEngine = require(utility.HapticEngine)

function Action.new(window, properties)
    properties = if typeof(properties) == "table" then properties else {}

    local self = setmetatable({
        window = assert(window, "Missing argument #1 (Window expected)"),
        name = properties.name or properties.Name or "Action",
        icon = assert(properties.icon or properties.Icon, "Missing argument (Icon expected)"),
        callback = assert(properties.callback or properties.Callback, "Missing argument (Function expected)"),
        linkedTab = properties.linkedTab or properties.LinkedTab,
    }, Action)

    self.action = self.window:Create("Frame", {
        Name = self.name,
        BorderSizePixel = 0,

        LayoutOrder = -(properties.order or 0),
        Size = UDim2.fromOffset(24, 24),
        BackgroundTransparency = 1,

        Parent = self.window.actionContainer,
    })

    self.iconLabel = self.window:Create("ImageLabel", {

        Image = self.icon,

        Size = UDim2.fromOffset(20, 20),
        BorderSizePixel = 0,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        BackgroundTransparency = 1,

        ImageTransparency = 1,

        Parent = self.action,
    }, { ImageColor3 = "ActionColor" })

    self.interact = self.window:Create("TextButton", {
        BackgroundTransparency = 1,
        Size = UDim2.fromScale(1, 1),
        BorderSizePixel = 0,
        Position = UDim2.fromScale(0.5, 0.5),
        AnchorPoint = Vector2.new(0.5, 0.5),
        TextTransparency = 1,

        Parent = self.action,
    })

    local function settleIcon()
        if not self.window:_settled() then
            return
        end
        if self.linkedTab and self.window.selectedTab == self.linkedTab then
            return
        end
        if self.isLit and self:isLit() then
            return
        end
        variables.tweenService
            :Create(
                self.iconLabel,
                TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
                { ImageTransparency = 0.6 }
            )
            :Play()
    end

    self.window:Connect(self.interact.MouseButton1Click, function()
        hapticEngine.click()
        task.spawn(function()
            local success, result = pcall(self.callback)
            if not success then
                log.warn(
                    `Rayfield encountered an error, with the callback for a {self.__type} component named '{self.name}':`
                )
                log.print(result)
            end

            settleIcon()
        end)
    end)

    self.window:Connect(self.interact.MouseEnter, function()
        if not self.window:_interactive() then
            return
        end
        variables.tweenService
            :Create(
                self.iconLabel,
                TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
                { ImageTransparency = 0.2 }
            )
            :Play()
    end)

    self.window:Connect(self.interact.MouseLeave, settleIcon)

    return self
end

return Action
end

Components.button = { Name = "button", Parent = Components }
Components.button.FindFirstChild = function(self, k) return self[k] end
Components.button.__loader = function(script, require)
local Button = {}
Button.__index = Button
Button.__type = "Button"

local utility = script.Parent.Parent.utility

local variables = require(utility.variables)
local functions = require(utility.functions)
local moveable = require(utility.moveable)
local lockable = require(utility.lockable)
local locale = require(utility.locale)
local hapticEngine = require(utility.HapticEngine)

function Button.new(tab, properties)
    properties = if typeof(properties) == "table" then properties else {}

    local self = setmetatable({
        tab = assert(tab, "Missing argument #1 (Tab expected)"),
        window = tab.window,
        name = properties.name or properties.Name or "Button",
        icon = properties.icon or properties.Icon,
        description = properties.description or properties.Description,
        compact = tab.compact or false,

        callback = properties.callback or properties.Callback or function() end,
    }, Button)

    if self.compact then
        self:_buildCompact()
    else
        self:_buildFull()
    end

    if self.description and not self.compact then
        self.descriptor = require(script.Parent.descriptor).new(self.tab, { description = self.description })
    end

    return self
end

function Button:_runCallback()
    self.window:_runGuarded(self, self.callback)
end

function Button:_buildFull()
    self.main = self.window:Create("Frame", {
        Size = UDim2.new(1, -20, 0, 43),
        BorderSizePixel = 0,
        Name = self.name,
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),

        BackgroundTransparency = 1,

        Parent = self.tab.tabPage,
    }, { BackgroundTransparency = "ElementTransparency" })

    self.stroke = self.window:StyleElementBody(self.main)
    self.hoverOverlay = self.window:CreateHoverOverlay(self.main)

    self.container = self.window:Create("Frame", {
        BorderSizePixel = 0,

        Parent = self.main,
        Size = UDim2.new(0, 170, 0, 16),
        Position = UDim2.new(0, 20, 0.5, 0),
        AnchorPoint = Vector2.new(0, 0.5),
        BackgroundTransparency = 1,
    })

    self.containerLayout = self.window:Create("UIListLayout", {
        Padding = UDim.new(0, 5),
        FillDirection = Enum.FillDirection.Horizontal,
        VerticalAlignment = Enum.VerticalAlignment.Center,
        HorizontalAlignment = Enum.HorizontalAlignment.Left,

        Parent = self.container,
    })

    if self.icon then
        self.iconLabel = self.window:Create("ImageLabel", {
            Image = self.icon,
            Size = UDim2.fromOffset(16, 16),
            BorderSizePixel = 0,
            BackgroundTransparency = 1,

            ImageTransparency = 1,

            Parent = self.container,
        }, { ImageColor3 = "ContentColor" })
    end

    self.title = self.window:Create("TextLabel", {
        Text = locale.t(self.name),

        Size = UDim2.fromOffset(250, 16),
        BorderSizePixel = 0,
        BackgroundTransparency = 1,
        TextSize = 16,
        AutomaticSize = Enum.AutomaticSize.X,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextWrapped = true,
        LayoutOrder = 1,

        TextTransparency = 1,

        Parent = self.container,
    }, { TextColor3 = "ContentColor", FontFace = "Font" })

    self.interact = self.window:Create("TextButton", {
        BackgroundTransparency = 1,
        Size = UDim2.fromScale(1, 1),
        BorderSizePixel = 0,
        Position = UDim2.fromScale(0.5, 0.5),
        AnchorPoint = Vector2.new(0.5, 0.5),
        TextTransparency = 1,

        Parent = self.main,
    })

    self.window:_wireElementHover(self)

    self.window:ConnectFor(self, self.interact.MouseButton1Click, function()
        hapticEngine.click()
        variables.tweenService
            :Create(
                self.stroke,
                TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
                { Transparency = 1 }
            )
            :Play()
        variables.tweenService
            :Create(
                self.main,
                TweenInfo.new(0.6, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out),
                { Size = UDim2.new(1, -26, 0, 43) }
            )
            :Play()

        self:_runCallback()

        task.wait(0.11)

        variables.tweenService
            :Create(
                self.main,
                TweenInfo.new(0.25, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out),
                { Size = UDim2.new(1, -20, 0, 43) }
            )
            :Play()
        variables.tweenService
            :Create(
                self.stroke,
                TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
                { Transparency = self.window.theme.ElementStrokeTransparency }
            )
            :Play()
    end)
end

function Button:_buildCompact()
    local window = self.window

    self.main, self.stroke, self.interact = window:_buildCompactRow(self.tab, self.name)
    self.hoverOverlay = self.interact

    window:Create("UIPadding", {
        PaddingLeft = UDim.new(0, 16),
        PaddingRight = UDim.new(0, 16),

        Parent = self.interact,
    })

    window:Create("UIListLayout", {
        FillDirection = Enum.FillDirection.Horizontal,
        VerticalAlignment = Enum.VerticalAlignment.Center,
        HorizontalAlignment = Enum.HorizontalAlignment.Center,
        Padding = UDim.new(0, 6),

        Parent = self.interact,
    })

    if self.icon then
        self.iconLabel = window:Create("ImageLabel", {
            Image = self.icon,
            Size = UDim2.fromOffset(16, 16),
            BorderSizePixel = 0,
            BackgroundTransparency = 1,
            LayoutOrder = 0,

            ImageTransparency = 1,

            Parent = self.interact,
        }, { ImageColor3 = "ContentColor" })
    end

    self.title = window:Create("TextLabel", {
        Text = locale.t(self.name),
        Size = UDim2.fromOffset(0, 16),
        AutomaticSize = Enum.AutomaticSize.X,
        BorderSizePixel = 0,
        BackgroundTransparency = 1,
        TextSize = 16,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextTruncate = Enum.TextTruncate.AtEnd,
        LayoutOrder = 1,

        TextTransparency = 1,

        Parent = self.interact,
    }, { TextColor3 = "ContentColor", FontFace = "Font" })

    window:Create("UIFlexItem", {
        FlexMode = Enum.UIFlexMode.Shrink,
        Parent = self.title,
    })

    self.window:_wireElementHover(self)

    self.window:ConnectFor(self, self.interact.MouseButton1Click, function()
        hapticEngine.click()
        variables.tweenService
            :Create(
                self.stroke,
                TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
                { Transparency = 1 }
            )
            :Play()

        self:_runCallback()

        task.wait(0.11)

        variables.tweenService
            :Create(
                self.stroke,
                TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
                { Transparency = self.window.theme.ElementStrokeTransparency }
            )
            :Play()
    end)
end

function Button:_setShown(shown, animate)
    if shown then
        self.window:_revealCommon(self, animate)
    else
        self.window:_hideCommon(self, animate)
    end
end

function Button:_minWidth()
    local w = 32
    if self.icon then
        w += 22
    end

    w += functions.textWidth(self.window.theme.Font, 16, locale.resolve(self.name))
    return w
end

moveable(Button)
lockable(Button)

return Button
end

Components.chrome = { Name = "chrome", Parent = Components }
Components.chrome.FindFirstChild = function(self, k) return self[k] end
Components.chrome.__loader = function(script, require)
local utility = script.Parent.Parent.utility
local variables = require(utility.variables)
local filesystem = require(utility.filesystem)
local constants = require(utility.constants)
local locale = require(utility.locale)
local hapticEngine = require(utility.HapticEngine)

local chrome = {}

local dragThreshold = 5

function chrome.buildCollapsedFace(window)
    local iconOnly = window.showIconOnly

    window.collapsedIcon = window:Create("ImageLabel", {
        Name = "CollapsedIcon",
        AnchorPoint = if iconOnly then Vector2.new(0.5, 0.5) else Vector2.new(0, 0.5),
        Position = if iconOnly then UDim2.fromScale(0.5, 0.5) else UDim2.new(0, 16, 0.5, 0),
        Size = UDim2.fromOffset(24, 24),
        BackgroundTransparency = 1,

        Image = window.showIcon,
        ZIndex = constants.zIndex.restoreContent,

        ImageTransparency = 1,

        Parent = window.main,
    }, { ImageColor3 = "TitlingColor" })

    window:Create("UICorner", {
        Parent = window.collapsedIcon,
    }, { CornerRadius = "PillCornerRadius" })

    local textContainer = window:Create("Frame", {
        Name = "CollapsedText",
        Visible = not iconOnly,
        AnchorPoint = Vector2.new(0, 0.5),
        Position = UDim2.new(0, 50, 0.5, 0),
        Size = UDim2.new(1, -60, 0, 32),
        BackgroundTransparency = 1,
        ZIndex = constants.zIndex.restoreContent,

        Parent = window.main,
    })

    window:Create("UIListLayout", {
        Padding = UDim.new(0, 1),
        VerticalAlignment = Enum.VerticalAlignment.Center,
        SortOrder = Enum.SortOrder.LayoutOrder,

        Parent = textContainer,
    })

    window.collapsedTitle = window:Create("TextLabel", {
        Name = "Title",
        Text = window.showName,
        Size = UDim2.new(1, 0, 0, 16),
        BackgroundTransparency = 1,
        FontFace = variables.brandFont(Enum.FontWeight.Medium),
        RichText = true,
        TextSize = 16,
        TextWrapped = true,
        TextXAlignment = Enum.TextXAlignment.Left,
        LayoutOrder = 1,
        ZIndex = constants.zIndex.restoreContent,

        TextTransparency = 1,

        Parent = textContainer,
    }, { TextColor3 = "TitlingColor" })

    window.collapsedSubtitle = window:Create("TextLabel", {
        Name = "Subtitle",
        Text = locale.t("Tap to show"),
        Size = UDim2.new(1, 0, 0, 14),
        BackgroundTransparency = 1,
        FontFace = variables.brandFont(Enum.FontWeight.Medium),
        TextSize = 14,
        TextXAlignment = Enum.TextXAlignment.Left,
        LayoutOrder = 2,
        ZIndex = constants.zIndex.restoreContent,

        TextTransparency = 1,

        Parent = textContainer,
    }, { TextColor3 = "TitlingColor" })

    window.collapsedInteract = window:Create("TextButton", {
        Name = "CollapsedInteract",
        BackgroundTransparency = 1,
        Size = UDim2.fromScale(1, 1),
        Text = "",
        TextTransparency = 1,
        Visible = false,
        ZIndex = constants.zIndex.restoreInteract,

        Parent = window.main,
    })

    chrome.bindCollapsedDrag(window)
end

function chrome.bindCollapsedDrag(window)
    local uis = variables.userInputService
    local dragging, moved = false, false
    local grabOffset, grabMouse = Vector2.zero, Vector2.zero

    local function insetOffset()
        if window.screenGui and window.screenGui.IgnoreGuiInset then
            return variables.guiService:GetGuiInset()
        end
        return Vector2.zero
    end

    window:Connect(window.collapsedInteract.InputBegan, function(input, processed)
        if processed or not window.hidden or window.animating then
            return
        end
        local inputType = input.UserInputType.Name
        if inputType ~= "MouseButton1" and inputType ~= "Touch" then
            return
        end

        dragging, moved = true, false
        grabMouse = uis:GetMouseLocation()
        grabOffset = window.main.AbsolutePosition + window.main.AbsoluteSize * window.main.AnchorPoint - grabMouse
    end)

    window:Connect(uis.InputEnded, function(input)
        local inputType = input.UserInputType.Name
        if inputType ~= "MouseButton1" and inputType ~= "Touch" then
            return
        end
        if not dragging then
            return
        end
        dragging = false

        if moved then
            window._collapsedPosition = window.main.Position
            return
        end

        hapticEngine.click()
        window:ToggleHide()
    end)

    window:Connect(uis.WindowFocusReleased, function()
        dragging = false
    end)

    window:Connect(variables.runService.RenderStepped, function()
        if not dragging then
            return
        end
        if not window.hidden or window.animating then
            dragging = false
            return
        end

        local mouse = uis:GetMouseLocation()
        if not moved and (mouse - grabMouse).Magnitude < dragThreshold then
            return
        end
        moved = true

        local target = mouse + grabOffset + insetOffset()
        window.main.Position = UDim2.fromOffset(target.X, target.Y)
    end)
end

function chrome.isNewUser()
    local localPlayer = variables.localPlayer
    if not localPlayer then
        return false
    end

    if typeof(filesystem.isfile) ~= "function" or typeof(filesystem.writefile) ~= "function" then
        return true
    end

    local path = variables.fileSystemManager:getPath("lastuser.txt")
    local currentId = tostring(localPlayer.UserId)
    local isNew = true

    pcall(function()
        if filesystem.isfile(path) then
            isNew = filesystem.readfile(path) ~= currentId
        end
    end)

    pcall(function()
        filesystem.writefile(path, currentId)
    end)

    return isNew
end

function chrome.setCollapsedShown(window, shown, tweenInfo)
    local targets = {
        [window.collapsedIcon] = { ImageTransparency = if shown then 0 else 1 },
    }

    if not window.showIconOnly then
        targets[window.collapsedTitle] = { TextTransparency = if shown then 0 else 1 }
        targets[window.collapsedSubtitle] = { TextTransparency = if shown then 0.5 else 1 }
    end

    for instance, props in targets do
        if tweenInfo then
            variables.tweenService:Create(instance, tweenInfo, props):Play()
        else
            for property, value in props do
                instance[property] = value
            end
        end
    end
end

return chrome
end

Components.colorpicker = { Name = "colorpicker", Parent = Components }
Components.colorpicker.FindFirstChild = function(self, k) return self[k] end
Components.colorpicker.__loader = function(script, require)
local ColorPicker = {}
ColorPicker.__index = ColorPicker
ColorPicker.__type = "ColorPicker"

local utility = script.Parent.Parent.utility

local variables = require(utility.variables)
local functions = require(utility.functions)
local moveable = require(utility.moveable)
local lockable = require(utility.lockable)
local constants = require(utility.constants)
local locale = require(utility.locale)
local hapticEngine = require(utility.HapticEngine)

local hueSequence = ColorSequence.new({
    ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 0, 0)),
    ColorSequenceKeypoint.new(0.17, Color3.fromRGB(255, 255, 0)),
    ColorSequenceKeypoint.new(0.33, Color3.fromRGB(0, 255, 0)),
    ColorSequenceKeypoint.new(0.50, Color3.fromRGB(0, 255, 255)),
    ColorSequenceKeypoint.new(0.67, Color3.fromRGB(0, 0, 255)),
    ColorSequenceKeypoint.new(0.83, Color3.fromRGB(255, 0, 255)),
    ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 0, 0)),
})

local headerHeight = 41
local contentY = 52
local mapSize = Vector2.new(150, 120)
local hueX = 184
local hueWidth = 10

local alphaX = 214
local alphaWidth = 10
local rightX = 240
local alphaFieldWidth = 62
local fieldGap = 8

local narrowWidth = 400

local layoutSpec = {
    wide = {
        height = 190,
        previewPos = UDim2.new(1, -20, 0, contentY + 39),
        previewSize = UDim2.new(1, -(rightX + 20), 0, 78),
        hexPos = UDim2.new(0, rightX, 0, contentY + 90),
        hexSize = UDim2.new(1, -(rightX + 20 + alphaFieldWidth + fieldGap), 0, 30),
        alphaFieldPos = UDim2.new(1, -(20 + alphaFieldWidth), 0, contentY + 90),
        alphaFieldSize = UDim2.new(0, alphaFieldWidth, 0, 30),
    },
    narrow = {
        height = 296,
        previewPos = UDim2.new(1, -20, 0, contentY + mapSize.Y + 40),
        previewSize = UDim2.new(1, -40, 0, 56),
        hexPos = UDim2.new(0, 20, 0, contentY + mapSize.Y + 78),
        hexSize = UDim2.new(1, -(40 + alphaFieldWidth + fieldGap), 0, 30),
        alphaFieldPos = UDim2.new(1, -(20 + alphaFieldWidth), 0, contentY + mapSize.Y + 78),
        alphaFieldSize = UDim2.new(0, alphaFieldWidth, 0, 30),
    },
}

local previewClosedPos = UDim2.new(1, -16, 0, headerHeight / 2)
local previewClosedSize = UDim2.fromOffset(40, 22)

local openInfo = TweenInfo.new(0.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)
local fadeInfo = TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
local followInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)

local dragInfo = TweenInfo.new(0.12, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
local heldInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)

local function clamp01(n)
    return math.clamp(n, 0, 1)
end

local function clampByte(n)
    return math.clamp(math.round(n), 0, 255)
end

local namedColors = {
    black = Color3.fromRGB(0, 0, 0),
    white = Color3.fromRGB(255, 255, 255),
    red = Color3.fromRGB(255, 0, 0),
    green = Color3.fromRGB(0, 255, 0),
    blue = Color3.fromRGB(0, 0, 255),
    yellow = Color3.fromRGB(255, 255, 0),
    cyan = Color3.fromRGB(0, 255, 255),
    magenta = Color3.fromRGB(255, 0, 255),
    orange = Color3.fromRGB(255, 165, 0),
    purple = Color3.fromRGB(128, 0, 128),
    pink = Color3.fromRGB(255, 105, 180),
    brown = Color3.fromRGB(139, 69, 19),
    gray = Color3.fromRGB(128, 128, 128),
    grey = Color3.fromRGB(128, 128, 128),
}

local function hslToColor(h, s, l)
    if s <= 0 then
        return Color3.new(l, l, l)
    end
    local function hue2(p, q, t)
        t = t % 1
        if t < 1 / 6 then
            return p + (q - p) * 6 * t
        elseif t < 1 / 2 then
            return q
        elseif t < 2 / 3 then
            return p + (q - p) * (2 / 3 - t) * 6
        end
        return p
    end
    local q = if l < 0.5 then l * (1 + s) else l + s - l * s
    local p = 2 * l - q
    return Color3.new(hue2(p, q, h + 1 / 3), hue2(p, q, h), hue2(p, q, h - 1 / 3))
end

local function numbersIn(s)
    local out = {}
    for n in s:gmatch("[%d%.]+") do
        table.insert(out, tonumber(n))
    end
    return out
end

local function parseColor(input)
    if typeof(input) ~= "string" then
        return nil
    end
    local s = (input:lower():match("^%s*(.-)%s*$")) or ""
    if s == "" then
        return nil
    end

    if namedColors[s] then
        return namedColors[s]
    end

    local model = s:match("^(%a+)")
    local nums = numbersIn(s)

    if (model == "hsv" or model == "hsb") and #nums >= 3 then
        local h = (nums[1] % 360) / 360
        local sat = if nums[2] > 1 then nums[2] / 100 else nums[2]
        local v = if nums[3] > 1 then nums[3] / 100 else nums[3]
        return Color3.fromHSV(h, clamp01(sat), clamp01(v))
    end

    if model == "hsl" and #nums >= 3 then
        local h = (nums[1] % 360) / 360
        local sat = if nums[2] > 1 then nums[2] / 100 else nums[2]
        local l = if nums[3] > 1 then nums[3] / 100 else nums[3]
        return hslToColor(h, clamp01(sat), clamp01(l))
    end

    if (model == "rgb" or model == "rgba") and #nums >= 3 then
        return Color3.fromRGB(clampByte(nums[1]), clampByte(nums[2]), clampByte(nums[3]))
    end

    local hex = s:match("^#?(%x%x%x%x%x%x)$") or s:match("^#?(%x%x%x)$") or s:match("^0x(%x%x%x%x%x%x)$")
    if hex then
        local ok, color = pcall(Color3.fromHex, hex)
        if ok then
            return color
        end
    end

    if #nums >= 3 and not model then
        if nums[1] <= 1 and nums[2] <= 1 and nums[3] <= 1 then
            return Color3.new(clamp01(nums[1]), clamp01(nums[2]), clamp01(nums[3]))
        end
        return Color3.fromRGB(clampByte(nums[1]), clampByte(nums[2]), clampByte(nums[3]))
    end

    return nil
end

local function coerceColor(value, fallback)
    if typeof(value) == "Color3" then
        return value
    end
    if typeof(value) == "string" then
        return parseColor(value) or fallback
    end
    return fallback
end

function ColorPicker.new(tab, properties)
    properties = if typeof(properties) == "table" then properties else {}

    local self = setmetatable({
        tab = assert(tab, "Missing argument #1 (Tab expected)"),
        window = tab.window,
        name = properties.name or properties.Name or "Color Picker",
        icon = properties.icon or properties.Icon,
        description = properties.description or properties.Description,
        forgetState = properties.forgetState or properties.ForgetState or tab.forgetState,

        callback = properties.callback or properties.Callback or function() end,

        _isOpen = false,
    }, ColorPicker)

    self.value = coerceColor(
        properties.color or properties.Color or properties.value or properties.Value or properties.default,
        Color3.fromRGB(255, 255, 255)
    )

    self.hue, self.sat, self.val = self.value:ToHSV()

    local a = properties.alpha or properties.Alpha
    self.alpha = if type(a) == "number" then clamp01(a) else 1

    self.flag = properties.flag
        or properties.Flag
        or (not self.forgetState and functions.deriveFlagFromName(self.name) or nil)
    self.window:_registerControl(self)

    self.main = self.window:Create("Frame", {
        Size = UDim2.new(1, -20, 0, headerHeight),
        BorderSizePixel = 0,
        Name = self.name,
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 1,

        Parent = self.tab.tabPage,
    }, { BackgroundTransparency = "ElementTransparency" })

    self.stroke = self.window:StyleElementBody(self.main)
    self.hoverOverlay = self.window:CreateHoverOverlay(self.main)

    self:_buildHeader()
    self:_buildPicker()

    self.window:ConnectFor(self, self.interact.MouseButton1Click, function()
        hapticEngine.click()
        if self._isOpen then
            self:_close()
        else
            self:_open()
        end
    end)

    self.window:ConnectFor(self, self.main.MouseEnter, function()
        if self._isOpen or not self.window:_interactive() then
            return
        end
        local theme = self.window.theme
        variables.tweenService
            :Create(self.stroke, fadeInfo, {
                Transparency = theme.ElementStrokeHoverTransparency,
                Color = theme.ElementStrokeHover,
            })
            :Play()
        variables.tweenService:Create(self.title, fadeInfo, { TextColor3 = theme.ElementTextHoverColor }):Play()
        variables.tweenService:Create(self.hoverOverlay, fadeInfo, { BackgroundTransparency = 0.97 }):Play()
    end)

    self.window:ConnectFor(self, self.main.MouseLeave, function()
        local theme = self.window.theme
        variables.tweenService
            :Create(
                self.stroke,
                fadeInfo,
                { Transparency = theme.ElementStrokeTransparency, Color = theme.ElementStroke }
            )
            :Play()
        variables.tweenService:Create(self.title, fadeInfo, { TextColor3 = theme.ContentColor }):Play()
        variables.tweenService:Create(self.hoverOverlay, fadeInfo, { BackgroundTransparency = 1 }):Play()
    end)

    if self.description then
        self.descriptor = require(script.Parent.descriptor).new(self.tab, { description = self.description })
    end

    self:_applyPickerVisibility(false, false)
    self:_setControlsVisible(false)

    self.window:ConnectFor(self, self.main:GetPropertyChangedSignal("AbsoluteSize"), function()

        if self.window.animating or (self.window.hidden and self.window.hasShownOnce) then
            return
        end
        self:_applyLayout()
    end)
    self:_applyLayout()

    self:_render("instant")

    return self
end

function ColorPicker:_buildHeader()
    self.container = self.window:Create("Frame", {
        Size = UDim2.new(0, 170, 0, 16),
        Position = UDim2.new(0, 20, 0, headerHeight / 2),
        AnchorPoint = Vector2.new(0, 0.5),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ZIndex = 5,

        Parent = self.main,
    })

    self.window:Create("UIListLayout", {
        Padding = UDim.new(0, 5),
        FillDirection = Enum.FillDirection.Horizontal,
        VerticalAlignment = Enum.VerticalAlignment.Center,
        SortOrder = Enum.SortOrder.LayoutOrder,

        Parent = self.container,
    })

    if self.icon then
        self.iconLabel = self.window:Create("ImageLabel", {
            Image = self.icon,
            Size = UDim2.fromOffset(16, 16),
            BorderSizePixel = 0,
            BackgroundTransparency = 1,
            ZIndex = 5,

            ImageTransparency = 1,

            Parent = self.container,
        }, { ImageColor3 = "ContentColor" })
    end

    self.title = self.window:Create("TextLabel", {
        Text = locale.t(self.name),
        Size = UDim2.fromOffset(150, 16),
        AutomaticSize = Enum.AutomaticSize.X,
        BorderSizePixel = 0,
        BackgroundTransparency = 1,
        TextSize = 16,
        TextXAlignment = Enum.TextXAlignment.Left,
        LayoutOrder = 1,
        ZIndex = 5,

        TextTransparency = 1,

        Parent = self.container,
    }, { TextColor3 = "ContentColor", FontFace = "Font" })

    self.preview = self.window:Create("Frame", {
        AnchorPoint = Vector2.new(1, 0.5),
        Position = previewClosedPos,
        Size = previewClosedSize,
        BackgroundColor3 = self.value,
        BorderSizePixel = 0,
        ZIndex = 3,

        BackgroundTransparency = 1,

        Parent = self.main,
    })

    self.window:Create("UICorner", {
        CornerRadius = UDim.new(0, 8),
        Parent = self.preview,
    })

    self.previewShadow = self.window:CreateGlow(self.preview, self.value, 20, 1)

    self.invisibleGroup = self.window:Create("Frame", {
        Size = UDim2.fromScale(1, 1),
        Position = UDim2.fromScale(0.5, 0.5),
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ZIndex = 5,

        Parent = self.preview,
    })

    self.window:Create("UIListLayout", {
        FillDirection = Enum.FillDirection.Horizontal,
        VerticalAlignment = Enum.VerticalAlignment.Center,
        HorizontalAlignment = Enum.HorizontalAlignment.Center,
        Padding = UDim.new(0, 6),
        SortOrder = Enum.SortOrder.LayoutOrder,

        Parent = self.invisibleGroup,
    })

    self.invisibleIcon = self.window:Create("ImageLabel", {
        Image = constants.icons.colorpicker,
        Size = UDim2.fromOffset(16, 16),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ZIndex = 5,

        ImageTransparency = 1,

        Parent = self.invisibleGroup,
    }, { ImageColor3 = "ContentColor" })

    self.invisibleText = self.window:Create("TextLabel", {
        Text = locale.t("Invisible"),
        Size = UDim2.fromOffset(0, 16),
        AutomaticSize = Enum.AutomaticSize.X,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        TextSize = 15,
        LayoutOrder = 1,
        ZIndex = 5,

        TextTransparency = 1,

        Parent = self.invisibleGroup,
    }, { TextColor3 = "ContentColor", FontFace = "Font" })

    self.interact = self.window:Create("TextButton", {
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, headerHeight),
        Position = UDim2.fromScale(0, 0),
        BorderSizePixel = 0,
        Text = "",
        TextTransparency = 1,
        AutoButtonColor = false,
        ZIndex = 10,

        Parent = self.main,
    })
end

function ColorPicker:_buildMap()
    self.map = self.window:Create("Frame", {
        Position = UDim2.fromOffset(20, contentY),
        Size = UDim2.fromOffset(mapSize.X, mapSize.Y),
        BackgroundColor3 = Color3.fromHSV(self.hue, 1, 1),
        BorderSizePixel = 0,
        ZIndex = 2,

        BackgroundTransparency = 1,

        Parent = self.main,
    })

    self.window:Create("UICorner", { CornerRadius = UDim.new(0, 8), Parent = self.map })

    self.mapStroke = self.window:Create("UIStroke", {
        Color = Color3.fromRGB(255, 255, 255),
        Transparency = 1,

        Parent = self.map,
    })

    self.satOverlay = self.window:Create("Frame", {
        Size = UDim2.fromScale(1, 1),
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BorderSizePixel = 0,
        ZIndex = 3,

        BackgroundTransparency = 1,

        Parent = self.map,
    })
    self.window:Create("UICorner", { CornerRadius = UDim.new(0, 8), Parent = self.satOverlay })
    self.window:Create("UIGradient", {
        Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 0),
            NumberSequenceKeypoint.new(1, 1),
        }),
        Parent = self.satOverlay,
    })

    self.valOverlay = self.window:Create("Frame", {
        Size = UDim2.fromScale(1, 1),
        BackgroundColor3 = Color3.fromRGB(0, 0, 0),
        BorderSizePixel = 0,
        ZIndex = 4,

        BackgroundTransparency = 1,

        Parent = self.map,
    })
    self.window:Create("UICorner", { CornerRadius = UDim.new(0, 8), Parent = self.valOverlay })
    self.window:Create("UIGradient", {
        Rotation = 90,
        Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 1),
            NumberSequenceKeypoint.new(1, 0),
        }),
        Parent = self.valOverlay,
    })
end

function ColorPicker:_buildPicker()
    self:_buildMap()

    self.satCursor = self.window:Create("Frame", {
        AnchorPoint = Vector2.new(0.5, 0.5),
        Size = UDim2.fromOffset(12, 12),
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BorderSizePixel = 0,
        ZIndex = 6,

        BackgroundTransparency = 1,

        Parent = self.map,
    })

    self.window:Create("UICorner", {
        CornerRadius = UDim.new(1, 0),
        Parent = self.satCursor,
    })

    self.satCursorStroke = self.window:Create("UIStroke", {
        Color = Color3.fromRGB(255, 255, 255),
        Thickness = 2,
        Transparency = 1,

        Parent = self.satCursor,
    })

    self.mapInteract = self.window:Create("TextButton", {
        BackgroundTransparency = 1,
        Size = UDim2.fromScale(1, 1),
        Text = "",
        TextTransparency = 1,
        AutoButtonColor = false,
        ZIndex = 7,

        Parent = self.map,
    })

    self.hueBar = self.window:Create("Frame", {
        Position = UDim2.fromOffset(hueX, contentY),
        Size = UDim2.fromOffset(hueWidth, mapSize.Y),
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BorderSizePixel = 0,
        ZIndex = 2,

        BackgroundTransparency = 1,

        Parent = self.main,
    })

    self.window:Create("UICorner", {
        CornerRadius = UDim.new(1, 0),
        Parent = self.hueBar,
    })

    self.window:Create("UIGradient", {
        Color = hueSequence,
        Rotation = 90,

        Parent = self.hueBar,
    })

    self.hueHandle = self.window:Create("Frame", {
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new(0.5, 0, 0, 0),
        Size = UDim2.fromOffset(hueWidth + 8, 8),
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BorderSizePixel = 0,
        ZIndex = 4,

        BackgroundTransparency = 1,

        Parent = self.hueBar,
    })

    self.window:Create("UICorner", {
        CornerRadius = UDim.new(1, 0),
        Parent = self.hueHandle,
    })

    self.hueHandleStroke = self.window:Create("UIStroke", {
        Color = Color3.fromRGB(255, 255, 255),
        Thickness = 2,
        Transparency = 1,

        Parent = self.hueHandle,
    })

    self.hueInteract = self.window:Create("TextButton", {
        BackgroundTransparency = 1,

        Size = UDim2.new(1, 16, 1, 8),
        Position = UDim2.fromScale(0.5, 0.5),
        AnchorPoint = Vector2.new(0.5, 0.5),
        Text = "",
        TextTransparency = 1,
        AutoButtonColor = false,
        ZIndex = 6,

        Parent = self.hueBar,
    })

    self.alphaBar = self.window:Create("Frame", {
        Position = UDim2.fromOffset(alphaX, contentY),
        Size = UDim2.fromOffset(alphaWidth, mapSize.Y),
        BackgroundColor3 = self.value,
        BorderSizePixel = 0,
        ZIndex = 2,

        BackgroundTransparency = 1,

        Parent = self.main,
    })

    self.window:Create("UICorner", {
        CornerRadius = UDim.new(1, 0),
        Parent = self.alphaBar,
    })

    self.alphaGradient = self.window:Create("UIGradient", {
        Rotation = 90,
        Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 0),
            NumberSequenceKeypoint.new(1, 1),
        }),
        Parent = self.alphaBar,
    })

    self.alphaHandle = self.window:Create("Frame", {
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new(0.5, 0, 0, 0),
        Size = UDim2.fromOffset(alphaWidth + 8, 8),
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BorderSizePixel = 0,
        ZIndex = 4,

        BackgroundTransparency = 1,

        Parent = self.alphaBar,
    })

    self.window:Create("UICorner", {
        CornerRadius = UDim.new(1, 0),
        Parent = self.alphaHandle,
    })

    self.alphaHandleStroke = self.window:Create("UIStroke", {
        Color = Color3.fromRGB(255, 255, 255),
        Thickness = 2,
        Transparency = 1,

        Parent = self.alphaHandle,
    })

    self.alphaInteract = self.window:Create("TextButton", {
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 16, 1, 8),
        Position = UDim2.fromScale(0.5, 0.5),
        AnchorPoint = Vector2.new(0.5, 0.5),
        Text = "",
        TextTransparency = 1,
        AutoButtonColor = false,
        ZIndex = 6,

        Parent = self.alphaBar,
    })

    self.hexBox = self.window:Create("Frame", {
        Position = UDim2.new(0, rightX, 0, contentY + 90),
        Size = UDim2.new(1, -(rightX + 20), 0, 30),
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BorderSizePixel = 0,
        ZIndex = 2,

        BackgroundTransparency = 1,

        Parent = self.main,
    })

    self.window:Create("UICorner", {
        CornerRadius = UDim.new(0, 8),
        Parent = self.hexBox,
    })

    self.hexBoxStroke = self.window:Create("UIStroke", {
        Color = Color3.fromRGB(255, 255, 255),
        Transparency = 1,

        Parent = self.hexBox,
    })

    self.hexInput = self.window:Create("TextBox", {
        Text = "#" .. self.value:ToHex():upper(),
        PlaceholderText = locale.t("Smart Input"),
        Size = UDim2.new(1, -14, 1, 0),
        Position = UDim2.fromScale(0.5, 0.5),
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        TextSize = 15,
        TextXAlignment = Enum.TextXAlignment.Center,
        ClearTextOnFocus = false,
        ZIndex = 3,

        TextTransparency = 1,

        Parent = self.hexBox,
    }, { TextColor3 = "ContentColor", FontFace = "Font", PlaceholderColor3 = "PlaceholderColor" })

    self.alphaBox = self.window:Create("Frame", {
        Position = UDim2.new(0, rightX, 0, contentY + 90),
        Size = UDim2.fromOffset(alphaFieldWidth, 30),
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BorderSizePixel = 0,
        ZIndex = 2,

        BackgroundTransparency = 1,

        Parent = self.main,
    })

    self.window:Create("UICorner", {
        CornerRadius = UDim.new(0, 8),
        Parent = self.alphaBox,
    })

    self.alphaBoxStroke = self.window:Create("UIStroke", {
        Color = Color3.fromRGB(255, 255, 255),
        Transparency = 1,

        Parent = self.alphaBox,
    })

    self.alphaInput = self.window:Create("TextBox", {
        Text = tostring(math.round(self.alpha * 100)) .. "%",
        PlaceholderText = "100%",
        Size = UDim2.new(1, -10, 1, 0),
        Position = UDim2.fromScale(0.5, 0.5),
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        TextSize = 15,
        TextXAlignment = Enum.TextXAlignment.Center,
        ClearTextOnFocus = false,
        ZIndex = 3,

        TextTransparency = 1,

        Parent = self.alphaBox,
    }, { TextColor3 = "ContentColor", FontFace = "Font", PlaceholderColor3 = "PlaceholderColor" })

    self.window:ConnectFor(self, self.mapInteract.InputBegan, function(input)
        if
            input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch
        then
            self:_beginDrag("sat", input.UserInputType == Enum.UserInputType.MouseButton1)
        end
    end)

    self.window:ConnectFor(self, self.hueInteract.InputBegan, function(input)
        if
            input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch
        then
            self:_beginDrag("hue", input.UserInputType == Enum.UserInputType.MouseButton1)
        end
    end)

    self.window:ConnectFor(self, self.alphaInteract.InputBegan, function(input)
        if
            input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch
        then
            self:_beginDrag("alpha", input.UserInputType == Enum.UserInputType.MouseButton1)
        end
    end)

    self.window:ConnectFor(self, variables.userInputService.InputEnded, function(input)
        if
            (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch)
            and self._drag
        then
            self:_endDrag()
        end
    end)

    self.window:ConnectFor(self, self.hexInput.FocusLost, function()
        local color = parseColor(self.hexInput.Text)
        if color then
            self:Set(color)
        else
            self.hexInput.Text = "#" .. self.value:ToHex():upper()
        end
    end)

    self.window:ConnectFor(self, self.alphaInput.FocusLost, function()
        local n = tonumber((self.alphaInput.Text:gsub("[^%d%.]", "")))
        if n then
            self:SetAlpha(clamp01(n / 100))
        else
            self.alphaInput.Text = tostring(math.round(self.alpha * 100)) .. "%"
        end
    end)
end

function ColorPicker:_beginDrag(region, isMouse)

    if not self._isOpen then
        return
    end
    self._drag = region
    self._dragIsMouse = isMouse
    self:_setHeld(region)
    self:_pump()

    if self._dragConnection then
        self._dragConnection:Disconnect()
        self._dragConnection = nil
    end

    self._dragConnection = variables.runService.RenderStepped:Connect(function()
        local mouseReleased = self._dragIsMouse
            and not variables.userInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1)
        if self.window.unloaded or not self._drag or mouseReleased then
            if mouseReleased then
                self:_endDrag()
                return
            end
            if self._dragConnection then
                self._dragConnection:Disconnect()
                self._dragConnection = nil
            end
            return
        end
        self:_pump()
    end)
end

function ColorPicker:_endDrag()
    self._drag = nil
    self:_setHeld(nil)
    if self._dragConnection then
        self._dragConnection:Disconnect()
        self._dragConnection = nil
    end

    self.window:_persist(self)
end

function ColorPicker:_setHeld(region)
    local satSize = if region == "sat" then UDim2.fromOffset(16, 16) else UDim2.fromOffset(12, 12)
    local hueSize = if region == "hue" then UDim2.fromOffset(hueWidth + 12, 10) else UDim2.fromOffset(hueWidth + 8, 8)
    local alphaSize = if region == "alpha"
        then UDim2.fromOffset(alphaWidth + 12, 10)
        else UDim2.fromOffset(alphaWidth + 8, 8)
    variables.tweenService:Create(self.satCursor, heldInfo, { Size = satSize }):Play()
    variables.tweenService:Create(self.hueHandle, heldInfo, { Size = hueSize }):Play()
    variables.tweenService:Create(self.alphaHandle, heldInfo, { Size = alphaSize }):Play()
end

function ColorPicker:_mouseLocation()
    local mouse = variables.userInputService:GetMouseLocation()
    local screenGui = self.window.screenGui
    if screenGui and screenGui.IgnoreGuiInset then
        return mouse - variables.guiService:GetGuiInset()
    end
    return mouse
end

function ColorPicker:_pump()

    local prevHue, prevSat, prevVal, prevAlpha = self.hue, self.sat, self.val, self.alpha

    if self._drag == "sat" then
        local size = self.map.AbsoluteSize
        if size.X <= 0 or size.Y <= 0 then
            return
        end
        local mouse = self:_mouseLocation()
        self.sat = clamp01((mouse.X - self.map.AbsolutePosition.X) / size.X)
        self.val = 1 - clamp01((mouse.Y - self.map.AbsolutePosition.Y) / size.Y)
    elseif self._drag == "hue" then
        local height = self.hueBar.AbsoluteSize.Y
        if height <= 0 then
            return
        end
        local mouse = self:_mouseLocation()
        self.hue = clamp01((mouse.Y - self.hueBar.AbsolutePosition.Y) / height)
    elseif self._drag == "alpha" then
        local height = self.alphaBar.AbsoluteSize.Y
        if height <= 0 then
            return
        end
        local mouse = self:_mouseLocation()

        self.alpha = 1 - clamp01((mouse.Y - self.alphaBar.AbsolutePosition.Y) / height)
    else
        return
    end

    if self.hue == prevHue and self.sat == prevSat and self.val == prevVal and self.alpha == prevAlpha then
        return
    end

    self.value = Color3.fromHSV(self.hue, self.sat, self.val)
    self:_render("drag")
    self:_fireCallback()
end

function ColorPicker:_render(mode)
    local mapHue = Color3.fromHSV(self.hue, 1, 1)
    local satPos = UDim2.new(self.sat, 0, 1 - self.val, 0)
    local huePos = UDim2.new(0.5, 0, self.hue, 0)
    local alphaPos = UDim2.new(0.5, 0, 1 - self.alpha, 0)
    local previewT = 1 - self.alpha
    local shadowT = 1 - 0.4 * self.alpha

    if mode == "instant" then
        self.map.BackgroundColor3 = mapHue
        self.satCursor.Position, self.satCursor.BackgroundColor3 = satPos, self.value
        self.hueHandle.Position, self.hueHandle.BackgroundColor3 = huePos, mapHue
        self.alphaBar.BackgroundColor3 = self.value
        self.alphaHandle.Position, self.alphaHandle.BackgroundColor3 = alphaPos, self.value
        self.preview.BackgroundColor3 = self.value
        self.previewShadow.Color = self.value
        if not self.window.hidden then
            self.preview.BackgroundTransparency = previewT
            self.previewShadow.Transparency = shadowT
        end
    else
        local moveInfo = if mode == "drag" then dragInfo else followInfo
        variables.tweenService:Create(self.map, moveInfo, { BackgroundColor3 = mapHue }):Play()
        variables.tweenService
            :Create(self.satCursor, moveInfo, { Position = satPos, BackgroundColor3 = self.value })
            :Play()
        variables.tweenService:Create(self.hueHandle, moveInfo, { Position = huePos, BackgroundColor3 = mapHue }):Play()
        variables.tweenService
            :Create(self.alphaHandle, moveInfo, { Position = alphaPos, BackgroundColor3 = self.value })
            :Play()

        variables.tweenService:Create(self.alphaBar, followInfo, { BackgroundColor3 = self.value }):Play()
        local previewGoal = { BackgroundColor3 = self.value }
        local shadowGoal = { Color = self.value }
        if not self.window.hidden then
            previewGoal.BackgroundTransparency = previewT
            shadowGoal.Transparency = shadowT
        end
        variables.tweenService:Create(self.preview, followInfo, previewGoal):Play()
        variables.tweenService:Create(self.previewShadow, followInfo, shadowGoal):Play()
    end

    if not self.hexInput:IsFocused() then
        self.hexInput.Text = "#" .. self.value:ToHex():upper()
    end
    if not self.alphaInput:IsFocused() then
        self.alphaInput.Text = tostring(math.round(self.alpha * 100)) .. "%"
    end

    self:_renderInvisible(mode ~= "instant")
end

function ColorPicker:_renderInvisible(animate)
    local inv = 0
    if self._isOpen and not self.window.hidden then
        inv = clamp01((0.12 - self.alpha) / 0.12)
    end
    local t = 1 - inv
    if animate then
        variables.tweenService:Create(self.invisibleIcon, fadeInfo, { ImageTransparency = t }):Play()
        variables.tweenService:Create(self.invisibleText, fadeInfo, { TextTransparency = t }):Play()
    else
        self.invisibleIcon.ImageTransparency = t
        self.invisibleText.TextTransparency = t
    end
end

function ColorPicker:_fireCallback()
    self.window:_runGuarded(self, self.callback, self.value, self.alpha)
end

function ColorPicker:_open()
    if self._isOpen then
        return
    end
    self._isOpen = true
    self:_setControlsVisible(true)

    if self._outsideClickConn then
        self.window:Disconnect(self._outsideClickConn)
    end
    self._outsideClickConn = self.window:Connect(variables.userInputService.InputBegan, function(input)
        if
            input.UserInputType ~= Enum.UserInputType.MouseButton1
            and input.UserInputType ~= Enum.UserInputType.Touch
        then
            return
        end
        local pos = input.Position
        local mainPos = self.main.AbsolutePosition
        local mainSize = self.main.AbsoluteSize
        if
            pos.X < mainPos.X
            or pos.X > mainPos.X + mainSize.X
            or pos.Y < mainPos.Y
            or pos.Y > mainPos.Y + mainSize.Y
        then
            self:_close()
        end
    end)

    variables.tweenService:Create(self.main, openInfo, { Size = UDim2.new(1, -20, 0, self._openHeight) }):Play()

    variables.tweenService
        :Create(self.preview, openInfo, { Position = self._previewOpenPos, Size = self._previewOpenSize })
        :Play()
    self:_applyPickerVisibility(true, true)
    self:_renderInvisible(true)
end

function ColorPicker:_close()
    if not self._isOpen then
        return
    end
    self._isOpen = false

    if self._outsideClickConn then
        self.window:Disconnect(self._outsideClickConn)
        self._outsideClickConn = nil
    end

    if self._drag then
        self:_endDrag()
    end
    if self.hexInput:IsFocused() then
        self.hexInput:ReleaseFocus()
    end
    if self.alphaInput:IsFocused() then
        self.alphaInput:ReleaseFocus()
    end

    self:_applyPickerVisibility(false, true)
    self:_renderInvisible(true)
    variables.tweenService
        :Create(self.preview, openInfo, { Position = previewClosedPos, Size = previewClosedSize })
        :Play()
    variables.tweenService:Create(self.main, openInfo, { Size = UDim2.new(1, -20, 0, headerHeight) }):Play()

    task.delay(fadeInfo.Time, function()
        if not self._isOpen then
            self:_setControlsVisible(false)
        end
    end)
end

function ColorPicker:_applyPickerVisibility(open, animate)
    local set = {
        [self.map] = { BackgroundTransparency = if open then 0 else 1 },
        [self.satOverlay] = { BackgroundTransparency = if open then 0 else 1 },
        [self.valOverlay] = { BackgroundTransparency = if open then 0 else 1 },
        [self.mapStroke] = { Transparency = if open then 0.9 else 1 },
        [self.satCursor] = { BackgroundTransparency = if open then 0 else 1 },
        [self.satCursorStroke] = { Transparency = if open then 0 else 1 },
        [self.hueBar] = { BackgroundTransparency = if open then 0 else 1 },
        [self.hueHandle] = { BackgroundTransparency = if open then 0 else 1 },
        [self.hueHandleStroke] = { Transparency = if open then 0 else 1 },
        [self.alphaBar] = { BackgroundTransparency = if open then 0 else 1 },
        [self.alphaHandle] = { BackgroundTransparency = if open then 0 else 1 },
        [self.alphaHandleStroke] = { Transparency = if open then 0 else 1 },
        [self.hexBox] = { BackgroundTransparency = if open then 0.9 else 1 },
        [self.hexBoxStroke] = { Transparency = if open then 0.85 else 1 },
        [self.hexInput] = { TextTransparency = if open then 0.4 else 1 },
        [self.alphaBox] = { BackgroundTransparency = if open then 0.9 else 1 },
        [self.alphaBoxStroke] = { Transparency = if open then 0.85 else 1 },
        [self.alphaInput] = { TextTransparency = if open then 0.4 else 1 },
    }

    for instance, props in set do
        if animate then
            variables.tweenService:Create(instance, fadeInfo, props):Play()
        else
            for prop, value in props do
                instance[prop] = value
            end
        end
    end
end

function ColorPicker:_setControlsVisible(visible)
    for _, frame in { self.map, self.hueBar, self.alphaBar, self.hexBox, self.alphaBox } do
        frame.Visible = visible
    end
end

function ColorPicker:_applyLayout()
    local width = self.main.AbsoluteSize.X
    local mode = if width > 0 and width < narrowWidth then "narrow" else "wide"
    if mode == self._layoutMode then
        return
    end
    self._layoutMode = mode

    local l = layoutSpec[mode]
    self._openHeight = l.height
    self._previewOpenPos = l.previewPos
    self._previewOpenSize = l.previewSize
    self.hexBox.Position = l.hexPos
    self.hexBox.Size = l.hexSize
    self.alphaBox.Position = l.alphaFieldPos
    self.alphaBox.Size = l.alphaFieldSize

    if self._isOpen then
        variables.tweenService:Create(self.main, openInfo, { Size = UDim2.new(1, -20, 0, self._openHeight) }):Play()
        variables.tweenService
            :Create(self.preview, openInfo, { Position = self._previewOpenPos, Size = self._previewOpenSize })
            :Play()
    end
end

function ColorPicker:Set(color, skipCallback)
    self.value = coerceColor(color, self.value)
    self.hue, self.sat, self.val = self.value:ToHSV()

    self:_render(if self._isOpen then "animate" else "instant")

    if not skipCallback then
        self:_fireCallback()
        self.window:_persist(self)
    end
end

function ColorPicker:SetAlpha(alpha, skipCallback)
    self.alpha = clamp01(if type(alpha) == "number" then alpha else self.alpha)
    self:_render(if self._isOpen then "animate" else "instant")

    if not skipCallback then
        self:_fireCallback()
        self.window:_persist(self)
    end
end

function ColorPicker:_serialize()
    return self.value:ToHex() .. string.format("%02x", math.clamp(math.round((self.alpha or 1) * 255), 0, 255))
end

function ColorPicker:_deserialize(raw)
    local hex = tostring(raw)
    local alpha = nil
    if #hex >= 8 then
        alpha = (tonumber(hex:sub(7, 8), 16) or 255) / 255
        hex = hex:sub(1, 6)
    end

    local ok, color = pcall(Color3.fromHex, hex)
    if not ok then
        return
    end
    if alpha then
        self:SetAlpha(alpha, true)
    end
    self:Set(color)
end

function ColorPicker:_setShown(shown, animate)
    local w = self.window
    if shown then
        w:_revealCommon(self, animate)

        w:_reveal(self.preview, { BackgroundTransparency = 1 - self.alpha }, animate)
        w:_reveal(self.previewShadow, { Transparency = 1 - 0.4 * self.alpha }, animate)
    else
        w:_hideCommon(self, animate)
        w:_reveal(self.preview, { BackgroundTransparency = 1 }, animate)
        w:_reveal(self.previewShadow, { Transparency = 1 }, animate)

        if self._isOpen then
            self:_close()
        end
    end
end

moveable(ColorPicker)
lockable(ColorPicker)

return ColorPicker
end

Components.console = { Name = "console", Parent = Components }
Components.console.FindFirstChild = function(self, k) return self[k] end
Components.console.__loader = function(script, require)
local Console = {}
Console.__index = Console
Console.__type = "Console"

local utility = script.Parent.Parent.utility

local moveable = require(utility.moveable)
local locale = require(utility.locale)

local defaultHeight = 120
local minHeight = 48
local titleHeight = 24
local padding = 17
local textPadding = 12
local textSize = 12
local lineHeight = 1.25

local defaultMaxLines = 200

local monoFont = Font.fromEnum(Enum.Font.Code)

function Console.new(tab, properties)
    properties = if typeof(properties) == "table" then properties else {}

    local self = setmetatable({
        tab = assert(tab, "Missing argument #1 (Tab expected)"),
        window = tab.window,
        name = properties.name or properties.Name,
        description = properties.description or properties.Description,

        height = math.max(tonumber(properties.height or properties.Height) or defaultHeight, minHeight),

        follow = properties.follow or properties.Follow or false,
        maxLines = math.max(tonumber(properties.maxLines or properties.MaxLines) or defaultMaxLines, 1),

        lines = {},

        lineLabels = {},
        head = 1,
        nextOrder = 1,
        textDirty = true,
    }, Console)

    self:_build()
    self:_setLines(properties.text or properties.Text or "")

    if self.description then
        self.descriptor = require(script.Parent.descriptor).new(self.tab, { description = self.description })
    end

    return self
end

function Console:Get(): string
    if self.textDirty then
        self.text = table.concat(self.lines, "\n")
        self.textDirty = false
    end
    return self.text
end

function Console:_setLines(text)
    text = if type(text) == "string" then text else tostring(text)

    table.clear(self.lines)
    if text ~= "" then
        for line in string.gmatch(text .. "\n", "([^\n]*)\n") do
            table.insert(self.lines, line)
        end
    end
    self:_trim()
    self:_flush()
end

function Console:_trim()
    local excess = #self.lines - self.maxLines
    if excess <= 0 then
        return
    end
    table.move(self.lines, excess + 1, #self.lines, 1)
    for index = #self.lines, #self.lines - excess + 1, -1 do
        self.lines[index] = nil
    end
end

function Console:_makeLabel()
    return self.window:Create("TextLabel", {
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        FontFace = monoFont,
        TextSize = textSize,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Top,
        TextWrapped = true,
        LineHeight = lineHeight,
        RichText = false,

        TextTransparency = self._textTransparency or 1,

        Parent = self.scroll,
    }, { TextColor3 = "ContentColor" })
end

local function rowText(line: string): string
    return if line == "" then " " else line
end

function Console:_flush()
    self.textDirty = true

    for index, line in self.lines do
        local label = self.lineLabels[index]
        if not label then
            label = self:_makeLabel()
            self.lineLabels[index] = label
        end
        label.LayoutOrder = index
        label.Text = rowText(line)
        label.Visible = true
    end

    for index = #self.lines + 1, #self.lineLabels do
        self.lineLabels[index].Visible = false
    end

    self.head = 1
    self.nextOrder = #self.lines + 1
    self:_follow()
end

function Console:_pushLine(line: string)
    self.textDirty = true

    if #self.lines < self.maxLines then
        table.insert(self.lines, line)
        local index = #self.lines
        local label = self.lineLabels[index]
        if not label then
            label = self:_makeLabel()
            self.lineLabels[index] = label
        end
        label.LayoutOrder = self.nextOrder
        label.Text = rowText(line)
        label.Visible = true
        self.nextOrder += 1
        return
    end

    table.move(self.lines, 2, #self.lines, 1)
    self.lines[#self.lines] = line

    local label = self.lineLabels[self.head]
    label.LayoutOrder = self.nextOrder
    label.Text = rowText(line)
    label.Visible = true

    self.nextOrder += 1
    self.head = (self.head % #self.lineLabels) + 1
end

function Console:_build()
    local top = if self.name then titleHeight else 0

    self.main = self.window:Create("Frame", {
        Size = UDim2.new(1, -20, 0, self.height + top + padding * 2),
        BorderSizePixel = 0,
        Name = self.name or "Console",
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),

        BackgroundTransparency = 1,

        Parent = self.tab.tabPage,
    }, { BackgroundTransparency = "ElementTransparency" })

    self.stroke = self.window:StyleElementBody(self.main)

    if self.name then
        self.container = self.window:Create("Frame", {
            Size = UDim2.new(1, -padding * 2, 0, 16),
            Position = UDim2.new(0, padding, 0, padding),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,

            Parent = self.main,
        })

        self.title = self.window:Create("TextLabel", {
            Text = locale.t(self.name),

            Size = UDim2.fromScale(1, 1),
            BorderSizePixel = 0,
            BackgroundTransparency = 1,
            TextSize = 16,
            TextXAlignment = Enum.TextXAlignment.Left,

            TextTransparency = 1,

            Parent = self.container,
        }, { TextColor3 = "ContentColor", FontFace = "Font" })
    end

    self.panel = self.window:Create("Frame", {
        AnchorPoint = Vector2.new(0.5, 1),
        Position = UDim2.new(0.5, 0, 1, -padding),
        Size = UDim2.new(1, -padding * 2, 0, self.height),
        BorderSizePixel = 0,
        ClipsDescendants = true,

        BackgroundTransparency = 1,

        Parent = self.main,
    }, { BackgroundColor3 = "StatBackground" })

    self.window:Create("UICorner", {
        Parent = self.panel,
    }, { CornerRadius = "ElementCornerRadius" })

    self.panelStroke = self.window:Create("UIStroke", {
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,

        Transparency = 1,

        Parent = self.panel,
    }, { Color = "SurfaceStroke" })

    self.scroll = self.window:Create("ScrollingFrame", {
        Size = UDim2.new(1, -textPadding * 2, 1, -textPadding * 2),
        Position = UDim2.fromScale(0.5, 0.5),
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        CanvasSize = UDim2.new(0, 0, 0, 0),
        ScrollBarThickness = 0,
        ScrollingDirection = Enum.ScrollingDirection.Y,

        Parent = self.panel,
    })

    self.scrollLayout = self.window:Create("UIListLayout", {
        FillDirection = Enum.FillDirection.Vertical,
        HorizontalAlignment = Enum.HorizontalAlignment.Left,
        VerticalAlignment = Enum.VerticalAlignment.Top,
        SortOrder = Enum.SortOrder.LayoutOrder,

        Parent = self.scroll,
    })

    self:_watchCanvas()
end

function Console:_pin()
    local scroll = self.scroll
    if not scroll or not scroll.Parent then
        return
    end
    scroll.CanvasPosition = Vector2.new(0, scroll.AbsoluteCanvasSize.Y)
end

function Console:_follow()
    if not self.follow then
        return
    end
    self:_pin()
    task.defer(function()
        self:_pin()
    end)
end

function Console:_watchCanvas()
    self.window:ConnectFor(self, self.scrollLayout:GetPropertyChangedSignal("AbsoluteContentSize"), function()
        if self.follow then
            self:_pin()
        end
    end)
end

function Console:Set(text)
    self:_setLines(text)
end

function Console:Append(line)
    line = if type(line) == "string" then line else tostring(line)
    for part in string.gmatch(line .. "\n", "([^\n]*)\n") do
        self:_pushLine(part)
    end
    self:_follow()
end

function Console:Clear()
    table.clear(self.lines)
    self:_flush()
end

function Console:Copy(): boolean
    local clipboard = (getgenv and getgenv().setclipboard) or setclipboard
    if typeof(clipboard) ~= "function" then
        return false
    end
    return (pcall(clipboard, self:Get()))
end

function Console:SetHeight(height)
    self.height = math.max(tonumber(height) or defaultHeight, minHeight)
    local top = if self.name then titleHeight else 0
    self.panel.Size = UDim2.new(1, -padding * 2, 0, self.height)
    self.main.Size = UDim2.new(1, -20, 0, self.height + top + padding * 2)
end

function Console:_setShown(shown, animate)
    local w = self.window

    w:_reveal(self.main, { BackgroundTransparency = if shown then w.theme.ElementTransparency or 0 else 1 }, animate)
    w:_reveal(self.stroke, { Transparency = if shown then w.theme.ElementStrokeTransparency else 1 }, animate)
    w:_reveal(self.panel, { BackgroundTransparency = if shown then 0 else 1 }, animate)
    w:_reveal(self.panelStroke, { Transparency = if shown then 0.9 else 1 }, animate)

    self._textTransparency = if shown then 0.15 else 1
    for _, label in self.lineLabels do
        w:_reveal(label, { TextTransparency = self._textTransparency }, animate)
    end

    if self.title then
        w:_reveal(self.title, { TextTransparency = if shown then 0 else 1 }, animate)
    end
    if self.descriptor then
        w:_reveal(self.descriptor.titleLabel, { TextTransparency = if shown then 0.7 else 1 }, animate)
    end
end

function Console:Remove()
    if self.descriptor then
        self.descriptor:Remove()
    end
    self.main:Destroy()
end

moveable(Console)

return Console
end

Components.descriptor = { Name = "descriptor", Parent = Components }
Components.descriptor.FindFirstChild = function(self, k) return self[k] end
Components.descriptor.__loader = function(script, require)
local Descriptor = {}
Descriptor.__index = Descriptor
Descriptor.__type = "Descriptor"

local locale = require(script.Parent.Parent.utility.locale)

function Descriptor.new(tab, properties)
    properties = if typeof(properties) == "table" then properties else {}

    local self = setmetatable({
        tab = assert(tab, "Missing argument #1 (Tab expected)"),
        window = tab.window,
        description = properties.description or properties.Description or "",
    }, Descriptor)

    self.main = self.window:Create("Frame", {
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, -30, 0, 0),

        Parent = self.tab.tabPage,
    })

    self.window:Create("UIListLayout", {
        SortOrder = Enum.SortOrder.LayoutOrder,
        Parent = self.main,
    })

    self.titleLabel = self.window:Create("TextLabel", {
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
        RichText = true,
        Size = UDim2.new(1, -90, 0, 0),
        Text = locale.t(self.description),
        TextSize = 12,
        TextWrapped = true,
        TextXAlignment = Enum.TextXAlignment.Left,

        TextTransparency = 1,

        Parent = self.main,
    }, { TextColor3 = "ContentColor", FontFace = "Font" })

    self.window:Create("Frame", {
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        LayoutOrder = 1,
        Size = UDim2.fromOffset(0, 15),
        Parent = self.main,
    })

    return self
end

return Descriptor
end

Components.divider = { Name = "divider", Parent = Components }
Components.divider.FindFirstChild = function(self, k) return self[k] end
Components.divider.__loader = function(script, require)
local Divider = {}
Divider.__index = Divider
Divider.__type = "Divider"

local moveable = require(script.Parent.Parent.utility.moveable)
local locale = require(script.Parent.Parent.utility.locale)

local lineThickness = 1
local defaultSpacing = 12
local labelGap = 10
local labelHeight = 14
local textSize = 12

local lineShown = 0.88
local labelShown = 0.55

function Divider.new(tab, properties)
    properties = if typeof(properties) == "table" then properties else {}

    local spacing = properties.spacing or properties.Spacing
    local text = properties.text or properties.Text

    local self = setmetatable({
        tab = assert(tab, "Missing argument #1 (Tab expected)"),
        window = tab.window,
        text = if text ~= nil then tostring(text) else "",
        spacing = if type(spacing) == "number" then math.max(spacing, 0) else defaultSpacing,

        line = properties.line ~= false and properties.Line ~= false,
    }, Divider)

    self.main = self.window:Create("Frame", {
        Size = UDim2.new(1, -40, 0, 0),
        BorderSizePixel = 0,
        Name = "Divider",
        BackgroundTransparency = 1,

        Parent = self.tab.tabPage,
    })

    self.window:Create("UIListLayout", {
        FillDirection = Enum.FillDirection.Horizontal,
        Padding = UDim.new(0, labelGap),
        SortOrder = Enum.SortOrder.LayoutOrder,
        VerticalAlignment = Enum.VerticalAlignment.Center,
        HorizontalAlignment = Enum.HorizontalAlignment.Center,

        Parent = self.main,
    })

    if self.line then
        self.left = self:_buildHalf(1)
    end

    if self.text ~= "" then
        self:_buildLabel()
    end

    self:_applyHeight()

    return self
end

function Divider:_buildHalf(order)
    local rule = self.window:Create("Frame", {
        Size = UDim2.new(0, 0, 0, lineThickness),
        BorderSizePixel = 0,
        LayoutOrder = order,

        BackgroundTransparency = 1,

        Parent = self.main,
    }, { BackgroundColor3 = "ContentColor" })

    self.window:Create("UIFlexItem", {
        FlexMode = Enum.UIFlexMode.Fill,

        Parent = rule,
    })

    return rule
end

function Divider:_buildLabel()
    self.title = self.window:Create("TextLabel", {
        Text = locale.t(self.text),
        Size = UDim2.fromOffset(0, labelHeight),
        AutomaticSize = Enum.AutomaticSize.X,
        BorderSizePixel = 0,
        BackgroundTransparency = 1,
        TextSize = textSize,
        TextXAlignment = Enum.TextXAlignment.Center,
        LayoutOrder = 2,

        TextTransparency = 1,

        Parent = self.main,
    }, { TextColor3 = "ContentColor", FontFace = "Font" })

    if self.line then
        self.right = self:_buildHalf(3)
    end
end

function Divider:_applyHeight()
    local content = if self.text ~= "" then labelHeight elseif self.line then lineThickness else 0
    self.main.Size = UDim2.new(1, -40, 0, self.spacing * 2 + content)
end

function Divider:Set(text)
    self.text = if text ~= nil then tostring(text) else ""

    if self.text ~= "" and not self.title then
        self:_buildLabel()

        if not self.window.hidden then
            self:_setShown(true, true)
        end
    end

    if self.title then
        self.window:_bindLocale(self.title, "Text", self.text)

        local named = self.text ~= ""
        self.title.Visible = named
        if self.right then
            self.right.Visible = named
        end
    end

    self:_applyHeight()
end

function Divider:_setShown(shown, animate)
    local w = self.window
    local ruleTransparency = if shown then lineShown else 1

    w:_reveal(self.left, { BackgroundTransparency = ruleTransparency }, animate)
    w:_reveal(self.right, { BackgroundTransparency = ruleTransparency }, animate)
    w:_reveal(self.title, { TextTransparency = if shown then labelShown else 1 }, animate)
end

moveable(Divider)

return Divider
end

Components.drag = { Name = "drag", Parent = Components }
Components.drag.FindFirstChild = function(self, k) return self[k] end
Components.drag.__loader = function(script, require)
local Drag = {}
Drag.__index = Drag
Drag.__type = "Drag"

local utility = script.Parent.Parent.utility

local variables = require(utility.variables)
local constants = require(utility.constants)

function Drag.new(window, properties)
    properties = if typeof(properties) == "table" then properties else {}

    local self = setmetatable({
        window = assert(window, "Missing argument #1 (Window expected)"),
    }, Drag)

    self.drag = self.window:Create("Frame", {
        BackgroundTransparency = 1,
        Size = UDim2.fromOffset(150, 20),
        AnchorPoint = Vector2.new(0.5, 0.5),

        Position = UDim2.new(0.5, 0, 0.5, self.window.size.Y.Offset / 2 + 15),
        ZIndex = constants.zIndex.drag,

        Visible = false,

        Parent = self.window.screenGui,
    })

    self.dragCosmetic = self.window:Create("Frame", {
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.3),
        ZIndex = constants.zIndex.drag,

        BackgroundTransparency = 1,
        Size = UDim2.fromOffset(0, 4),

        Parent = self.drag,
    })

    self.window:Create("UICorner", {
        CornerRadius = UDim.new(0, 20),

        Parent = self.dragCosmetic,
    })

    self.window:CreateGlow(self.dragCosmetic, Color3.fromRGB(255, 255, 255), 10, 0.5)

    self.dragInteract = self.window:Create("TextButton", {
        BackgroundTransparency = 1,
        Size = UDim2.fromScale(1, 1),
        TextTransparency = 1,
        ZIndex = constants.zIndex.drag,

        Parent = self.drag,
    })

    local dragging = false
    local relative = nil

    local offset = Vector2.zero
    local screenGui = self.window.screenGui

    if screenGui and screenGui.IgnoreGuiInset then
        offset = variables.guiService:GetGuiInset()
    end

    local function getPosition()
        local mouseLocation = variables.userInputService and variables.userInputService:GetMouseLocation()
            or Vector2.new(0, 0)
        local validRelative = relative or Vector2.new(0, 0)
        local validOffset = offset or Vector2.new(0, 0)

        return mouseLocation + validRelative + validOffset
    end

    local function getTargets()
        local position = getPosition()
        local x, y = position.X, position.Y

        if self.window.settings and self.window.settings.keepOnScreen then
            local size = self.window.main.AbsoluteSize
            local screen = self.window.screenGui.AbsoluteSize
            local margin = 8
            local halfX, halfY = size.X / 2, size.Y / 2

            x = math.clamp(x, halfX + margin, math.max(halfX + margin, screen.X - halfX - margin))
            y = math.clamp(y, halfY + margin, math.max(halfY + margin, screen.Y - halfY - margin))
        end

        local mainTarget = UDim2.fromOffset(x, y)
        local dragTarget = UDim2.fromOffset(x, y + (self.window.main.Size.Y.Offset / 2 + 15))
        return mainTarget, dragTarget
    end

    self.window:Connect(self.drag.MouseEnter, function()
        if not dragging and not self.window.hidden then
            variables.tweenService
                :Create(
                    self.dragCosmetic,
                    TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
                    { BackgroundTransparency = 0.5, Size = UDim2.new(0, 120, 0, 4) }
                )
                :Play()
        end
    end)

    self.window:Connect(self.drag.MouseLeave, function()
        if not dragging and not self.window.hidden then
            variables.tweenService
                :Create(
                    self.dragCosmetic,
                    TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
                    { BackgroundTransparency = 0.7, Size = UDim2.new(0, 100, 0, 4) }
                )
                :Play()
        end
    end)

    local function releaseDrag()
        if not dragging then
            return
        end
        dragging = false

        if not self.window:_interactive() then
            return
        end

        variables.tweenService
            :Create(
                self.dragCosmetic,
                TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
                { Size = UDim2.new(0, 100, 0, 4), BackgroundTransparency = 0.7 }
            )
            :Play()

        local settle = TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
        local mainTarget, dragTarget = getTargets()
        variables.tweenService:Create(self.window.main, settle, { Position = mainTarget }):Play()
        variables.tweenService:Create(self.drag, settle, { Position = dragTarget }):Play()
    end

    self.window:Connect(self.dragInteract.InputBegan, function(input, processed)
        if processed then
            return
        end

        local inputType = input.UserInputType.Name
        if inputType == "MouseButton1" or inputType == "Touch" then

            if not self.window:_interactive() then
                return
            end

            dragging = true

            if screenGui and screenGui.IgnoreGuiInset then
                offset = variables.guiService:GetGuiInset()
            end

            relative = self.window.main.AbsolutePosition
                + self.window.main.AbsoluteSize * self.window.main.AnchorPoint
                - variables.userInputService:GetMouseLocation()
            if not self.window.hidden then
                variables.tweenService
                    :Create(
                        self.dragCosmetic,
                        TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
                        { Size = UDim2.new(0, 110, 0, 4), BackgroundTransparency = 0 }
                    )
                    :Play()
            end
        end
    end)

    self.window:Connect(variables.userInputService.InputEnded, function(input)
        local inputType = input.UserInputType.Name
        if inputType == "MouseButton1" or inputType == "Touch" then
            releaseDrag()
        end
    end)

    self.window:Connect(variables.userInputService.WindowFocusReleased, releaseDrag)

    local mainRemaining = 1e-7
    local barRemaining = 1e-60

    self.window:Connect(variables.runService.RenderStepped, function(dt)
        if not dragging then
            return
        end

        if not self.window:_interactive() then
            releaseDrag()
            return
        end

        local mainTarget, dragTarget = getTargets()

        self.window.main.Position = self.window.main.Position:Lerp(mainTarget, 1 - mainRemaining ^ dt)
        self.drag.Position = self.drag.Position:Lerp(dragTarget, 1 - barRemaining ^ dt)
    end)

    return self
end

return Drag
end

Components.dropdown = { Name = "dropdown", Parent = Components }
Components.dropdown.FindFirstChild = function(self, k) return self[k] end
Components.dropdown.__loader = function(script, require)
local Dropdown = {}
Dropdown.__index = Dropdown
Dropdown.__type = "Dropdown"

local utility = script.Parent.Parent.utility

local variables = require(utility.variables)
local functions = require(utility.functions)
local image = require(utility.image)
local constants = require(utility.constants)
local locale = require(utility.locale)
local hapticEngine = require(utility.HapticEngine)
local windowSizing = require(utility.windowSizing)
local lockable = require(utility.lockable)

local chevronIcon = constants.icons.chevron
local checkIcon = constants.icons.check
local dotIcon = constants.icons.dot
local searchIconAsset = constants.icons.search

local roundRadius = UDim.new(0, 12)
local flatRadius = UDim.new(0, 7)

local searchCollapsedHeight = 30
local searchExpandedHeight = 38

local optionHeight = 38
local optionGap = 5
local listPadding = 2

local headerHeight = 41
local headerGap = 6
local cardPaddingTop = 7
local cardPaddingBottom = 6
local cardPadding = cardPaddingTop + cardPaddingBottom

local maxVisibleOptions = 4

local actionsHeight = 22
local hintTween = TweenInfo.new(0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
local hoverTween = TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)

local scrollbarShown = 0.4
local searchTween = TweenInfo.new(0.35, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)

local function dedupStrings(arr)
    local seen = {}
    local out = {}
    for _, v in arr do
        if typeof(v) == "string" and not seen[v] then
            seen[v] = true
            table.insert(out, v)
        end
    end
    return out
end

local function normalizeValue(value, multi)
    if value == nil then
        return {}
    end
    if typeof(value) == "string" then
        return { value }
    end
    if typeof(value) == "table" then
        local out = dedupStrings(value)
        if not multi and #out > 1 then
            return { out[1] }
        end
        return out
    end
    return {}
end

local function intersectWithOptions(value, options)
    local out = {}
    for _, v in value do
        if table.find(options, v) then
            table.insert(out, v)
        end
    end
    return out
end

local function sameSelection(a, b)
    if #a ~= #b then
        return false
    end
    for _, v in a do
        if not table.find(b, v) then
            return false
        end
    end
    return true
end

function Dropdown.new(tab, properties)
    properties = if typeof(properties) == "table" then properties else {}

    local options = properties.options or properties.Options or {}
    local multiSelect = properties.multiSelect or properties.MultiSelect or properties.MultipleOptions or false

    local self = setmetatable({
        tab = assert(tab, "Missing argument #1 (Tab expected)"),
        window = tab.window,
        name = properties.name or properties.Name or "Dropdown",
        icon = properties.icon or properties.Icon,
        description = properties.description or properties.Description,
        forgetState = properties.forgetState or properties.ForgetState or tab.forgetState,

        flag = properties.flag
            or properties.Flag
            or (
                not (properties.forgetState or properties.ForgetState or tab.forgetState)
                    and functions.deriveFlagFromName(properties.name or properties.Name or "Dropdown")
                or nil
            ),

        callback = properties.callback or properties.Callback or function() end,

        options = dedupStrings(options),
        multiSelect = multiSelect,
        placeholderText = locale.resolve(properties.placeholder or properties.Placeholder or "None"),
        value = normalizeValue(
            properties.value or properties.Value or properties.currentOption or properties.CurrentOption,
            multiSelect
        ),

        _isOpen = false,
        _optionFrames = {},
    }, Dropdown)

    self._desiredValue = self.value
    self.value = intersectWithOptions(self.value, self.options)

    self.window:_registerControl(self)

    self.main = self.window:Create("Frame", {
        Size = UDim2.new(1, -20, 0, 41),
        BorderSizePixel = 0,
        Name = self.name,
        BackgroundTransparency = 1,

        Parent = self.tab.tabPage,
    })

    self.top = self.window:Create("Frame", {
        Size = UDim2.new(1, 0, 0, 41),
        Position = UDim2.fromScale(0, 0),
        BorderSizePixel = 0,
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 1,
        ZIndex = 1,

        Parent = self.main,
    }, { BackgroundTransparency = "ElementTransparency" })

    self.stroke = self.window:StyleElementBody(self.top)
    self.hoverOverlay = self.window:CreateHoverOverlay(self.top)
    self.flashTarget = self.top

    self.container = self.window:Create("Frame", {
        BorderSizePixel = 0,

        Parent = self.top,
        Size = UDim2.new(0, 170, 0, 16),
        Position = UDim2.new(0, 20, 0.5, 0),
        AnchorPoint = Vector2.new(0, 0.5),
        BackgroundTransparency = 1,
        ZIndex = 5,
    })

    self.containerLayout = self.window:Create("UIListLayout", {
        Padding = UDim.new(0, 5),
        FillDirection = Enum.FillDirection.Horizontal,
        VerticalAlignment = Enum.VerticalAlignment.Center,
        HorizontalAlignment = Enum.HorizontalAlignment.Left,

        Parent = self.container,
    })

    if self.icon then
        self.iconLabel = self.window:Create("ImageLabel", {
            Image = self.icon,
            Size = UDim2.fromOffset(16, 16),
            BorderSizePixel = 0,
            BackgroundTransparency = 1,

            ImageTransparency = 1,

            ZIndex = 5,
            Parent = self.container,
        }, { ImageColor3 = "ContentColor" })
    end

    self.title = self.window:Create("TextLabel", {

        Text = locale.t(self.name),

        Size = UDim2.fromOffset(150, 16),
        BorderSizePixel = 0,
        BackgroundTransparency = 1,
        TextSize = 16,
        AutomaticSize = Enum.AutomaticSize.X,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextWrapped = true,
        LayoutOrder = 1,

        TextTransparency = 1,

        ZIndex = 5,
        Parent = self.container,
    }, { TextColor3 = "ContentColor", FontFace = "Font" })

    self.selectedLabel = self.window:Create("TextLabel", {
        AnchorPoint = Vector2.new(1, 0.5),
        Position = UDim2.new(1, -41, 0.5, 0),
        Size = UDim2.fromOffset(168, 15),
        BorderSizePixel = 0,
        BackgroundTransparency = 1,
        TextSize = 15,
        TextXAlignment = Enum.TextXAlignment.Right,
        TextWrapped = true,

        TextTransparency = 1,

        ZIndex = 5,
        Parent = self.top,
    }, { TextColor3 = "ContentColor", FontFace = "Font" })

    self.chevron = self.window:Create("ImageLabel", {
        AnchorPoint = Vector2.new(1, 0.5),
        Position = UDim2.new(1, -18, 0.5, 0),
        Size = UDim2.fromOffset(16, 16),
        BorderSizePixel = 0,
        BackgroundTransparency = 1,
        Image = "rbxassetid://" .. tostring(chevronIcon),
        Rotation = 180,

        ImageTransparency = 1,

        ZIndex = 5,
        Parent = self.top,
    }, { ImageColor3 = "ContentColor" })

    self.interact = self.window:Create("TextButton", {
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 41),
        Position = UDim2.fromScale(0, 0),
        BorderSizePixel = 0,
        Text = "",
        TextTransparency = 1,
        ZIndex = 10,
        AutoButtonColor = false,

        Parent = self.main,
    })

    self.panel = self.window:Create("Frame", {
        AnchorPoint = Vector2.new(1, 1),
        Position = UDim2.new(1, 0, 1, 0),
        Size = UDim2.new(1, 0, 1, -(headerHeight + headerGap)),
        BorderSizePixel = 0,
        ClipsDescendants = true,
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        ZIndex = 1,

        BackgroundTransparency = 1,

        Parent = self.main,
    })

    self.panelStroke = self.window:StyleElementPanel(self.panel)

    self.window:Create("UIListLayout", {
        Padding = UDim.new(0, 5),
        FillDirection = Enum.FillDirection.Vertical,
        VerticalAlignment = Enum.VerticalAlignment.Top,
        HorizontalAlignment = Enum.HorizontalAlignment.Center,
        SortOrder = Enum.SortOrder.LayoutOrder,

        Parent = self.panel,
    })

    self.window:Create("UIPadding", {
        PaddingTop = UDim.new(0, cardPaddingTop),
        PaddingBottom = UDim.new(0, cardPaddingBottom),

        Parent = self.panel,
    })

    self:_buildSearch()
    self:_buildActions()

    self.list = self.window:Create("ScrollingFrame", {
        Active = true,
        Size = UDim2.new(1, 0, 0, 0),
        BorderSizePixel = 0,
        BackgroundTransparency = 1,
        ClipsDescendants = true,
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        CanvasSize = UDim2.new(),
        ScrollBarImageColor3 = Color3.fromRGB(240, 240, 240),
        ScrollBarThickness = 3,
        ScrollBarImageTransparency = 1,
        ScrollingDirection = Enum.ScrollingDirection.Y,
        LayoutOrder = 3,
        ZIndex = 1,

        Parent = self.panel,
    })

    self.window:Create("UIFlexItem", {
        FlexMode = Enum.UIFlexMode.Fill,

        Parent = self.list,
    })

    self.window:ConnectFor(self, self.list:GetPropertyChangedSignal("CanvasPosition"), function()
        self:_syncScrollHint()
    end)
    self.window:ConnectFor(self, self.list:GetPropertyChangedSignal("AbsoluteCanvasSize"), function()
        self:_syncScrollHint()
    end)

    self.window:ConnectFor(self, self.list:GetPropertyChangedSignal("AbsoluteWindowSize"), function()
        self:_syncScrollHint()
    end)

    self.listLayout = self.window:Create("UIListLayout", {
        Padding = UDim.new(0, 5),
        SortOrder = Enum.SortOrder.LayoutOrder,
        HorizontalAlignment = Enum.HorizontalAlignment.Center,

        Parent = self.list,
    })

    self.window:Create("UIPadding", {
        PaddingTop = UDim.new(0, listPadding),
        PaddingBottom = UDim.new(0, listPadding),

        Parent = self.list,
    })

    self.emptyLabel = self.window:Create("TextLabel", {
        Name = "Empty",
        Size = UDim2.new(1, -12, 0, optionHeight),
        BackgroundTransparency = 1,
        Text = locale.t("No matches"),
        TextSize = 14,
        TextTransparency = 0.55,
        Visible = false,
        LayoutOrder = 1,

        Parent = self.list,
    }, { TextColor3 = "ContentColor", FontFace = "Font" })

    local function isOptionSelected(name)
        return table.find(self.value, name) ~= nil
    end

    local function renderOptionState(data, animate)
        local selected = isOptionSelected(data.name)
        local bgT = if self._isOpen then (selected and 0.9 or 0.95) else 1
        local titleT = if self._isOpen then (selected and 0 or 0.3) else 1

        local iconT = if self._isOpen then (selected and 0 or 0.7) else 1
        local strokeT = if self._isOpen then (selected and 0.85 or 0.93) else 1

        image.assign(data.checkIcon, "Image", if selected then checkIcon else dotIcon)

        if animate then
            local info = TweenInfo.new(0.3, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)
            variables.tweenService:Create(data.frame, info, { BackgroundTransparency = bgT }):Play()
            variables.tweenService:Create(data.title, info, { TextTransparency = titleT }):Play()
            variables.tweenService:Create(data.checkIcon, info, { ImageTransparency = iconT }):Play()
            variables.tweenService:Create(data.stroke, info, { Transparency = strokeT }):Play()
        else
            data.frame.BackgroundTransparency = bgT
            data.title.TextTransparency = titleT
            data.checkIcon.ImageTransparency = iconT
            data.stroke.Transparency = strokeT
        end
    end

    local function updateSelectedLabel()
        if self.multiSelect then
            local n = #self.value
            if n == 0 then
                self.selectedLabel.Text = self.placeholderText
            elseif n == 1 then
                self.selectedLabel.Text = self.value[1]
            else
                self.selectedLabel.Text = locale.resolve("Various")
            end
        else
            self.selectedLabel.Text = self.value[1] or self.placeholderText
        end
    end

    self._renderOptionState = renderOptionState
    self._updateSelectedLabel = updateSelectedLabel

    local function buildOption(optionName)
        local frame = self.window:Create("Frame", {
            Size = UDim2.new(1, -12, 0, optionHeight),
            BorderSizePixel = 0,

            LayoutOrder = #self._optionFrames + 1,

            BackgroundTransparency = 1,

            Parent = self.list,
        }, { BackgroundColor3 = "DropdownHighlight" })

        local corner = self.window:Create("UICorner", {
            CornerRadius = flatRadius,
            Parent = frame,
        })

        local optionStroke = self.window:Create("UIStroke", {
            Color = Color3.fromRGB(255, 255, 255),
            Transparency = 1,
            Parent = frame,
        })

        local interact = self.window:Create("TextButton", {
            BackgroundTransparency = 1,
            Size = UDim2.fromScale(1, 1),
            Text = "",
            TextTransparency = 1,
            ZIndex = 50,
            Parent = frame,
        })

        local container = self.window:Create("Frame", {
            AnchorPoint = Vector2.new(0, 0.5),
            Position = UDim2.new(0, 14, 0.5, 0),
            Size = UDim2.fromOffset(170, 16),
            BorderSizePixel = 0,
            BackgroundTransparency = 1,
            ZIndex = 5,
            Parent = frame,
        })

        self.window:Create("UIListLayout", {
            Padding = UDim.new(0, 5),
            FillDirection = Enum.FillDirection.Horizontal,
            VerticalAlignment = Enum.VerticalAlignment.Center,
            SortOrder = Enum.SortOrder.LayoutOrder,
            Parent = container,
        })

        local checkIcon = self.window:Create("ImageLabel", {
            Image = "rbxassetid://" .. tostring(checkIcon),
            Size = UDim2.fromOffset(16, 16),
            BorderSizePixel = 0,
            BackgroundTransparency = 1,
            ImageTransparency = 1,
            ZIndex = 5,
            Parent = container,
        }, { ImageColor3 = "ContentColor" })

        local title = self.window:Create("TextLabel", {
            Text = optionName,
            Size = UDim2.fromOffset(170, 16),
            BorderSizePixel = 0,
            BackgroundTransparency = 1,
            TextSize = 16,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextWrapped = true,
            LayoutOrder = 1,
            TextTransparency = 1,
            ZIndex = 5,
            Parent = container,
        }, { TextColor3 = "ContentColor", FontFace = "Font" })

        local data = {
            name = optionName,
            frame = frame,
            interact = interact,
            title = title,
            checkIcon = checkIcon,
            container = container,
            stroke = optionStroke,
            corner = corner,

            connections = {},
        }

        table.insert(
            data.connections,
            self.window:ConnectFor(self, frame.MouseEnter, function()
                if not self._isOpen or not self.window:_interactive() then
                    return
                end
                if isOptionSelected(data.name) then
                    return
                end
                variables.tweenService
                    :Create(
                        frame,
                        TweenInfo.new(0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
                        { BackgroundTransparency = 0.9 }
                    )
                    :Play()
                variables.tweenService
                    :Create(
                        title,
                        TweenInfo.new(0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
                        { TextTransparency = 0.15 }
                    )
                    :Play()
            end)
        )

        table.insert(
            data.connections,
            self.window:ConnectFor(self, frame.MouseLeave, function()
                if not self._isOpen then
                    return
                end
                if isOptionSelected(data.name) then
                    return
                end
                variables.tweenService
                    :Create(
                        frame,
                        TweenInfo.new(0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
                        { BackgroundTransparency = 0.95 }
                    )
                    :Play()
                variables.tweenService
                    :Create(
                        title,
                        TweenInfo.new(0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
                        { TextTransparency = 0.3 }
                    )
                    :Play()
            end)
        )

        table.insert(
            data.connections,
            self.window:ConnectFor(self, interact.MouseButton1Click, function()

                if not self._isOpen then
                    return
                end
                hapticEngine.click()
                local sel = isOptionSelected(data.name)

                if not self.multiSelect then
                    if sel then
                        self:_close()
                        return
                    end
                    table.clear(self.value)
                    table.insert(self.value, data.name)
                else
                    if sel then
                        local idx = table.find(self.value, data.name)
                        if idx then
                            table.remove(self.value, idx)
                        end
                    else
                        table.insert(self.value, data.name)
                    end
                end

                self._desiredValue = table.clone(self.value)

                for _, d in self._optionFrames do
                    renderOptionState(d, true)
                end

                updateSelectedLabel()

                self.window:_runGuarded(self, self.callback, self:_callbackValue())
                self.window:_persist(self)

                if not self.multiSelect then
                    task.wait(0.1)
                    self:_close()
                end
            end)
        )

        return data
    end

    self._buildOption = buildOption

    for _, opt in self.options do
        local data = buildOption(opt)
        table.insert(self._optionFrames, data)
    end

    updateSelectedLabel()
    self:_updateCorners()

    self.window:ConnectFor(self, self.interact.MouseButton1Click, function()
        hapticEngine.click()
        if self._isOpen then
            self:_close()
        else
            self:_open()
        end
    end)

    self.window:ConnectFor(self, self.main.MouseEnter, function()
        if self._isOpen or not self.window:_interactive() then
            return
        end
        variables.tweenService
            :Create(self.title, hoverTween, { TextColor3 = self.window.theme.ElementTextHoverColor })
            :Play()
        variables.tweenService:Create(self.hoverOverlay, hoverTween, { BackgroundTransparency = 0.97 }):Play()
        variables.tweenService
            :Create(self.stroke, hoverTween, {
                Transparency = self.window.theme.ElementStrokeHoverTransparency,
                Color = self.window.theme.ElementStrokeHover,
            })
            :Play()
    end)

    self.window:ConnectFor(self, self.main.MouseLeave, function()
        variables.tweenService:Create(self.title, hoverTween, { TextColor3 = self.window.theme.ContentColor }):Play()
        variables.tweenService:Create(self.hoverOverlay, hoverTween, { BackgroundTransparency = 1 }):Play()
        variables.tweenService
            :Create(self.stroke, hoverTween, {
                Transparency = self.window.theme.ElementStrokeTransparency,
                Color = self.window.theme.ElementStroke,
            })
            :Play()
    end)

    if self.description then
        self.descriptor = require(script.Parent.descriptor).new(self.tab, { description = self.description })
    end

    return self
end

function Dropdown:_callbackValue()
    if self.multiSelect then
        return table.clone(self.value)
    end
    return self.value[1]
end

function Dropdown:_buildSearch()
    self._searchOpen = false

    self.searchbar = self.window:Create("Frame", {
        Name = "Search",
        Size = UDim2.new(1, -12, 0, searchCollapsedHeight),
        BorderSizePixel = 0,
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 1,
        LayoutOrder = 1,
        ClipsDescendants = false,
        ZIndex = 1,

        Parent = self.panel,
    })

    self.window:Create("UICorner", {
        CornerRadius = UDim.new(0, 12),
        Parent = self.searchbar,
    })

    self.searchStroke = self.window:Create("UIStroke", {
        Color = Color3.fromRGB(255, 255, 255),
        Transparency = 1,
        Parent = self.searchbar,
    })

    self.searchShadow = self.window:CreateGlow(self.searchbar, Color3.fromRGB(255, 255, 255), 20, 1)

    self.searchToggle = self.window:Create("TextButton", {
        BackgroundTransparency = 1,
        Size = UDim2.fromScale(1, 1),
        Text = "",
        TextTransparency = 1,
        ZIndex = 51,
        Parent = self.searchbar,
    })

    self.searchInput = self.window:Create("TextBox", {
        Text = "",
        PlaceholderText = locale.t("Search..."),
        Size = UDim2.new(1, -58, 0, 16),
        Position = UDim2.new(0, 44, 0.5, 0),
        AnchorPoint = Vector2.new(0, 0.5),
        BackgroundTransparency = 1,
        TextSize = 16,
        TextXAlignment = Enum.TextXAlignment.Left,
        ClearTextOnFocus = false,
        TextEditable = false,
        Interactable = false,
        ZIndex = 52,

        TextTransparency = 1,

        Parent = self.searchbar,
    }, { TextColor3 = "ContentColor", FontFace = "Font", PlaceholderColor3 = "PlaceholderColor" })

    self.searchIcon = self.window:Create("ImageButton", {
        Image = "rbxassetid://" .. tostring(searchIconAsset),
        Size = UDim2.fromOffset(20, 20),
        Position = UDim2.new(0, 24, 0.5, 0),
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundTransparency = 1,
        ScaleType = Enum.ScaleType.Fit,
        AutoButtonColor = false,
        ZIndex = 53,

        ImageTransparency = 1,

        Parent = self.searchbar,
    }, { ImageColor3 = "ContentColor" })

    self.window:ConnectFor(self, self.searchToggle.MouseButton1Click, function()
        if not self._searchOpen then
            self:_expandSearch()
        end
    end)
    self.window:ConnectFor(self, self.searchIcon.MouseButton1Click, function()
        if self._searchOpen then
            self:_collapseSearch()
        else
            self:_expandSearch()
        end
    end)
    self.window:ConnectFor(self, self.searchInput:GetPropertyChangedSignal("Text"), function()
        self:_applyFilter(self.searchInput.Text)
    end)
    self.window:ConnectFor(self, self.searchInput.FocusLost, function()
        if self.searchInput.Text == "" then
            self:_collapseSearch()
        end
    end)
end

function Dropdown:_expandSearch()
    if self._searchOpen then
        return
    end
    self._searchOpen = true
    self.searchInput.TextEditable = true
    self.searchInput.Interactable = true

    variables.tweenService
        :Create(
            self.searchbar,
            searchTween,
            { Size = UDim2.new(1, -12, 0, searchExpandedHeight), BackgroundTransparency = 0.92 }
        )
        :Play()
    variables.tweenService:Create(self.searchStroke, searchTween, { Transparency = 0.86 }):Play()
    variables.tweenService:Create(self.searchShadow, searchTween, { Transparency = 0.92 }):Play()
    variables.tweenService:Create(self.searchInput, searchTween, { TextTransparency = 0.3 }):Play()

    self:_resizeToOptions()
    self.searchInput:CaptureFocus()
end

function Dropdown:_collapseSearch()
    if not self._searchOpen then
        return
    end
    self._searchOpen = false
    self.searchInput.TextEditable = false
    self.searchInput.Interactable = false
    self.searchInput:ReleaseFocus()
    self.searchInput.Text = ""

    variables.tweenService
        :Create(
            self.searchbar,
            searchTween,
            { Size = UDim2.new(1, -12, 0, searchCollapsedHeight), BackgroundTransparency = 1 }
        )
        :Play()
    variables.tweenService:Create(self.searchStroke, searchTween, { Transparency = 1 }):Play()
    variables.tweenService:Create(self.searchShadow, searchTween, { Transparency = 1 }):Play()
    variables.tweenService:Create(self.searchInput, searchTween, { TextTransparency = 1 }):Play()

    self:_resizeToOptions()
end

function Dropdown:_applyFilter(query)
    query = string.lower(query or "")
    local shown = 0
    for _, data in self._optionFrames do
        local visible = query == "" or string.find(string.lower(data.name), query, 1, true) ~= nil
        data.frame.Visible = visible
        if visible then
            shown += 1
        end
    end

    self.emptyLabel.Visible = shown == 0 and query ~= ""
    self:_updateCorners()
    self:_resizeToOptions()
    self:_syncScrollHint()
end

function Dropdown:_syncScrollHint()

    local canvasSize, windowSize, at =
        self.list.AbsoluteCanvasSize, self.list.AbsoluteWindowSize, self.list.CanvasPosition
    if not canvasSize or not windowSize or not at then
        return
    end

    local more = self._isOpen and windowSize.Y > 0 and canvasSize.Y - (at.Y + windowSize.Y) > 1

    variables.tweenService
        :Create(self.list, hintTween, { ScrollBarImageTransparency = if more then scrollbarShown else 1 })
        :Play()
end

function Dropdown:_visibleOptions(): { string }
    local names = {}
    for _, data in self._optionFrames do
        if data.frame.Visible then
            table.insert(names, data.name)
        end
    end
    return names
end

function Dropdown:_buildActions()
    if not self.multiSelect then
        return
    end

    self.actions = self.window:Create("Frame", {
        Name = "Actions",
        Size = UDim2.new(1, -12, 0, actionsHeight),
        BackgroundTransparency = 1,
        LayoutOrder = 2,

        Parent = self.panel,
    })

    self.window:Create("UIListLayout", {
        Padding = UDim.new(0, 12),
        FillDirection = Enum.FillDirection.Horizontal,
        VerticalAlignment = Enum.VerticalAlignment.Center,
        SortOrder = Enum.SortOrder.LayoutOrder,

        Parent = self.actions,
    })

    local function action(label: string, order: number, apply: () -> ())
        local button = self.window:Create("TextButton", {
            AutomaticSize = Enum.AutomaticSize.X,
            Size = UDim2.fromOffset(0, actionsHeight),
            BackgroundTransparency = 1,
            Text = locale.t(label),
            TextSize = 13,
            TextTransparency = 0.45,
            LayoutOrder = order,

            Parent = self.actions,
        }, { TextColor3 = "ContentColor", FontFace = "Font" })

        self.window:ConnectFor(self, button.MouseEnter, function()
            variables.tweenService:Create(button, hintTween, { TextTransparency = 0.15 }):Play()
        end)
        self.window:ConnectFor(self, button.MouseLeave, function()
            variables.tweenService:Create(button, hintTween, { TextTransparency = 0.45 }):Play()
        end)
        self.window:ConnectFor(self, button.MouseButton1Click, function()
            apply()
            self:_afterBulkChange()
        end)

        return button
    end

    action("Select all", 1, function()
        local shown = self:_visibleOptions()
        for _, name in shown do
            if not table.find(self.value, name) then
                table.insert(self.value, name)
            end
        end
    end)
    action("Clear", 2, function()
        local shown = self:_visibleOptions()
        for index = #self.value, 1, -1 do
            if table.find(shown, self.value[index]) then
                table.remove(self.value, index)
            end
        end
    end)
end

function Dropdown:_afterBulkChange()

    self._desiredValue = table.clone(self.value)

    for _, data in self._optionFrames do
        self._renderOptionState(data, true)
    end
    self:_updateSelectedLabel()
    self:_updateCorners()
    self.window:_runGuarded(self, self.callback, self:_callbackValue())
    self.window:_persist(self)
    hapticEngine.click()
end

function Dropdown:_resizeToOptions()
    if not self._isOpen then
        return
    end
    variables.tweenService:Create(self.main, searchTween, { Size = UDim2.new(1, -20, 0, self:_openHeight()) }):Play()
end

function Dropdown:_updateCorners()
    local visible = {}
    for _, data in self._optionFrames do
        if data.frame.Visible then
            table.insert(visible, data)
        end
    end

    for i, data in visible do
        local topR = if i == 1 then roundRadius else flatRadius
        local botR = if i == #visible then roundRadius else flatRadius
        data.corner.TopLeftRadius = topR
        data.corner.TopRightRadius = topR
        data.corner.BottomLeftRadius = botR
        data.corner.BottomRightRadius = botR
    end
end

local function listHeight(count: number): number
    return count * optionHeight + math.max(0, count - 1) * optionGap + listPadding * 2
end

local function rowsThatFit(space: number): number
    return math.max(math.floor((space - listPadding * 2 + optionGap) / (optionHeight + optionGap)), 1)
end

function Dropdown:_pageHeight(): number
    local size = self.window.size
    return windowSizing.pageHeight(size and size.Y.Offset, self.window.layout.mode)
end

function Dropdown:_openHeight()
    local n = 0
    for _, data in self._optionFrames do
        if data.frame.Visible then
            n += 1
        end
    end

    local searchHeight = if self._searchOpen then searchExpandedHeight else searchCollapsedHeight
    local overhead = headerHeight
        + headerGap
        + cardPadding
        + searchHeight
        + optionGap
        + (if self.actions then actionsHeight + optionGap else 0)

    local available = self:_pageHeight()

    local rows = math.min(math.max(n, 1), maxVisibleOptions, rowsThatFit(available - overhead))

    return math.min(overhead + listHeight(rows), available)
end

function Dropdown:_open()
    if self._isOpen then
        return
    end
    self._isOpen = true

    if self._outsideClickConn then
        self.window:Disconnect(self._outsideClickConn)
    end
    self._outsideClickConn = self.window:Connect(variables.userInputService.InputBegan, function(input)
        if
            input.UserInputType ~= Enum.UserInputType.MouseButton1
            and input.UserInputType ~= Enum.UserInputType.Touch
        then
            return
        end

        local pos = input.Position
        local mainPos = self.main.AbsolutePosition
        local mainSize = self.main.AbsoluteSize
        if
            pos.X < mainPos.X
            or pos.X > mainPos.X + mainSize.X
            or pos.Y < mainPos.Y
            or pos.Y > mainPos.Y + mainSize.Y
        then
            self:_close()
        end
    end)

    variables.tweenService
        :Create(
            self.main,
            TweenInfo.new(0.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out),
            { Size = UDim2.new(1, -20, 0, self:_openHeight()) }
        )
        :Play()
    variables.tweenService
        :Create(
            self.chevron,
            TweenInfo.new(0.7, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out),
            { Rotation = 0 }
        )
        :Play()
    variables.tweenService
        :Create(
            self.panel,
            TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
            { BackgroundTransparency = self.window.theme.ElementTransparency or 0 }
        )
        :Play()
    variables.tweenService
        :Create(
            self.panelStroke,
            TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
            { Transparency = self.window.theme.ElementStrokeTransparency }
        )
        :Play()
    variables.tweenService
        :Create(
            self.searchIcon,
            TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
            { ImageTransparency = 0.5 }
        )
        :Play()

    for _, data in self._optionFrames do
        self._renderOptionState(data, true)
    end

    self:_syncScrollHint()
    self:_bringIntoView()
end

function Dropdown:_bringIntoView()
    local page = self.tab and self.tab.tabPage
    if not page then
        return
    end

    local view, at, pageAt, cardAt =
        page.AbsoluteWindowSize, page.CanvasPosition, page.AbsolutePosition, self.main.AbsolutePosition
    if not view or not at or not pageAt or not cardAt or view.Y <= 0 then
        return
    end

    local top = cardAt.Y - pageAt.Y + at.Y
    local bottom = top + self:_openHeight()
    local overflow = bottom - (at.Y + view.Y)
    if overflow <= 0 then
        return
    end

    local target = math.min(at.Y + overflow + 8, top)
    variables.tweenService
        :Create(page, TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
            CanvasPosition = Vector2.new(at.X, target),
        })
        :Play()
end

function Dropdown:_close()
    if not self._isOpen then
        return
    end
    self._isOpen = false

    if self._outsideClickConn then
        self.window:Disconnect(self._outsideClickConn)
        self._outsideClickConn = nil
    end

    self:_collapseSearch()
    self:_syncScrollHint()

    variables.tweenService
        :Create(
            self.chevron,
            TweenInfo.new(0.7, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out),
            { Rotation = 180 }
        )
        :Play()
    variables.tweenService
        :Create(
            self.panel,
            TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
            { BackgroundTransparency = 1 }
        )
        :Play()
    variables.tweenService
        :Create(
            self.panelStroke,
            TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
            { Transparency = 1 }
        )
        :Play()
    variables.tweenService
        :Create(
            self.searchIcon,
            TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
            { ImageTransparency = 1 }
        )
        :Play()

    for _, data in self._optionFrames do
        self._renderOptionState(data, true)
    end

    variables.tweenService
        :Create(
            self.main,
            TweenInfo.new(0.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out),
            { Size = UDim2.new(1, -20, 0, 41) }
        )
        :Play()
end

function Dropdown:_destroyOption(data)
    if data.connections then
        for _, connection in data.connections do
            local idx = table.find(self.connections, connection)
            if idx then
                table.remove(self.connections, idx)
            end
            self.window:Disconnect(connection)
        end
        data.connections = nil
    end
    self.window:DestroySubtree(data.frame)
end

function Dropdown:_deriveSelection()
    local previous = self.value
    self.value = intersectWithOptions(self._desiredValue or self.value, self.options)
    return not sameSelection(self.value, previous)
end

function Dropdown:_reindexOptions()
    for index, data in self._optionFrames do
        data.frame.LayoutOrder = index
    end
end

function Dropdown:_rebindOption(data, name, index)
    data.name = name
    data.title.Text = name
    data.frame.LayoutOrder = index
end

function Dropdown:_destroyOptionsFrom(first)
    local roots, connections = {}, {}

    for index = #self._optionFrames, first, -1 do
        local data = self._optionFrames[index]
        table.insert(roots, data.frame)
        if data.connections then
            table.move(data.connections, 1, #data.connections, #connections + 1, connections)
            data.connections = nil
        end
        self._optionFrames[index] = nil
    end

    self.window:DisconnectMany(self, connections)
    self.window:DestroySubtrees(roots)
end

function Dropdown:Refresh(newOptions)
    self.options = dedupStrings(newOptions or {})

    local selectionChanged = self:_deriveSelection()

    local existing = #self._optionFrames
    local wanted = #self.options

    for index = 1, math.min(existing, wanted) do
        self:_rebindOption(self._optionFrames[index], self.options[index], index)
    end

    for index = existing + 1, wanted do
        local data = self._buildOption(self.options[index])
        data.frame.LayoutOrder = index
        table.insert(self._optionFrames, data)
    end

    if wanted < existing then
        self:_destroyOptionsFrom(wanted + 1)
    end

    for _, data in self._optionFrames do
        self._renderOptionState(data, false)
    end

    self._updateSelectedLabel()

    self:_applyFilter(if self._searchOpen then self.searchInput.Text else "")

    if selectionChanged then
        self.window:_runGuarded(self, self.callback, self:_callbackValue())
        self.window:_persist(self)
    end
end

function Dropdown:Add(option)
    if typeof(option) ~= "string" or option == "" then
        return
    end
    if table.find(self.options, option) then
        return
    end

    table.insert(self.options, option)
    local data = self._buildOption(option)
    table.insert(self._optionFrames, data)

    local selectionChanged = self:_deriveSelection()

    if self._isOpen then
        self._renderOptionState(data, true)
    end

    self:_applyFilter(if self._searchOpen then self.searchInput.Text else "")

    if selectionChanged then
        self._updateSelectedLabel()
        self.window:_runGuarded(self, self.callback, self:_callbackValue())
        self.window:_persist(self)
    end
end

function Dropdown:Remove(option)
    local idx = table.find(self.options, option)
    if not idx then
        return
    end

    table.remove(self.options, idx)

    for i, data in self._optionFrames do
        if data.name == option then
            self:_destroyOption(data)
            table.remove(self._optionFrames, i)
            self:_reindexOptions()
            break
        end
    end

    if self._desiredValue then
        local desiredIdx = table.find(self._desiredValue, option)
        if desiredIdx then
            table.remove(self._desiredValue, desiredIdx)
        end
    end

    local valueIdx = table.find(self.value, option)
    if valueIdx then
        table.remove(self.value, valueIdx)
        self._updateSelectedLabel()

        self.window:_runGuarded(self, self.callback, self:_callbackValue())
        self.window:_persist(self)
    end

    self:_applyFilter(if self._searchOpen then self.searchInput.Text else "")
end

function Dropdown:Set(value, skipCallback)
    local newValue = normalizeValue(value, self.multiSelect)

    self._desiredValue = newValue
    self.value = intersectWithOptions(newValue, self.options)

    for _, data in self._optionFrames do
        self._renderOptionState(data, true)
    end
    self._updateSelectedLabel()

    if not skipCallback then
        self.window:_runGuarded(self, self.callback, self:_callbackValue())
        self.window:_persist(self)
    end
end

function Dropdown:_setShown(shown, animate)

    local w = self.window
    w:_reveal(self.stroke, { Transparency = if shown then w.theme.ElementStrokeTransparency else 1 }, animate)
    w:_reveal(self.title, { TextTransparency = if shown then 0 else 1 }, animate)
    w:_reveal(self.top, { BackgroundTransparency = if shown then (w.theme.ElementTransparency or 0) else 1 }, animate)
    if self.iconLabel then
        w:_reveal(self.iconLabel, { ImageTransparency = if shown then 0 else 1 }, animate)
    end
    if self.descriptor then
        w:_reveal(self.descriptor.titleLabel, { TextTransparency = if shown then 0.7 else 1 }, animate)
    end
    w:_reveal(self.selectedLabel, { TextTransparency = if shown then 0.5 else 1 }, animate)
    w:_reveal(self.chevron, { ImageTransparency = if shown then 0.5 else 1 }, animate)

    if not shown and self._isOpen then
        self:_close()
    end
end

function Dropdown:MoveTo(index)
    self.tab:_moveElement(self, index)
end

function Dropdown:MoveToTop()
    self.tab:_moveElement(self, 1)
end

function Dropdown:MoveToBottom()
    self.tab:_moveElement(self, #self.tab.elements)
end

function Dropdown:MoveUp()
    local idx = table.find(self.tab.elements, self)
    if idx then
        self.tab:_moveElement(self, idx - 1)
    end
end

function Dropdown:MoveDown()
    local idx = table.find(self.tab.elements, self)
    if idx then
        self.tab:_moveElement(self, idx + 1)
    end
end

lockable(Dropdown)

return Dropdown
end

Components.group = { Name = "group", Parent = Components }
Components.group.FindFirstChild = function(self, k) return self[k] end
Components.group.__loader = function(script, require)
local Group = {}
Group.__index = Group
Group.__type = "Group"

local moveable = require(script.Parent.Parent.utility.moveable)
local log = require(script.Parent.Parent.utility.log)
local assignOrder = require(script.Parent.Parent.utility.ordering)

local elementPadding = 8

local compactCapable = {
    button = true,
    toggle = true,
    stat = true,
    slider = true,
}

function Group.new(tab, properties)
    properties = if typeof(properties) == "table" then properties else {}

    local dir = string.lower(properties.direction or properties.Direction or "row")
    local vertical = dir == "column" or dir == "vertical"
    local horizontal = not vertical
    local direction = if horizontal then Enum.FillDirection.Horizontal else Enum.FillDirection.Vertical

    local self = setmetatable({
        tab = assert(tab, "Missing argument #1 (Tab expected)"),
        window = tab.window,
        direction = direction,
        compact = horizontal,
        forgetState = tab.forgetState,
        elements = {},
    }, Group)

    local nestedInRow = tab.direction == Enum.FillDirection.Horizontal

    self.main = self.window:Create("Frame", {
        Name = "Group",
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        AutomaticSize = Enum.AutomaticSize.Y,

        Size = if horizontal then UDim2.new(1, -20, 0, 0) else UDim2.new(1, 0, 0, 0),

        Parent = self.tab.tabPage,
    })

    if nestedInRow then

        self.main.Size = UDim2.new(0, 0, 0, 0)
        self.window:Create("UIFlexItem", {
            FlexMode = Enum.UIFlexMode.Fill,
            Parent = self.main,
        })
    end

    self.tabPage = self.main

    self.layout = self.window:Create("UIListLayout", {
        FillDirection = direction,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, elementPadding),
        VerticalAlignment = if horizontal then Enum.VerticalAlignment.Center else Enum.VerticalAlignment.Top,
        HorizontalAlignment = if horizontal then Enum.HorizontalAlignment.Left else Enum.HorizontalAlignment.Center,

        Parent = self.main,
    })

    return self
end

function Group:_add(componentName, properties)
    if self.compact and not compactCapable[componentName] then
        log.warn(
            `Rayfield: a row only holds compact elements (button/toggle/stat/slider), ignoring '{componentName}'. Use a column for it.`
        )
        return nil
    end

    local element = require(script.Parent[componentName]).new(self, properties)
    table.insert(self.elements, element)
    assignOrder(element, #self.elements * 10)
    self.window:_restoreLate(element)

    if self.compact then
        self:_wrapChild(element)
    end
    self:_reflowRow()

    if not self.window.hidden then
        element:_setShown(true, true)
    end

    return element
end

function Group:_reflowRow()
    if self.direction ~= Enum.FillDirection.Horizontal then
        return
    end

    local onlyGroups = #self.elements > 0
    for _, element in self.elements do
        if element.__type ~= "Group" then
            onlyGroups = false
            break
        end
    end

    self.layout.Padding = if onlyGroups then UDim.new(0, -10) else UDim.new(0, elementPadding)
end

function Group:_wrapChild(element)
    self.layout.Wraps = true
    self.layout.HorizontalFlex = Enum.UIFlexAlignment.Fill

    element._widthManaged = true

    local minWidth = if element._minWidth then element:_minWidth() else 0
    if minWidth > 0 then
        element.main.AutomaticSize = Enum.AutomaticSize.None
        element.main.Size = UDim2.new(0, minWidth, element.main.Size.Y.Scale, element.main.Size.Y.Offset)
    end
end

function Group:CreateButton(properties)
    return self:_add("button", properties)
end
function Group:CreateToggle(properties)
    return self:_add("toggle", properties)
end
function Group:CreateSwitch(properties)
    return self:_add("toggle", properties)
end
function Group:CreateStat(properties)
    return self:_add("stat", properties)
end
function Group:CreateSlider(properties)
    return self:_add("slider", properties)
end
function Group:CreateDropdown(properties)
    return self:_add("dropdown", properties)
end
function Group:CreateSection(properties)
    return self:_add("section", properties)
end
function Group:CreateText(properties)
    return self:_add("text", properties)
end
function Group:CreateDivider(properties)
    return self:_add("divider", properties)
end

function Group:_addGroup(properties)
    properties = if typeof(properties) == "table" then table.clone(properties) else {}

    if self.direction == Enum.FillDirection.Horizontal then

        self.layout.VerticalAlignment = Enum.VerticalAlignment.Top

        if self.tab.direction ~= Enum.FillDirection.Horizontal then
            self.main.Size = UDim2.new(1, 0, 0, 0)
        end
    end

    local group = Group.new(self, properties)
    table.insert(self.elements, group)
    group.main.LayoutOrder = #self.elements * 10
    self:_reflowRow()
    return group
end

function Group:CreateGroup(properties)
    return self:_addGroup(properties)
end

function Group:_moveElement(element, targetIndex)
    local idx = table.find(self.elements, element)
    if not idx then
        return
    end
    table.remove(self.elements, idx)
    targetIndex = math.clamp(targetIndex, 1, #self.elements + 1)
    table.insert(self.elements, targetIndex, element)
    for i, el in self.elements do
        assignOrder(el, i * 10)
    end
end

function Group:_setShown(shown, animate)
    for _, el in self.elements do
        el:_setShown(shown, animate)
    end
end

function Group:_refreshTheme()
    for _, el in self.elements do
        if el._refreshTheme then
            el:_refreshTheme()
        end
    end
end

moveable(Group)

return Group
end

Components.input = { Name = "input", Parent = Components }
Components.input.FindFirstChild = function(self, k) return self[k] end
Components.input.__loader = function(script, require)
local Input = {}
Input.__index = Input
Input.__type = "Input"

local utility = script.Parent.Parent.utility

local variables = require(utility.variables)
local functions = require(utility.functions)
local moveable = require(utility.moveable)
local lockable = require(utility.lockable)
local locale = require(utility.locale)
local constants = require(utility.constants)
local hapticEngine = require(utility.HapticEngine)

local resizeInfo = constants.pillResizeInfo

local focusInfo = TweenInfo.new(0.15, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)

local function parseExp(text)
    local a, b = text:match("^([%d%.%-]+)%^([%d%.%-]+)$")
    if a and b then
        local na, nb = tonumber(a), tonumber(b)
        if na and nb then
            return na ^ nb
        end
    end
    return tonumber(text)
end

function Input.new(tab, properties)
    properties = if typeof(properties) == "table" then properties else {}

    local self = setmetatable({
        tab = assert(tab, "Missing argument #1 (Tab expected)"),
        window = tab.window,
        name = properties.name or properties.Name or "Input",
        icon = properties.icon or properties.Icon,
        description = properties.description or properties.Description,
        forgetState = properties.forgetState or properties.ForgetState or tab.forgetState,
        placeholder = properties.placeholder or properties.Placeholder or "",
        numeric = properties.numeric or properties.Numeric or false,
        clearOnFocus = properties.clearOnFocus or properties.ClearOnFocus or false,

        callback = properties.callback or properties.Callback or function() end,
    }, Input)

    self.value =
        tostring(properties.value or properties.Value or properties.currentValue or properties.CurrentValue or "")

    self.flag = properties.flag
        or properties.Flag
        or (not self.forgetState and functions.deriveFlagFromName(self.name) or nil)
    self.window:_registerControl(self)

    self.main = self.window:Create("Frame", {
        Size = UDim2.new(1, -20, 0, 41),
        BorderSizePixel = 0,
        Name = self.name,
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),

        BackgroundTransparency = 1,

        Parent = self.tab.tabPage,
    }, { BackgroundTransparency = "ElementTransparency" })

    self.stroke = self.window:StyleElementBody(self.main)
    self.hoverOverlay = self.window:CreateHoverOverlay(self.main)

    self.container = self.window:Create("Frame", {
        Size = UDim2.new(0, 170, 0, 16),
        Position = UDim2.new(0, 20, 0.5, 0),
        AnchorPoint = Vector2.new(0, 0.5),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ZIndex = 5,

        Parent = self.main,
    })

    self.window:Create("UIListLayout", {
        Padding = UDim.new(0, 5),
        FillDirection = Enum.FillDirection.Horizontal,
        VerticalAlignment = Enum.VerticalAlignment.Center,

        Parent = self.container,
    })

    if self.icon then
        self.iconLabel = self.window:Create("ImageLabel", {
            Image = self.icon,
            Size = UDim2.fromOffset(16, 16),
            BorderSizePixel = 0,
            BackgroundTransparency = 1,
            ZIndex = 5,

            ImageTransparency = 1,

            Parent = self.container,
        }, { ImageColor3 = "ContentColor" })
    end

    self.title = self.window:Create("TextLabel", {
        Text = locale.t(self.name),
        Size = UDim2.fromOffset(150, 16),
        AutomaticSize = Enum.AutomaticSize.X,
        BorderSizePixel = 0,
        BackgroundTransparency = 1,
        TextSize = 16,
        TextXAlignment = Enum.TextXAlignment.Left,
        LayoutOrder = 1,
        ZIndex = 5,

        TextTransparency = 1,

        Parent = self.container,
    }, { TextColor3 = "ContentColor", FontFace = "Font" })

    self.box = self.window:Create("Frame", {
        AnchorPoint = Vector2.new(1, 0.5),
        Position = UDim2.new(1, -7, 0, 20),
        Size = UDim2.fromOffset(85, 30),
        BorderSizePixel = 0,

        BackgroundTransparency = 1,

        Parent = self.main,
    }, { BackgroundColor3 = "FieldBackground" })

    self.window:Create("UICorner", {
        CornerRadius = UDim.new(1, 0),
        Parent = self.box,
    })

    self.boxStroke = self.window:Create("UIStroke", {
        Transparency = 1,

        Parent = self.box,
    }, { Color = "SurfaceStroke" })

    self.glow = self.window:CreateGlow(self.box, "FieldGlow", 20, 1)
    self._glowIdle = 1

    self.input = self.window:Create("TextBox", {
        Text = self.value,
        PlaceholderText = locale.t(self.placeholder),
        Size = UDim2.new(1, -15, 0, 15),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        TextSize = 15,
        TextXAlignment = Enum.TextXAlignment.Center,
        TextTruncate = Enum.TextTruncate.AtEnd,
        ClearTextOnFocus = self.clearOnFocus,

        TextTransparency = 1,

        Parent = self.box,
    }, { TextColor3 = "ContentColor", FontFace = "Font", PlaceholderColor3 = "PlaceholderColor" })

    self.window:ConnectFor(self, self.input:GetPropertyChangedSignal("Text"), function()
        if self.numeric then
            local cleaned = (self.input.Text:gsub("[^%d%.%-eE%^]", ""))
            if cleaned ~= self.input.Text then
                self.input.Text = cleaned
                return
            end
        end
        self:_sizeBox(true)
    end)

    self.window:ConnectFor(self, self.input.Focused, function()
        variables.tweenService:Create(self.input, focusInfo, { TextTransparency = 0 }):Play()
    end)

    self.window:ConnectFor(self, self.input.FocusLost, function()
        variables.tweenService:Create(self.input, focusInfo, { TextTransparency = 0.6 }):Play()

        if self.clearOnFocus and self.input.Text == "" and self.value ~= "" then
            self.input.Text = self.value
            return
        end
        if self.input.Text == self.value then
            return
        end
        self:_commit(self.input.Text)
    end)

    self.window:_wireElementHover(self)

    if self.description then
        self.descriptor = require(script.Parent.descriptor).new(self.tab, { description = self.description })
    end

    self:_sizeBox(false)

    return self
end

function Input:_sizeBox(animate)
    local shown = self.input.Text ~= "" and self.input.Text or self.placeholder
    local width = math.clamp(functions.textWidth(self.window.theme.Font, 15, shown) + 30, 70, 220)
    if animate then
        variables.tweenService:Create(self.box, resizeInfo, { Size = UDim2.fromOffset(width, 30) }):Play()
    else
        self.box.Size = UDim2.fromOffset(width, 30)
    end
end

function Input:_commit(text, silent)
    text = tostring(text)
    if self.numeric then
        local n = parseExp(text)
        if not n or n ~= n or n == math.huge or n == -math.huge then

            if self.input.Text ~= self.value then
                self.input.Text = self.value
            end
            return
        end
        text = tostring(n)
    end

    local changed = text ~= self.value
    self.value = text
    if self.input.Text ~= text then
        self.input.Text = text
    end

    if not silent then
        self.window:_runGuarded(self, self.callback, text)
        self.window:_persist(self)

        if changed and not self.window._loading then
            hapticEngine.click()
            self.window:_flashResult(self, true)
        end
    end
end

function Input:Set(value, skipCallback)
    self:_commit(value, skipCallback)
end

function Input:_setShown(shown, animate)
    local w = self.window
    if shown then
        w:_revealCommon(self, animate)
        w:_reveal(self.box, { BackgroundTransparency = w.theme.FieldTransparency }, animate)
        w:_reveal(self.boxStroke, { Transparency = 0.85 }, animate)
        w:_reveal(self.input, { TextTransparency = 0.6 }, animate)
    else
        w:_hideCommon(self, animate)
        w:_reveal(self.box, { BackgroundTransparency = 1 }, animate)
        w:_reveal(self.boxStroke, { Transparency = 1 }, animate)
        w:_reveal(self.input, { TextTransparency = 1 }, animate)
    end
end

function Input:_refreshTheme()
    variables.tweenService
        :Create(
            self.box,
            TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
            { BackgroundTransparency = self.window.theme.FieldTransparency }
        )
        :Play()
end

moveable(Input)
lockable(Input)

return Input
end

Components.keybind = { Name = "keybind", Parent = Components }
Components.keybind.FindFirstChild = function(self, k) return self[k] end
Components.keybind.__loader = function(script, require)
local Keybind = {}
Keybind.__index = Keybind
Keybind.__type = "Keybind"

local utility = script.Parent.Parent.utility

local variables = require(utility.variables)
local functions = require(utility.functions)
local moveable = require(utility.moveable)
local lockable = require(utility.lockable)
local locale = require(utility.locale)
local constants = require(utility.constants)
local hapticEngine = require(utility.HapticEngine)
local enums = require(utility.enums)
local log = require(utility.log)

local resizeInfo = constants.pillResizeInfo
local recordInfo = TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)

local mouseNames = {
    [Enum.UserInputType.MouseButton1] = "MB1",
    [Enum.UserInputType.MouseButton2] = "MB2",
    [Enum.UserInputType.MouseButton3] = "MB3",
}

local function keyName(value)
    if typeof(value) ~= "EnumItem" or value == Enum.KeyCode.Unknown then
        return "None"
    end
    return mouseNames[value] or value.Name
end

local function coerceKey(value)
    if typeof(value) == "EnumItem" then
        return value
    end
    if type(value) == "string" then
        local ok, key = pcall(function()
            return Enum.KeyCode[value]
        end)
        if ok and key then
            return key
        end
        local mouseOk, button = pcall(function()
            return Enum.UserInputType[value]
        end)
        if mouseOk and button and mouseNames[button] then
            return button
        end
    end
    return Enum.KeyCode.Unknown
end

function Keybind.new(tab, properties)
    properties = if typeof(properties) == "table" then properties else {}

    local self = setmetatable({
        tab = assert(tab, "Missing argument #1 (Tab expected)"),
        window = tab.window,
        name = properties.name or properties.Name or "Keybind",
        icon = properties.icon or properties.Icon,
        description = properties.description or properties.Description,
        forgetState = properties.forgetState or properties.ForgetState or tab.forgetState,

        isMenuToggle = properties.isMenuToggle or properties.IsMenuToggle or false,

        callback = properties.callback or properties.Callback or function() end,

        onChanged = properties.onChanged or properties.OnChanged or function() end,

        hold = properties.hold or properties.Hold or false,
        holdThreshold = properties.holdThreshold or properties.HoldThreshold or 0.2,

        recording = false,
    }, Keybind)

    self.value = coerceKey(properties.value or properties.Value or properties.default or properties.Default)

    self.flag = properties.flag
        or properties.Flag
        or (not self.forgetState and functions.deriveFlagFromName(self.name) or nil)
    self.window:_registerControl(self)

    self.main = self.window:Create("Frame", {
        Size = UDim2.new(1, -20, 0, 41),
        BorderSizePixel = 0,
        Name = self.name,
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),

        BackgroundTransparency = 1,

        Parent = self.tab.tabPage,
    }, { BackgroundTransparency = "ElementTransparency" })

    self.stroke = self.window:StyleElementBody(self.main)
    self.hoverOverlay = self.window:CreateHoverOverlay(self.main)

    self.container = self.window:Create("Frame", {
        Size = UDim2.new(0, 170, 0, 16),
        Position = UDim2.new(0, 20, 0.5, 0),
        AnchorPoint = Vector2.new(0, 0.5),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ZIndex = 5,

        Parent = self.main,
    })

    self.window:Create("UIListLayout", {
        Padding = UDim.new(0, 5),
        FillDirection = Enum.FillDirection.Horizontal,
        VerticalAlignment = Enum.VerticalAlignment.Center,

        Parent = self.container,
    })

    if self.icon then
        self.iconLabel = self.window:Create("ImageLabel", {
            Image = self.icon,
            Size = UDim2.fromOffset(16, 16),
            BorderSizePixel = 0,
            BackgroundTransparency = 1,
            ZIndex = 5,

            ImageTransparency = 1,

            Parent = self.container,
        }, { ImageColor3 = "ContentColor" })
    end

    self.title = self.window:Create("TextLabel", {
        Text = locale.t(self.name),
        Size = UDim2.fromOffset(150, 16),
        AutomaticSize = Enum.AutomaticSize.X,
        BorderSizePixel = 0,
        BackgroundTransparency = 1,
        TextSize = 16,
        TextXAlignment = Enum.TextXAlignment.Left,
        LayoutOrder = 1,
        ZIndex = 5,

        TextTransparency = 1,

        Parent = self.container,
    }, { TextColor3 = "ContentColor", FontFace = "Font" })

    self.box = self.window:Create("TextButton", {
        AnchorPoint = Vector2.new(1, 0.5),
        Position = UDim2.new(1, -7, 0, 20),
        Size = UDim2.fromOffset(40, 30),
        AutoButtonColor = false,
        Text = "",
        BorderSizePixel = 0,

        BackgroundTransparency = 1,

        Parent = self.main,
    }, { BackgroundColor3 = "FieldBackground" })

    self.window:Create("UICorner", {
        CornerRadius = UDim.new(1, 0),
        Parent = self.box,
    })

    self.boxStroke = self.window:Create("UIStroke", {
        Transparency = 1,

        Parent = self.box,
    }, { Color = "SurfaceStroke" })

    self.glow = self.window:CreateGlow(self.box, "FieldGlow", 20, 1)
    self._glowIdle = 0.9

    self.keyLabel = self.window:Create("TextLabel", {
        Text = keyName(self.value),
        Size = UDim2.fromScale(1, 1),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        TextSize = 15,
        TextXAlignment = Enum.TextXAlignment.Center,
        ZIndex = 2,

        TextTransparency = 1,

        Parent = self.box,
    }, { TextColor3 = "ContentColor", FontFace = "Font" })

    self.window:ConnectFor(self, self.box.MouseButton1Click, function()
        hapticEngine.click()
        if self.recording then
            self:_stopRecording()
        else
            self:_startRecording()
        end
    end)

    self.window:ConnectFor(self, variables.userInputService.InputBegan, function(input, processed)
        if processed then
            return
        end
        if self.recording then
            self:_capture(input)
            return
        end

        if self.window._recordingKeybind then
            return
        end
        if self:_matches(input) then
            if self.hold then
                self:_beginHold(input)
            else
                self.window:_runGuarded(self, self.callback, self.value)
            end
        end
    end)

    self.window:_wireElementHover(self)

    if self.description then
        self.descriptor = require(script.Parent.descriptor).new(self.tab, { description = self.description })
    end

    self:_sizeBox(false)

    return self
end

function Keybind:_sizeBox(animate)
    local width = math.clamp(functions.textWidth(self.window.theme.Font, 15, self.keyLabel.Text) + 28, 40, 200)
    if animate then
        variables.tweenService:Create(self.box, resizeInfo, { Size = UDim2.fromOffset(width, 30) }):Play()
    else
        self.box.Size = UDim2.fromOffset(width, 30)
    end
end

function Keybind:_startRecording()

    local current = self.window._recordingKeybind
    if current and current ~= self then
        current:_stopRecording()
    end
    self.recording = true
    self.window._recordingKeybind = self
    self.keyLabel.Text = locale.resolve("Recording")
    self:_sizeBox(true)
    variables.tweenService:Create(self.glow, recordInfo, { Transparency = 0.7 }):Play()
    variables.tweenService:Create(self.keyLabel, recordInfo, { TextTransparency = 0 }):Play()
end

function Keybind:_stopRecording()
    self.recording = false

    if self.window._recordingKeybind == self then
        local window = self.window
        task.defer(function()
            if window._recordingKeybind == self then
                window._recordingKeybind = nil
            end
        end)
    end
    self.keyLabel.Text = keyName(self.value)
    self:_sizeBox(true)
    variables.tweenService:Create(self.glow, recordInfo, { Transparency = 0.9 }):Play()
    variables.tweenService:Create(self.keyLabel, recordInfo, { TextTransparency = 0.6 }):Play()
end

function Keybind:_capture(input)
    local key
    if input.UserInputType == Enum.UserInputType.Keyboard then
        if input.KeyCode == Enum.KeyCode.Escape then
            self:_stopRecording()
            return
        end
        if input.KeyCode == Enum.KeyCode.Backspace then
            self:_bind(Enum.KeyCode.Unknown)
            return
        end
        key = input.KeyCode
    elseif
        input.UserInputType == Enum.UserInputType.MouseButton2
        or input.UserInputType == Enum.UserInputType.MouseButton3
    then
        key = input.UserInputType
    end
    if not key then
        return
    end

    if self.isMenuToggle then

        local clash = self.window:_keybindUsing(key, self)
        if clash then
            self.window:Notify({
                title = locale.resolve("Keybind unavailable"),
                content = string.format(
                    locale.resolve("%s is bound to %s. Kept %s."),
                    keyName(key),
                    clash.name,
                    keyName(self.value)
                ),
            })
            self:_stopRecording()
            self.window:_flashResult(self, false)
            return
        end
    elseif key == self.window.settings.toggleKeybind then

        self.window:Notify({
            title = locale.resolve("Keybind unavailable"),
            content = string.format(
                locale.resolve("%s is the menu toggle key. Kept %s."),
                keyName(key),
                keyName(self.value)
            ),
        })
        self:_stopRecording()
        self.window:_flashResult(self, false)
        return
    end

    self:_bind(key)
end

function Keybind:_bind(key)
    self.value = key
    self:_stopRecording()
    self.window:_runGuarded(self, self.onChanged, key)
    self.window:_persist(self)

    self.window:_flashResult(self, true)
end

function Keybind:_matches(input)
    local v = self.value
    if typeof(v) ~= "EnumItem" or v == Enum.KeyCode.Unknown then
        return false
    end
    if v.EnumType == Enum.KeyCode then
        return input.KeyCode == v
    elseif v.EnumType == Enum.UserInputType then
        return input.UserInputType == v
    end
    return false
end

function Keybind:_beginHold(input)
    if self._holding or self._holdPress then
        return
    end
    local press = {}
    self._holdPress = press

    local heldKeyCode = input.KeyCode
    local heldInputType = input.UserInputType

    task.delay(self.holdThreshold, function()
        if self._holdPress ~= press then
            return
        end
        self._holding = true
        self.window:_runGuarded(self, self.callback, true)
    end)

    local conn
    conn = self.window:ConnectFor(self, variables.userInputService.InputEnded, function(ended)
        local released = if heldKeyCode ~= Enum.KeyCode.Unknown
            then ended.KeyCode == heldKeyCode
            else ended.UserInputType == heldInputType
        if not released then
            return
        end

        if self.connections then
            local index = table.find(self.connections, conn)
            if index then
                table.remove(self.connections, index)
            end
        end
        self.window:Disconnect(conn)
        if self._holdPress == press then
            self._holdPress = nil
        end
        if self._holding then
            self._holding = false
            self.window:_runGuarded(self, self.callback, false)
        end
    end)
end

function Keybind:Set(value, skipChanged)
    local key = coerceKey(value)

    if key ~= Enum.KeyCode.Unknown then
        if self.isMenuToggle then
            local clash = self.window:_keybindUsing(key, self)
            if clash then
                log.warn(
                    "Rayfield: "
                        .. keyName(key)
                        .. " is bound to '"
                        .. tostring(clash.name)
                        .. "'; kept "
                        .. keyName(self.value)
                )
                return
            end
        elseif key == self.window.settings.toggleKeybind then
            log.warn("Rayfield: " .. keyName(key) .. " is the menu toggle key; kept " .. keyName(self.value))
            return
        end
    end

    self.value = key
    if self.recording then
        self:_stopRecording()
    else
        self.keyLabel.Text = keyName(self.value)
        self:_sizeBox(true)
    end

    if not skipChanged then
        self.window:_runGuarded(self, self.onChanged, self.value)
        self.window:_persist(self)
    end
end

function Keybind:_serialize()
    return { tostring(self.value.EnumType), self.value.Value }
end

function Keybind:_deserialize(raw)

    local enumName = tostring(raw[1]):gsub("^Enum%.", "")
    local enumOk, enumType = pcall(function()
        return Enum[enumName]
    end)
    if not enumOk or not enumType then
        return
    end

    local item = enums.itemFromValue(enumType, raw[2])
    if item then
        self:Set(item)
    end
end

function Keybind:_setShown(shown, animate)
    local w = self.window
    if shown then
        w:_revealCommon(self, animate)
        w:_reveal(self.box, { BackgroundTransparency = w.theme.FieldTransparency }, animate)
        w:_reveal(self.boxStroke, { Transparency = 0.85 }, animate)
        w:_reveal(self.keyLabel, { TextTransparency = 0.6 }, animate)
        w:_reveal(self.glow, { Transparency = 0.9 }, animate)
    else
        w:_hideCommon(self, animate)
        w:_reveal(self.box, { BackgroundTransparency = 1 }, animate)
        w:_reveal(self.boxStroke, { Transparency = 1 }, animate)
        w:_reveal(self.keyLabel, { TextTransparency = 1 }, animate)
        w:_reveal(self.glow, { Transparency = 1 }, animate)
    end
end

function Keybind:_refreshTheme()
    variables.tweenService
        :Create(
            self.box,
            TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
            { BackgroundTransparency = self.window.theme.FieldTransparency }
        )
        :Play()
end

moveable(Keybind)
lockable(Keybind)

return Keybind
end

Components.notification = { Name = "notification", Parent = Components }
Components.notification.FindFirstChild = function(self, k) return self[k] end
Components.notification.__loader = function(script, require)
local Notification = {}
Notification.__index = Notification
Notification.__type = "Notification"

local utility = script.Parent.Parent.utility

local variables = require(utility.variables)
local functions = require(utility.functions)
local constants = require(utility.constants)
local hapticEngine = require(utility.HapticEngine)

local growInfo = TweenInfo.new(0.6, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)
local fadeLong = TweenInfo.new(0.4, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)
local fadeShort = TweenInfo.new(0.3, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)

local swipeInInfo = TweenInfo.new(0.6, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)

local shrinkInfo = TweenInfo.new(0.9, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)

local offscreenRight = UDim2.new(0.5, 360, 0.5, 0)
local centred = UDim2.new(0.5, 0, 0.5, 0)

local maxLive = 6

local stackPadding = 8

local function autoDuration(content)
    return math.clamp(#content * 0.06 + 3, 3, 9)
end

function Notification.new(window, properties)
    properties = if typeof(properties) == "table" then properties else {}

    local self = setmetatable({
        window = assert(window, "Missing argument #1 (Window expected)"),
        title = properties.title or properties.Title or "Notification",
        content = properties.content or properties.Content or "",
        icon = properties.icon or properties.Icon,
        _hovered = false,
        _dismissed = false,
    }, Notification)

    self.duration = properties.duration or properties.Duration or autoDuration(self.content)

    local hasIcon = self.icon ~= nil and self.icon ~= 0 and self.icon ~= ""

    self.main = self.window:Create("Frame", {
        Name = "Notification",
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 0),
        BorderSizePixel = 0,
        ZIndex = constants.zIndex.notification,

        Parent = self.window.notifications,
    })

    self.window:Create("UIPadding", {
        PaddingTop = UDim.new(0, stackPadding),

        Parent = self.main,
    })

    self.body = self.window:Create("Frame", {
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        Size = UDim2.new(1, 0, 1, 0),
        Position = offscreenRight,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Active = true,
        BorderSizePixel = 0,
        ZIndex = constants.zIndex.notification,

        BackgroundTransparency = 1,

        Parent = self.main,
    })

    self.window:Create("UIGradient", {
        Rotation = 270,
        Offset = Vector2.new(0, -0.1),

        Parent = self.body,
    }, { Color = { "WindowColor", functions.toColorSequence } })

    self.window:Create("UICorner", {
        Parent = self.body,
    }, { CornerRadius = "CornerRoundness" })

    self.stroke = self.window:Create("UIStroke", {
        Transparency = 1,

        Parent = self.body,
    }, { Color = "SurfaceStroke" })

    self.shadow = self.window:CreateGlow(self.body, "ShadowColor", 20, 1)

    self.window:Create("UIPadding", {
        PaddingLeft = UDim.new(0, 20),
        PaddingRight = UDim.new(0, 20),

        Parent = self.body,
    })

    self.window:Create("UIListLayout", {
        FillDirection = Enum.FillDirection.Horizontal,
        VerticalAlignment = Enum.VerticalAlignment.Center,
        HorizontalAlignment = Enum.HorizontalAlignment.Left,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, 14),

        Parent = self.body,
    })

    if hasIcon then
        self.iconLabel = self.window:Create("ImageLabel", {
            Image = self.icon,
            Size = UDim2.fromOffset(24, 24),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            LayoutOrder = 1,
            ZIndex = constants.zIndex.notification,

            ImageTransparency = 1,

            Parent = self.body,
        }, { ImageColor3 = "ContentColor" })
    end

    self.container = self.window:Create("Frame", {
        Size = UDim2.fromOffset(hasIcon and 222 or 260, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        LayoutOrder = 2,
        ZIndex = constants.zIndex.notification,

        Parent = self.body,
    })

    self.window:Create("UIListLayout", {
        FillDirection = Enum.FillDirection.Vertical,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, 4),

        Parent = self.container,
    })

    self.titleLabel = self.window:Create("TextLabel", {
        Text = self.title,
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
        TextSize = 16,
        TextWrapped = true,
        TextXAlignment = Enum.TextXAlignment.Left,
        LayoutOrder = 1,
        ZIndex = constants.zIndex.notification,

        TextTransparency = 1,

        Parent = self.container,
    }, { TextColor3 = "ContentColor", FontFace = "TitleFont" })

    if self.content ~= "" then
        self.descriptionLabel = self.window:Create("TextLabel", {
            Text = self.content,
            Size = UDim2.new(1, 0, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            BackgroundTransparency = 1,
            TextSize = 15,
            TextWrapped = true,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextYAlignment = Enum.TextYAlignment.Top,
            LayoutOrder = 2,
            ZIndex = constants.zIndex.notification,

            TextTransparency = 1,

            Parent = self.container,
        }, { TextColor3 = "ContentColor", FontFace = "Font" })
    end

    self.window._notificationCount = (self.window._notificationCount or 0) + 1
    self.main.LayoutOrder = self.window._notificationCount

    local live = self.window._liveNotifications
    if not live then
        live = {}
        self.window._liveNotifications = live
    end
    table.insert(live, self)
    while #live > maxLive do
        local oldest = table.remove(live, 1)
        if oldest and oldest ~= self then
            task.spawn(oldest._dismiss, oldest)
        end
    end

    self._connections = {
        self.window:Connect(self.body.MouseEnter, function()
            self._hovered = true
        end),
        self.window:Connect(self.body.MouseLeave, function()
            self._hovered = false
        end),
        self.window:Connect(self.body.InputBegan, function(input)
            if
                input.UserInputType == Enum.UserInputType.MouseButton1
                or input.UserInputType == Enum.UserInputType.Touch
            then
                self:_dismiss()
            end
        end),
    }

    task.spawn(function()
        self:_show()
    end)

    return self
end

function Notification:_measure()
    local colWidth = self.iconLabel and 222 or 260

    local contentH = functions.textHeight(self.window.theme.TitleFont, 16, self.title, colWidth)
    if self.descriptionLabel then
        contentH = contentH + 4 + functions.textHeight(self.window.theme.Font, 15, self.content, colWidth)
    end

    return math.max(contentH, self.iconLabel and 24 or 0) + 28
end

function Notification:_show()

    local target = self:_measure() + stackPadding
    if self._dismissed or not self.main.Parent then
        return
    end

    hapticEngine.notify()

    variables.tweenService:Create(self.main, growInfo, { Size = UDim2.new(1, 0, 0, target) }):Play()
    variables.tweenService:Create(self.body, swipeInInfo, { Position = centred }):Play()
    variables.tweenService:Create(self.body, fadeLong, { BackgroundTransparency = 0 }):Play()
    variables.tweenService:Create(self.titleLabel, fadeShort, { TextTransparency = 0 }):Play()
    variables.tweenService:Create(self.stroke, fadeLong, { Transparency = 0.95 }):Play()
    variables.tweenService:Create(self.shadow, fadeShort, { Transparency = 0.6 }):Play()

    task.wait(0.05)
    if self._dismissed or not self.main.Parent then
        return
    end
    if self.iconLabel then
        variables.tweenService:Create(self.iconLabel, fadeShort, { ImageTransparency = 0 }):Play()
    end

    task.wait(0.05)
    if self._dismissed or not self.main.Parent then
        return
    end
    if self.descriptionLabel then
        variables.tweenService:Create(self.descriptionLabel, fadeShort, { TextTransparency = 0.35 }):Play()
    end

    local elapsed = 0
    while elapsed < self.duration and not self._dismissed and self.main.Parent do
        local dt = task.wait()
        if not self._hovered then
            elapsed += dt
        end
    end

    self:_dismiss()
end

function Notification:_dismiss()
    if self._dismissed then
        return
    end
    self._dismissed = true

    local live = self.window._liveNotifications
    local index = live and table.find(live, self)
    if live and index then
        table.remove(live, index)
    end

    if not self.main.Parent then
        return
    end

    variables.tweenService:Create(self.body, fadeLong, { BackgroundTransparency = 1 }):Play()
    variables.tweenService:Create(self.stroke, fadeLong, { Transparency = 1 }):Play()
    variables.tweenService:Create(self.shadow, fadeShort, { Transparency = 1 }):Play()
    variables.tweenService:Create(self.titleLabel, fadeShort, { TextTransparency = 1 }):Play()
    if self.descriptionLabel then
        variables.tweenService:Create(self.descriptionLabel, fadeShort, { TextTransparency = 1 }):Play()
    end
    if self.iconLabel then
        variables.tweenService:Create(self.iconLabel, fadeShort, { ImageTransparency = 1 }):Play()
    end

    variables.tweenService:Create(self.body, shrinkInfo, { Size = UDim2.new(1, -90, 1, 0) }):Play()
    local collapse = variables.tweenService:Create(self.main, shrinkInfo, { Size = UDim2.new(1, 0, 0, 0) })
    collapse:Play()
    collapse.Completed:Wait()

    if not self.main.Parent then
        return
    end

    for _, connection in self._connections do
        self.window:Disconnect(connection)
    end
    self.window:DestroySubtree(self.main)
end

return Notification
end

Components.popup = { Name = "popup", Parent = Components }
Components.popup.FindFirstChild = function(self, k) return self[k] end
Components.popup.__loader = function(script, require)
local Popup = {}
Popup.__index = Popup
Popup.__type = "Popup"

local utility = script.Parent.Parent.utility
local variables = require(utility.variables)
local functions = require(utility.functions)
local constants = require(utility.constants)
local locale = require(utility.locale)
local log = require(utility.log)
local hapticEngine = require(utility.HapticEngine)

local enterInfo = TweenInfo.new(0.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)
local fadeLong = TweenInfo.new(0.4, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)
local fadeShort = TweenInfo.new(0.3, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)
local backdropInfo = TweenInfo.new(0.35, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)

local cardWidth = 400
local sidePadding = 22
local topPadding = 24
local bottomPadding = 22
local regionGap = 16
local innerWidth = cardWidth - sidePadding * 2

local titleSize = 18
local subtitleSize = 14
local contentSize = 15
local headerIconSize = 16
local headerIconGap = 12
local maxContentHeight = 300

local contentInset = 4
local contentWidth = innerWidth - contentInset * 2

local boxSidePad = 16
local boxVerticalPad = 13
local boxIconSize = 20
local boxIconGap = 10
local boxTitleSize = 15
local boxDescSize = 14
local boxGap = 8
local boxWidthInset = 10

local buttonHeight = 40
local buttonGap = 8
local buttonCorner = UDim.new(1, 0)
local buttonTextSize = 16

local backdropShown = 0.5

local stack = {}

local consumedEscape = nil

local function pruneStack()
    for index = #stack, 1, -1 do
        local open = stack[index]
        if open._closed or not open.screenGui.Parent then
            table.remove(stack, index)
        end
    end
end

local function topmost(popup)
    pruneStack()
    return stack[#stack] == popup
end

function Popup.new(window, properties)
    properties = if typeof(properties) == "table" then properties else {}

    local self = setmetatable({
        window = assert(window, "Missing argument #1 (Window expected)"),
        title = properties.title or properties.Title or "Popup",
        subtitle = properties.subtitle or properties.Subtitle,
        content = properties.content or properties.Content,
        icon = properties.icon or properties.Icon,
        boxes = properties.boxes or properties.Boxes,
        options = properties.options or properties.Options,

        dismissable = if properties.dismissable ~= nil
            then properties.dismissable
            elseif properties.Dismissable ~= nil then properties.Dismissable
            else true,
        _reveal = {},
        _connections = {},
        _closed = false,
    }, Popup)

    if not self.options or #self.options == 0 then
        self.options = { { text = "Okay" } }
    end

    self:_build()

    pruneStack()
    table.insert(stack, self)

    task.spawn(function()
        self:_show()
    end)

    return self
end

function Popup:_fade(instance, prop, to)
    table.insert(self._reveal, { instance = instance, prop = prop, to = to })
    return instance
end

function Popup:_build()
    local window = self.window
    local hasIcon = self.icon ~= nil and self.icon ~= 0 and self.icon ~= ""

    self.screenGui = window:Create("ScreenGui", {
        Name = variables.httpService:GenerateGUID(false),
        IgnoreGuiInset = true,
        ResetOnSpawn = false,
        Enabled = true,
        DisplayOrder = constants.displayOrder.popup,
        ZIndexBehavior = Enum.ZIndexBehavior.Global,

        Parent = variables.guiContainer,
    })

    self.backdrop = window:Create("Frame", {
        Name = "Backdrop",
        BackgroundColor3 = Color3.fromRGB(0, 0, 0),
        BorderSizePixel = 0,
        Size = UDim2.fromScale(1, 1),
        Active = true,

        BackgroundTransparency = 1,

        Parent = self.screenGui,
    })
    self:_fade(self.backdrop, "BackgroundTransparency", backdropShown)

    self.card = window:Create("Frame", {
        Name = "Card",
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new(0.5, 0, 0.5, 14),
        Size = UDim2.fromOffset(cardWidth, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        Active = true,
        BorderSizePixel = 0,

        BackgroundTransparency = 1,

        Parent = self.screenGui,
    })
    self:_fade(self.card, "BackgroundTransparency", 0)

    window:Create("UIGradient", {
        Rotation = 270,
        Offset = Vector2.new(0, -0.1),

        Parent = self.card,
    }, { Color = { "WindowColor", functions.toColorSequence } })

    window:Create("UICorner", {
        Parent = self.card,
    }, { CornerRadius = "CornerRoundness" })

    self.cardStroke = window:Create("UIStroke", {
        Transparency = 1,

        Parent = self.card,
    }, { Color = "SurfaceStroke" })
    self:_fade(self.cardStroke, "Transparency", 0.95)

    self.cardShadow = window:CreateGlow(self.card, "ShadowColor", 26, 1)
    self:_fade(self.cardShadow, "Transparency", 0.55)

    window:Create("UIPadding", {
        PaddingLeft = UDim.new(0, sidePadding),
        PaddingRight = UDim.new(0, sidePadding),
        PaddingTop = UDim.new(0, topPadding),
        PaddingBottom = UDim.new(0, bottomPadding),

        Parent = self.card,
    })

    window:Create("UIListLayout", {
        FillDirection = Enum.FillDirection.Vertical,
        HorizontalAlignment = Enum.HorizontalAlignment.Center,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, regionGap),

        Parent = self.card,
    })

    local headerHeight = self:_measureHeader(hasIcon)
    self:_buildHeader(hasIcon, headerHeight)
    local contentHeight = self:_buildContent()
    self:_buildFooter()

    local regions = 2 + (contentHeight > 0 and 1 or 0)
    local cardHeight = topPadding
        + headerHeight
        + contentHeight
        + buttonHeight
        + bottomPadding
        + regionGap * (regions - 1)
    self.card.Size = UDim2.fromOffset(cardWidth, cardHeight)
    self.card.AutomaticSize = Enum.AutomaticSize.None

    if self.dismissable then
        table.insert(
            self._connections,
            window:Connect(self.backdrop.InputBegan, function(input)
                if
                    input.UserInputType == Enum.UserInputType.MouseButton1
                    or input.UserInputType == Enum.UserInputType.Touch
                then
                    self:Close()
                end
            end)
        )
        table.insert(
            self._connections,
            window:Connect(variables.userInputService.InputBegan, function(input, processed)
                if not processed and input.KeyCode == Enum.KeyCode.Escape and topmost(self) then
                    if input == consumedEscape then
                        return
                    end
                    consumedEscape = input
                    self:Close()
                end
            end)
        )
    end
end

function Popup:_buildHeader(hasIcon, headerHeight)
    local window = self.window

    local header = window:Create("Frame", {
        Name = "Header",
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, headerHeight),
        LayoutOrder = 1,

        Parent = self.card,
    })

    window:Create("UIListLayout", {
        FillDirection = Enum.FillDirection.Horizontal,
        VerticalAlignment = Enum.VerticalAlignment.Center,
        HorizontalAlignment = Enum.HorizontalAlignment.Left,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, headerIconGap),

        Parent = header,
    })

    if hasIcon then
        self:_fade(
            window:Create("ImageLabel", {
                Image = self.icon,
                Size = UDim2.fromOffset(headerIconSize, headerIconSize),
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                LayoutOrder = 1,

                ImageTransparency = 1,

                Parent = header,
            }, { ImageColor3 = "TitlingColor" }),
            "ImageTransparency",
            0
        )
    end

    local textColumn = window:Create("Frame", {
        Name = "Text",
        BackgroundTransparency = 1,
        Size = UDim2.new(1, hasIcon and -(headerIconSize + headerIconGap) or 0, 0, self._columnH),
        LayoutOrder = 2,

        Parent = header,
    })

    window:Create("UIListLayout", {
        FillDirection = Enum.FillDirection.Vertical,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, 3),

        Parent = textColumn,
    })

    self:_fade(
        window:Create("TextLabel", {
            Text = locale.t(self.title),
            Size = UDim2.new(1, 0, 0, self._titleH),
            BackgroundTransparency = 1,
            TextSize = titleSize,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextWrapped = true,
            LayoutOrder = 1,

            TextTransparency = 1,

            Parent = textColumn,
        }, { TextColor3 = "TitlingColor", FontFace = "Font" }),
        "TextTransparency",
        0
    )

    if self.subtitle and self.subtitle ~= "" then
        self:_fade(
            window:Create("TextLabel", {
                Text = locale.t(self.subtitle),
                Size = UDim2.new(1, 0, 0, self._subH),
                BackgroundTransparency = 1,
                TextSize = subtitleSize,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextWrapped = true,
                LayoutOrder = 2,

                TextTransparency = 1,

                Parent = textColumn,
            }, { TextColor3 = "TitlingColor", FontFace = "Font" }),
            "TextTransparency",
            0.55
        )
    end
end

function Popup:_buildContent()
    if (not self.content or self.content == "") and (not self.boxes or #self.boxes == 0) then
        return 0
    end

    local window = self.window
    local measured = if self.boxes and #self.boxes > 0 then self:_measureBoxes() else self:_measureText()
    local viewHeight = math.min(measured, maxContentHeight) + contentInset * 2

    local content = window:Create("ScrollingFrame", {
        Name = "Content",
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, viewHeight),
        CanvasSize = UDim2.new(0, 0, 0, 0),
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        ScrollBarThickness = 4,
        ScrollBarImageColor3 = Color3.fromRGB(255, 255, 255),
        ScrollingDirection = Enum.ScrollingDirection.Y,
        LayoutOrder = 2,

        ScrollBarImageTransparency = 1,

        Parent = self.card,
    })
    self:_fade(content, "ScrollBarImageTransparency", 0.8)

    window:Create("UIPadding", {
        PaddingLeft = UDim.new(0, contentInset),
        PaddingRight = UDim.new(0, contentInset),
        PaddingTop = UDim.new(0, contentInset),
        PaddingBottom = UDim.new(0, contentInset),

        Parent = content,
    })

    if self.boxes and #self.boxes > 0 then
        window:Create("UIListLayout", {
            FillDirection = Enum.FillDirection.Vertical,
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, boxGap),

            Parent = content,
        })
        for index, box in self.boxes do
            self:_buildBox(content, box, index)
        end
    else
        self:_fade(
            window:Create("TextLabel", {
                Text = locale.t(self.content),
                Size = UDim2.new(1, 0, 0, measured),
                BackgroundTransparency = 1,
                TextSize = contentSize,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextYAlignment = Enum.TextYAlignment.Top,
                TextWrapped = true,

                TextTransparency = 1,

                Parent = content,
            }, { TextColor3 = "ContentColor", FontFace = "Font" }),
            "TextTransparency",
            0.5
        )
    end

    return viewHeight
end

function Popup:_buildBox(parent, box, order)
    local window = self.window
    box = if typeof(box) == "table" then box else { title = tostring(box) }
    local hasIcon = box.icon ~= nil and box.icon ~= 0 and box.icon ~= ""
    local frameH, titleH, descH, columnH = self:_measureBox(box)

    local frame = window:Create("Frame", {
        Name = "Box",
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BorderSizePixel = 0,
        Size = UDim2.new(1, -boxWidthInset, 0, frameH),
        LayoutOrder = order,

        BackgroundTransparency = 1,

        Parent = parent,
    })
    self:_fade(frame, "BackgroundTransparency", 0)

    local stroke = window:StyleElementPanel(frame)
    self:_fade(stroke, "Transparency", window.theme.ElementStrokeTransparency)

    window:Create("UIPadding", {
        PaddingLeft = UDim.new(0, boxSidePad),
        PaddingRight = UDim.new(0, boxSidePad),
        PaddingTop = UDim.new(0, boxVerticalPad),
        PaddingBottom = UDim.new(0, boxVerticalPad),

        Parent = frame,
    })

    window:Create("UIListLayout", {
        FillDirection = Enum.FillDirection.Horizontal,
        VerticalAlignment = Enum.VerticalAlignment.Center,
        HorizontalAlignment = Enum.HorizontalAlignment.Left,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, boxIconGap),

        Parent = frame,
    })

    if hasIcon then
        self:_fade(
            window:Create("ImageLabel", {
                Image = box.icon,
                Size = UDim2.fromOffset(boxIconSize, boxIconSize),
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                LayoutOrder = 1,

                ImageTransparency = 1,

                Parent = frame,
            }, { ImageColor3 = "ContentColor" }),
            "ImageTransparency",
            0
        )
    end

    local textColumn = window:Create("Frame", {
        BackgroundTransparency = 1,
        Size = UDim2.new(1, hasIcon and -(boxIconSize + boxIconGap) or 0, 0, columnH),
        LayoutOrder = 2,

        Parent = frame,
    })

    window:Create("UIListLayout", {
        FillDirection = Enum.FillDirection.Vertical,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, 3),

        Parent = textColumn,
    })

    self:_fade(
        window:Create("TextLabel", {
            Text = locale.t(box.title or box.Title or ""),
            Size = UDim2.new(1, 0, 0, titleH),
            BackgroundTransparency = 1,
            TextSize = boxTitleSize,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextWrapped = true,
            LayoutOrder = 1,

            TextTransparency = 1,

            Parent = textColumn,
        }, { TextColor3 = "ContentColor", FontFace = "TitleFont" }),
        "TextTransparency",
        0
    )

    local description = box.description or box.Description
    if description and description ~= "" then
        self:_fade(
            window:Create("TextLabel", {
                Text = locale.t(description),
                Size = UDim2.new(1, 0, 0, descH),
                BackgroundTransparency = 1,
                TextSize = boxDescSize,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextYAlignment = Enum.TextYAlignment.Top,
                TextWrapped = true,
                LayoutOrder = 2,

                TextTransparency = 1,

                Parent = textColumn,
            }, { TextColor3 = "ContentColor", FontFace = "Font" }),
            "TextTransparency",
            0.65
        )
    end
end

function Popup:_buildFooter()
    local window = self.window

    local footer = window:Create("Frame", {
        Name = "Footer",
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, buttonHeight),
        LayoutOrder = 3,

        Parent = self.card,
    })

    window:Create("UIListLayout", {
        FillDirection = Enum.FillDirection.Horizontal,
        VerticalAlignment = Enum.VerticalAlignment.Center,
        HorizontalAlignment = Enum.HorizontalAlignment.Center,
        HorizontalFlex = Enum.UIFlexAlignment.Fill,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, buttonGap),

        Parent = footer,
    })

    for index, option in self.options do
        self:_buildButton(footer, option, index)
    end
end

function Popup:_buildButton(parent, option, order)
    local window = self.window
    option = if typeof(option) == "table" then option else { text = tostring(option) }
    local style = option.style or option.Style or "neutral"
    local label = option.text or option.Text or option.name or option.Name or "Okay"
    local callback = option.callback or option.Callback

    local restColor, hoverColor, edgeColor, strokeShown
    if style == "primary" then
        restColor, hoverColor, edgeColor, strokeShown =
            window.theme.AccentColor, window.theme.AccentStroke, window.theme.AccentStroke, 0.1
    elseif style == "danger" then
        restColor, hoverColor, edgeColor, strokeShown =
            window.theme.ErrorColor, window.theme.ErrorStrokeColor, window.theme.ErrorStrokeColor, 0
    else
        restColor, hoverColor, edgeColor, strokeShown =
            window.theme.NeutralButton, window.theme.NeutralButtonHover, window.theme.NeutralButtonStroke, 0.85
    end

    local button = window:Create("Frame", {
        Name = "Button",
        BackgroundColor3 = restColor,
        BorderSizePixel = 0,
        Size = UDim2.new(0, 0, 0, buttonHeight),
        LayoutOrder = order,

        BackgroundTransparency = 1,

        Parent = parent,
    })
    self:_fade(button, "BackgroundTransparency", 0)

    window:Create("UIFlexItem", { FlexMode = Enum.UIFlexMode.Fill, Parent = button })
    window:Create("UICorner", { CornerRadius = buttonCorner, Parent = button })

    local stroke = window:Create("UIStroke", {
        Color = edgeColor,
        Transparency = 1,

        Parent = button,
    })
    self:_fade(stroke, "Transparency", strokeShown)

    self:_fade(
        window:Create("TextLabel", {
            Text = locale.t(label),
            Size = UDim2.fromScale(1, 1),
            BackgroundTransparency = 1,
            TextSize = buttonTextSize,
            TextXAlignment = Enum.TextXAlignment.Center,
            TextTruncate = Enum.TextTruncate.AtEnd,

            TextColor3 = functions.contrastText(restColor),
            TextTransparency = 1,

            Parent = button,
        }, { FontFace = "Font" }),
        "TextTransparency",
        0
    )

    local interact = window:Create("TextButton", {
        Text = "",
        BackgroundTransparency = 1,
        Size = UDim2.fromScale(1, 1),
        BorderSizePixel = 0,
        ZIndex = 2,

        Parent = button,
    })

    local hoverInfo = TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
    table.insert(
        self._connections,
        window:Connect(interact.MouseEnter, function()
            if self._closed then
                return
            end
            variables.tweenService:Create(button, hoverInfo, { BackgroundColor3 = hoverColor }):Play()
        end)
    )
    table.insert(
        self._connections,
        window:Connect(interact.MouseLeave, function()
            variables.tweenService:Create(button, hoverInfo, { BackgroundColor3 = restColor }):Play()
        end)
    )

    table.insert(
        self._connections,
        window:Connect(interact.MouseButton1Click, function()
            if self._closed then
                return
            end
            hapticEngine.click()

            variables.tweenService:Create(stroke, hoverInfo, { Transparency = 1 }):Play()
            if callback then
                task.spawn(function()
                    local ok, err = pcall(callback)
                    if not ok then
                        log.warn("Rayfield: popup button '" .. label .. "' callback errored:")
                        log.print(err)
                    end
                end)
            end
            self:Close()
        end)
    )
end

function Popup:_measureHeader(hasIcon)
    local textWidth = innerWidth - (if hasIcon then headerIconSize + headerIconGap else 0)
    self._titleH = functions.textHeight(self.window.theme.Font, titleSize, locale.resolve(self.title), textWidth)
    self._subH = if self.subtitle and self.subtitle ~= ""
        then functions.textHeight(self.window.theme.Font, subtitleSize, locale.resolve(self.subtitle), textWidth)
        else 0
    self._columnH = self._titleH + (if self._subH > 0 then 3 + self._subH else 0)
    return math.max(self._columnH, if hasIcon then headerIconSize else 0)
end

function Popup:_measureText()

    return functions.textHeight(self.window.theme.Font, contentSize, locale.resolve(self.content), contentWidth)
end

function Popup:_measureBox(box)
    box = if typeof(box) == "table" then box else { title = tostring(box) }
    local hasIcon = box.icon ~= nil and box.icon ~= 0 and box.icon ~= ""
    local textWidth = contentWidth - boxWidthInset - boxSidePad * 2 - (if hasIcon then boxIconSize + boxIconGap else 0)

    local titleH = functions.textHeight(
        self.window.theme.TitleFont,
        boxTitleSize,
        locale.resolve(box.title or box.Title or ""),
        textWidth
    )
    local descH = 0
    local description = box.description or box.Description
    if description and description ~= "" then
        descH = functions.textHeight(self.window.theme.Font, boxDescSize, locale.resolve(description), textWidth)
    end

    local columnH = titleH + (if descH > 0 then 3 + descH else 0)
    local frameH = math.max(columnH, if hasIcon then boxIconSize else 0) + boxVerticalPad * 2
    return frameH, titleH, descH, columnH
end

function Popup:_measureBoxes()
    local total = 0
    for index, box in self.boxes do
        total += (self:_measureBox(box))
        if index < #self.boxes then
            total += boxGap
        end
    end
    return total
end

function Popup:_show()
    if not self.screenGui.Parent then
        return
    end

    hapticEngine.notify()

    variables.tweenService:Create(self.card, enterInfo, { Position = UDim2.new(0.5, 0, 0.5, 0) }):Play()

    for _, entry in self._reveal do
        local info = if entry.instance == self.backdrop then backdropInfo else fadeLong
        variables.tweenService:Create(entry.instance, info, { [entry.prop] = entry.to }):Play()
    end
end

function Popup:Close()
    if self._closed then
        return
    end
    self._closed = true

    local index = table.find(stack, self)
    if index then
        table.remove(stack, index)
    end

    for _, connection in self._connections do
        self.window:Disconnect(connection)
    end
    self._connections = {}

    if not self.screenGui.Parent then
        return
    end

    variables.tweenService:Create(self.card, fadeShort, { Position = UDim2.new(0.5, 0, 0.5, 10) }):Play()

    for _, entry in self._reveal do
        variables.tweenService:Create(entry.instance, fadeShort, { [entry.prop] = 1 }):Play()
    end

    task.delay(fadeShort.Time, function()
        self.window:DestroySubtree(self.screenGui)
    end)
end

return Popup
end

Components.progress = { Name = "progress", Parent = Components }
Components.progress.FindFirstChild = function(self, k) return self[k] end
Components.progress.__loader = function(script, require)
local Progress = {}
Progress.__index = Progress
Progress.__type = "Progress"

local utility = script.Parent.Parent.utility

local variables = require(utility.variables)
local functions = require(utility.functions)
local moveable = require(utility.moveable)
local locale = require(utility.locale)

local rowHeight = 60
local trackHeight = 8
local inset = 20

local stepHeight = 6
local stepGap = 6

local titleSize = 16
local readoutSize = 14
local readoutTransparency = 0.4

local fillInfo = TweenInfo.new(0.45, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)

local fillTransparency = NumberSequence.new({
    NumberSequenceKeypoint.new(0, 0.85),
    NumberSequenceKeypoint.new(1, 0),
})

local sweepSeconds = 0.9
local sweepInfo = TweenInfo.new(sweepSeconds, Enum.EasingStyle.Quint, Enum.EasingDirection.InOut, -1, true)

local function finite(value: unknown): number?
    local number = tonumber(value)
    if number == nil or number ~= number or math.abs(number) == math.huge then
        return nil
    end
    return number
end

function Progress.new(tab, properties)
    properties = if typeof(properties) == "table" then properties else {}

    local steps = finite(properties.steps or properties.Steps)
    steps = if steps and steps >= 2 then math.floor(steps) else nil

    local range = properties.range or properties.Range
    local min = finite(range and range[1]) or 0
    local max = finite(range and range[2]) or steps or 1
    if min > max then
        min, max = max, min
    end

    local self = setmetatable({
        tab = assert(tab, "Missing argument #1 (Tab expected)"),
        window = tab.window,
        name = properties.name or properties.Name or "Progress",
        icon = properties.icon or properties.Icon,
        description = properties.description or properties.Description,

        min = min,
        max = max,
        steps = steps,
        value = 0,

        text = properties.text or properties.Text,
        format = properties.format or properties.Format,
        showValue = if properties.showValue == nil then true else properties.showValue == true,
        indeterminate = properties.indeterminate or properties.Indeterminate or false,
    }, Progress)

    self.value = self:_clamp(finite(properties.value or properties.Value) or min)

    self:_build()

    if self.description then
        self.descriptor = require(script.Parent.descriptor).new(self.tab, { description = self.description })
    end

    return self
end

function Progress:_clamp(value: number): number
    return math.clamp(finite(value) or self.min, self.min, self.max)
end

function Progress:_ratio(): number
    local span = self.max - self.min
    if span <= 0 then
        return 1
    end
    return (self.value - self.min) / span
end

function Progress:_filledSteps(): number
    local count = self.steps :: number
    return math.clamp(math.round(self:_ratio() * count), 0, count)
end

function Progress:_readout(): string
    if self.text then
        return locale.resolve(self.text)
    end
    if self.format then
        local ok, formatted = pcall(self.format, self.value, self.min, self.max)
        if ok and type(formatted) == "string" then
            return formatted
        end
    end

    if self.steps then
        return string.format("%d/%d", self:_filledSteps(), self.steps)
    end
    return string.format("%d%%", math.round(self:_ratio() * 100))
end

function Progress:_build()
    self.main = self.window:Create("Frame", {
        Size = UDim2.new(1, -20, 0, rowHeight),
        BorderSizePixel = 0,
        Name = self.name,
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),

        BackgroundTransparency = 1,

        Parent = self.tab.tabPage,
    }, { BackgroundTransparency = "ElementTransparency" })

    self.stroke = self.window:StyleElementBody(self.main)

    self.container = self.window:Create("Frame", {
        Size = UDim2.new(0, 170, 0, titleSize),
        Position = UDim2.new(0, inset, 0, 20),
        AnchorPoint = Vector2.new(0, 0.5),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,

        Parent = self.main,
    })

    self.window:Create("UIListLayout", {
        Padding = UDim.new(0, 6),
        FillDirection = Enum.FillDirection.Horizontal,
        VerticalAlignment = Enum.VerticalAlignment.Center,
        HorizontalAlignment = Enum.HorizontalAlignment.Left,
        SortOrder = Enum.SortOrder.LayoutOrder,

        Parent = self.container,
    })

    if self.icon then
        self.iconLabel = self.window:Create("ImageLabel", {
            Image = self.icon,
            Size = UDim2.fromOffset(16, 16),
            BorderSizePixel = 0,
            BackgroundTransparency = 1,

            ImageTransparency = 1,

            Parent = self.container,
        }, { ImageColor3 = "ContentColor" })
    end

    self.title = self.window:Create("TextLabel", {
        Text = locale.t(self.name),

        Size = UDim2.fromOffset(250, titleSize),
        BorderSizePixel = 0,
        BackgroundTransparency = 1,
        TextSize = titleSize,
        AutomaticSize = Enum.AutomaticSize.X,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextWrapped = true,
        LayoutOrder = 1,

        TextTransparency = 1,

        Parent = self.container,
    }, { TextColor3 = "ContentColor", FontFace = "Font" })

    self.readout = self.window:Create("TextLabel", {
        Text = self:_readout(),

        AnchorPoint = Vector2.new(1, 0.5),
        Position = UDim2.new(1, -inset, 0, 20),
        Size = UDim2.fromOffset(50, readoutSize),
        AutomaticSize = Enum.AutomaticSize.X,
        BorderSizePixel = 0,
        BackgroundTransparency = 1,
        TextSize = readoutSize,
        TextXAlignment = Enum.TextXAlignment.Right,
        Visible = self.showValue,

        TextTransparency = 1,

        Parent = self.main,
    }, { TextColor3 = "ContentColor", FontFace = "Font" })

    if self.steps then
        self:_buildSteps()
        return
    end

    self.track = self.window:Create("Frame", {
        AnchorPoint = Vector2.new(0.5, 1),
        Position = UDim2.new(0.5, 0, 1, -16),
        Size = UDim2.new(1, -inset * 2, 0, trackHeight),
        BorderSizePixel = 0,

        BackgroundTransparency = 1,

        Parent = self.main,
    }, { BackgroundColor3 = "SliderBackground" })

    self.window:Create("UICorner", {
        CornerRadius = UDim.new(1, 0),

        Parent = self.track,
    })

    self.fill = self.window:Create("Frame", {
        AnchorPoint = Vector2.new(0, 0.5),
        Position = UDim2.fromScale(0, 0.5),
        Size = UDim2.fromScale(if self.indeterminate then 0 else self:_ratio(), 1),
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BorderSizePixel = 0,
        ZIndex = 2,

        BackgroundTransparency = 1,

        Parent = self.track,
    })

    self.window:Create("UICorner", {
        CornerRadius = UDim.new(1, 0),

        Parent = self.fill,
    })

    self.window:Create("UIGradient", {
        Offset = Vector2.new(0, 0.5),
        Rotation = 2,
        Transparency = fillTransparency,

        Parent = self.fill,
    }, { Color = { "SliderProgress", functions.toColorSequence } })

    self.fillGlow = self.window:CreateGlow(self.fill, "AccentColor", 20, 1)

    if self.indeterminate then
        self:_startSweep()
    end
end

function Progress:_buildSteps()
    local count = self.steps :: number

    self.track = self.window:Create("Frame", {
        AnchorPoint = Vector2.new(0.5, 1),
        Position = UDim2.new(0.5, 0, 1, -17),
        Size = UDim2.new(1, -inset * 2, 0, stepHeight),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,

        Parent = self.main,
    })

    self.window:Create("UIListLayout", {
        Padding = UDim.new(0, stepGap),
        FillDirection = Enum.FillDirection.Horizontal,
        VerticalAlignment = Enum.VerticalAlignment.Center,
        HorizontalAlignment = Enum.HorizontalAlignment.Left,
        SortOrder = Enum.SortOrder.LayoutOrder,

        Parent = self.track,
    })

    self.stepFrames = {}
    for index = 1, count do

        local segment = self.window:Create("Frame", {
            Size = UDim2.new(1 / count, -(stepGap * (count - 1)) / count, 1, 0),
            BorderSizePixel = 0,
            LayoutOrder = index,

            BackgroundTransparency = 1,

            Parent = self.track,
        }, { BackgroundColor3 = "SliderBackground" })

        self.window:Create("UICorner", {
            CornerRadius = UDim.new(1, 0),

            Parent = segment,
        })

        local fill = self.window:Create("Frame", {
            Size = UDim2.fromScale(1, 1),
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            BorderSizePixel = 0,
            ZIndex = 2,

            BackgroundTransparency = 1,

            Parent = segment,
        })

        self.window:Create("UICorner", {
            CornerRadius = UDim.new(1, 0),

            Parent = fill,
        })

        self.window:Create("UIGradient", {
            Rotation = 90,

            Parent = fill,
        }, { Color = { "SliderProgress", functions.toColorSequence } })

        table.insert(self.stepFrames, { segment = segment, fill = fill })
    end
end

function Progress:_startSweep()
    if self._sweep or self.steps then
        return
    end

    self.fill.AnchorPoint = Vector2.new(0, 0.5)
    self.fill.Position = UDim2.fromScale(0, 0.5)
    self.fill.Size = UDim2.fromScale(0, 1)

    self._sweep = variables.tweenService:Create(self.fill, sweepInfo, { Size = UDim2.fromScale(1, 1) })
    self._sweep:Play()
end

function Progress:_stopSweep()
    if not self._sweep then
        return
    end
    self._sweep:Cancel()
    self._sweep = nil
    self.fill.AnchorPoint = Vector2.new(0, 0.5)
    self.fill.Position = UDim2.fromScale(0, 0.5)
end

function Progress:_render(animate: boolean?)
    self.readout.Text = self:_readout()

    if self.steps then

        if not self._shown then
            return
        end
        local filled = self:_filledSteps()
        for index, step in self.stepFrames do
            local target = if index <= filled then 0 else 1
            if animate == false then
                step.fill.BackgroundTransparency = target
            else
                variables.tweenService:Create(step.fill, fillInfo, { BackgroundTransparency = target }):Play()
            end
        end
        return
    end

    local size = UDim2.fromScale(self:_ratio(), 1)
    if animate == false then
        self.fill.Size = size
    else
        variables.tweenService:Create(self.fill, fillInfo, { Size = size }):Play()
    end
end

function Progress:Set(value)
    self.value = self:_clamp(value)

    if self.indeterminate then
        self.indeterminate = false
        self:_stopSweep()
    end

    self:_render()
end

function Progress:Get(): number
    return self.value
end

function Progress:GetPercentage(): number
    return self:_ratio()
end

function Progress:SetRange(min, max)
    min = finite(min) or self.min
    max = finite(max) or self.max
    if min > max then
        min, max = max, min
    end

    self.min, self.max = min, max
    self.value = self:_clamp(self.value)
    self:_render()
end

function Progress:SetText(text)
    self.text = text
    self.readout.Text = self:_readout()
end

function Progress:SetIndeterminate(state)
    state = state == true
    if state == self.indeterminate then
        return
    end
    self.indeterminate = state

    if state then
        self:_startSweep()
    else
        self:_stopSweep()
        self:_render(false)
    end
end

function Progress:_setShown(shown, animate)
    local w = self.window

    self._shown = shown
    w:_reveal(self.readout, { TextTransparency = if shown then readoutTransparency else 1 }, animate)

    if shown then
        w:_revealCommon(self, animate)
    else
        w:_hideCommon(self, animate)
    end

    if self.steps then
        local filled = self:_filledSteps()
        for index, step in self.stepFrames do
            w:_reveal(step.segment, { BackgroundTransparency = if shown then 0 else 1 }, animate)
            w:_reveal(step.fill, { BackgroundTransparency = if shown and index <= filled then 0 else 1 }, animate)
        end
        return
    end

    w:_reveal(self.track, { BackgroundTransparency = if shown then 0 else 1 }, animate)
    w:_reveal(self.fill, { BackgroundTransparency = if shown then 0 else 1 }, animate)
    w:_reveal(self.fillGlow, { Transparency = if shown then w.theme.AccentGlow else 1 }, animate)
end

function Progress:Remove()
    self:_stopSweep()
    if self.descriptor then
        self.descriptor:Remove()
    end
    self.main:Destroy()
end

moveable(Progress)

return Progress
end

Components.search = { Name = "search", Parent = Components }
Components.search.FindFirstChild = function(self, k) return self[k] end
Components.search.__loader = function(script, require)
local utility = script.Parent.Parent.utility
local variables = require(utility.variables)
local constants = require(utility.constants)
local locale = require(utility.locale)
local action = require(script.Parent.action)

local search = {}

local swapInfo = TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)

local iconRest = 0.6
local iconLit = 0.2

local function unitText(unit)
    if unit.__type == "Group" then
        local parts = {}
        local function walk(group)
            for _, child in group.elements do
                if child.__type == "Group" then
                    walk(child)
                elseif child.name then
                    table.insert(parts, child.name)
                end
            end
        end
        walk(unit)
        return table.concat(parts, "\n")
    end
    return unit.name or ""
end

local function collectUnits(window)
    local units = {}
    for _, tab in window.tabs do
        if tab.neglectSelector then
            continue
        end
        for _, element in tab.elements do
            if element.__type ~= "Section" then
                table.insert(units, element)
            end
        end
    end
    return units
end

local function setPillShown(window, shown, info)
    variables.tweenService
        :Create(window.searchPill, info, {
            BackgroundTransparency = if shown then 0.9 else 1,
        })
        :Play()
    variables.tweenService:Create(window.searchStroke, info, { Transparency = if shown then 0.85 else 1 }):Play()
    variables.tweenService:Create(window.searchShadow, info, { Transparency = if shown then 0.92 else 1 }):Play()
    variables.tweenService:Create(window.searchIcon, info, { ImageTransparency = if shown then 0.65 else 1 }):Play()
    variables.tweenService:Create(window.searchInput, info, { TextTransparency = if shown then 0.2 else 1 }):Play()
end

local function setTabsShown(window, shown, info)
    if window.layout.mode == "sidebar" then
        return
    end
    for _, tab in window.tabs do
        if not tab.neglectSelector and tab.topbarItem then
            tab:_applyVisual(
                if shown then (if window.selectedTab == tab then "selected" else "unselected") else "hidden",
                info
            )
        end
    end
end

local function applyFilter(window, query)
    query = string.lower(query or "")
    local anyVisible = false
    for _, entry in window._searchUnits do
        local match = query == "" or string.find(entry.text, query, 1, true) ~= nil
        entry.unit.main.Visible = match
        if entry.unit.descriptor then
            entry.unit.descriptor.main.Visible = match
        end
        anyVisible = anyVisible or match
    end
    window.searchEmpty.Visible = not anyVisible and query ~= ""
end

local function gatherUnits(window)
    window._searchUnits = {}
    local order = 0
    for _, unit in collectUnits(window) do
        order += 1
        local main = unit.main
        table.insert(window._searchUnits, {
            unit = unit,
            text = string.lower(unitText(unit)),
            homeParent = main.Parent,
            homeOrder = main.LayoutOrder,
            descOrder = unit.descriptor and unit.descriptor.main.LayoutOrder,
        })

        main.LayoutOrder = order * 10
        main.Parent = window.searchPage
        main.Visible = true
        if unit.descriptor then
            unit.descriptor.main.LayoutOrder = order * 10 + 1
            unit.descriptor.main.Parent = window.searchPage
            unit.descriptor.main.Visible = true
        end
    end
end

local function restoreUnits(window)
    for _, entry in window._searchUnits do
        local unit = entry.unit
        if unit.main and unit.main.Parent then
            unit.main.LayoutOrder = entry.homeOrder
            unit.main.Parent = entry.homeParent
            unit.main.Visible = true
        end
        if unit.descriptor and unit.descriptor.main and unit.descriptor.main.Parent then
            unit.descriptor.main.LayoutOrder = entry.descOrder
            unit.descriptor.main.Parent = entry.homeParent
            unit.descriptor.main.Visible = true
        end
    end
    window._searchUnits = {}
end

function search.open(window)

    if window._searching or window.minimised or not window:_interactive() then
        return
    end
    window._searching = true

    gatherUnits(window)
    applyFilter(window, "")
    window:_jumpTo(window.searchPage)

    setTabsShown(window, false, swapInfo)
    task.delay(swapInfo.Time, function()
        if window._searching and window.layout.mode ~= "sidebar" then
            window.tabList.Visible = false
        end
    end)

    window.searchPill.Visible = true
    setPillShown(window, true, swapInfo)
    window.searchInput:CaptureFocus()

    variables.tweenService:Create(window.searchAction.iconLabel, swapInfo, { ImageTransparency = iconLit }):Play()
end

function search.close(window, config)
    if not window._searching then
        return
    end
    config = config or {}
    window._searching = false

    window.searchInput.Text = ""
    window.searchInput:ReleaseFocus()
    window.searchEmpty.Visible = false

    restoreUnits(window)
    local target = if config.jumpTo == nil then window.selectedTab and window.selectedTab.tabPage else config.jumpTo
    if target then
        window:_jumpTo(target)
    end

    setPillShown(window, false, swapInfo)
    task.delay(swapInfo.Time, function()
        if not window._searching then
            window.searchPill.Visible = false
        end
    end)

    if config.showTabs then
        window.tabList.Visible = true
        setTabsShown(window, true, swapInfo)
    end

    variables.tweenService:Create(window.searchAction.iconLabel, swapInfo, { ImageTransparency = iconRest }):Play()
end

function search.toggle(window)
    if window._searching then
        search.close(window, { showTabs = true })
    else
        search.open(window)
    end
end

function search.railWidth(window, width)
    if window.searchPill then
        window.searchPill.Size = UDim2.new(1, -(width + 30), 0, 35)
    end
end

function search.build(window)
    window._searching = false

    window.searchPage = window:Create("ScrollingFrame", {
        Name = "Search",
        Size = UDim2.new(1, -20, 1, 0),
        Position = UDim2.new(0.5, 0, 0, 68),
        AnchorPoint = Vector2.new(0.5, 0.5),
        BorderSizePixel = 0,
        BackgroundTransparency = 1,
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        CanvasSize = UDim2.new(0, 0, 0, 0),
        ScrollBarThickness = 0,
        ScrollingDirection = Enum.ScrollingDirection.Y,
        LayoutOrder = 2000,

        Parent = window.elements,
    })

    window:Create("UIListLayout", {
        Padding = UDim.new(0, 7),
        FillDirection = Enum.FillDirection.Vertical,
        VerticalAlignment = Enum.VerticalAlignment.Top,
        HorizontalAlignment = Enum.HorizontalAlignment.Center,
        SortOrder = Enum.SortOrder.LayoutOrder,

        Parent = window.searchPage,
    })

    window:Create("UIPadding", {
        PaddingTop = UDim.new(0, if window.layout.mode == "sidebar" then 53 else 10),
        PaddingBottom = UDim.new(0, 33),

        Parent = window.searchPage,
    })

    window.searchEmpty = window:Create("TextLabel", {
        Name = "NoResults",
        Text = locale.t("No results"),
        FontFace = variables.brandFont(Enum.FontWeight.Medium),
        TextSize = 15,
        TextTransparency = 0.6,
        BackgroundTransparency = 1,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new(0.5, 0, 0.55, 0),
        Size = UDim2.fromOffset(200, 20),
        Visible = false,
        ZIndex = 3,

        Parent = window.main,
    }, { TextColor3 = "ContentColor", FontFace = "Font" })

    local sidebarLayout = window.layout.mode == "sidebar"

    local top = if sidebarLayout then window.layout.chromeHeight + 8 else window.layout.tabStripTop + 1

    window.searchPill = window:Create("Frame", {
        Name = "SearchBar",
        AnchorPoint = Vector2.new(if sidebarLayout then 1 else 0.5, 0),
        Position = UDim2.new(if sidebarLayout then 1 else 0.5, if sidebarLayout then -15 else 0, 0, top),
        Size = UDim2.new(1, if sidebarLayout then -(window.layout.railWidth + 30) else -35, 0, 35),
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BorderSizePixel = 0,
        ZIndex = 10,

        BackgroundTransparency = 1,
        Visible = false,

        Parent = window.main,
    })

    window:Create("UICorner", {
        CornerRadius = UDim.new(1, 0),
        Parent = window.searchPill,
    })

    window.searchStroke = window:Create("UIStroke", {
        Color = Color3.fromRGB(255, 255, 255),
        Thickness = 1,

        Transparency = 1,

        Parent = window.searchPill,
    })

    window.searchShadow = window:Create("UIShadow", {
        BlurRadius = UDim.new(0, 20),
        Color = Color3.fromRGB(255, 255, 255),
        ZIndex = -1,

        Transparency = 1,

        Parent = window.searchPill,
    })

    window.searchIcon = window:Create("ImageLabel", {
        Image = "rbxassetid://" .. tostring(constants.icons.search),
        AnchorPoint = Vector2.new(0, 0.5),
        Position = UDim2.new(0, 15, 0.5, 1),
        Size = UDim2.fromOffset(16, 16),
        BackgroundTransparency = 1,
        ZIndex = 10,

        ImageTransparency = 1,

        Parent = window.searchPill,
    }, { ImageColor3 = "ContentColor" })

    window.searchInput = window:Create("TextBox", {
        Text = "",
        PlaceholderText = locale.t("Search all pages"),
        AnchorPoint = Vector2.new(0, 0.5),
        Position = UDim2.new(0, 40, 0.5, 0),
        Size = UDim2.new(1, -110, 0, 18),
        BackgroundTransparency = 1,
        TextSize = 16,
        TextXAlignment = Enum.TextXAlignment.Left,
        ClearTextOnFocus = false,
        ClipsDescendants = true,
        ZIndex = 10,

        TextTransparency = 1,

        Parent = window.searchPill,
    }, { TextColor3 = "ContentColor", FontFace = "Font", PlaceholderColor3 = "PlaceholderColor" })

    window:Connect(window.searchInput:GetPropertyChangedSignal("Text"), function()
        if window._searching then
            applyFilter(window, window.searchInput.Text)
        end
    end)

    window.searchAction = action.new(window, {
        name = "Search",
        icon = constants.icons.search,
        order = 4,

        callback = function()
            search.toggle(window)
        end,
    })

    window.searchAction.isLit = function()
        return window._searching
    end
end

return search
end

Components.section = { Name = "section", Parent = Components }
Components.section.FindFirstChild = function(self, k) return self[k] end
Components.section.__loader = function(script, require)
local Section = {}
Section.__index = Section
Section.__type = "Section"

local moveable = require(script.Parent.Parent.utility.moveable)
local locale = require(script.Parent.Parent.utility.locale)

function Section.new(tab, properties)
    properties = if typeof(properties) == "table" then properties else {}

    local self = setmetatable({
        tab = assert(tab, "Missing argument #1 (Tab expected)"),
        window = tab.window,
        name = properties.name or properties.Name or "Section",
        icon = properties.icon or properties.Icon,
    }, Section)

    local topSpace = if #self.tab.elements == 0 then 0 else 13

    self.main = self.window:Create("Frame", {
        Size = UDim2.new(1, -40, 0, 20 + topSpace),
        BorderSizePixel = 0,
        Name = self.name,
        BackgroundTransparency = 1,
        Parent = self.tab.tabPage,
    })

    if topSpace > 0 then
        self.window:Create("UIPadding", {
            PaddingTop = UDim.new(0, topSpace),
            Parent = self.main,
        })
    end

    self.window:Create("UIListLayout", {
        FillDirection = Enum.FillDirection.Horizontal,
        Padding = UDim.new(0, 6),
        SortOrder = Enum.SortOrder.LayoutOrder,
        VerticalAlignment = Enum.VerticalAlignment.Top,
        Parent = self.main,
    })

    if self.icon then
        self.iconLabel = self.window:Create("ImageLabel", {
            Image = self.icon,
            Size = UDim2.fromOffset(16, 16),
            BorderSizePixel = 0,
            BackgroundTransparency = 1,

            ImageTransparency = 1,

            Parent = self.main,
        }, { ImageColor3 = "ContentColor" })
    end

    self.title = self.window:Create("TextLabel", {

        Text = locale.t(self.name),

        Size = UDim2.fromOffset(0, 16),
        BorderSizePixel = 0,
        BackgroundTransparency = 1,
        TextSize = 15,
        AutomaticSize = Enum.AutomaticSize.X,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextWrapped = true,
        LayoutOrder = 1,

        TextTransparency = 1,

        Parent = self.main,
    }, { TextColor3 = "ContentColor", FontFace = "Font" })

    return self
end

function Section:_setShown(shown, animate)
    local w = self.window
    w:_reveal(self.title, { TextTransparency = if shown then 0.6 else 1 }, animate)
    if self.iconLabel then
        w:_reveal(self.iconLabel, { ImageTransparency = if shown then 0.65 else 1 }, animate)
    end
end

moveable(Section)

return Section
end

Components.sidebar = { Name = "sidebar", Parent = Components }
Components.sidebar.FindFirstChild = function(self, k) return self[k] end
Components.sidebar.__loader = function(script, require)
local utility = script.Parent.Parent.utility
local variables = require(utility.variables)
local image = require(utility.image)
local locale = require(utility.locale)
local tabSelector = require(script.Parent.tabSelector)
local search = require(script.Parent.search)

local sidebar = {}

local nameTransparency = 0
local subtitleTransparency = 0.7
local avatarPlateTransparency = 0.95

local settleInfo = TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)

local function profileVisible(window)
    return window.layout.mode == "sidebar"
        and window.profile ~= nil
        and window.settings.showProfile
        and variables.localPlayer ~= nil
end

local function buildProfile(window, layout)
    local player = variables.localPlayer
    if not player then
        return
    end

    window.profile = window:Create("Frame", {
        Name = "Profile",
        AnchorPoint = Vector2.new(0.5, 1),
        Position = UDim2.fromScale(0.5, 1),
        Size = UDim2.new(1, 0, 0, layout.footerHeight),
        BackgroundTransparency = 1,

        Parent = window.sidebar,
    })

    window.profileContainer = window:Create("Frame", {
        AnchorPoint = Vector2.new(0, 0.5),
        Position = UDim2.new(0, layout.rowInset, 0.5, 0),
        Size = UDim2.new(1, -layout.rowInset, 1, 0),
        BackgroundTransparency = 1,

        Parent = window.profile,
    })

    window.profileLayout = window:Create("UIListLayout", {
        Padding = UDim.new(0, 10),
        FillDirection = Enum.FillDirection.Horizontal,
        VerticalAlignment = Enum.VerticalAlignment.Center,
        HorizontalAlignment = Enum.HorizontalAlignment.Left,
        SortOrder = Enum.SortOrder.LayoutOrder,

        Parent = window.profileContainer,
    })

    window.profileAvatar = window:Create("ImageLabel", {
        Name = "Avatar",
        Image = image.avatar(player.UserId, function(uri)
            if window.profileAvatar and not window.unloaded then
                image.assign(window.profileAvatar, "Image", uri)
            end
        end),
        Size = UDim2.fromOffset(layout.avatarSize, layout.avatarSize),
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BorderSizePixel = 0,

        BackgroundTransparency = 1,
        ImageTransparency = 1,

        Parent = window.profileContainer,
    })

    window:Create("UICorner", {
        CornerRadius = UDim.new(1, 0),

        Parent = window.profileAvatar,
    })

    window.profileLabels = window:Create("Frame", {
        Size = UDim2.fromOffset(50, layout.avatarSize),
        AutomaticSize = Enum.AutomaticSize.X,
        BackgroundTransparency = 1,
        LayoutOrder = 1,

        Parent = window.profileContainer,
    })

    window:Create("UIListLayout", {
        Padding = UDim.new(0, 2),
        FillDirection = Enum.FillDirection.Vertical,
        VerticalAlignment = Enum.VerticalAlignment.Center,
        HorizontalAlignment = Enum.HorizontalAlignment.Left,
        SortOrder = Enum.SortOrder.LayoutOrder,

        Parent = window.profileLabels,
    })

    window.profileName = window:Create("TextLabel", {
        Text = player.DisplayName,
        Size = UDim2.fromOffset(50, 16),
        AutomaticSize = Enum.AutomaticSize.X,
        BackgroundTransparency = 1,
        TextSize = 16,
        TextXAlignment = Enum.TextXAlignment.Left,

        TextTransparency = 1,

        Parent = window.profileLabels,
    }, { TextColor3 = "TitlingColor", FontFace = "Font" })

    window.profileSubtitle = window:Create("TextLabel", {
        Text = "",
        Size = UDim2.fromOffset(50, 14),
        AutomaticSize = Enum.AutomaticSize.X,
        BackgroundTransparency = 1,
        TextSize = 14,
        TextXAlignment = Enum.TextXAlignment.Left,
        LayoutOrder = 1,
        Visible = false,

        TextTransparency = 1,

        Parent = window.profileLabels,
    }, { TextColor3 = "TitlingColor", FontFace = "Font" })
end

function sidebar.build(window, layout)
    window.sidebar = window:Create("Frame", {
        Name = "Sidebar",
        AnchorPoint = Vector2.new(0, 1),
        Position = UDim2.fromScale(0, 1),
        Size = UDim2.new(0, layout.railWidth, 1, -layout.chromeHeight),
        BackgroundTransparency = 1,

        Visible = false,

        Parent = window.main,
    })

    window.tabList = window:Create("ScrollingFrame", {
        Name = "Tabs",
        Active = true,
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        CanvasSize = UDim2.new(0, 0, 0, 0),
        ScrollBarThickness = 0,
        ScrollBarImageTransparency = 1,
        ScrollingDirection = Enum.ScrollingDirection.Y,
        ClipsDescendants = true,

        Parent = window.sidebar,
    })

    window:Create("UIPadding", {
        PaddingTop = UDim.new(0, layout.railPadding),
        PaddingBottom = UDim.new(0, layout.railPadding),

        Parent = window.tabList,
    })

    window.tabListLayout = window:Create("UIListLayout", {
        Padding = UDim.new(0, layout.rowSpacing),
        FillDirection = Enum.FillDirection.Vertical,
        VerticalAlignment = Enum.VerticalAlignment.Top,
        HorizontalAlignment = Enum.HorizontalAlignment.Center,
        SortOrder = Enum.SortOrder.LayoutOrder,

        Parent = window.tabList,
    })

    buildProfile(window, layout)
    sidebar.reflowProfile(window)
end

function sidebar.reflowProfile(window)
    local layout = window.layout
    local shown = profileVisible(window)

    if window.profile then
        window.profile.Visible = shown
    end
    window.tabList.Size = UDim2.new(1, 0, 1, if shown then -layout.footerHeight else 0)
end

function sidebar.applyWidth(window, width)
    local layout = window.layout

    window.sidebar.Size = UDim2.new(0, width, 1, -layout.chromeHeight)
    window.elements.Size = UDim2.new(1, -width, 1, -layout.chromeHeight)
    window.bottomFade.Size = UDim2.new(1, -width, layout.fadeSize.Y.Scale, layout.fadeSize.Y.Offset)
    search.railWidth(window, width)

    local collapsed = width < (layout.railWidth :: number)
    for _, tab in window.tabs do
        if not tab.neglectSelector then
            tabSelector.setRowCollapsed(tab, collapsed, layout)
        end
    end

    if window.profileContainer then
        window.profileContainer.Position = UDim2.new(0, if collapsed then 0 else layout.rowInset, 0.5, 0)
        window.profileContainer.Size = UDim2.new(1, if collapsed then 0 else -layout.rowInset, 1, 0)
        window.profileLayout.HorizontalAlignment = if collapsed
            then Enum.HorizontalAlignment.Center
            else Enum.HorizontalAlignment.Left
        window.profileLabels.Visible = not collapsed
    end
end

function sidebar.setProfileShown(window, shown, tweenInfo)
    if not window.profile or not window.profile.Visible then
        return
    end

    local targets = {
        [window.profileAvatar] = {
            ImageTransparency = if shown then 0 else 1,
            BackgroundTransparency = if shown then avatarPlateTransparency else 1,
        },
        [window.profileName] = { TextTransparency = if shown then nameTransparency else 1 },
        [window.profileSubtitle] = { TextTransparency = if shown then subtitleTransparency else 1 },
    }

    for instance, properties in targets do
        if tweenInfo then
            variables.tweenService:Create(instance, tweenInfo, properties):Play()
        else
            for property, value in properties do
                instance[property] = value
            end
        end
    end
end

function sidebar.setProfileEnabled(window, enabled)
    if not window.profile then
        window.settings.showProfile = enabled
        return
    end

    if enabled then
        window.settings.showProfile = true
        sidebar.reflowProfile(window)
        sidebar.setProfileShown(window, true, settleInfo)
        return
    end

    sidebar.setProfileShown(window, false, settleInfo)
    task.delay(settleInfo.Time, function()
        if window.unloaded or window.settings.showProfile then
            return
        end
        sidebar.reflowProfile(window)
    end)
    window.settings.showProfile = false
end

function sidebar.setSubtitle(window, text)
    if not window.profileSubtitle then
        return
    end

    local resolved = if type(text) == "string" and text ~= "" then locale.resolve(text) else nil
    window.profileSubtitle.Text = resolved or ""
    window.profileSubtitle.Visible = resolved ~= nil
end

return sidebar
end

Components.slider = { Name = "slider", Parent = Components }
Components.slider.FindFirstChild = function(self, k) return self[k] end
Components.slider.__loader = function(script, require)
local Slider = {}
Slider.__index = Slider
Slider.__type = "Slider"

local utility = script.Parent.Parent.utility

local variables = require(utility.variables)
local functions = require(utility.functions)
local odometer = require(utility.odometer)
local moveable = require(utility.moveable)
local lockable = require(utility.lockable)
local locale = require(utility.locale)
local hapticEngine = require(utility.HapticEngine)

local function decimalsOf(step)
    local decimals = 0
    while decimals < 6 do
        local scaled = step * 10 ^ decimals
        if math.abs(scaled - math.round(scaled)) < 1e-9 then
            break
        end
        decimals += 1
    end
    return decimals
end

local function snapTo(range, increment, value)
    local snapped = range[1] + math.round((value - range[1]) / increment) * increment
    return math.clamp(snapped, range[1], range[2])
end

local tweenInfo = TweenInfo.new(0.45, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)
local heldInfo = TweenInfo.new(0.3, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)
local followInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)

local narrowWidth = 300

local handleRest = Vector2.new(35, 20)
local handleHeld = Vector2.new(41, 22)

local function fillSize(ratio: number): UDim2
    return UDim2.new(ratio, 0, 1, 0)
end

local function handleOffset(): UDim2
    return UDim2.new(1, 0, 0.5, 0)
end

local function ratioFromPointer(x: number, left: number, travel: number): number
    return math.clamp((x - left) / travel, 0, 1)
end

function Slider.new(tab, properties)
    properties = if typeof(properties) == "table" then properties else {}

    local self = setmetatable({
        tab = assert(tab, "Missing argument #1 (Tab expected)"),
        window = tab.window,
        name = properties.name or properties.Name or "Slider",
        icon = properties.icon or properties.Icon,
        description = properties.description or properties.Description,
        forgetState = properties.forgetState or properties.ForgetState or tab.forgetState,

        range = properties.range or properties.Range or { 0, 100 },
        increment = properties.increment or properties.Increment or 1,
        suffix = properties.suffix or properties.Suffix or "",

        callback = properties.callback or properties.Callback or function() end,

        dragging = false,
        minimal = properties.minimal or properties.Minimal or false,

        _handleWidth = handleRest.X,
    }, Slider)

    assert(
        typeof(self.range) == "table" and typeof(self.range[1]) == "number" and typeof(self.range[2]) == "number",
        "A slider range needs two numbers, like { 0, 100 }."
    )

    if self.range[1] > self.range[2] then
        self.range = { self.range[2], self.range[1] }
    end
    if self.increment <= 0 then
        self.increment = 1
    end

    self.value = if (properties.value or properties.Value) ~= nil
        then (properties.value or properties.Value)
        elseif (properties.currentValue or properties.CurrentValue) ~= nil then (
            properties.currentValue or properties.CurrentValue
        )
        else self.range[1]

    self.value = snapTo(self.range, self.increment, self.value)

    self._decimals = decimalsOf(self.increment)

    self.flag = properties.flag
        or properties.Flag
        or (not self.forgetState and functions.deriveFlagFromName(self.name) or nil)
    self.window:_registerControl(self)

    self.main = self.window:Create("Frame", {
        Size = UDim2.new(1, -20, 0, 65),
        BorderSizePixel = 0,
        Name = self.name,
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),

        BackgroundTransparency = 1,

        Parent = self.tab.tabPage,
    }, { BackgroundTransparency = "ElementTransparency" })

    self.stroke = self.window:StyleElementBody(self.main)
    self._lastValue = self.value

    if not self.minimal then
        self:_buildLabel()
    end

    self.track = self.window:Create("Frame", {
        AnchorPoint = Vector2.new(1, 0.5),
        Position = UDim2.new(1, -15, 0.5, 0),
        Size = UDim2.fromOffset(222, 14),
        BorderSizePixel = 0,
        BackgroundTransparency = 1,

        Parent = self.main,
    }, { BackgroundColor3 = "SliderBackground" })

    self.window:Create("UICorner", {
        CornerRadius = UDim.new(0, 13),

        Parent = self.track,
    })

    self.progress = self.window:Create("Frame", {
        AnchorPoint = Vector2.new(0, 0.5),
        Position = UDim2.fromScale(0, 0.5),
        Size = UDim2.fromScale(0, 1),
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BorderSizePixel = 0,
        ZIndex = 2,
        BackgroundTransparency = 1,

        Parent = self.track,
    })

    self.window:Create("UICorner", {
        CornerRadius = UDim.new(0, 13),

        Parent = self.progress,
    })

    self.window:Create("UIGradient", {
        Offset = Vector2.new(0, 0.5),
        Rotation = 2,
        Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 0.85),
            NumberSequenceKeypoint.new(1, 0),
        }),

        Parent = self.progress,
    }, { Color = { "SliderProgress", functions.toColorSequence } })

    self.progressGlow = self.window:CreateGlow(self.progress, "AccentColor", 20, 1)

    self.handle = self.window:Create("Frame", {
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = handleOffset(),
        Size = UDim2.fromOffset(handleRest.X, handleRest.Y),
        BorderSizePixel = 0,
        ZIndex = 50,
        BackgroundTransparency = 1,

        Parent = self.progress,
    }, { BackgroundColor3 = "SliderHandle" })

    self.window:Create("UICorner", {
        CornerRadius = UDim.new(1, 0),

        Parent = self.handle,
    })

    self.handleGlow = self.window:CreateGlow(self.handle, Color3.fromRGB(255, 255, 255), 10, 1)

    self.handleStroke = self.window:Create("UIStroke", {
        Transparency = 1,

        Parent = self.handle,
    }, { Color = "SliderStroke" })

    self.interact = self.window:Create("TextButton", {
        BackgroundTransparency = 1,
        Size = UDim2.fromScale(1, 1),
        Text = "",
        TextTransparency = 1,
        ZIndex = 10,

        Parent = self.track,
    })

    self.window:ConnectFor(self, self.main.MouseEnter, function()
        if not self.window:_interactive() then
            return
        end
        variables.tweenService
            :Create(self.track, tweenInfo, { BackgroundColor3 = self.window.theme.SliderBackgroundHover })
            :Play()
    end)

    self.window:ConnectFor(self, self.main.MouseLeave, function()
        variables.tweenService
            :Create(self.track, tweenInfo, { BackgroundColor3 = self.window.theme.SliderBackground })
            :Play()
    end)

    self.window:ConnectFor(self, self.interact.InputBegan, function(input)
        if
            input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch
        then
            hapticEngine.click()
            self.dragging = true
            self:_setHeld(true)
            self:_updateFromMouse()

            if self._dragConnection then
                self._dragConnection:Disconnect()
                self._dragConnection = nil
            end

            self._dragConnection = variables.runService.RenderStepped:Connect(function()
                if self.window.unloaded or not self.dragging then
                    if self._dragConnection then
                        self._dragConnection:Disconnect()
                        self._dragConnection = nil
                    end
                    return
                end
                self:_updateFromMouse()
            end)
        end
    end)

    self.window:ConnectFor(self, variables.userInputService.InputEnded, function(input)
        if
            input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch
        then
            self:_endDrag()
        end
    end)

    self.window:ConnectFor(self, variables.userInputService.WindowFocusReleased, function()
        self:_endDrag()
    end)

    if self.description and not self.minimal then
        self.descriptor = require(script.Parent.descriptor).new(self.tab, { description = self.description })
    end

    self.window:ConnectFor(self, self.main:GetPropertyChangedSignal("AbsoluteSize"), function()

        if self.window.animating or (self.window.hidden and self.window.hasShownOnce) then
            return
        end
        self:_applyLayout()
    end)
    self:_applyLayout()

    if self.minimal then

        self.main.Size = UDim2.new(1, -20, 0, 41)
        self.track.AnchorPoint = Vector2.new(0.5, 0.5)
        self.track.Position = UDim2.new(0.5, 0, 0.5, 0)
        self.track.Size = UDim2.new(1, -30, 0, 14)
    end

    self:_renderProgress()

    return self
end

function Slider:_buildLabel()

    self.container = self.window:Create("Frame", {
        AnchorPoint = Vector2.new(0, 0.5),
        Position = UDim2.new(0, 20, 0.5, 0),
        Size = UDim2.fromOffset(170, 33),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ZIndex = 5,

        Parent = self.main,
    })

    self.containerLayout = self.window:Create("UIListLayout", {
        Padding = UDim.new(0, 2),
        VerticalAlignment = Enum.VerticalAlignment.Center,
        SortOrder = Enum.SortOrder.LayoutOrder,

        Parent = self.container,
    })

    self.titleContainer = self.window:Create("Frame", {
        Size = UDim2.new(1, 0, 0, 16),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ZIndex = 5,

        Parent = self.container,
    })

    self.window:Create("UIListLayout", {
        Padding = UDim.new(0, 5),
        FillDirection = Enum.FillDirection.Horizontal,
        VerticalAlignment = Enum.VerticalAlignment.Center,
        SortOrder = Enum.SortOrder.LayoutOrder,

        Parent = self.titleContainer,
    })

    self.titleFlex = self.window:Create("UIFlexItem", {
        FlexMode = Enum.UIFlexMode.None,
        Parent = self.titleContainer,
    })

    if self.icon then
        self.iconLabel = self.window:Create("ImageLabel", {
            Image = self.icon,
            Size = UDim2.fromOffset(16, 16),
            BorderSizePixel = 0,
            BackgroundTransparency = 1,
            ZIndex = 5,

            ImageTransparency = 1,

            Parent = self.titleContainer,
        }, { ImageColor3 = "ContentColor" })
    end

    self.title = self.window:Create("TextLabel", {
        Text = locale.t(self.name),
        Size = UDim2.new(1, 0, 0, 16),
        BorderSizePixel = 0,
        BackgroundTransparency = 1,
        TextSize = 16,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextTruncate = Enum.TextTruncate.AtEnd,
        RichText = true,
        LayoutOrder = 1,
        ZIndex = 5,

        TextTransparency = 1,

        Parent = self.titleContainer,
    }, { TextColor3 = "ContentColor", FontFace = "Font" })

    self.window:Create("UIFlexItem", {
        FlexMode = Enum.UIFlexMode.Shrink,
        Parent = self.title,
    })

    self.valueHost = self.window:Create("Frame", {
        Size = UDim2.new(1, 0, 0, 16),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ZIndex = 6,
        LayoutOrder = 1,

        Parent = self.container,
    })

    self.valueOdo = odometer.new(self.window, self.valueHost, {
        textSize = 15,
        alignment = Enum.HorizontalAlignment.Left,
        transparency = 1,
        duration = 0.28,
    })
    self.valueOdo:snap(self:_format(self.value))
end

function Slider:_setMainHeight(height)
    if self._widthManaged then
        self.main.Size = UDim2.new(self.main.Size.X.Scale, self.main.Size.X.Offset, 0, height)
    else
        self.main.Size = UDim2.new(1, -20, 0, height)
    end
end

function Slider:_applyLayout()
    if self.minimal then
        return
    end
    local width = self.main.AbsoluteSize.X
    local mode = if width > 0 and width < narrowWidth then "narrow" else "wide"
    if self._layoutMode == mode then
        return
    end
    self._layoutMode = mode

    if mode == "narrow" then
        self:_setMainHeight(70)

        self.container.AnchorPoint = Vector2.new(0, 0)
        self.container.Position = UDim2.new(0, 20, 0, 14)
        self.container.Size = UDim2.new(1, -40, 0, 16)
        self.containerLayout.FillDirection = Enum.FillDirection.Horizontal
        self.titleFlex.FlexMode = Enum.UIFlexMode.Fill
        self.valueHost.AutomaticSize = Enum.AutomaticSize.X
        self.valueHost.Size = UDim2.new(0, 0, 0, 16)

        self.track.AnchorPoint = Vector2.new(0.5, 1)
        self.track.Position = UDim2.new(0.5, 0, 1, -14)
        self.track.Size = UDim2.new(1, -30, 0, 14)
    else
        self:_setMainHeight(65)

        self.container.AnchorPoint = Vector2.new(0, 0.5)
        self.container.Position = UDim2.new(0, 20, 0.5, 0)
        self.container.Size = UDim2.new(0, 170, 0, 33)
        self.containerLayout.FillDirection = Enum.FillDirection.Vertical
        self.titleFlex.FlexMode = Enum.UIFlexMode.None
        self.valueHost.AutomaticSize = Enum.AutomaticSize.None
        self.valueHost.Size = UDim2.new(1, 0, 0, 16)

        self.track.AnchorPoint = Vector2.new(1, 0.5)
        self.track.Position = UDim2.new(1, -15, 0.5, 0)
        self.track.Size = UDim2.new(0, 222, 0, 14)
    end
end

function Slider:_format(value)
    local text = string.format("%." .. self._decimals .. "f", value)
    if self.suffix ~= "" then
        return text .. " " .. self.suffix
    end
    return text
end

function Slider:_pillTravel()
    return math.max(self.track.AbsoluteSize.X, 0)
end

function Slider:_renderProgress(info)
    local span = self.range[2] - self.range[1]
    local ratio = if span ~= 0 then math.clamp((self.value - self.range[1]) / span, 0, 1) else 0

    local size = fillSize(ratio)
    if info then
        variables.tweenService:Create(self.progress, info, { Size = size }):Play()
    else
        self.progress.Size = size
    end
end

function Slider:_updateFromMouse()
    local travel = self:_pillTravel()
    if travel <= 0 then
        return
    end

    local ratio =
        ratioFromPointer(variables.userInputService:GetMouseLocation().X, self.track.AbsolutePosition.X, travel)
    local value = snapTo(self.range, self.increment, self.range[1] + ratio * (self.range[2] - self.range[1]))

    if value ~= self.value then
        self.value = value
        if self.valueOdo then
            self.valueOdo:snap(self:_format(value))
        end
        self._lastValue = value
        self:_renderProgress(followInfo)
        self:_fireCallback(value)
    end
end

function Slider:_endDrag()
    if not self.dragging then
        return
    end
    self.dragging = false
    self:_setHeld(false)

    if self._dragConnection then
        self._dragConnection:Disconnect()
        self._dragConnection = nil
    end

    self.window:_persist(self)
end

function Slider:_setHeld(held)

    if not held then
        self:_fireCallback(self.value)
    end

    local target = if held then handleHeld else handleRest
    self._handleWidth = target.X

    variables.tweenService
        :Create(self.handle, heldInfo, {
            Size = UDim2.fromOffset(target.X, target.Y),
            BackgroundTransparency = if held then 0.7 else 0,
        })
        :Play()
    variables.tweenService:Create(self.handleStroke, heldInfo, { Transparency = if held then 0.6 else 1 }):Play()
    self:_renderProgress(heldInfo)
end

function Slider:_fireCallback(value)
    self.window:_runGuarded(self, self.callback, value, self.dragging == true)
end

function Slider:Set(value, skipCallback)
    value = snapTo(self.range, self.increment, value)
    self.value = value
    if self.valueOdo then
        self.valueOdo:to(self:_format(value), value >= (self._lastValue or value))
    end
    self._lastValue = value
    self:_renderProgress(tweenInfo)

    if not skipCallback then
        self:_fireCallback(value)
        self.window:_persist(self)
    end
end

local sliderGlowReveal = TweenInfo.new(0.4, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out, 0, false, 0.35)

function Slider:_setShown(shown, animate)
    local w = self.window
    if shown then
        w:_revealCommon(self, animate)
        w:_reveal(self.track, { BackgroundTransparency = 0 }, animate)
        w:_reveal(self.progress, { BackgroundTransparency = 0 }, animate)
        w:_reveal(self.handle, { BackgroundTransparency = 0 }, animate)
        if self.valueOdo then
            self.valueOdo:reveal(0.3, animate)
        end

        w:_reveal(self.progressGlow, { Transparency = math.max(0.55, w.theme.AccentGlow) }, animate, sliderGlowReveal)
        w:_reveal(self.handleGlow, { Transparency = 0.8 }, animate, sliderGlowReveal)
    else
        w:_hideCommon(self, animate)
        w:_reveal(self.track, { BackgroundTransparency = 1 }, animate)
        w:_reveal(self.progress, { BackgroundTransparency = 1 }, animate)
        w:_reveal(self.handle, { BackgroundTransparency = 1 }, animate)
        if self.valueOdo then
            self.valueOdo:reveal(1, animate)
        end
        w:_reveal(self.progressGlow, { Transparency = 1 }, animate, sliderGlowReveal)
        w:_reveal(self.handleGlow, { Transparency = 1 }, animate, sliderGlowReveal)
    end
end

function Slider:_refreshTheme()
    variables.tweenService
        :Create(
            self.progressGlow,
            TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
            { Transparency = math.max(0.55, self.window.theme.AccentGlow) }
        )
        :Play()
end

function Slider:_minWidth()
    if self.minimal then
        return 100
    end
    local w = 40
    if self.icon then
        w += 22
    end

    w += functions.textWidth(self.window.theme.Font, 16, locale.resolve(self.name))
    w += 12
    w += functions.textWidth(self.window.theme.Font, 15, self:_format(self.value))
    return math.max(w, 160)
end

moveable(Slider)
lockable(Slider)

return Slider
end

Components.stat = { Name = "stat", Parent = Components }
Components.stat.FindFirstChild = function(self, k) return self[k] end
Components.stat.__loader = function(script, require)
local Statistic = {}
Statistic.__index = Statistic
Statistic.__type = "Statistic"

local utility = script.Parent.Parent.utility

local variables = require(utility.variables)
local functions = require(utility.functions)
local odometer = require(utility.odometer)
local moveable = require(utility.moveable)
local constants = require(utility.constants)
local locale = require(utility.locale)
local log = require(utility.log)

local accents = constants.statAccents

local accentTransparency = NumberSequence.new({
    NumberSequenceKeypoint.new(0, 0.85),
    NumberSequenceKeypoint.new(1, 0),
})

local compactHeight = 41

local accentTweenInfo = TweenInfo.new(0.6, Enum.EasingStyle.Exponential)

local function glowColor(accent)
    return accent.fill.Keypoints[1].Value
end

local function formatPct(pct)
    if pct > 0 then
        return string.format("+%.1f%%", pct)
    elseif pct < 0 then
        return string.format("%.1f%%", pct)
    else
        return "0%"
    end
end

local function formatValue(value)
    if typeof(value) ~= "number" then
        return tostring(value)
    end

    local rounded = math.round(math.abs(value))
    local s = string.format("%.0f", rounded)
    local result = s:reverse():gsub("%d%d%d", "%0,"):reverse()
    if result:sub(1, 1) == "," then
        result = result:sub(2)
    end

    return if value < 0 and rounded ~= 0 then "-" .. result else result
end

local function formatChange(delta)

    local rounded = math.round(delta)
    if rounded > 0 then
        return "+" .. formatValue(rounded)
    elseif rounded < 0 then
        return formatValue(rounded)
    else
        return "0"
    end
end

function Statistic.new(tab, properties)
    properties = if typeof(properties) == "table" then properties else {}

    local self = setmetatable({
        tab = assert(tab, "Missing argument #1 (Tab expected)"),
        window = tab.window,
        name = properties.name or properties.Name or "Statistic",
        icon = properties.icon or properties.Icon,
        description = properties.description or properties.Description,

        value = if (properties.value or properties.Value) ~= nil then (properties.value or properties.Value) else 0,

        _hasValue = (properties.value or properties.Value) ~= nil,

        numberEasing = if (properties.numberEasing ~= nil)
            then properties.numberEasing
            elseif properties.NumberEasing ~= nil then properties.NumberEasing
            else true,

        changeMode = properties.changeMode or properties.ChangeMode or "percentage",
        changeBaseline = properties.changeBaseline or properties.ChangeBaseline or "previous",

        prefix = properties.prefix or properties.Prefix or "",
        suffix = properties.suffix or properties.Suffix or "",

        compact = properties.compact or properties.Compact or tab.compact or false,
        display = (properties.display or properties.Display or "value"),

        _initialValue = if (properties.value or properties.Value) ~= nil
            then (properties.value or properties.Value)
            else nil,
        _lastChange = 0,
    }, Statistic)

    if self.compact then
        self:_buildCompact()
    else
        self:_buildFull()
    end

    if self.description then
        if self.compact then
            log.warn(`Rayfield: a compact stat has no room for a description, ignoring it on '{self.name}'.`)
        else
            self.descriptor = require(script.Parent.descriptor).new(self.tab, { description = self.description })
        end
    end

    return self
end

function Statistic:_buildFull()
    local window = self.window

    self.main = window:Create("Frame", {
        Size = UDim2.new(1, -20, 0, 90),
        BorderSizePixel = 0,
        Name = self.name,
        ZIndex = 5,

        BackgroundTransparency = 1,

        Parent = self.tab.tabPage,
    }, { BackgroundColor3 = "StatBackground", BackgroundTransparency = "ElementTransparency" })

    window:Create("UICorner", {
        Parent = self.main,
    }, { CornerRadius = "ElementCornerRadius" })

    self.stroke = window:Create("UIStroke", {
        Transparency = 1,
        Color = Color3.fromRGB(255, 255, 255),

        Parent = self.main,
    }, { Transparency = "ElementStrokeTransparency" })

    self.strokeGradient = window:Create("UIGradient", {
        Rotation = 2,
        Offset = Vector2.new(0, 0.5),
        Color = accents.neutral.stroke,
        Transparency = accentTransparency,

        Parent = self.stroke,
    })

    self.titleContainer = window:Create("Frame", {
        Size = UDim2.new(1, -40, 0, 32),
        Position = UDim2.fromOffset(20, 15),
        BorderSizePixel = 0,
        LayoutOrder = -1,
        BackgroundTransparency = 1,
        ZIndex = 5,

        Parent = self.main,
    })

    self.gradientContainer = window:Create("Frame", {
        Size = UDim2.fromScale(1, 1),
        Position = UDim2.fromOffset(0, 0),
        BorderSizePixel = 0,
        BackgroundTransparency = 1,
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        ZIndex = 5,

        Parent = self.main,
    })

    self.glow = window:CreateGlow(self.main, glowColor(accents.neutral), 13, 1)

    self.title = window:Create("TextLabel", {
        Text = locale.t(self.name),

        Size = UDim2.fromOffset(300, 19),
        BorderSizePixel = 0,
        BackgroundTransparency = 1,
        TextSize = 19,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextWrapped = true,
        LayoutOrder = 1,
        ZIndex = 10,

        TextTransparency = 1,

        Parent = self.titleContainer,
    }, { TextColor3 = "ContentColor", FontFace = "TitleFont" })

    self.mainGradient = window:Create("UIGradient", {
        Rotation = 2,
        Offset = Vector2.new(0, 0.5),
        Color = accents.neutral.fill,
        Transparency = accentTransparency,

        Parent = self.gradientContainer,
    })

    window:Create("UICorner", {
        Parent = self.gradientContainer,
    }, { CornerRadius = "ElementCornerRadius" })

    if self.icon then
        self.iconLabel = window:Create("ImageLabel", {
            Image = self.icon,
            Size = UDim2.fromOffset(32, 32),
            BorderSizePixel = 0,
            BackgroundTransparency = 1,
            ZIndex = 10,

            ImageTransparency = 1,

            Parent = self.titleContainer,
        }, { ImageColor3 = "ContentColor" })
    end

    self.containerLayout = window:Create("UIListLayout", {
        Padding = UDim.new(0, 8),
        FillDirection = Enum.FillDirection.Horizontal,
        VerticalAlignment = Enum.VerticalAlignment.Center,
        HorizontalAlignment = Enum.HorizontalAlignment.Left,
        SortOrder = Enum.SortOrder.LayoutOrder,

        Parent = self.titleContainer,
    })

    self.valueHost = window:Create("Frame", {
        AnchorPoint = Vector2.new(0, 1),
        Position = UDim2.new(0, 20, 1, -15),
        Size = UDim2.fromOffset(200, 20),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ZIndex = 10,

        Parent = self.main,
    })

    self.changeHost = window:Create("Frame", {
        AnchorPoint = Vector2.new(1, 1),
        Position = UDim2.new(1, -20, 1, -15),
        Size = UDim2.fromOffset(200, 15),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ZIndex = 10,

        Parent = self.main,
    })

    self.valueOdo = odometer.new(window, self.valueHost, {
        textSize = 20,
        alignment = Enum.HorizontalAlignment.Left,
        transparency = 1,
    })
    self.valueOdo:snap(self:_formatValue(self.value))

    self.changeOdo = odometer.new(window, self.changeHost, {
        textSize = 15,
        alignment = Enum.HorizontalAlignment.Right,
        transparency = 1,
    })
    self.changeOdo:snap(self:_formatChange(0))

    self._accentGradients = { self.strokeGradient, self.mainGradient }
end

function Statistic:_buildCompact()
    local window = self.window

    local inRow = self.tab.compact or false

    self.main = window:Create("Frame", {
        Name = self.name,
        Size = if inRow then UDim2.fromOffset(0, compactHeight) else UDim2.new(1, -20, 0, compactHeight),
        AutomaticSize = if inRow then Enum.AutomaticSize.X else Enum.AutomaticSize.None,
        ClipsDescendants = true,
        BorderSizePixel = 0,
        ZIndex = 5,

        BackgroundTransparency = 1,

        Parent = self.tab.tabPage,
    }, { BackgroundColor3 = "StatBackground", BackgroundTransparency = "ElementTransparency" })

    window:Create("UICorner", {
        Parent = self.main,
    }, { CornerRadius = "ElementCornerRadius" })

    self.stroke = window:Create("UIStroke", {
        Transparency = 1,
        Color = Color3.fromRGB(255, 255, 255),

        Parent = self.main,
    }, { Transparency = "ElementStrokeTransparency" })

    self.strokeGradient = window:Create("UIGradient", {
        Rotation = 2,
        Offset = Vector2.new(0, 0.5),
        Color = accents.neutral.stroke,
        Transparency = accentTransparency,

        Parent = self.stroke,
    })

    if inRow then
        window:Create("UIFlexItem", {
            FlexMode = Enum.UIFlexMode.Fill,
            Parent = self.main,
        })
    end

    window:Create("UIListLayout", {
        FillDirection = Enum.FillDirection.Horizontal,
        VerticalAlignment = Enum.VerticalAlignment.Center,
        HorizontalFlex = Enum.UIFlexAlignment.Fill,

        Parent = self.main,
    })

    self.card = window:Create("Frame", {
        AutomaticSize = Enum.AutomaticSize.X,
        Size = UDim2.fromOffset(0, compactHeight),
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BorderSizePixel = 0,
        ZIndex = 5,

        BackgroundTransparency = 1,

        Parent = self.main,
    })

    window:Create("UICorner", {
        Parent = self.card,
    }, { CornerRadius = "ElementCornerRadius" })

    self.mainGradient = window:Create("UIGradient", {
        Rotation = 2,
        Offset = Vector2.new(0, 0.5),
        Color = accents.neutral.fill,
        Transparency = accentTransparency,

        Parent = self.card,
    })

    window:Create("UIPadding", {
        PaddingLeft = UDim.new(0, 15),
        PaddingRight = UDim.new(0, 15),

        Parent = self.card,
    })

    window:Create("UIListLayout", {
        FillDirection = Enum.FillDirection.Horizontal,
        VerticalAlignment = Enum.VerticalAlignment.Center,
        HorizontalFlex = Enum.UIFlexAlignment.SpaceBetween,
        Padding = UDim.new(0, 10),

        Parent = self.card,
    })

    self.titleContainer = window:Create("Frame", {
        AutomaticSize = Enum.AutomaticSize.X,
        Size = UDim2.fromOffset(0, 16),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        LayoutOrder = 0,
        ZIndex = 6,

        Parent = self.card,
    })

    window:Create("UIFlexItem", {
        FlexMode = Enum.UIFlexMode.Shrink,
        Parent = self.titleContainer,
    })

    window:Create("UIListLayout", {
        Padding = UDim.new(0, 6),
        FillDirection = Enum.FillDirection.Horizontal,
        VerticalAlignment = Enum.VerticalAlignment.Center,
        HorizontalAlignment = Enum.HorizontalAlignment.Left,
        SortOrder = Enum.SortOrder.LayoutOrder,

        Parent = self.titleContainer,
    })

    if self.icon then
        self.iconLabel = window:Create("ImageLabel", {
            Image = self.icon,
            Size = UDim2.fromOffset(20, 20),
            BorderSizePixel = 0,
            BackgroundTransparency = 1,
            LayoutOrder = 0,
            ZIndex = 6,

            ImageTransparency = 1,

            Parent = self.titleContainer,
        }, { ImageColor3 = "ContentColor" })
    end

    self.title = window:Create("TextLabel", {
        Text = locale.t(self.name),
        Size = UDim2.fromOffset(0, 16),
        AutomaticSize = Enum.AutomaticSize.X,
        BorderSizePixel = 0,
        BackgroundTransparency = 1,
        TextSize = 16,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextTruncate = Enum.TextTruncate.AtEnd,
        LayoutOrder = 1,
        ZIndex = 6,

        TextTransparency = 1,

        Parent = self.titleContainer,
    }, { TextColor3 = "ContentColor", FontFace = "Font" })

    window:Create("UIFlexItem", {
        FlexMode = Enum.UIFlexMode.Shrink,
        Parent = self.title,
    })

    self.readoutHost = window:Create("Frame", {
        AutomaticSize = Enum.AutomaticSize.X,
        Size = UDim2.fromOffset(0, 18),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        LayoutOrder = 1,
        ZIndex = 6,

        Parent = self.card,
    })

    self.readoutOdo = odometer.new(window, self.readoutHost, {
        textSize = 17,
        alignment = Enum.HorizontalAlignment.Right,
        transparency = 1,
    })
    self.readoutOdo:snap(self.display == "change" and self:_formatChange(0) or self:_formatValue(self.value))

    self._accentGradients = { self.strokeGradient, self.mainGradient }
end

function Statistic:_setAccent(key, direction)
    local accent = accents[key]
    self.strokeGradient.Color = accent.stroke
    self.mainGradient.Color = accent.fill
    if self.glow then
        self.glow.Color = glowColor(accent)
    end

    local rotation = if direction == 1 then 14 elseif direction == -1 then -10 else 2
    local offset = if direction == 1
        then Vector2.new(0.04, 0.5)
        elseif direction == -1 then Vector2.new(-0.04, 0.5)
        else Vector2.new(0, 0.5)
    for _, gradient in self._accentGradients do
        variables.tweenService:Create(gradient, accentTweenInfo, { Rotation = rotation, Offset = offset }):Play()
    end
end

function Statistic:_formatValue(value)
    return self.prefix .. formatValue(value) .. self.suffix
end

function Statistic:_formatChange(delta)
    if self.changeMode == "absolute" then
        return formatChange(delta)
    else
        return formatPct(delta)
    end
end

function Statistic:_showValue(odo, value, previousValue, hasNoHistory)
    if self.numberEasing and not hasNoHistory then
        odo:to(self:_formatValue(value), value >= previousValue)
    else
        odo:snap(self:_formatValue(value))
    end
end

function Statistic:_updateFullReadouts(value, previousValue, targetChange, noChange, infinityText, hasNoHistory)
    self:_showValue(self.valueOdo, value, previousValue, hasNoHistory)

    if infinityText then
        self.changeOdo:snap(infinityText)
        self._lastChange = 0
    elseif self.numberEasing and not noChange then
        self.changeOdo:to(self:_formatChange(targetChange), targetChange >= self._lastChange)
        self._lastChange = targetChange
    else
        self.changeOdo:snap(self:_formatChange(targetChange or 0))
        self._lastChange = targetChange or 0
    end
end

function Statistic:_updateCompactReadout(value, previousValue, targetChange, noChange, infinityText, hasNoHistory)
    if self.display == "change" then
        if infinityText then
            self.readoutOdo:snap(infinityText)
            self._lastChange = 0
        elseif self.numberEasing and not noChange then
            self.readoutOdo:to(self:_formatChange(targetChange), targetChange >= self._lastChange)
            self._lastChange = targetChange
        else
            self.readoutOdo:snap(self:_formatChange(targetChange or 0))
            self._lastChange = targetChange or 0
        end
    else
        self:_showValue(self.readoutOdo, value, previousValue, hasNoHistory)
    end
end

function Statistic:Set(value)
    assert(typeof(value) == "number", "Statistic:Set() - value must be a number, got " .. typeof(value))

    local previousValue = self.value
    local hasNoHistory = not self._hasValue
    self.value = value
    self._hasValue = true

    if hasNoHistory then
        self._initialValue = value
    end

    local refValue = if self.changeBaseline == "initial" then self._initialValue else previousValue
    local noChange = hasNoHistory or refValue == value

    local targetChange, infinityText, accentKey, direction
    if noChange then
        targetChange = 0
        accentKey = "neutral"
        direction = 0
    elseif refValue == 0 then
        local sign = if value > 0 then "+" else "-"
        local suffix = if self.changeMode == "percentage" then "∞%" else "∞"
        infinityText = sign .. suffix
        accentKey = if value > 0 then "positive" else "negative"
        direction = if value > 0 then 1 else -1
    elseif self.changeMode == "percentage" then
        targetChange = ((value - refValue) / math.abs(refValue)) * 100
        direction = if targetChange > 0 then 1 elseif targetChange < 0 then -1 else 0
        accentKey = if direction == 1 then "positive" elseif direction == -1 then "negative" else "neutral"
    else
        targetChange = value - refValue
        direction = if targetChange > 0 then 1 elseif targetChange < 0 then -1 else 0
        accentKey = if direction == 1 then "positive" elseif direction == -1 then "negative" else "neutral"
    end

    self:_setAccent(accentKey, direction)

    if self.compact then
        self:_updateCompactReadout(value, previousValue, targetChange, noChange, infinityText, hasNoHistory)
    else
        self:_updateFullReadouts(value, previousValue, targetChange, noChange, infinityText, hasNoHistory)
    end
end

function Statistic:ResetBaseline(newBaseline)
    local previousValue = self.value
    local hasNoHistory = not self._hasValue
    local baseline = if typeof(newBaseline) == "number" then newBaseline else self.value
    self._initialValue = baseline
    self.value = baseline
    self._hasValue = true
    self._lastChange = 0

    if self.compact then
        if self.display == "change" then
            self.readoutOdo:snap(self:_formatChange(0))
        else
            self:_showValue(self.readoutOdo, baseline, previousValue, hasNoHistory)
        end
    else
        self.changeOdo:snap(self:_formatChange(0))
        self:_showValue(self.valueOdo, baseline, previousValue, hasNoHistory)
    end

    self:_setAccent("neutral", 0)
end

function Statistic:_setShown(shown, animate)
    local w = self.window

    if self.compact then
        w:_reveal(
            self.main,
            { BackgroundTransparency = if shown then (self.window.theme.ElementTransparency or 0) else 1 },
            animate
        )
        w:_reveal(
            self.stroke,
            { Transparency = if shown then self.window.theme.ElementStrokeTransparency else 1 },
            animate
        )
        w:_reveal(self.card, { BackgroundTransparency = if shown then 0 else 1 }, animate)
        w:_reveal(self.title, { TextTransparency = if shown then 0 else 1 }, animate)
        if self.iconLabel then
            w:_reveal(self.iconLabel, { ImageTransparency = if shown then 0 else 1 }, animate)
        end
        self.readoutOdo:reveal(if shown then 0 else 1, animate)
        return
    end

    if shown then
        w:_revealCommon(self, animate)
        w:_reveal(self.gradientContainer, { BackgroundTransparency = 0 }, animate)
        w:_reveal(self.glow, { Transparency = 0.82 }, animate)
        self.valueOdo:reveal(0, animate)
        self.changeOdo:reveal(0, animate)
    else
        w:_hideCommon(self, animate)
        w:_reveal(self.gradientContainer, { BackgroundTransparency = 1 }, animate)
        w:_reveal(self.glow, { Transparency = 1 }, animate)
        self.valueOdo:reveal(1, animate)
        self.changeOdo:reveal(1, animate)
    end
end

function Statistic:_minWidth()
    local w = 30 + 10
    if self.icon then
        w += 26
    end

    w += functions.textWidth(self.window.theme.Font, 16, locale.resolve(self.name))
    local readout = if self.display == "change" then self:_formatChange(0) else self:_formatValue(self.value)
    w += functions.textWidth(self.window.theme.Font, 17, readout)
    return w
end

moveable(Statistic)

return Statistic
end

Components.tab = { Name = "tab", Parent = Components }
Components.tab.FindFirstChild = function(self, k) return self[k] end
Components.tab.__loader = function(script, require)
local Tab = {}
Tab.__index = Tab
Tab.__type = "Tab"

local utility = script.Parent.Parent.utility

local variables = require(utility.variables)
local assignOrder = require(utility.ordering)
local hapticEngine = require(utility.HapticEngine)
local search = require(script.Parent.search)
local tabSelector = require(script.Parent.tabSelector)

local function teardownElements(window, elements)
    for _, element in elements do
        if element.__type == "Group" then
            teardownElements(window, element.elements)
        else
            window:_unregisterControl(element)
        end

        if element.connections then
            for _, connection in element.connections do
                window:Disconnect(connection)
            end
            element.connections = nil
        end

        if element._dragConnection then
            element._dragConnection:Disconnect()
            element._dragConnection = nil
        end

        if window._recordingKeybind == element then
            window._recordingKeybind = nil
        end
        if element._outsideClickConn then
            window:Disconnect(element._outsideClickConn)
            element._outsideClickConn = nil
        end
    end
end

local selectTweenInfo = TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
local hoverTweenInfo = TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)

function Tab.new(window, properties)
    properties = if typeof(properties) == "table" then properties else {}

    local self = setmetatable({
        window = assert(window, "Missing argument #1 (Window expected)"),
        name = properties.name or properties.Name,
        icon = properties.icon or properties.Icon,
        neglectSelector = properties.neglectSelector or properties.NeglectSelector or false,
        customOrder = properties.customOrder or properties.CustomOrder or 0,

        forgetState = properties.forgetState or properties.ForgetState or false,

        elements = {},
        connections = {},
    }, Tab)

    assert(self.name or self.icon, "A tab needs a name or an icon.")

    if not self.neglectSelector then
        tabSelector.build(self, self.window.layout)
    end

    self.tabPage = self.window:Create("ScrollingFrame", {
        Name = self.name,
        Size = UDim2.new(1, -20, 1, 0),
        Position = UDim2.new(0.5, 0, 0, 68),
        AnchorPoint = Vector2.new(0.5, 0.5),
        BorderSizePixel = 0,
        BackgroundTransparency = 1,
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        CanvasSize = UDim2.new(0, 0, 0, 0),
        ScrollBarThickness = 0,
        ScrollingDirection = Enum.ScrollingDirection.Y,

        LayoutOrder = self.customOrder or 0,

        Parent = self.window.elements,
    })

    self.tabPageLayout = self.window:Create("UIListLayout", {
        Padding = UDim.new(0, 7),
        FillDirection = Enum.FillDirection.Vertical,
        VerticalAlignment = Enum.VerticalAlignment.Top,
        HorizontalAlignment = Enum.HorizontalAlignment.Center,
        SortOrder = Enum.SortOrder.LayoutOrder,

        Parent = self.tabPage,
    })

    self.window:Create("UIPadding", {
        PaddingTop = UDim.new(0, 10),
        PaddingBottom = UDim.new(0, 33),

        Parent = self.tabPage,
    })

    if not self.neglectSelector then
        table.insert(
            self.connections,
            self.window:Connect(self.topbarItemInteract.MouseButton1Click, function()
                hapticEngine.click()
                self:Select()
            end)
        )

        table.insert(
            self.connections,
            self.window:Connect(self.topbarItemInteract.MouseEnter, function()
                if not self.window:_interactive() then
                    return
                end
                if self.window.selectedTab ~= self then
                    self:_applyVisual("hover", hoverTweenInfo)
                    self:_spinGradients()
                end
            end)
        )

        table.insert(
            self.connections,
            self.window:Connect(self.topbarItemInteract.MouseLeave, function()
                if self.window.selectedTab ~= self then
                    self:_applyVisual("unselected", hoverTweenInfo)
                end
            end)
        )
    end

    return self
end

function Tab:_applyVisual(stateName, tweenInfo)
    if self.neglectSelector or not self.topbarItem then
        return
    end

    local state = tabSelector.states[self.window.layout.mode][stateName]
    if not state then
        return
    end

    tabSelector.applyVisual(self, state, tweenInfo)
end

function Tab:_spinGradients()
    if self.neglectSelector then
        return
    end

    local spinInfo = TweenInfo.new(0.7, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
    for _, gradient in { self.topbarItemGradient, self.topbarItemStrokeGradient } do
        gradient.Rotation = 90 - 360
        variables.tweenService:Create(gradient, spinInfo, { Rotation = 90 }):Play()
    end
end

function Tab:Select(noAnimation)

    if self.window._searching then
        search.close(self.window, { showTabs = true, jumpTo = false })
    end

    self.window.selectedTab = self
    self.window:_jumpTo(self.tabPage)

    local skipAnimation = noAnimation or not self.window:_interactive()

    if not self.neglectSelector and not skipAnimation then
        self:_applyVisual("selected", selectTweenInfo)
    end

    for _, tab in self.window.tabs do
        if tab ~= self.window.selectedTab then
            tab:Deselect(skipAnimation)
        end
    end

    if self ~= self.window.rfSettings and self.window.settingsAction and not skipAnimation then
        variables.tweenService
            :Create(
                self.window.settingsAction.iconLabel,
                TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
                { ImageTransparency = 0.6 }
            )
            :Play()
    end
end

function Tab:Deselect(noAnimation)
    if not self.neglectSelector and not noAnimation then
        self:_applyVisual("unselected", selectTweenInfo)
    end
end

function Tab:_register(element)
    table.insert(self.elements, element)
    assignOrder(element, #self.elements * 10)
    self.window:_restoreLate(element)

    if not self.window.hidden then
        element:_setShown(true, true)
    end

    return element
end

function Tab:CreateButton(properties)
    return self:_register(require(script.Parent.button).new(self, properties))
end

function Tab:CreateToggle(properties)
    return self:_register(require(script.Parent.toggle).new(self, properties))
end

function Tab:CreateSwitch(properties)
    return self:CreateToggle(properties)
end

function Tab:CreateSection(properties)
    return self:_register(require(script.Parent.section).new(self, properties))
end

function Tab:CreateText(properties)
    return self:_register(require(script.Parent.text).new(self, properties))
end

function Tab:CreateDivider(properties)
    return self:_register(require(script.Parent.divider).new(self, properties))
end

function Tab:CreateProgress(properties)
    return self:_register(require(script.Parent.progress).new(self, properties))
end

function Tab:CreateConsole(properties)
    return self:_register(require(script.Parent.console).new(self, properties))
end

function Tab:CreateStat(properties)
    return self:_register(require(script.Parent.stat).new(self, properties))
end

function Tab:CreateSlider(properties)
    return self:_register(require(script.Parent.slider).new(self, properties))
end

function Tab:CreateDropdown(properties)
    return self:_register(require(script.Parent.dropdown).new(self, properties))
end

function Tab:CreateInput(properties)
    return self:_register(require(script.Parent.input).new(self, properties))
end

function Tab:CreateKeybind(properties)
    return self:_register(require(script.Parent.keybind).new(self, properties))
end

function Tab:CreateColorPicker(properties)
    return self:_register(require(script.Parent.colorpicker).new(self, properties))
end

function Tab:CreateGroup(properties)
    return self:_register(require(script.Parent.group).new(self, properties))
end

function Tab:_moveElement(element, targetIndex)
    local idx = table.find(self.elements, element)
    if not idx then
        return
    end
    table.remove(self.elements, idx)
    targetIndex = math.clamp(targetIndex, 1, #self.elements + 1)
    table.insert(self.elements, targetIndex, element)
    for i, el in self.elements do
        assignOrder(el, i * 10)
    end
end

function Tab:Remove()
    local window = self.window

    if window._searching then
        search.close(window, { showTabs = true, jumpTo = window.selectedTab and window.selectedTab.tabPage })
    end

    local idx = table.find(window.tabs, self)
    if idx then
        table.remove(window.tabs, idx)
    end

    if window.selectedTab == self then
        window.selectedTab = nil
        for _, tab in ipairs(window.tabs) do
            if not tab.neglectSelector then
                tab:Select()
                break
            end
        end
    end

    teardownElements(window, self.elements)

    for _, connection in self.connections do
        window:Disconnect(connection)
    end
    self.connections = {}

    if self.topbarItem then
        window:DestroySubtree(self.topbarItem)
    end
    if self.tabPage then
        window:DestroySubtree(self.tabPage)
    end
    self.topbarItem = nil
    self.tabPage = nil
    self.elements = {}
end

return Tab
end

Components.tabSection = { Name = "tabSection", Parent = Components }
Components.tabSection.FindFirstChild = function(self, k) return self[k] end
Components.tabSection.__loader = function(script, require)
local TabSection = {}
TabSection.__index = TabSection
TabSection.__type = "TabSection"

local locale = require(script.Parent.Parent.utility.locale)
local log = require(script.Parent.Parent.utility.log)

local sectionInset = 20

local spacingAbove = 6

local spacingBelow = 3

local function anythingAbove(window)
    for _, tab in window.tabs do
        if not tab.neglectSelector then
            return true
        end
    end
    return #window.tabSections > 0
end

function TabSection.new(window, properties)
    properties = if typeof(properties) == "table" then properties else {}

    local self = setmetatable({
        window = assert(window, "Missing argument #1 (Window expected)"),
        name = properties.name or properties.Name or "Section",
        icon = properties.icon or properties.Icon,
    }, TabSection)

    if window.layout.mode ~= "sidebar" then
        if not window._warnedTabSection then
            window._warnedTabSection = true
            log.warn("Rayfield: Window:CreateSection needs the sidebar layout; it does nothing on the top strip.")
        end
        self.inert = true
        return self
    end

    self.main = window:Create("Frame", {
        Name = self.name,
        Size = UDim2.new(1, -sectionInset * 2, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,

        Visible = false,

        Parent = window.tabList,
    })

    self.padding = window:Create("UIPadding", {
        PaddingTop = UDim.new(0, if anythingAbove(window) then spacingAbove else 0),
        PaddingBottom = UDim.new(0, spacingBelow),

        Parent = self.main,
    })

    window:Create("UIListLayout", {
        FillDirection = Enum.FillDirection.Horizontal,
        Padding = UDim.new(0, 6),
        SortOrder = Enum.SortOrder.LayoutOrder,
        HorizontalAlignment = Enum.HorizontalAlignment.Left,
        VerticalAlignment = Enum.VerticalAlignment.Top,

        Parent = self.main,
    })

    if self.icon then
        self.iconLabel = window:Create("ImageLabel", {
            Image = self.icon,
            Size = UDim2.fromOffset(16, 16),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            LayoutOrder = 0,

            ImageTransparency = 1,

            Parent = self.main,
        }, { ImageColor3 = "ContentColor" })
    end

    self.title = window:Create("TextLabel", {
        Text = locale.t(self.name),

        Size = UDim2.fromOffset(0, 15),
        AutomaticSize = Enum.AutomaticSize.X,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        TextSize = 15,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Bottom,
        TextWrapped = true,
        LayoutOrder = 1,

        TextTransparency = 1,

        Parent = self.main,
    }, { TextColor3 = "ContentColor", FontFace = "Font" })

    return self
end

function TabSection:_setShown(shown, animate)
    if not self.main then
        return
    end
    local w = self.window
    w:_reveal(self.title, { TextTransparency = if shown then 0.6 else 1 }, animate)
    if self.iconLabel then
        w:_reveal(self.iconLabel, { ImageTransparency = if shown then 0.65 else 1 }, animate)
    end
end

function TabSection:_setVisible(visible)
    if self.main then
        self.main.Visible = visible
    end
end

function TabSection:Remove()
    local index = table.find(self.window.tabSections, self)
    if index then
        table.remove(self.window.tabSections, index)
    end
    self.window:DestroySubtree(self.main)
    self.main = nil
end

return TabSection
end

Components.tabSelector = { Name = "tabSelector", Parent = Components }
Components.tabSelector.FindFirstChild = function(self, k) return self[k] end
Components.tabSelector.__loader = function(script, require)
local utility = script.Parent.Parent.utility
local variables = require(utility.variables)
local functions = require(utility.functions)
local locale = require(utility.locale)

local tabSelector = {}

local function initialOf(name: string?): string
    if type(name) ~= "string" or name == "" then
        return "?"
    end
    local afterFirst = utf8.offset(name, 2)
    local first = if afterFirst then string.sub(name, 1, afterFirst - 1) else name
    return string.upper(first)
end

tabSelector.states = {
    top = {
        selected = { background = 0, stroke = 0, content = 0 },
        hover = { background = 0.4, stroke = 0.3, content = 0.3 },
        unselected = { background = 0.8, stroke = 0.65, content = 0.5 },
        hidden = { background = 1, stroke = 1, content = 1 },
    },

    sidebar = {
        selected = { background = 0.4, stroke = 0.5, content = 0, shadow = 0.8 },
        hover = { background = 0.7, stroke = 0.8, content = 0.3, shadow = 1 },
        unselected = { background = 1, stroke = 1, content = 0.5, shadow = 1 },
        hidden = { background = 1, stroke = 1, content = 1, shadow = 1 },
    },
}

local function addGradients(tab, host, stroke)
    tab.topbarItemGradient = tab.window:Create("UIGradient", {
        Rotation = 90,

        Parent = host,
    }, { Color = { "TabBackground", functions.toColorSequence } })

    tab.topbarItemStrokeGradient = tab.window:Create("UIGradient", {
        Rotation = 90,

        Parent = stroke,
    }, { Color = { "TabStroke", functions.toColorSequence } })
end

local function addContent(tab, iconSize, withInitial)

    if withInitial and not tab.icon then
        tab.topbarItemInitial = tab.window:Create("TextLabel", {
            Text = initialOf(tab.name),

            Size = UDim2.fromOffset(iconSize, iconSize),
            BorderSizePixel = 0,
            BackgroundTransparency = 1,
            TextSize = iconSize - 4,
            TextXAlignment = Enum.TextXAlignment.Center,
            TextYAlignment = Enum.TextYAlignment.Center,
            Visible = false,

            TextTransparency = 1,

            Parent = tab.topbarItemContainer,
        }, { TextColor3 = "TabColor", FontFace = "Font" })
    end

    if tab.icon then
        tab.topbarItemIcon = tab.window:Create("ImageLabel", {

            Image = tab.icon,

            Size = UDim2.fromOffset(iconSize, iconSize),
            BorderSizePixel = 0,
            BackgroundTransparency = 1,

            ImageTransparency = 1,

            Parent = tab.topbarItemContainer,
        }, { ImageColor3 = "TabColor" })
    end

    if tab.name then
        tab.topbarItemTitle = tab.window:Create("TextLabel", {

            Text = locale.t(tab.name),

            Size = UDim2.fromOffset(0, 16),
            BorderSizePixel = 0,
            BackgroundTransparency = 1,
            TextSize = 16,
            AutomaticSize = Enum.AutomaticSize.XY,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextWrapped = true,
            LayoutOrder = 1,

            TextTransparency = 1,

            Parent = tab.topbarItemContainer,
        }, { TextColor3 = "TabColor", FontFace = "Font" })
    end
end

local function buildPill(tab)
    tab.topbarItem = tab.window:Create("Frame", {
        Name = tab.name,
        Size = UDim2.fromOffset(0, 34),
        AutomaticSize = Enum.AutomaticSize.X,
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BorderSizePixel = 0,

        BackgroundTransparency = 1,
        Visible = false,

        LayoutOrder = tab.customOrder or 0,

        Parent = tab.window.tabList,
    })

    tab.topbarItemInteract = tab.window:Create("TextButton", {
        Active = false,
        BackgroundTransparency = 1,
        Size = UDim2.fromScale(1, 1),
        BorderSizePixel = 0,
        Text = "",
        TextTransparency = 1,

        Parent = tab.topbarItem,
    })

    tab.window:Create("UICorner", {
        Parent = tab.topbarItem,
    }, { CornerRadius = "PillCornerRadius" })

    tab.topbarItemStroke = tab.window:Create("UIStroke", {
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        Color = Color3.fromRGB(255, 255, 255),

        Transparency = 1,

        Parent = tab.topbarItem,
    })

    addGradients(tab, tab.topbarItem, tab.topbarItemStroke)

    tab.topbarItemContainer = tab.window:Create("Frame", {
        Size = UDim2.fromOffset(0, 34),
        AutomaticSize = Enum.AutomaticSize.X,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,

        Parent = tab.topbarItem,
    })

    tab.window:Create("UIPadding", {
        PaddingLeft = UDim.new(0, 13),
        PaddingRight = UDim.new(0, 14),

        Parent = tab.topbarItemContainer,
    })

    tab.topbarItemLayout = tab.window:Create("UIListLayout", {
        Padding = UDim.new(0, 6),
        FillDirection = Enum.FillDirection.Horizontal,
        VerticalAlignment = Enum.VerticalAlignment.Center,
        HorizontalAlignment = Enum.HorizontalAlignment.Center,
        SortOrder = Enum.SortOrder.LayoutOrder,

        Parent = tab.topbarItemContainer,
    })

    addContent(tab, 16, false)
end

local function buildRow(tab, layout)
    tab.topbarItem = tab.window:Create("Frame", {
        Name = tab.name,
        Size = UDim2.new(1, -layout.rowInset * 2, 0, layout.rowHeight),
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BorderSizePixel = 0,

        BackgroundTransparency = 1,
        Visible = false,

        LayoutOrder = tab.customOrder or 0,

        Parent = tab.window.tabList,
    })

    tab.topbarItemInteract = tab.window:Create("TextButton", {
        Active = false,
        BackgroundTransparency = 1,
        Size = UDim2.fromScale(1, 1),
        BorderSizePixel = 0,
        Text = "",
        TextTransparency = 1,

        Parent = tab.topbarItem,
    })

    tab.window:Create("UICorner", {
        CornerRadius = UDim.new(0, layout.rowCornerRadius),

        Parent = tab.topbarItem,
    })

    tab.topbarItemStroke = tab.window:Create("UIStroke", {
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        Color = Color3.fromRGB(255, 255, 255),

        Transparency = 1,

        Parent = tab.topbarItem,
    })

    addGradients(tab, tab.topbarItem, tab.topbarItemStroke)

    tab.topbarItemShadow = tab.window:Create("UIShadow", {
        BlurRadius = UDim.new(0, 20),
        Color = Color3.fromRGB(255, 255, 255),
        Offset = UDim2.new(0, 0, 0, -15),
        Spread = UDim2.new(0, 10, 0, -30),
        ZIndex = -1,

        Transparency = 1,

        Parent = tab.topbarItem,
    })

    tab.topbarItemContainer = tab.window:Create("Frame", {
        Size = UDim2.new(1, -layout.rowPadding, 0, 24),
        Position = UDim2.new(0, layout.rowPadding, 0.5, 0),
        AnchorPoint = Vector2.new(0, 0.5),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,

        Parent = tab.topbarItem,
    })

    tab.topbarItemLayout = tab.window:Create("UIListLayout", {
        Padding = UDim.new(0, layout.rowContentSpacing),
        FillDirection = Enum.FillDirection.Horizontal,
        VerticalAlignment = Enum.VerticalAlignment.Center,
        HorizontalAlignment = Enum.HorizontalAlignment.Left,
        SortOrder = Enum.SortOrder.LayoutOrder,

        Parent = tab.topbarItemContainer,
    })

    addContent(tab, layout.rowIconSize, true)
end

function tabSelector.build(tab, layout)
    if layout.mode == "sidebar" then
        buildRow(tab, layout)
    else
        buildPill(tab)
    end
end

function tabSelector.setRowCollapsed(tab, collapsed, layout)
    if layout.mode ~= "sidebar" or not tab.topbarItem then
        return
    end

    if tab.topbarItemTitle then
        tab.topbarItemTitle.Visible = not collapsed
    end

    if tab.topbarItemInitial then
        tab.topbarItemInitial.Visible = collapsed
    end
    local inset = if collapsed then 0 else layout.rowPadding
    tab.topbarItemContainer.Size = UDim2.new(1, -inset, 0, 24)
    tab.topbarItemContainer.Position = UDim2.new(0, inset, 0.5, 0)
    tab.topbarItemLayout.HorizontalAlignment = if collapsed
        then Enum.HorizontalAlignment.Center
        else Enum.HorizontalAlignment.Left
end

function tabSelector.applyVisual(tab, state, tweenInfo)
    local targets = {
        [tab.topbarItem] = { BackgroundTransparency = state.background },
        [tab.topbarItemStroke] = { Transparency = state.stroke },
    }

    if tab.topbarItemIcon then
        targets[tab.topbarItemIcon] = { ImageTransparency = state.content }
    end
    if tab.topbarItemTitle then
        targets[tab.topbarItemTitle] = { TextTransparency = state.content }
    end
    if tab.topbarItemInitial then
        targets[tab.topbarItemInitial] = { TextTransparency = state.content }
    end
    if tab.topbarItemShadow and state.shadow then
        targets[tab.topbarItemShadow] = { Transparency = state.shadow }
    end

    for instance, properties in targets do
        if tweenInfo then
            variables.tweenService:Create(instance, tweenInfo, properties):Play()
        else
            for property, value in properties do
                instance[property] = value
            end
        end
    end
end

return tabSelector
end

Components.tag = { Name = "tag", Parent = Components }
Components.tag.FindFirstChild = function(self, k) return self[k] end
Components.tag.__loader = function(script, require)
local Tag = {}
Tag.__index = Tag
Tag.__type = "Tag"

local utility = script.Parent.Parent.utility

local variables = require(utility.variables)
local functions = require(utility.functions)
local image = require(utility.image)

local defaultColor = Color3.fromRGB(255, 175, 15)
local setTweenInfo = TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)

function Tag.new(window, properties)
    properties = if typeof(properties) == "table" then properties else {}

    local self = setmetatable({
        window = assert(window, "Missing argument #1 (Window expected)"),
        text = properties.text or properties.Text or properties.title or properties.Title,
        icon = properties.icon or properties.Icon,
        color = properties.color or properties.Color or defaultColor,
    }, Tag)

    assert(self.icon or (self.text and self.text ~= ""), "A Tag requires an icon, text, or both.")

    self.main = self.window:Create("Frame", {
        Name = "Tag",
        Size = UDim2.fromOffset(10, 24),
        AutomaticSize = Enum.AutomaticSize.X,
        BackgroundColor3 = self.color,
        BorderSizePixel = 0,
        LayoutOrder = properties.order or properties.Order or 0,

        BackgroundTransparency = 1,

        Parent = self.window.tagContainer,
    })

    self.window:Create("UICorner", {
        CornerRadius = UDim.new(1, 0),

        Parent = self.main,
    })

    self.window:Create("UIPadding", {
        PaddingLeft = UDim.new(0, 10),
        PaddingRight = UDim.new(0, 10),

        Parent = self.main,
    })

    self.window:Create("UIListLayout", {
        Padding = UDim.new(0, 5),
        FillDirection = Enum.FillDirection.Horizontal,
        VerticalAlignment = Enum.VerticalAlignment.Center,
        SortOrder = Enum.SortOrder.LayoutOrder,

        Parent = self.main,
    })

    local contrast = functions.contrastColor(self.color)

    self.iconLabel = self.window:Create("ImageLabel", {
        Name = "Icon",
        Image = self.icon or "",
        ImageColor3 = contrast,
        Size = UDim2.fromOffset(16, 16),
        BackgroundTransparency = 1,
        Visible = self.icon ~= nil,
        ZIndex = 5,

        ImageTransparency = 1,

        Parent = self.main,
    })

    self.title = self.window:Create("TextLabel", {
        Name = "Title",
        AnchorPoint = Vector2.new(0, 0.5),
        Size = UDim2.fromOffset(10, 15),
        AutomaticSize = Enum.AutomaticSize.X,
        BackgroundTransparency = 1,
        Text = self.text or "",
        TextColor3 = contrast,
        TextSize = 15,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextWrapped = true,
        RichText = true,
        Visible = self.text ~= nil and self.text ~= "",
        LayoutOrder = 1,
        ZIndex = 5,

        TextTransparency = 1,

        Parent = self.main,
    }, { FontFace = "Font" })

    self.window.tagContainer.Visible = true

    if not self.window.hidden then
        self:_setShown(true, setTweenInfo)
    end

    return self
end

function Tag:_setShown(shown, animate)
    local target = if shown then 0 else 1
    local info = if typeof(animate) == "TweenInfo" then animate elseif animate then setTweenInfo else nil
    if info then
        variables.tweenService:Create(self.main, info, { BackgroundTransparency = target }):Play()
        variables.tweenService:Create(self.iconLabel, info, { ImageTransparency = target }):Play()
        variables.tweenService:Create(self.title, info, { TextTransparency = target }):Play()
    else
        self.main.BackgroundTransparency = target
        self.iconLabel.ImageTransparency = target
        self.title.TextTransparency = target
    end
end

function Tag:SetColor(color)
    self.color = color
    local contrast = functions.contrastColor(color)
    variables.tweenService:Create(self.main, setTweenInfo, { BackgroundColor3 = color }):Play()
    variables.tweenService:Create(self.iconLabel, setTweenInfo, { ImageColor3 = contrast }):Play()
    variables.tweenService:Create(self.title, setTweenInfo, { TextColor3 = contrast }):Play()
end

function Tag:SetText(text)
    self.text = text
    self.title.Text = text or ""
    self.title.Visible = text ~= nil and text ~= ""
end

function Tag:SetIcon(icon)
    self.icon = icon
    image.assign(self.iconLabel, "Image", icon)
    self.iconLabel.Visible = icon ~= nil
end

function Tag:Set(properties)
    if properties.color or properties.Color then
        self:SetColor(properties.color or properties.Color)
    end
    if properties.text or properties.Text or properties.title or properties.Title then
        self:SetText(properties.text or properties.Text or properties.title or properties.Title)
    end
    if properties.icon ~= nil or properties.Icon ~= nil then
        self:SetIcon(properties.icon or properties.Icon)
    end
end

function Tag:Remove()

    self.window:DestroySubtree(self.main)
    local idx = table.find(self.window.tags, self)
    if idx then
        table.remove(self.window.tags, idx)
    end
    if #self.window.tags == 0 then
        self.window.tagContainer.Visible = false
    end
end

return Tag
end

Components.text = { Name = "text", Parent = Components }
Components.text.FindFirstChild = function(self, k) return self[k] end
Components.text.__loader = function(script, require)
local Text = {}
Text.__index = Text
Text.__type = "Text"

local moveable = require(script.Parent.Parent.utility.moveable)
local locale = require(script.Parent.Parent.utility.locale)

local titleSize = 16
local bodySize = 14

local bodyShown = 0.45

function Text.new(tab, properties)
    properties = if typeof(properties) == "table" then properties else {}

    local self = setmetatable({
        tab = assert(tab, "Missing argument #1 (Tab expected)"),
        window = tab.window,
        name = tostring(properties.name or properties.Name or ""),
        text = tostring(properties.text or properties.Text or ""),
        icon = properties.icon or properties.Icon,
    }, Text)

    self.main = self.window:Create("Frame", {
        Size = UDim2.new(1, -20, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        BorderSizePixel = 0,
        Name = if self.name ~= "" then self.name else "Text",
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),

        BackgroundTransparency = 1,

        Parent = self.tab.tabPage,
    }, { BackgroundTransparency = "ElementTransparency" })

    self.stroke = self.window:StyleElementBody(self.main)

    self.window:Create("UIPadding", {
        PaddingTop = UDim.new(0, 14),
        PaddingBottom = UDim.new(0, 14),
        PaddingLeft = UDim.new(0, 20),
        PaddingRight = UDim.new(0, 20),

        Parent = self.main,
    })

    self.window:Create("UIListLayout", {
        Padding = UDim.new(0, 6),
        SortOrder = Enum.SortOrder.LayoutOrder,

        Parent = self.main,
    })

    self.titleRow = self.window:Create("Frame", {
        Name = "Title",
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        BorderSizePixel = 0,
        BackgroundTransparency = 1,
        LayoutOrder = 1,

        Parent = self.main,
    })

    self.window:Create("UIListLayout", {
        FillDirection = Enum.FillDirection.Horizontal,
        Padding = UDim.new(0, 6),
        SortOrder = Enum.SortOrder.LayoutOrder,
        VerticalAlignment = Enum.VerticalAlignment.Top,

        Parent = self.titleRow,
    })

    if self.icon then
        self.iconLabel = self.window:Create("ImageLabel", {
            Image = self.icon,
            Size = UDim2.fromOffset(16, 16),
            BorderSizePixel = 0,
            BackgroundTransparency = 1,

            ImageTransparency = 1,

            Parent = self.titleRow,
        }, { ImageColor3 = "ContentColor" })
    end

    self.title = self.window:Create("TextLabel", {
        Text = locale.t(self.name),
        Size = UDim2.new(1, if self.icon then -22 else 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        BorderSizePixel = 0,
        BackgroundTransparency = 1,
        RichText = true,
        TextSize = titleSize,
        TextWrapped = true,
        TextXAlignment = Enum.TextXAlignment.Left,
        LayoutOrder = 1,

        TextTransparency = 1,

        Parent = self.titleRow,
    }, { TextColor3 = "TitlingColor", FontFace = "Font" })

    self.body = self.window:Create("TextLabel", {
        Text = locale.t(self.text),
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        BorderSizePixel = 0,
        BackgroundTransparency = 1,
        RichText = true,
        TextSize = bodySize,
        TextWrapped = true,
        TextXAlignment = Enum.TextXAlignment.Left,
        LayoutOrder = 2,

        TextTransparency = 1,

        Parent = self.main,
    }, { TextColor3 = "ContentColor", FontFace = "Font" })

    self:_applyPresence()

    return self
end

function Text:_applyPresence()
    self.titleRow.Visible = self.name ~= "" or self.icon ~= nil
    self.body.Visible = self.text ~= ""
end

function Text:Set(text)
    self.text = tostring(text)
    self.window:_bindLocale(self.body, "Text", self.text)
    self:_applyPresence()
end

function Text:SetTitle(title)
    self.name = tostring(title)
    self.window:_bindLocale(self.title, "Text", self.name)
    self:_applyPresence()
end

function Text:_setShown(shown, animate)

    if shown then
        self.window:_revealCommon(self, animate)
    else
        self.window:_hideCommon(self, animate)
    end

    self.window:_reveal(self.body, { TextTransparency = if shown then bodyShown else 1 }, animate)
end

moveable(Text)

return Text
end

Components.toast = { Name = "toast", Parent = Components }
Components.toast.FindFirstChild = function(self, k) return self[k] end
Components.toast.__loader = function(script, require)
local Toast = {}
Toast.__index = Toast
Toast.__type = "Toast"

local utility = script.Parent.Parent.utility
local variables = require(utility.variables)
local functions = require(utility.functions)
local constants = require(utility.constants)
local image = require(utility.image)
local hapticEngine = require(utility.HapticEngine)

local slideInfo = TweenInfo.new(0.6, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)
local growInfo = TweenInfo.new(0.6, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)
local fadeLong = TweenInfo.new(0.4, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)
local fadeShort = TweenInfo.new(0.3, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)
local shrinkInfo = TweenInfo.new(0.6, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)

local iconSize = 24
local avatarSize = 32
local leftPadding = 18
local rightPadding = 18

local avatarLeftPadding = 10
local avatarRightPadding = 28
local iconGap = 12
local stackPadding = 8
local MIN_WIDTH, MAX_WIDTH = 140, 320

local maxLive = 6

local offscreenAbove = UDim2.new(0.5, 0, 0.5, -180)
local offscreenBelow = UDim2.new(0.5, 0, 0.5, 180)
local centred = UDim2.new(0.5, 0, 0.5, 0)

local function autoDuration(text)
    return math.clamp(#text * 0.06 + 3, 3, 9)
end

local function resolveImage(icon)
    if type(icon) == "number" then
        return "rbxassetid://" .. tostring(icon)
    end
    return icon
end

function Toast.new(window, properties, container)
    properties = if typeof(properties) == "table" then properties else {}

    local self = setmetatable({
        window = assert(window, "Missing argument #1 (Window expected)"),
        title = properties.title or properties.Title or "",
        subtitle = properties.subtitle or properties.Subtitle,
        icon = properties.icon or properties.Icon,

        avatar = properties.avatar or properties.Avatar,

        minWidth = properties.minWidth or properties.MinWidth,

        subtitleAbove = properties.subtitleAbove or properties.SubtitleAbove or false,
        position = properties.position or "Top",
        _hovered = false,
        _dismissed = false,
    }, Toast)

    self.duration = properties.duration or properties.Duration or autoDuration(self.title .. (self.subtitle or ""))

    local hasAvatar = self.avatar ~= nil and self.avatar ~= 0
    local hasIcon = hasAvatar or (self.icon ~= nil and self.icon ~= 0 and self.icon ~= "")

    self._iconImage = if hasAvatar
        then image.avatar(self.avatar, function(uri)

            if self.iconLabel and not self._dismissed and self.main.Parent then
                image.assign(self.iconLabel, "Image", uri)
            end
        end)
        elseif hasIcon then resolveImage(self.icon)
        else nil
    self._iconSize = if hasAvatar then avatarSize else iconSize
    self._leftPad = if hasAvatar then avatarLeftPadding else leftPadding
    self._rightPad = if hasAvatar then avatarRightPadding else rightPadding
    self._minWidth = math.clamp(self.minWidth or 0, MIN_WIDTH, MAX_WIDTH)
    local hasSubtitle = self.subtitle ~= nil and self.subtitle ~= ""

    self.main = self.window:Create("Frame", {
        Name = "Toast",
        BackgroundTransparency = 1,
        Size = UDim2.new(0, 0, 0, 0),
        BorderSizePixel = 0,
        ZIndex = constants.zIndex.toast,

        Parent = container or self.window.toasts,
    })

    self.window:Create("UIPadding", {
        PaddingTop = UDim.new(0, stackPadding),

        Parent = self.main,
    })

    self.body = self.window:Create("Frame", {
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        Size = UDim2.new(1, 0, 1, 0),
        Position = if self.position == "Bottom" then offscreenBelow else offscreenAbove,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Active = true,
        BorderSizePixel = 0,
        ZIndex = constants.zIndex.toast,

        BackgroundTransparency = 1,

        Parent = self.main,
    })

    self.window:Create("UIGradient", {
        Rotation = 270,
        Offset = Vector2.new(0, -0.1),

        Parent = self.body,
    }, { Color = { "WindowColor", functions.toColorSequence } })

    self.window:Create("UICorner", {
        CornerRadius = UDim.new(1, 0),

        Parent = self.body,
    })

    self.stroke = self.window:Create("UIStroke", {
        Transparency = 1,

        Parent = self.body,
    }, { Color = "SurfaceStroke" })

    self.shadow = self.window:CreateGlow(self.body, "ShadowColor", 20, 1)

    self.window:Create("UIPadding", {
        PaddingLeft = UDim.new(0, self._leftPad),
        PaddingRight = UDim.new(0, self._rightPad),

        Parent = self.body,
    })

    self.window:Create("UIListLayout", {
        FillDirection = Enum.FillDirection.Horizontal,
        VerticalAlignment = Enum.VerticalAlignment.Center,
        HorizontalAlignment = Enum.HorizontalAlignment.Left,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, iconGap),

        Parent = self.body,
    })

    if hasIcon then

        self.iconLabel = self.window:Create("ImageLabel", {
            Image = self._iconImage,
            Size = UDim2.fromOffset(self._iconSize, self._iconSize),
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            BorderSizePixel = 0,
            LayoutOrder = 1,
            ZIndex = constants.zIndex.toastContent,

            BackgroundTransparency = 1,
            ImageTransparency = 1,

            Parent = self.body,
        }, if hasAvatar then nil else { ImageColor3 = "ContentColor" })

        self.window:Create("UICorner", {
            CornerRadius = UDim.new(1, 0),

            Parent = self.iconLabel,
        })
    end

    self.container = self.window:Create("Frame", {
        AutomaticSize = Enum.AutomaticSize.X,
        Size = UDim2.fromOffset(0, hasSubtitle and 32 or 16),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        LayoutOrder = 2,
        ZIndex = constants.zIndex.toastContent,

        Parent = self.body,
    })

    self.window:Create("UIListLayout", {
        FillDirection = Enum.FillDirection.Vertical,
        VerticalAlignment = Enum.VerticalAlignment.Center,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, 1),

        Parent = self.container,
    })

    self.titleLabel = self.window:Create("TextLabel", {
        Text = self.title,
        AutomaticSize = Enum.AutomaticSize.X,
        Size = UDim2.fromOffset(0, 16),
        BackgroundTransparency = 1,
        TextSize = 16,
        TextXAlignment = Enum.TextXAlignment.Left,
        LayoutOrder = if self.subtitleAbove then 2 else 1,
        ZIndex = constants.zIndex.toastContent,

        TextTransparency = 1,

        Parent = self.container,
    }, { TextColor3 = "ContentColor", FontFace = "TitleFont" })

    if hasSubtitle then
        self.subtitleLabel = self.window:Create("TextLabel", {
            Text = self.subtitle,
            AutomaticSize = Enum.AutomaticSize.X,
            Size = UDim2.fromOffset(0, 14),
            BackgroundTransparency = 1,
            TextSize = 14,
            TextXAlignment = Enum.TextXAlignment.Left,
            LayoutOrder = if self.subtitleAbove then 1 else 2,
            ZIndex = constants.zIndex.toastContent,

            TextTransparency = 1,

            Parent = self.container,
        }, { TextColor3 = "ContentColor", FontFace = "Font" })
    end

    self.window._toastCount = (self.window._toastCount or 0) + 1
    self.main.LayoutOrder = -self.window._toastCount

    local stacks = self.window._liveToasts
    if not stacks then
        stacks = {}
        self.window._liveToasts = stacks
    end
    local live = stacks[self.main.Parent]
    if not live then
        live = {}
        stacks[self.main.Parent] = live
    end
    self._live = live
    table.insert(live, self)
    while #live > maxLive do
        local oldest = table.remove(live, 1)
        if oldest and oldest ~= self then
            task.spawn(oldest._dismiss, oldest)
        end
    end

    self._connections = {
        self.window:Connect(self.body.MouseEnter, function()
            self._hovered = true
        end),
        self.window:Connect(self.body.MouseLeave, function()
            self._hovered = false
        end),
        self.window:Connect(self.body.InputBegan, function(input)
            if
                input.UserInputType == Enum.UserInputType.MouseButton1
                or input.UserInputType == Enum.UserInputType.Touch
            then
                self:_dismiss()
            end
        end),
    }

    task.spawn(function()
        self:_show()
    end)

    return self
end

function Toast:_measure()
    local titleWidth = functions.textWidth(self.window.theme.TitleFont, 16, self.title)
    local subtitleWidth = if self.subtitleLabel
        then functions.textWidth(self.window.theme.Font, 14, self.subtitle)
        else 0
    local textWidth = math.max(titleWidth, subtitleWidth)

    local left = if self.iconLabel then self._leftPad + self._iconSize + iconGap else self._leftPad
    local width = math.clamp(left + textWidth + self._rightPad, self._minWidth, MAX_WIDTH)

    if left + textWidth + self._rightPad > MAX_WIDTH then
        local column = MAX_WIDTH - left - self._rightPad
        for _, label in { self.titleLabel, self.subtitleLabel } do
            if label then
                label.AutomaticSize = Enum.AutomaticSize.None
                label.TextTruncate = Enum.TextTruncate.AtEnd
                label.Size = UDim2.fromOffset(column, label.Size.Y.Offset)
            end
        end
    end

    local textHeight = if self.subtitleLabel then 16 + 1 + 14 else 16
    local height = math.max(textHeight, if self.iconLabel then self._iconSize else 0) + 18

    return width, height
end

function Toast:_show()
    if not self.main.Parent then
        return
    end

    hapticEngine.notify()

    local width, height = self:_measure()
    if self._dismissed or not self.main.Parent then
        return
    end
    self.main.Size = UDim2.new(0, width, 0, 0)

    variables.tweenService:Create(self.main, growInfo, { Size = UDim2.new(0, width, 0, height + stackPadding) }):Play()
    variables.tweenService:Create(self.body, slideInfo, { Position = centred }):Play()
    variables.tweenService:Create(self.body, fadeLong, { BackgroundTransparency = 0 }):Play()
    variables.tweenService:Create(self.stroke, fadeLong, { Transparency = 0.9 }):Play()
    variables.tweenService:Create(self.shadow, fadeShort, { Transparency = 0.6 }):Play()
    variables.tweenService:Create(self.titleLabel, fadeShort, { TextTransparency = 0 }):Play()

    task.wait(0.05)
    if self._dismissed or not self.main.Parent then
        return
    end
    if self.iconLabel then
        variables.tweenService:Create(self.iconLabel, fadeShort, { BackgroundTransparency = 0.95 }):Play()
        variables.tweenService:Create(self.iconLabel, fadeShort, { ImageTransparency = 0 }):Play()
    end

    task.wait(0.05)
    if self._dismissed or not self.main.Parent then
        return
    end
    if self.subtitleLabel then
        variables.tweenService:Create(self.subtitleLabel, fadeShort, { TextTransparency = 0.5 }):Play()
    end

    local elapsed = 0
    while elapsed < self.duration and not self._dismissed and self.main.Parent do
        local dt = task.wait()
        if not self._hovered then
            elapsed += dt
        end
    end

    self:_dismiss()
end

function Toast:_dismiss()
    if self._dismissed then
        return
    end
    self._dismissed = true

    local live = self._live
    local index = live and table.find(live, self)
    if live and index then
        table.remove(live, index)
    end

    if not self.main.Parent then
        return
    end

    variables.tweenService:Create(self.body, fadeLong, { BackgroundTransparency = 1 }):Play()
    variables.tweenService:Create(self.stroke, fadeLong, { Transparency = 1 }):Play()
    variables.tweenService:Create(self.shadow, fadeShort, { Transparency = 1 }):Play()
    variables.tweenService:Create(self.titleLabel, fadeShort, { TextTransparency = 1 }):Play()
    if self.subtitleLabel then
        variables.tweenService:Create(self.subtitleLabel, fadeShort, { TextTransparency = 1 }):Play()
    end
    if self.iconLabel then
        variables.tweenService
            :Create(self.iconLabel, fadeShort, { ImageTransparency = 1, BackgroundTransparency = 1 })
            :Play()
    end

    variables.tweenService:Create(self.body, shrinkInfo, { Size = UDim2.new(1, -60, 1, 0) }):Play()
    local collapse =
        variables.tweenService:Create(self.main, shrinkInfo, { Size = UDim2.new(0, self.main.Size.X.Offset, 0, 0) })
    collapse:Play()
    collapse.Completed:Wait()

    if not self.main.Parent then
        return
    end

    for _, connection in self._connections do
        self.window:Disconnect(connection)
    end
    self.window:DestroySubtree(self.main)
end

return Toast
end

Components.toggle = { Name = "toggle", Parent = Components }
Components.toggle.FindFirstChild = function(self, k) return self[k] end
Components.toggle.__loader = function(script, require)
local Toggle = {}
Toggle.__index = Toggle
Toggle.__type = "Toggle"

local utility = script.Parent.Parent.utility

local variables = require(utility.variables)
local functions = require(utility.functions)
local moveable = require(utility.moveable)
local lockable = require(utility.lockable)
local locale = require(utility.locale)
local hapticEngine = require(utility.HapticEngine)

function Toggle.new(tab, properties)
    properties = if typeof(properties) == "table" then properties else {}

    local self = setmetatable({
        tab = assert(tab, "Missing argument #1 (Tab expected)"),
        window = tab.window,
        name = properties.name or properties.Name or "Switch",
        icon = properties.icon or properties.Icon,
        description = properties.description or properties.Description,
        forgetState = properties.forgetState or properties.ForgetState or tab.forgetState,
        compact = tab.compact or false,

        flag = properties.flag
            or properties.Flag
            or (
                not (properties.forgetState or properties.ForgetState or tab.forgetState)
                    and functions.deriveFlagFromName(properties.name or properties.Name or "Switch")
                or nil
            ),

        callback = properties.callback or properties.Callback or function() end,

        value = if (properties.value or properties.Value) ~= nil then (properties.value or properties.Value) else false,
    }, Toggle)

    self.window:_registerControl(self)

    if self.compact then
        self:_buildCompact()
    else
        self:_buildFull()
    end

    if self.description and not self.compact then
        self.descriptor = require(script.Parent.descriptor).new(self.tab, { description = self.description })
    end

    return self
end

function Toggle:_buildSwitch(parent)
    local window = self.window

    self.functionContainer = window:Create("Frame", {
        BorderSizePixel = 0,
        Size = UDim2.fromOffset(50, 21),

        BackgroundTransparency = 1,

        Parent = parent,
    }, { BackgroundColor3 = "ToggleTrack" })

    window:Create("UICorner", {
        CornerRadius = UDim.new(0, 15),
        Parent = self.functionContainer,
    })

    self.containerStroke = window:Create("UIStroke", {
        Transparency = 1,
        Parent = self.functionContainer,
    }, { Color = "SurfaceStroke" })

    self.indicator = window:Create("Frame", {
        BorderSizePixel = 0,
        Size = UDim2.fromOffset(25, 17),
        Position = self.value and UDim2.new(1, -28, 0.5, 0) or UDim2.new(1, -47, 0.5, 0),
        AnchorPoint = Vector2.new(0, 0.5),
        BackgroundColor3 = self.value and self.window.theme.AccentColor or self.window.theme.ToggleKnobOff,

        BackgroundTransparency = 1,

        Parent = self.functionContainer,
    })

    window:Create("UICorner", {
        CornerRadius = UDim.new(1, 0),
        Parent = self.indicator,
    })

    self.indicatorStroke = window:Create("UIStroke", {
        Color = self.value and self.window.theme.AccentStroke or Color3.fromRGB(255, 255, 255),
        Transparency = 1,
        Parent = self.indicator,
    })

    self.indicatorGlow = window:CreateGlow(self.indicator, "AccentColor", 20, 1)

    self.overlay = window:Create("Frame", {
        BorderSizePixel = 0,
        Size = UDim2.fromScale(1, 1),
        Position = UDim2.fromScale(0, 0),
        AnchorPoint = Vector2.new(0, 0),
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),

        BackgroundTransparency = 1,

        Parent = self.functionContainer,
    }, { Visible = "DarkToggleOverlay" })

    window:Create("UICorner", {
        CornerRadius = UDim.new(0, 15),
        Parent = self.overlay,
    })

    self.overlayGradient = window:Create("UIGradient", {
        Rotation = 90,
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(30, 30, 30)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(30, 30, 30)),
        }),
        Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 1),
            NumberSequenceKeypoint.new(1, 0.35),
        }),

        Parent = self.overlay,
    })

    return self.functionContainer
end

function Toggle:_performToggle()
    hapticEngine.click()
    self.value = not self.value
    self:_animateIndicator()

    self.window:_runGuarded(self, self.callback, self.value)
    self.window:_persist(self)
end

function Toggle:_buildFull()
    local window = self.window

    self.main = window:Create("Frame", {
        Size = UDim2.new(1, -20, 0, 41),
        BorderSizePixel = 0,
        Name = self.name,
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),

        BackgroundTransparency = 1,

        Parent = self.tab.tabPage,
    }, { BackgroundTransparency = "ElementTransparency" })

    self.stroke = window:StyleElementBody(self.main)
    self.hoverOverlay = window:CreateHoverOverlay(self.main)

    self.container = window:Create("Frame", {
        BorderSizePixel = 0,

        Parent = self.main,
        Size = UDim2.new(0, 170, 0, 16),
        Position = UDim2.new(0, 20, 0.5, 0),
        AnchorPoint = Vector2.new(0, 0.5),
        BackgroundTransparency = 1,
    })

    self.containerLayout = window:Create("UIListLayout", {
        Padding = UDim.new(0, 5),
        FillDirection = Enum.FillDirection.Horizontal,
        VerticalAlignment = Enum.VerticalAlignment.Center,
        HorizontalAlignment = Enum.HorizontalAlignment.Left,

        Parent = self.container,
    })

    if self.icon then
        self.iconLabel = window:Create("ImageLabel", {
            Image = self.icon,
            Size = UDim2.fromOffset(16, 16),
            BorderSizePixel = 0,
            BackgroundTransparency = 1,

            ImageTransparency = 1,

            Parent = self.container,
        }, { ImageColor3 = "ContentColor" })
    end

    self.title = window:Create("TextLabel", {
        Text = locale.t(self.name),
        Size = UDim2.fromOffset(250, 16),
        BorderSizePixel = 0,
        BackgroundTransparency = 1,
        TextSize = 16,
        AutomaticSize = Enum.AutomaticSize.X,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextWrapped = true,
        LayoutOrder = 1,

        TextTransparency = 1,

        Parent = self.container,
    }, { TextColor3 = "ContentColor", FontFace = "Font" })

    self.interact = window:Create("TextButton", {
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 1, 0),
        BorderSizePixel = 0,
        Position = UDim2.fromScale(1, 0.5),
        AnchorPoint = Vector2.new(1, 0.5),
        TextTransparency = 1,
        ZIndex = 10,

        Parent = self.main,
    })

    self:_buildSwitch(self.main)
    self.functionContainer.Position = UDim2.new(1, -15, 0, 20)
    self.functionContainer.AnchorPoint = Vector2.new(1, 0.5)

    self.window:_wireElementHover(self)

    self.window:ConnectFor(self, self.interact.MouseButton1Click, function()
        variables.tweenService
            :Create(
                self.stroke,
                TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
                { Transparency = 1 }
            )
            :Play()
        variables.tweenService
            :Create(
                self.main,
                TweenInfo.new(0.6, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out),
                { Size = UDim2.new(1, -26, 0, 41) }
            )
            :Play()

        self:_performToggle()

        task.wait(0.11)

        variables.tweenService
            :Create(
                self.main,
                TweenInfo.new(0.25, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out),
                { Size = UDim2.new(1, -20, 0, 41) }
            )
            :Play()
        variables.tweenService
            :Create(
                self.stroke,
                TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
                { Transparency = self.window.theme.ElementStrokeTransparency }
            )
            :Play()
    end)
end

function Toggle:_buildCompact()
    local window = self.window

    self.main, self.stroke, self.interact = window:_buildCompactRow(self.tab, self.name, 10)
    self.hoverOverlay = self.interact

    window:Create("UIPadding", {
        PaddingLeft = UDim.new(0, 15),
        PaddingRight = UDim.new(0, 15),

        Parent = self.interact,
    })

    window:Create("UIListLayout", {
        FillDirection = Enum.FillDirection.Horizontal,
        VerticalAlignment = Enum.VerticalAlignment.Center,
        HorizontalFlex = Enum.UIFlexAlignment.SpaceBetween,
        Padding = UDim.new(0, 10),

        Parent = self.interact,
    })

    self.container = window:Create("Frame", {
        AutomaticSize = Enum.AutomaticSize.X,
        Size = UDim2.fromOffset(0, 16),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        LayoutOrder = 0,

        Parent = self.interact,
    })

    window:Create("UIFlexItem", {
        FlexMode = Enum.UIFlexMode.Shrink,
        Parent = self.container,
    })

    window:Create("UIListLayout", {
        Padding = UDim.new(0, 5),
        FillDirection = Enum.FillDirection.Horizontal,
        VerticalAlignment = Enum.VerticalAlignment.Center,
        HorizontalAlignment = Enum.HorizontalAlignment.Left,

        Parent = self.container,
    })

    if self.icon then
        self.iconLabel = window:Create("ImageLabel", {
            Image = self.icon,
            Size = UDim2.fromOffset(16, 16),
            BorderSizePixel = 0,
            BackgroundTransparency = 1,
            LayoutOrder = 0,

            ImageTransparency = 1,

            Parent = self.container,
        }, { ImageColor3 = "ContentColor" })
    end

    self.title = window:Create("TextLabel", {
        Text = locale.t(self.name),
        Size = UDim2.fromOffset(0, 16),
        AutomaticSize = Enum.AutomaticSize.X,
        BorderSizePixel = 0,
        BackgroundTransparency = 1,
        TextSize = 16,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextTruncate = Enum.TextTruncate.AtEnd,
        LayoutOrder = 1,

        TextTransparency = 1,

        Parent = self.container,
    }, { TextColor3 = "ContentColor", FontFace = "Font" })

    window:Create("UIFlexItem", {
        FlexMode = Enum.UIFlexMode.Shrink,
        Parent = self.title,
    })

    self:_buildSwitch(self.interact)
    self.functionContainer.LayoutOrder = 1

    self.window:_wireElementHover(self)

    self.window:ConnectFor(self, self.interact.MouseButton1Click, function()
        variables.tweenService
            :Create(
                self.stroke,
                TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
                { Transparency = 1 }
            )
            :Play()

        self:_performToggle()

        task.wait(0.11)

        variables.tweenService
            :Create(
                self.stroke,
                TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
                { Transparency = self.window.theme.ElementStrokeTransparency }
            )
            :Play()
    end)
end

function Toggle:_animateIndicator()
    local info = TweenInfo.new(0.6, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)
    if self.indicatorGlow then
        variables.tweenService
            :Create(self.indicatorGlow, info, { Transparency = self.value and self.window.theme.AccentGlow or 1 })
            :Play()
    end
    if self.value then
        variables.tweenService
            :Create(self.indicator, info, {
                Position = UDim2.new(1, -28, 0.5, 0),
                BackgroundColor3 = self.window.theme.AccentColor,
                BackgroundTransparency = 0,
            })
            :Play()
        variables.tweenService
            :Create(self.indicatorStroke, info, { Color = self.window.theme.AccentStroke, Transparency = 0 })
            :Play()
    else
        variables.tweenService
            :Create(self.indicator, info, {
                Position = UDim2.new(1, -47, 0.5, 0),
                BackgroundColor3 = self.window.theme.ToggleKnobOff,
                BackgroundTransparency = self.window.theme.ToggleKnobOffTransparency,
            })
            :Play()
        variables.tweenService
            :Create(self.indicatorStroke, info, { Color = Color3.fromRGB(255, 255, 255), Transparency = 0.7 })
            :Play()
    end
end

local toggleReveal = TweenInfo.new(0.6, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)

local toggleGlowReveal = TweenInfo.new(0.6, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out, 0, false, 0.35)

function Toggle:_setShown(shown, animate)
    local w = self.window
    if shown then
        w:_revealCommon(self, animate)

        w:_reveal(self.indicator, {
            BackgroundColor3 = self.value and w.theme.AccentColor or w.theme.ToggleKnobOff,
            BackgroundTransparency = self.value and 0 or w.theme.ToggleKnobOffTransparency,
        }, animate, toggleReveal)
        w:_reveal(self.indicatorStroke, {
            Color = self.value and w.theme.AccentStroke or Color3.fromRGB(255, 255, 255),
            Transparency = self.value and 0 or 0.7,
        }, animate, toggleReveal)
        w:_reveal(
            self.indicatorGlow,
            { Transparency = self.value and w.theme.AccentGlow or 1 },
            animate,
            toggleGlowReveal
        )
        w:_reveal(self.overlay, { BackgroundTransparency = 0 }, animate, toggleReveal)
        w:_reveal(self.containerStroke, { Transparency = 0.85 }, animate, toggleReveal)
        w:_reveal(
            self.functionContainer,
            { BackgroundTransparency = w.theme.ToggleTrackTransparency },
            animate,
            toggleReveal
        )
    else
        w:_hideCommon(self, animate)
        w:_reveal(self.indicator, { BackgroundTransparency = 1 }, animate, toggleReveal)
        w:_reveal(self.indicatorStroke, { Transparency = 1 }, animate, toggleReveal)
        w:_reveal(self.indicatorGlow, { Transparency = 1 }, animate, toggleGlowReveal)
        w:_reveal(self.overlay, { BackgroundTransparency = 1 }, animate, toggleReveal)
        w:_reveal(self.containerStroke, { Transparency = 1 }, animate, toggleReveal)
        w:_reveal(self.functionContainer, { BackgroundTransparency = 1 }, animate, toggleReveal)
    end
end

function Toggle:_refreshTheme()
    local t = self.window.theme
    local info = TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
    local ts = variables.tweenService
    ts:Create(self.functionContainer, info, { BackgroundTransparency = t.ToggleTrackTransparency }):Play()
    ts:Create(self.indicator, info, {
        BackgroundColor3 = self.value and t.AccentColor or t.ToggleKnobOff,
        BackgroundTransparency = self.value and 0 or t.ToggleKnobOffTransparency,
    }):Play()
    ts:Create(self.indicatorStroke, info, {
        Color = self.value and t.AccentStroke or Color3.fromRGB(255, 255, 255),
    }):Play()
    if self.indicatorGlow then
        ts:Create(self.indicatorGlow, info, { Transparency = self.value and t.AccentGlow or 1 }):Play()
    end
end

function Toggle:_minWidth()
    local w = 30 + 10 + 50
    if self.icon then
        w += 21
    end

    w += functions.textWidth(self.window.theme.Font, 16, locale.resolve(self.name))
    return w
end

moveable(Toggle)
lockable(Toggle)

function Toggle:Set(value, skipCallback)
    local changed = self.value ~= value
    self.value = value

    if changed then
        self:_animateIndicator()
    end

    if not skipCallback then
        self.window:_runGuarded(self, self.callback, self.value)
        self.window:_persist(self)
    end
end

return Toggle
end

Components.window = { Name = "window", Parent = Components }
Components.window.FindFirstChild = function(self, k) return self[k] end
Components.window.__loader = function(script, require)
local utility = script.Parent.Parent.utility
local image = require(utility.image)
local functions = require(utility.functions)
local persistence = require(utility.persistence)
local constants = require(utility.constants)
local locale = require(utility.locale)
local log = require(utility.log)
local hapticEngine = require(utility.HapticEngine)
local windowSizing = require(utility.windowSizing)
local layouts = require(utility.layouts)
local chrome = require(script.Parent.chrome)
local search = require(script.Parent.search)
local sidebar = require(script.Parent.sidebar)

local variables = require(utility.variables)

local themes = script.Parent.Parent.themes

local Window = {}
Window.__index = Window

local revealInfo = TweenInfo.new(0.4, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)

local collapsedSize = UDim2.fromOffset(185, 50)
local collapsedIconSize = UDim2.fromOffset(50, 50)
local collapsedTop = UDim2.new(0.5, 0, 0, 20)
local topToastOpenPosition = UDim2.new(0.5, 0, 0, 12)
local topToastClosedPosition = UDim2.new(0.5, 0, 0, collapsedTop.Y.Offset + collapsedSize.Y.Offset + 12)
local topToastMoveInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)

local maxToastWidth = 320

local compactRowHeight = 41

local lockScrimTransparency = 0.55
local lockedDescriptionTransparency = 0.55

local tabStagger = 0.04
local maxStaggeredTabs = 8

local viewportReconcileInterval = 2

local function fitWindowSize(mode): UDim2
    local camera = variables.workspace.CurrentCamera
    return windowSizing.fit(camera and camera.ViewportSize, mode)
end

local cornerNames = { "TopLeftRadius", "TopRightRadius", "BottomLeftRadius", "BottomRightRadius" }

local perCornerSupported = (function()
    return (
        pcall(function()
            local probe = Instance.new("UICorner")
            probe.TopLeftRadius = UDim.new(0, 1)
            probe:Destroy()
        end)
    )
end)()

local function resolveLayout(value)
    return if value then layouts.sidebar else layouts.top
end

local gradientKeys = {
    WindowColor = true,
    ElementGradient = true,
    ElementStrokeGradient = true,
    TabBackground = true,
    TabStroke = true,
    SliderProgress = true,
}

local function coerceThemeValue(key, value)
    if gradientKeys[key] and typeof(value) == "Color3" then
        return ColorSequence.new(value)
    end
    return value
end

local function firstColor(value)
    return if typeof(value) == "ColorSequence" then value.Keypoints[1].Value else value
end

local function setTopToastPosition(window, animate)
    local container = window._toastsTop
    if not container then
        return
    end

    local target = if window._collapsedShown then topToastClosedPosition else topToastOpenPosition
    if not animate or container.Position == target then
        container.Position = target
        return
    end

    variables.tweenService:Create(container, topToastMoveInfo, { Position = target }):Play()
end

local function edgeShade(color, amount)
    local luminance = 0.299 * color.R + 0.587 * color.G + 0.114 * color.B
    local target = if luminance > 0.5 then Color3.new(0, 0, 0) else Color3.new(1, 1, 1)
    return color:Lerp(target, amount)
end

local function deriveStrokes(resolved, overrides)
    if overrides.ElementGradient then
        local fill = firstColor(resolved.ElementGradient)
        if overrides.ElementStroke == nil then
            resolved.ElementStroke = edgeShade(fill, 0.28)
        end
        if overrides.ElementStrokeGradient == nil then
            resolved.ElementStrokeGradient = ColorSequence.new(edgeShade(fill, 0.4))
        end
        if overrides.ElementStrokeHover == nil then
            resolved.ElementStrokeHover = edgeShade(fill, 0.52)
        end
    end
    if overrides.TabBackground and overrides.TabStroke == nil then
        resolved.TabStroke = ColorSequence.new(edgeShade(firstColor(resolved.TabBackground), 0.4))
    end
end

local function themeOverrides(value)
    if typeof(value) == "table" then
        return value
    elseif typeof(value) == "string" then
        local named = themes:FindFirstChild(string.lower(value))
        if named then
            return require(named)
        end

        log.warn("Rayfield: unknown theme '" .. value .. "', using default")
    elseif value ~= nil then
        log.warn("Rayfield: invalid theme (expected a built-in name or a theme table), using default")
    end
    return require(themes["default"])
end

local function resolveTheme(value)
    local resolved = table.clone(require(themes["default"]))
    local overrides = themeOverrides(value)
    for key, override in overrides do
        resolved[key] = coerceThemeValue(key, override)
    end

    if typeof(value) == "table" then
        deriveStrokes(resolved, overrides)
    end

    local userTable = if typeof(value) == "table" then value else nil
    if not (userTable and (userTable.Font or userTable.font)) then
        resolved.Font = variables.brandFont(Enum.FontWeight.Medium)
    end
    if not (userTable and (userTable.TitleFont or userTable.titleFont)) then
        resolved.TitleFont = variables.brandFont(Enum.FontWeight.SemiBold)
    end

    return resolved
end

function Window.new(properties)
    properties = if typeof(properties) == "table" then properties else {}

    if properties.translations or properties.Translations then
        locale.register(properties.translations or properties.Translations)
    end
    if properties.translator or properties.Translator then
        locale.translator = properties.translator or properties.Translator
    end
    locale.setActive(properties.locale or properties.Locale or locale.detect())

    local fallbackFont = properties.fallbackFont or properties.FallbackFont
    if fallbackFont then
        variables.setFallbackFont(fallbackFont)
    end

    local layout = resolveLayout(properties.sidebarLayout or properties.SidebarLayout)

    local self = setmetatable({
        name = properties.name or properties.Name or "Rayfield Window",
        subheading = properties.subtitle or properties.Subtitle,
        layout = layout,
        size = fitWindowSize(layout.mode),
        instances = {},
        connections = {},

        icon = properties.icon or properties.Icon,
        showName = properties.showName or properties.ShowName or "Rayfield",
        showIcon = properties.showIcon or properties.ShowIcon or constants.icons.rayfield,

        showIconOnly = properties.showIconOnly or properties.ShowIconOnly or false,

        profileText = properties.profile or properties.Profile,

        themeProperties = {},
        localeProperties = {},
        tabs = {},
        tabSections = {},
        tags = {},
        selectedTab = nil,
        theme = resolveTheme(properties.theme or properties.Theme),

        controls = {},

        configuration = (function()
            local cfg = properties.configuration or properties.Configuration
            if not cfg then
                return {}
            end
            return {
                autoSave = cfg.autoSave or cfg.AutoSave,
                autoLoad = cfg.autoLoad or cfg.AutoLoad,
                fileName = cfg.fileName or cfg.FileName,
                customFolder = cfg.customFolder or cfg.CustomFolder,
            }
        end)(),
    }, Window)

    self.Flags = setmetatable({}, {
        __index = function(_, flag)
            local control = self.controls[flag]
            return control and control.value
        end,
        __newindex = function(_, flag, value)
            local control = self.controls[flag]
            if not control then
                log.warn("Rayfield: no flag '" .. tostring(flag) .. "' to set")
                return
            end
            control:Set(value)
        end,
        __iter = function()
            local flag
            return function()
                local control
                flag, control = next(self.controls, flag)
                if flag then
                    return flag, control.value
                end
                return nil
            end
        end,
    })

    self.settings = {
        toggleKeybind = Enum.KeyCode.K,
        mouseOverride = true,
        keepOnScreen = true,
        welcomeToast = true,
        haptics = true,
        showProfile = true,
    }

    self.screenGui = self:Create("ScreenGui", {
        Name = variables.httpService:GenerateGUID(false),
        IgnoreGuiInset = true,
        ResetOnSpawn = false,
        Enabled = true,
        DisplayOrder = constants.displayOrder.window,
        ZIndexBehavior = Enum.ZIndexBehavior.Global,

        Parent = variables.guiContainer,
    })

    self.main = self:Create("Frame", {
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        Name = self.name,
        ZIndex = 1,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new(0.5, 0, 0.5, 0),

        Size = UDim2.fromOffset((self.size.X.Offset - 50), 0),
        BackgroundTransparency = 1,
        Visible = false,

        Parent = self.screenGui,
    })

    self.drag = require(script.Parent.drag).new(self)

    self.windowCorner = self:Create("UICorner", {

        Parent = self.main,
    }, { CornerRadius = "CornerRoundness" })

    self.windowStroke = self:Create("UIStroke", {

        Transparency = 1,

        Parent = self.main,
    }, { Color = "SurfaceStroke" })

    self.windowGradient = self:Create("UIGradient", {
        Rotation = 270,
        Offset = Vector2.new(0, -0.1),

        Parent = self.main,
    }, { Color = { "WindowColor", functions.toColorSequence } })

    self.bottomFade = self:Create("Frame", {
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BorderSizePixel = 0,
        AnchorPoint = Vector2.new(1, 1),
        Position = UDim2.fromScale(1, 1),
        Size = self.layout.fadeSize,
        ZIndex = constants.zIndex.bottomFade,

        BackgroundTransparency = 1,

        Parent = self.main,
    })

    self.bottomFadeCorner = self:_roundCorners(self.bottomFade, self.layout.fadeCorners)

    self.bottomFadeGradient = self:Create("UIGradient", {
        Rotation = 270,
        Offset = Vector2.new(0, 0.2),
        Transparency = self.layout.fadeTransparency,

        Parent = self.bottomFade,
    }, {

        Color = {
            "WindowColor",
            function(color)
                return ColorSequence.new(functions.toColorSequence(color).Keypoints[1].Value)
            end,
        },
    })

    self.topbar = self:Create("Frame", {

        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, self.layout.topbarHeight),

        Active = true,

        Parent = self.main,
    })

    self.topContainer = self:Create("Frame", {
        Size = UDim2.new(0, 300, 0, 24),
        Position = UDim2.new(0, 25, 0.5, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        AnchorPoint = Vector2.new(0, 0.5),
        BackgroundTransparency = 1,

        Parent = self.topbar,
    })

    self.topContainerLayout = self:Create("UIListLayout", {
        Padding = UDim.new(0, 8),
        FillDirection = Enum.FillDirection.Horizontal,
        VerticalAlignment = Enum.VerticalAlignment.Center,
        HorizontalAlignment = Enum.HorizontalAlignment.Left,
        SortOrder = Enum.SortOrder.LayoutOrder,

        Parent = self.topContainer,
    })

    self.titleContainer = self:Create("Frame", {
        Size = UDim2.fromOffset(50, 24),
        Position = UDim2.new(0, 25, 0.5, 0),
        AutomaticSize = Enum.AutomaticSize.XY,
        AnchorPoint = Vector2.new(0, 0.5),
        BackgroundTransparency = 1,
        LayoutOrder = 1,

        Parent = self.topContainer,
    })

    self.titleContainerLayout = self:Create("UIListLayout", {
        Padding = UDim.new(0, 3),
        FillDirection = Enum.FillDirection.Vertical,
        VerticalAlignment = Enum.VerticalAlignment.Center,
        SortOrder = Enum.SortOrder.LayoutOrder,

        Parent = self.titleContainer,
    })

    if self.name then
        self.title = self:Create("TextLabel", {

            Text = locale.t(self.name),

            FontFace = variables.brandFont(Enum.FontWeight.Medium),

            Size = UDim2.fromOffset(50, 20),
            AutomaticSize = Enum.AutomaticSize.X,

            BackgroundTransparency = 1,
            TextSize = 20,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextWrapped = true,

            TextTransparency = 1,

            Parent = self.titleContainer,
        }, { FontFace = "Font", TextColor3 = "TitlingColor" })
    end

    if self.icon then
        self.topbarIcon = self:Create("ImageLabel", {
            Image = self.icon,

            BackgroundTransparency = 1,
            Size = UDim2.fromOffset(32, 32),

            ImageTransparency = 1,

            Parent = self.topContainer,
        }, { ImageColor3 = "TitlingColor" })
    end

    if self.subheading then
        self.subtitle = self:Create("TextLabel", {

            Text = locale.t(self.subheading),

            Size = UDim2.fromOffset(50, 12),
            AutomaticSize = Enum.AutomaticSize.X,
            BackgroundTransparency = 1,
            TextSize = 12,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextWrapped = true,

            TextTransparency = 1,

            Parent = self.titleContainer,
        }, { TextColor3 = "TitlingColor", FontFace = "Font" })
    end

    self.tagContainer = self:Create("Frame", {
        AnchorPoint = Vector2.new(0, 0.5),
        Position = UDim2.new(0, 25, 0.5, 0),
        Size = UDim2.fromOffset(50, 24),
        AutomaticSize = Enum.AutomaticSize.XY,
        BackgroundTransparency = 1,
        LayoutOrder = 2,
        Visible = false,

        Parent = self.topContainer,
    })

    self.tagContainerLayout = self:Create("UIListLayout", {
        Padding = UDim.new(0, 5),
        FillDirection = Enum.FillDirection.Horizontal,
        VerticalAlignment = Enum.VerticalAlignment.Center,
        SortOrder = Enum.SortOrder.LayoutOrder,

        Parent = self.tagContainer,
    })

    self.windowShadow = self:CreateGlow(self.main, "ShadowColor", 20, 1)

    self.elements = self:Create("Frame", {
        Size = UDim2.new(1, 0, 1, -self.layout.chromeHeight),
        Position = UDim2.fromScale(1, 1),
        AnchorPoint = Vector2.new(1, 1),
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BorderSizePixel = 0,
        BackgroundTransparency = 1,
        ClipsDescendants = true,

        Parent = self.main,
    })

    if self.layout.mode == "sidebar" then
        self.elementsCorner = self:_roundCorners(self.elements, self.layout.cardCorners)

        self.elementsStroke = self:Create("UIStroke", {
            ApplyStrokeMode = Enum.ApplyStrokeMode.Border,

            Transparency = 1,

            Parent = self.elements,
        }, { Color = "SurfaceStroke" })

        self:Create("UIGradient", {
            Rotation = self.layout.cardStrokeRotation,
            Transparency = self.layout.cardStrokeTransparency,

            Parent = self.elementsStroke,
        })
    end

    self.elementsLayout = self:Create("UIPageLayout", {
        Padding = UDim.new(0, 0),
        FillDirection = self.layout.pageDirection,
        VerticalAlignment = Enum.VerticalAlignment.Center,
        HorizontalAlignment = Enum.HorizontalAlignment.Center,
        SortOrder = Enum.SortOrder.LayoutOrder,

        ScrollWheelInputEnabled = false,
        GamepadInputEnabled = false,
        TouchInputEnabled = false,

        EasingStyle = Enum.EasingStyle.Exponential,
        TweenTime = 0.4,

        Parent = self.elements,
    })

    if self.layout.mode == "sidebar" then
        sidebar.build(self, self.layout)
        sidebar.applyWidth(self, layouts.railWidthFor(self.layout, self.size.X.Offset))
    else
        self.tabList = self:Create("ScrollingFrame", {
            Name = "Tabs",
            Active = true,
            Size = UDim2.new(1, 0, 0, self.layout.tabStripHeight),
            Position = UDim2.new(0.5, 0, 0, self.layout.tabStripTop),
            AnchorPoint = Vector2.new(0.5, 0),

            BackgroundTransparency = 1,
            AutomaticCanvasSize = Enum.AutomaticSize.X,
            CanvasSize = UDim2.new(0, 0, 0, 0),
            ScrollBarThickness = 0,
            ScrollBarImageTransparency = 1,
            ScrollingDirection = Enum.ScrollingDirection.X,

            Parent = self.main,
        })

        self.tabListLayout = self:Create("UIListLayout", {
            Padding = UDim.new(0, 7),
            FillDirection = Enum.FillDirection.Horizontal,
            VerticalAlignment = Enum.VerticalAlignment.Center,
            HorizontalAlignment = Enum.HorizontalAlignment.Left,
            SortOrder = Enum.SortOrder.LayoutOrder,

            Parent = self.tabList,
        })

        self:Create("UIPadding", {
            PaddingLeft = UDim.new(0, 22),
            PaddingRight = UDim.new(0, 10),

            Parent = self.tabList,
        })
    end

    self.actionContainer = self:Create("Frame", {

        AnchorPoint = Vector2.new(1, 0.5),
        AutomaticSize = Enum.AutomaticSize.X,
        Size = UDim2.fromOffset(0, 24),
        Position = UDim2.new(1, -20, 0.5, 0),
        BackgroundTransparency = 1,

        Parent = self.topbar,
    })

    self.actionsListLayout = self:Create("UIListLayout", {
        Padding = UDim.new(0, 5),
        FillDirection = Enum.FillDirection.Horizontal,
        VerticalAlignment = Enum.VerticalAlignment.Center,
        HorizontalAlignment = Enum.HorizontalAlignment.Right,
        SortOrder = Enum.SortOrder.LayoutOrder,

        Parent = self.actionContainer,
    })

    self.rfSettings = self:CreateTab({
        name = "Rayfield Settings",
        customOrder = 1000,

        neglectSelector = true,

        forgetState = true,
    })

    require(script.Parent.action).new(self, {
        name = "Close",
        icon = constants.icons.close,
        order = 1,

        callback = function()
            self:ToggleHide()
        end,
    })

    self.minimiseAction = require(script.Parent.action).new(self, {
        name = "Minimise",
        icon = constants.icons.minimise,
        order = 2,

        callback = function()
            self:ToggleMinimise()
        end,
    })

    self.settingsAction = require(script.Parent.action).new(self, {
        name = "Settings",
        icon = constants.icons.settings,
        order = 3,
        linkedTab = self.rfSettings,

        callback = function()
            self.rfSettings:Select()
        end,
    })

    search.build(self)

    self:_applyRailWidth()

    self.unloaded = false
    self.minimised = false
    self.hidden = true
    self.animating = false
    self._revealing = false
    self.hasShownOnce = false
    self._collapsedShown = false

    self:LoadSettings()
    if self.layout.mode == "sidebar" then
        sidebar.reflowProfile(self)
        sidebar.setSubtitle(self, self.profileText)
    end
    hapticEngine.setContainer(self.screenGui)
    hapticEngine.setEnabled(self.settings.haptics)
    chrome.buildCollapsedFace(self)
    self:_bindKeybind()
    self:_bindMouseOverride()
    self:_bindTopbarDrag()
    self:_watchViewport()
    self:_buildSettingsUI()

    self:_syncLiveAnimation()

    return self
end

function Window:_syncLiveAnimation()
    if not self.theme.LiveAnimation then
        self._liveAnimating = false
        return
    end
    if self._liveAnimating then
        return
    end

    self._liveAnimating = true

    self._liveGeneration = (self._liveGeneration or 0) + 1
    local generation = self._liveGeneration
    task.spawn(function()
        local out = true
        local tweenInfo = TweenInfo.new(10, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)

        while self._liveGeneration == generation and self._liveAnimating and not self.unloaded do
            local tweenW = variables.tweenService:Create(self.windowGradient, tweenInfo, {
                Offset = Vector2.new(if out then 0.4 else -0.2, 0),
                Rotation = (if out then 220 else 280),
            })

            self._liveTween = tweenW
            tweenW:Play()
            tweenW.Completed:Wait()
            out = not out
        end
        if self._liveGeneration == generation then
            self._liveAnimating = false
            self._liveTween = nil
        end
    end)
end

function Window:ChangeTheme(theme)

    local overrides = if typeof(theme) == "table" then theme else resolveTheme(theme)
    for name, value in overrides do
        self.theme[name] = coerceThemeValue(name, value)
    end

    if typeof(theme) == "table" then
        deriveStrokes(self.theme, overrides)
    end

    for instance, properties in self.themeProperties do
        for property, value in properties do
            local targetValue = if typeof(value) == "table" then value[2](self.theme[value[1]]) else self.theme[value]

            if typeof(targetValue) == "Color3" or typeof(targetValue) == "number" then
                variables.tweenService
                    :Create(
                        instance,
                        TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
                        { [property] = targetValue }
                    )
                    :Play()
            else
                instance[property] = targetValue
            end
        end
    end

    if self.hidden then

        self._themeRefreshPending = true
    else
        self:_refreshElementThemes()
    end

    self:_syncLiveAnimation()
end

function Window:_refreshElementThemes()
    for _, tab in self.tabs do
        for _, element in tab.elements do
            if element._refreshTheme then
                element:_refreshTheme()
            end
        end
    end
end

function Window:CreateTab(properties)
    assert(not self.unloaded, "Cannot create a tab on an unloaded window.")
    local newTab = require(script.Parent.tab).new(self, properties)

    table.insert(self.tabs, newTab)

    if not newTab.neglectSelector then
        local isFirstVisible = true
        for _, tab in self.tabs do
            if tab ~= newTab and not tab.neglectSelector then
                isFirstVisible = false
                break
            end
        end
        if isFirstVisible then
            newTab:Select(true)
        end

        if not self.hidden and not self.minimised then
            newTab.topbarItem.Visible = true
            newTab:_applyVisual(
                if self.selectedTab == newTab then "selected" else "unselected",
                TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
            )
        end
    end

    return newTab
end

function Window:CreateSection(properties)
    assert(not self.unloaded, "Cannot create a section on an unloaded window.")
    local section = require(script.Parent.tabSection).new(self, properties)
    table.insert(self.tabSections, section)

    if not section.inert and not self.hidden and not self.minimised then
        section:_setVisible(true)
        section:_setShown(true, TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out))
    end

    return section
end

function Window:_setTabSectionsShown(shown, tweenInfo)
    for _, section in self.tabSections do
        section:_setShown(shown, tweenInfo)
    end
end

function Window:_setTabSectionsVisible(visible)
    for _, section in self.tabSections do
        section:_setVisible(visible)
    end
end

function Window:CreateTag(properties)
    assert(not self.unloaded, "Cannot create a tag on an unloaded window.")
    local newTag = require(script.Parent.tag).new(self, properties)
    table.insert(self.tags, newTag)
    return newTag
end

function Window:_registerControl(control)
    if not control.flag or control.flag == "" or control.forgetState then
        return
    end

    local flag = control.flag
    if self.controls[flag] then
        local n = 2
        while self.controls[flag .. n] do
            n += 1
        end
        flag = flag .. n
        log.warn(
            "Rayfield: duplicate config flag '"
                .. control.flag
                .. "', saving this one as '"
                .. flag
                .. "'. Set a unique flag to keep it stable across sessions."
        )
    end

    control.flag = flag
    self.controls[flag] = control
    return flag
end

function Window:_restoreLate(element)
    if not self._loadedConfig or not element.flag or element.forgetState then
        return
    end

    local wasLoading = self._loading
    self._loading = true
    persistence.applyTo(element, self._loadedConfig[element.flag])
    self._loading = wasLoading
end

function Window:_persist(control)

    if control.flag and not control.forgetState and self.configuration.autoSave and not self._loading then
        task.spawn(self.Save, self)
    end
end

function Window:_unregisterControl(control)
    if control.flag and self.controls[control.flag] == control then
        self.controls[control.flag] = nil
    end
end

function Window:_keybindUsing(key, exclude)
    if typeof(key) ~= "EnumItem" or key == Enum.KeyCode.Unknown then
        return nil
    end
    for _, tab in self.tabs do
        for _, element in tab.elements do
            if element ~= exclude and element.__type == "Keybind" and element.value == key then
                return element
            end
        end
    end
    return nil
end

function Window:Notify(properties)
    if self.unloaded then
        return
    end
    if not self.notifications then
        self.notifications = self:Create("Frame", {
            Name = "Notifications",
            Size = UDim2.new(0, 300, 0, 800),
            Position = UDim2.new(1, -20, 1, -20),
            AnchorPoint = Vector2.new(1, 1),
            BackgroundTransparency = 1,

            Parent = self.screenGui,
        })

        self:Create("UIListLayout", {
            FillDirection = Enum.FillDirection.Vertical,
            VerticalAlignment = Enum.VerticalAlignment.Bottom,
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            SortOrder = Enum.SortOrder.LayoutOrder,

            Padding = UDim.new(0, 0),

            Parent = self.notifications,
        })
    end

    return require(script.Parent.notification).new(self, properties)
end

function Window:Toast(properties)
    if self.unloaded then
        return
    end

    properties = if typeof(properties) == "table" then properties else {}
    local position = properties.position or properties.Position or "Top"
    local isTop = typeof(position) ~= "string" or position:lower() ~= "bottom"
    properties.position = if isTop then "Top" else "Bottom"
    local containerKey = if isTop then "_toastsTop" else "_toastsBottom"
    local container = self[containerKey]

    if not container then
        container = self:Create("Frame", {
            Name = "Toasts",
            Size = UDim2.new(0, maxToastWidth, 1, -24),
            Position = if isTop then topToastOpenPosition else UDim2.new(0.5, 0, 1, -12),
            AnchorPoint = if isTop then Vector2.new(0.5, 0) else Vector2.new(0.5, 1),
            BackgroundTransparency = 1,
            ZIndex = constants.zIndex.toast,

            Parent = self.screenGui,
        })

        self:Create("UIListLayout", {
            FillDirection = Enum.FillDirection.Vertical,
            VerticalAlignment = if isTop then Enum.VerticalAlignment.Top else Enum.VerticalAlignment.Bottom,
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            SortOrder = Enum.SortOrder.LayoutOrder,

            Padding = UDim.new(0, 0),

            Parent = container,
        })

        self[containerKey] = container

        if isTop then
            setTopToastPosition(self, false)
        end
    end

    return require(script.Parent.toast).new(self, properties, container)
end

function Window:Popup(properties)
    if self.unloaded then
        return
    end
    return require(script.Parent.popup).new(self, properties)
end

function Window:Hide()

    if self.animating or self.hidden then
        return
    end

    if self._searching then
        search.close(self, { showTabs = false, jumpTo = self.selectedTab and self.selectedTab.tabPage })
    end

    if self._recordingKeybind then
        self._recordingKeybind:_stopRecording()
    end

    self.animating = true
    self._revealing = true
    self.hidden = true
    self.collapsedInteract.Visible = false

    if self.minimised then
        self.minimised = false
        image.assign(self.minimiseAction.iconLabel, "Image", constants.icons.minimise)
    end

    self._restorePosition = self.main.Position

    local home, size = self:_collapsedRect()

    local fadeInfo = TweenInfo.new(0.18, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)

    local moveInfo = TweenInfo.new(0.35, Enum.EasingStyle.Exponential, Enum.EasingDirection.InOut)
    local cornerInfo = TweenInfo.new(0.35, Enum.EasingStyle.Exponential, Enum.EasingDirection.InOut)
    local faceInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)

    variables.tweenService
        :Create(self.drag.dragCosmetic, fadeInfo, { Size = UDim2.fromOffset(0, 4), BackgroundTransparency = 1 })
        :Play()
    task.delay(0.18, function()
        if not self.hidden then
            return
        end
        self.drag.drag.Visible = false
    end)

    self:_fadeSurfaces(false, fadeInfo)

    if self.title then
        variables.tweenService:Create(self.title, fadeInfo, { TextTransparency = 1 }):Play()
    end
    if self.subtitle then
        variables.tweenService:Create(self.subtitle, fadeInfo, { TextTransparency = 1 }):Play()
    end
    if self.topbarIcon then
        variables.tweenService:Create(self.topbarIcon, fadeInfo, { ImageTransparency = 1 }):Play()
    end

    for _, action in ipairs(self.actionContainer:GetChildren()) do
        if action:IsA("Frame") then
            variables.tweenService:Create(action.ImageLabel, fadeInfo, { ImageTransparency = 1 }):Play()
        end
    end

    for _, tag in self.tags do
        tag:_setShown(false, fadeInfo)
    end

    for _, tab in pairs(self.tabs) do
        if not tab.neglectSelector and tab.topbarItem then
            tab:_applyVisual("hidden", fadeInfo)
        end
    end
    self:_setTabSectionsShown(false, fadeInfo)

    self:_fadeSelectedElementsOut()

    local collapse = variables.tweenService:Create(self.main, moveInfo, { Size = size, Position = home })
    collapse.Completed:Connect(function()

        if self.unloaded or not self.hidden then
            return
        end

        self._collapsedShown = true
        setTopToastPosition(self, true)
        self.collapsedInteract.Visible = true
        self.animating = false
        self._revealing = false
    end)
    collapse:Play()
    variables.tweenService:Create(self.windowCorner, cornerInfo, { CornerRadius = UDim.new(1, 0) }):Play()

    task.delay(0.18, function()
        if not self.hidden then
            return
        end
        self.topbar.Visible = false
        self:_setContentVisible(false)

        chrome.setCollapsedShown(self, true, faceInfo)
    end)
end

function Window:ToggleHide()
    if self.animating then
        return
    end
    if self.hidden then
        self:Show()
    else
        self:Hide()
    end
end

function Window:ToggleMinimise()
    if self.animating or self.hidden then
        return
    end

    if self._searching then
        search.close(self, { showTabs = true })
    end

    self.animating = true

    local sizeInfo = TweenInfo.new(0.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)
    local fadeInfo = TweenInfo.new(0.4, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)

    if self.minimised then
        self.minimised = false
        image.assign(self.minimiseAction.iconLabel, "Image", constants.icons.minimise)

        variables.tweenService:Create(self.main, sizeInfo, { Size = self.size }):Play()
        self:_fadeSurfaces(true, fadeInfo)

        variables.tweenService
            :Create(self.drag.drag, sizeInfo, {
                Position = UDim2.new(
                    self.main.Position.X.Scale,
                    self.main.Position.X.Offset,
                    self.main.Position.Y.Scale,
                    self.main.Position.Y.Offset + self.size.Y.Offset / 2 + 15
                ),
            })
            :Play()

        task.delay(0.2, function()
            if self.minimised or self.hidden then
                return
            end
            self:_setContentVisible(true)

            for _, tab in pairs(self.tabs) do
                if not tab.neglectSelector and tab.topbarItem then
                    tab.topbarItem.Visible = true
                    tab:_applyVisual(if self.selectedTab == tab then "selected" else "unselected", fadeInfo)
                end
            end
            self:_setTabSectionsVisible(true)
            self:_setTabSectionsShown(true, fadeInfo)

            self:_revealElements(0.035, 0.4)
        end)

        task.delay(0.5, function()
            self.animating = false
        end)
    else
        self.minimised = true
        image.assign(self.minimiseAction.iconLabel, "Image", constants.icons.maximise)

        self:_fadeSelectedElementsOut()
        for _, tab in pairs(self.tabs) do
            if not tab.neglectSelector and tab.topbarItem then
                tab:_applyVisual("hidden", fadeInfo)
            end
        end
        self:_setTabSectionsShown(false, fadeInfo)

        task.delay(0.3, function()
            if not self.minimised then
                return
            end
            self:_setContentVisible(false)
            for _, tab in pairs(self.tabs) do
                if not tab.neglectSelector and tab.topbarItem then
                    tab.topbarItem.Visible = false
                end
            end
            self:_setTabSectionsVisible(false)
        end)

        self:_fadeSurfaces(false, fadeInfo)
        variables.tweenService
            :Create(self.main, sizeInfo, { Size = UDim2.fromOffset(self.size.X.Offset, self.layout.topbarHeight) })
            :Play()

        variables.tweenService
            :Create(self.drag.drag, sizeInfo, {
                Position = UDim2.new(
                    self.main.Position.X.Scale,
                    self.main.Position.X.Offset,
                    self.main.Position.Y.Scale,
                    self.main.Position.Y.Offset + self.layout.topbarHeight / 2 + 15
                ),
            })
            :Play()

        task.delay(0.5, function()
            self.animating = false
        end)
    end
end

function Window:_syncDragBar()
    local bar = self.drag and self.drag.drag
    if not bar then
        return
    end
    local position = self.main.Position
    local below = self.size.Y.Offset / 2 + 15
    bar.Position = UDim2.new(position.X.Scale, position.X.Offset, position.Y.Scale, position.Y.Offset + below)
end

function Window:_clampedPosition(position: UDim2): UDim2
    if not self.settings or not self.settings.keepOnScreen then
        return position
    end

    if position.X.Scale ~= 0 or position.Y.Scale ~= 0 then
        return position
    end

    local screen = self.screenGui.AbsoluteSize
    local halfX, halfY = self.size.X.Offset / 2, self.size.Y.Offset / 2
    local margin = 8

    local x = math.clamp(position.X.Offset, halfX + margin, math.max(halfX + margin, screen.X - halfX - margin))
    local y = math.clamp(position.Y.Offset, halfY + margin, math.max(halfY + margin, screen.Y - halfY - margin))
    if x == position.X.Offset and y == position.Y.Offset then
        return position
    end
    return UDim2.fromOffset(x, y)
end

function Window:_clampToScreen()
    self.main.Position = self:_clampedPosition(self.main.Position)
end

function Window:_applyWindowSize()
    if self.unloaded then
        return
    end

    local size = fitWindowSize(self.layout.mode)
    local changed = size ~= self.size
    self.size = size

    self:_applyRailWidth()

    if self.hidden or self.minimised or self.animating or self._revealing then
        self._pendingResize = self._pendingResize or changed
        return
    end

    if not changed and not self._pendingResize then
        return
    end
    self._pendingResize = false

    self.main.Size = size
    self:_clampToScreen()
    self:_syncDragBar()
end

function Window:_applyRailWidth()
    if self.layout.mode ~= "sidebar" then
        return
    end
    sidebar.applyWidth(self, layouts.railWidthFor(self.layout, self.size.X.Offset))
end

function Window:_watchViewport()
    local cameraConnection: RBXScriptConnection? = nil
    local pending = false

    local function request()

        if pending then
            return
        end
        pending = true
        task.defer(function()
            pending = false
            self:_applyWindowSize()
        end)
    end

    local function bind()
        if cameraConnection then
            self:Disconnect(cameraConnection)
            cameraConnection = nil
        end
        local camera = variables.workspace.CurrentCamera
        if camera then
            cameraConnection = self:Connect(camera:GetPropertyChangedSignal("ViewportSize"), request)
        end
        request()
    end

    self:Connect(variables.workspace:GetPropertyChangedSignal("CurrentCamera"), bind)
    bind()

    local sinceReconcile = 0
    self:Connect(variables.runService.Heartbeat, function(delta: number)
        sinceReconcile += delta
        if sinceReconcile < viewportReconcileInterval then
            return
        end
        sinceReconcile = 0
        self:_applyWindowSize()
    end)
end

function Window:_bindKeybind()
    self:Connect(variables.userInputService.InputBegan, function(input, processed)
        if processed or self._recordingKeybind then
            return
        end
        if input.KeyCode == self.settings.toggleKeybind or input.UserInputType == self.settings.toggleKeybind then
            self:ToggleHide()
        end
    end)
end

function Window:_bindMouseOverride()
    local uis = variables.userInputService

    local function active()
        return self.settings.mouseOverride and not self.hidden and not self.minimised
    end

    local function free()
        if not active() then
            return
        end

        if uis:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then
            return
        end
        if uis.MouseBehavior ~= Enum.MouseBehavior.Default then
            uis.MouseBehavior = Enum.MouseBehavior.Default
        end
        if not uis.MouseIconEnabled then
            uis.MouseIconEnabled = true
        end
    end

    self:Connect(uis:GetPropertyChangedSignal("MouseBehavior"), free)
    self:Connect(uis:GetPropertyChangedSignal("MouseIconEnabled"), free)

    self:Connect(uis.InputEnded, function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton2 then
            free()
        end
    end)

    self._freeMouse = free
end

function Window:_bindTopbarDrag()
    local uis = variables.userInputService
    local dragging = false
    local relative = Vector2.zero

    local offset = Vector2.zero
    if self.screenGui and self.screenGui.IgnoreGuiInset then
        offset = variables.guiService:GetGuiInset()
    end

    local function getTarget()
        local position = uis:GetMouseLocation() + relative + offset
        local x, y = position.X, position.Y

        if self.settings and self.settings.keepOnScreen then
            local size = self.main.AbsoluteSize
            local screen = self.screenGui.AbsoluteSize
            local margin = 8
            local halfX, halfY = size.X / 2, size.Y / 2
            x = math.clamp(x, halfX + margin, math.max(halfX + margin, screen.X - halfX - margin))
            y = math.clamp(y, halfY + margin, math.max(halfY + margin, screen.Y - halfY - margin))
        end

        return UDim2.fromOffset(x, y)
    end

    local function overInteractiveChild(x, y)
        for _, region in { self.tabList, self.actionContainer } do
            local position, size = region.AbsolutePosition, region.AbsoluteSize
            if x >= position.X and x <= position.X + size.X and y >= position.Y and y <= position.Y + size.Y then
                return true
            end
        end
        return false
    end

    self:Connect(self.topbar.InputBegan, function(input, processed)
        if processed then
            return
        end

        local inputType = input.UserInputType.Name
        if inputType ~= "MouseButton1" and inputType ~= "Touch" then
            return
        end

        if overInteractiveChild(input.Position.X, input.Position.Y) then
            return
        end

        if not self:_interactive() then
            return
        end

        dragging = true

        if self.screenGui and self.screenGui.IgnoreGuiInset then
            offset = variables.guiService:GetGuiInset()
        end

        relative = self.main.AbsolutePosition + self.main.AbsoluteSize * self.main.AnchorPoint - uis:GetMouseLocation()
    end)

    self:Connect(uis.InputEnded, function(input)
        local inputType = input.UserInputType.Name
        if inputType == "MouseButton1" or inputType == "Touch" then
            dragging = false
        end
    end)

    self:Connect(uis.WindowFocusReleased, function()
        dragging = false
    end)

    self:Connect(variables.runService.RenderStepped, function()
        if not dragging then
            return
        end

        if not self:_interactive() then
            dragging = false
            return
        end

        self.main.Position = getTarget()

        if self.drag and self.drag.drag then
            local mainPosition = self.main.Position
            self.drag.drag.Position = UDim2.new(
                mainPosition.X.Scale,
                mainPosition.X.Offset,
                mainPosition.Y.Scale,
                mainPosition.Y.Offset + (self.main.Size.Y.Offset / 2 + 15)
            )
        end
    end)
end

function Window:_buildSettingsUI()
    self.rfSettings:CreateSection({ name = "General" })

    self.rfSettings:CreateKeybind({
        name = "Toggle Keybind",
        icon = constants.icons.search,
        value = self.settings.toggleKeybind,
        isMenuToggle = true,
        onChanged = function(key)
            self.settings.toggleKeybind = key
            self:SaveSettings()
        end,
    })

    self.rfSettings:CreateToggle({
        name = "Unlock cursor while open",
        description = "Unlocks the cursor while the menu is open so you can configure in FPS games that lock it.",
        value = self.settings.mouseOverride,
        callback = function(state)
            self.settings.mouseOverride = state
            self:SaveSettings()
        end,
    })

    self.rfSettings:CreateToggle({
        name = "Welcome toast",
        description = "Shows a 'Signed in as' toast the first time you open the menu on a new account.",
        value = self.settings.welcomeToast,
        callback = function(state)
            self.settings.welcomeToast = state
            self:SaveSettings()
        end,
    })

    self.rfSettings:CreateToggle({
        name = "Haptics",
        description = "A subtle tap as you interact, on devices that support haptics.",
        value = self.settings.haptics,
        callback = function(state)
            self.settings.haptics = state
            hapticEngine.setEnabled(state)
            self:SaveSettings()
        end,
    })

    self.rfSettings:CreateSection({ name = "Window" })

    if self.layout.mode == "sidebar" and self.profile then
        self.rfSettings:CreateToggle({
            name = "Show profile",
            description = "Shows your avatar and name at the base of the sidebar. Turn it off to keep "
                .. "them out of a stream or a screenshot.",
            value = self.settings.showProfile,
            callback = function(state)
                sidebar.setProfileEnabled(self, state)
                self:SaveSettings()
            end,
        })
    end

    self.rfSettings:CreateToggle({
        name = "Keep window on screen",
        description = "Stops the window being dragged off the edge of the screen and lost.",
        value = self.settings.keepOnScreen,
        callback = function(state)
            self.settings.keepOnScreen = state
            self:SaveSettings()
        end,
    })

    self.rfSettings:CreateButton({
        name = "Reset Window Position",
        callback = function()
            variables.tweenService
                :Create(self.main, TweenInfo.new(0.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
                    Position = UDim2.new(0.5, 0, 0.5, 0),
                })
                :Play()
            variables.tweenService
                :Create(self.drag.drag, TweenInfo.new(0.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
                    Position = UDim2.new(0.5, 0, 0.5, self.size.Y.Offset / 2 + 15),
                })
                :Play()
        end,
    })

    if next(self.configuration) ~= nil then
        self.rfSettings:CreateSection({ name = "Configurations" })

        local selected = self:ListConfigs()[1]
        local configDropdown, nameInput

        local function refreshConfigs()
            local names = self:ListConfigs()
            configDropdown:Refresh(names)
            if selected and not table.find(names, selected) then
                selected = names[1]
            end
            if selected then
                configDropdown:Set(selected, true)
            end
        end

        configDropdown = self.rfSettings:CreateDropdown({
            name = "Saved Configurations",
            icon = constants.icons.config,
            options = self:ListConfigs(),
            value = selected,
            placeholder = "No saved configurations",
            callback = function(value)
                selected = value
            end,
        })

        nameInput = self.rfSettings:CreateInput({
            name = "Configuration Name",
            description = "Name a new configuration, or leave blank to overwrite the selected one.",
            placeholder = "e.g. PvP Loadout",
            clearOnFocus = false,
        })

        local actions = self.rfSettings:CreateGroup()

        actions:CreateButton({
            name = "Save",
            icon = constants.icons.config,
            callback = function()
                local name = nameInput.value
                if name == "" then
                    name = selected
                end
                if not name or name == "" then
                    self:Toast({ title = locale.resolve("Name your configuration first") })
                    return
                end
                if self:Save(name) then
                    nameInput:Set("")
                    selected = name
                    refreshConfigs()
                    self:Toast({
                        title = locale.resolve("Saved configuration"),
                        subtitle = name,
                        icon = constants.icons.config,
                    })
                else
                    self:Toast({ title = locale.resolve("Couldn't save configuration"), subtitle = name })
                end
            end,
        })

        actions:CreateButton({
            name = "Load",
            callback = function()
                if not selected or selected == "" then
                    self:Toast({ title = locale.resolve("Pick a configuration to load") })
                    return
                end
                if self:_applyNamedConfig(selected) then
                    self:Toast({ title = locale.resolve("Loaded configuration"), subtitle = selected })
                else
                    self:Toast({ title = locale.resolve("Couldn't load configuration"), subtitle = selected })
                end
            end,
        })

        actions:CreateButton({
            name = "Delete",
            callback = function()
                local deleting = selected
                if not deleting or deleting == "" then
                    self:Toast({ title = locale.resolve("Pick a configuration to delete") })
                    return
                end
                if self:DeleteConfig(deleting) then
                    refreshConfigs()
                    self:Toast({ title = locale.resolve("Deleted configuration"), subtitle = deleting })
                else
                    self:Toast({ title = locale.resolve("Couldn't delete configuration"), subtitle = deleting })
                end
            end,
        })
    end
end

function Window:SetProfile(text)
    self.profileText = text
    sidebar.setSubtitle(self, text)
end

function Window:SaveSettings()
    return persistence.saveSettings(self)
end

function Window:LoadSettings()
    return persistence.loadSettings(self)
end

function Window:_roundCorners(parent, corners)
    if not corners or not perCornerSupported then
        return self:Create("UICorner", {
            Parent = parent,
        }, { CornerRadius = "CornerRoundness" })
    end

    local properties = { Parent = parent }
    local themed = {}
    for _, name in cornerNames do
        properties[name] = UDim.new(0, 0)
    end
    for _, name in corners do
        properties[name] = nil
        themed[name] = "CornerRoundness"
    end

    return self:Create("UICorner", properties, themed)
end

function Window:_setElementLocked(element, locked, reason)
    locked = locked == true

    local wasLocked = element.locked == true
    if wasLocked == locked and not (locked and reason) then
        return
    end
    element.locked = locked

    if not element.lockScrim then
        self:_buildLockScrim(element)
    end

    local info = TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)

    if locked then
        element.lockScrim.Visible = true
    end
    variables.tweenService
        :Create(element.lockScrim, info, {
            BackgroundTransparency = if locked then lockScrimTransparency else 1,
        })
        :Play()
    if not locked then
        task.delay(info.Time, function()
            if not element.locked and element.lockScrim then
                element.lockScrim.Visible = false
            end
        end)
    end

    local descriptor = element.descriptor
    if not descriptor then
        return
    end

    if locked then

        element._descriptionBefore = element._descriptionBefore or descriptor.titleLabel.Text
        descriptor.titleLabel.Text = locale.resolve(reason or "This element is locked.")
    elseif element._descriptionBefore then
        descriptor.titleLabel.Text = element._descriptionBefore
        element._descriptionBefore = nil
    end

    variables.tweenService
        :Create(descriptor.titleLabel, info, {
            TextTransparency = if locked then lockedDescriptionTransparency else 0.7,
        })
        :Play()
end

function Window:_buildLockScrim(element)
    element.lockScrim = self:Create("TextButton", {
        Name = "ElementLock",
        Active = true,
        AutoButtonColor = false,
        Size = UDim2.fromScale(1, 1),
        BorderSizePixel = 0,
        Text = "",
        TextTransparency = 1,
        ZIndex = constants.zIndex.elementLock,
        Visible = false,

        BackgroundTransparency = 1,

        Parent = element.main,
    }, { BackgroundColor3 = { "WindowColor", firstColor } })

    self:Create("UICorner", {
        Parent = element.lockScrim,
    }, { CornerRadius = "ElementCornerRadius" })
end

function Window:_setContentVisible(visible)
    self.elements.Visible = visible
    self.tabList.Visible = visible
    if self.sidebar then
        self.sidebar.Visible = visible
    end
end

function Window:_fadeSurfaces(shown, fadeInfo)
    local targets = {
        [self.windowShadow] = { Transparency = if shown then 0.6 else 1 },
        [self.windowStroke] = { Transparency = if shown then 0.95 else 1 },
        [self.bottomFade] = { BackgroundTransparency = if shown then 0 else 1 },
    }

    if self.elementsStroke then
        targets[self.elements] = {
            BackgroundTransparency = if shown then self.layout.cardTransparency else 1,
        }
        targets[self.elementsStroke] = { Transparency = if shown then 0 else 1 }
    end

    for instance, properties in targets do
        if fadeInfo then
            variables.tweenService:Create(instance, fadeInfo, properties):Play()
        else
            for property, value in properties do
                instance[property] = value
            end
        end
    end

    sidebar.setProfileShown(self, shown, fadeInfo)
end

function Window:_fadeSelectedElementsOut()
    if self.selectedTab then
        for _, element in ipairs(self.selectedTab.elements) do
            element:_setShown(false, true)
        end
    end
end

function Window:_revealElements(perElementDelay, budget)
    for _, tab in pairs(self.tabs) do
        if tab ~= self.selectedTab then
            for _, element in ipairs(tab.elements) do
                element:_setShown(true, false)
            end
        end
    end

    local tab = self.selectedTab
    if not tab then
        return
    end

    local page = tab.tabPage
    local viewTop = page.AbsolutePosition.Y
    local viewBottom = viewTop + page.AbsoluteWindowSize.Y

    local maxStaggered = math.floor(budget / perElementDelay)
    local staggered = 0
    for _, element in ipairs(tab.elements) do
        local top = element.main.AbsolutePosition.Y
        local onScreen = (top + element.main.AbsoluteSize.Y) > viewTop and top < viewBottom
        if onScreen then
            element:_setShown(true, true)
            staggered += 1
            if staggered <= maxStaggered then
                task.wait(perElementDelay)
            end
        else
            element:_setShown(true, false)
        end
    end
end

function Window:Show()

    if self.animating or not self.hidden then
        return
    end
    self.animating = true
    self._revealing = true

    if self.configuration.autoLoad and not self._autoLoaded then
        self._autoLoaded = true
        local ok, err = pcall(self.Load, self)
        if not ok then
            log.warn("Rayfield: Failed to load configuration - " .. tostring(err))
        end
    end

    self.hidden = false
    self.minimised = false

    if self._themeRefreshPending then
        self._themeRefreshPending = false
        self:_refreshElementThemes()
    end

    self.collapsedInteract.Visible = false

    if self._freeMouse then
        self._freeMouse()
    end

    if self.hasShownOnce then
        self:_quickRestore()
    else
        self.hasShownOnce = true
        self:_firstShow()
    end
end

function Window:_quickRestore()

    local target = self:_clampedPosition(self._restorePosition or UDim2.new(0.5, 0, 0.5, 0))
    self._restorePosition = target

    local growInfo = TweenInfo.new(0.35, Enum.EasingStyle.Exponential, Enum.EasingDirection.InOut)
    local cornerInfo = TweenInfo.new(0.35, Enum.EasingStyle.Exponential, Enum.EasingDirection.InOut)
    local fadeInfo = TweenInfo.new(0.28, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)

    chrome.setCollapsedShown(self, false, TweenInfo.new(0.15, Enum.EasingStyle.Quint, Enum.EasingDirection.Out))
    local restore = variables.tweenService:Create(self.main, growInfo, { Size = self.size, Position = target })
    restore.Completed:Connect(function()
        if self.hidden or self.unloaded then
            return
        end

        self._collapsedShown = false
        setTopToastPosition(self, true)
    end)
    restore:Play()
    variables.tweenService:Create(self.windowCorner, cornerInfo, { CornerRadius = self.theme.CornerRoundness }):Play()

    task.delay(0.22, function()
        self.topbar.Visible = true
        self:_setContentVisible(true)

        self:_fadeSurfaces(true, fadeInfo)

        if self.topbarIcon then
            variables.tweenService:Create(self.topbarIcon, fadeInfo, { ImageTransparency = 0 }):Play()
        end
        if self.title then
            variables.tweenService:Create(self.title, fadeInfo, { TextTransparency = 0 }):Play()
        end
        if self.subtitle then
            variables.tweenService:Create(self.subtitle, fadeInfo, { TextTransparency = 0.7 }):Play()
        end

        for _, action in ipairs(self.actionContainer:GetChildren()) do
            if action:IsA("Frame") then
                variables.tweenService:Create(action.ImageLabel, fadeInfo, { ImageTransparency = 0.6 }):Play()
            end
        end

        if self.settingsAction and self.selectedTab == self.rfSettings then
            variables.tweenService:Create(self.settingsAction.iconLabel, fadeInfo, { ImageTransparency = 0.2 }):Play()
        end

        for _, tag in self.tags do
            tag:_setShown(true, fadeInfo)
        end

        for _, tab in pairs(self.tabs) do
            if not tab.neglectSelector and tab.topbarItem then
                tab.topbarItem.Visible = true
                tab:_applyVisual(if self.selectedTab == tab then "selected" else "unselected", fadeInfo)
            end
        end
        self:_setTabSectionsVisible(true)
        self:_setTabSectionsShown(true, fadeInfo)

        self:_revealElements(0.035, 0.4)
    end)

    task.delay(0.22, function()
        self.drag.drag.Position =
            UDim2.new(target.X.Scale, target.X.Offset, target.Y.Scale, target.Y.Offset + self.size.Y.Offset / 2 + 15)
        self.drag.dragCosmetic.Size = UDim2.fromOffset(0, 4)
        self.drag.dragCosmetic.BackgroundTransparency = 1
        self.drag.drag.Visible = true
        variables.tweenService
            :Create(self.drag.dragCosmetic, growInfo, { Size = UDim2.fromOffset(100, 4), BackgroundTransparency = 0.7 })
            :Play()
    end)

    task.delay(0.6, function()
        self.animating = false
        self._revealing = false
    end)
end

function Window:_firstShow()

    self:_setContentVisible(true)

    self.drag.drag.Visible = false
    self.main.Visible = true
    variables.tweenService
        :Create(
            self.main,
            TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.InOut),
            { BackgroundTransparency = 0, Size = self.size }
        )
        :Play()
    task.wait(0.85)
    self:_fadeSurfaces(true, TweenInfo.new(0.6, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out))
    task.wait(0.3)

    if self.icon then
        variables.tweenService
            :Create(
                self.topbarIcon,
                TweenInfo.new(0.6, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out),
                { ImageTransparency = 0 }
            )
            :Play()
    end
    if self.title then
        variables.tweenService
            :Create(
                self.title,
                TweenInfo.new(0.4, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out),
                { TextTransparency = 0 }
            )
            :Play()
    end
    task.wait(0.1)
    if self.subtitle then
        variables.tweenService
            :Create(
                self.subtitle,
                TweenInfo.new(0.4, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out),
                { TextTransparency = 0.7 }
            )
            :Play()
    end

    for _, action in ipairs(self.actionContainer:GetChildren()) do
        if action:IsA("Frame") then
            task.wait(0.02)
            variables.tweenService
                :Create(
                    action.ImageLabel,
                    TweenInfo.new(0.4, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out),
                    { ImageTransparency = 0.6 }
                )
                :Play()
        end
    end

    for _, tag in self.tags do
        tag:_setShown(true, TweenInfo.new(0.4, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out))
    end

    task.wait(0.2)

    task.spawn(function()
        local info = TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)

        self:_setTabSectionsVisible(true)
        self:_setTabSectionsShown(true, info)

        local staggered = 0
        for _, tab in pairs(self.tabs) do
            if not tab.neglectSelector then
                tab.topbarItem.Visible = true
                tab:_applyVisual(if self.selectedTab == tab then "selected" else "unselected", info)
                tab:_spinGradients()

                staggered += 1
                if staggered <= maxStaggeredTabs then
                    task.wait(tabStagger)
                end
            end
        end
    end)

    self:_revealElements(0.03, 2)

    task.wait(1)

    self:_syncDragBar()
    self.drag.drag.Visible = true
    variables.tweenService
        :Create(
            self.drag.dragCosmetic,
            TweenInfo.new(0.6, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out),
            { BackgroundTransparency = 0.7 }
        )
        :Play()
    variables.tweenService
        :Create(
            self.drag.dragCosmetic,
            TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out),
            { Size = UDim2.fromOffset(100, 4) }
        )
        :Play()

    self.animating = false
    self._revealing = false

    local localPlayer = variables.localPlayer
    if localPlayer and self.settings.welcomeToast and chrome.isNewUser() then
        self:Toast({
            title = localPlayer.DisplayName,
            subtitle = locale.resolve("Signed in as"),
            subtitleAbove = true,
            avatar = localPlayer.UserId,
            minWidth = 220,
        })
    end
end

function Window:GetPath()
    return persistence.getPath(self)
end

function Window:Save(name)
    if name ~= nil and (type(name) ~= "string" or name == "") then
        return false
    end
    return persistence.save(self, name)
end

function Window:Load(name)
    if name ~= nil and (type(name) ~= "string" or name == "") then
        return false
    end
    return persistence.load(self, name)
end

function Window:_applyNamedConfig(name)
    if not self:Load(name) then
        return false
    end

    local _, defaultPath = persistence.getPath(self)
    self._loadedConfigPath = defaultPath
    self:Save()
    return true
end

function Window:ListConfigs()
    return persistence.list(self)
end

function Window:DeleteConfig(name)
    return persistence.delete(self, name)
end

function Window:Get(flag)
    local control = self.controls[flag]
    return control and control.value
end

function Window:Set(flag, value)
    local control = self.controls[flag]
    if not control then
        return false
    end
    control:Set(value)
    return true
end

function Window:_jumpTo(page)
    if page then
        self.elementsLayout:JumpTo(page)
    end
end

function Window:Navigate(tab)
    if tab == nil then
        return
    end

    local target
    for _, candidate in self.tabs do

        if candidate == tab or candidate.name == tab or candidate.tabPage == tab then
            target = candidate
            break
        end
    end

    if not target then
        return
    end
    target:Select()
end

function Window:Create(className, properties, themeProperties)
    assert(typeof(className) == "string", "Invalid argument #1 (string expected)")
    local instance = Instance.new(className)

    if themeProperties and self.theme then
        for property, value in themeProperties do
            instance[property] = (
                if typeof(value) == "table" then value[2](self.theme[value[1]]) else self.theme[value]
            )
        end

        self.themeProperties[instance] = themeProperties
    end

    if properties then
        for property, value in properties do
            if locale.isToken(value) then
                self:_bindLocale(instance, property, locale.sourceOf(value))
            else
                image.assign(instance, property, value)
            end
        end
    end

    table.insert(self.instances, instance)
    return instance
end

function Window:_bindLocale(instance, property, source)
    instance[property] = locale.resolve(source)

    local entries = self.localeProperties[instance]
    if not entries then
        entries = {}
        self.localeProperties[instance] = entries
    end
    entries[property] = source
end

function Window:SetLocale(localeId)
    locale.setActive(localeId)
    for instance, entries in self.localeProperties do
        for property, source in entries do
            instance[property] = locale.resolve(source)
        end
    end
end

function Window:SetTranslator(translator)
    locale.translator = translator
end

function Window:RegisterTranslations(tables)
    locale.register(tables)
    self:SetLocale(locale.current)
end

function Window:CreateGlow(parent, color, blur, transparency)
    local properties = {
        BlurRadius = UDim.new(0, blur),
        Transparency = transparency,
        ZIndex = -1,

        Parent = parent,
    }

    if typeof(color) == "string" then
        return self:Create("UIShadow", properties, {
            Color = {
                color,
                function(value)
                    return if typeof(value) == "ColorSequence" then value.Keypoints[1].Value else value
                end,
            },
        })
    end

    properties.Color = color
    return self:Create("UIShadow", properties)
end

function Window:_flashResult(element, ok)
    local box = element.box
    if not box then
        return
    end
    local glow = element.glow
    local stroke = element.boxStroke
    local fill = ok and constants.accent.on or self.theme.ErrorColor
    local edge = ok and constants.accent.onStroke or self.theme.ErrorStrokeColor
    local inInfo = TweenInfo.new(0.1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
    local outInfo = TweenInfo.new(0.45, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)

    variables.tweenService:Create(box, inInfo, { BackgroundColor3 = fill }):Play()
    if stroke then
        variables.tweenService:Create(stroke, inInfo, { Color = edge, Transparency = 0.4 }):Play()
    end
    if glow then
        variables.tweenService:Create(glow, inInfo, { Color = edge, Transparency = 0.6 }):Play()
    end

    element._flashToken = (element._flashToken or 0) + 1
    local token = element._flashToken
    task.delay(0.22, function()
        if element._flashToken ~= token then
            return
        end
        variables.tweenService:Create(box, outInfo, { BackgroundColor3 = self.theme.FieldBackground }):Play()
        if stroke then
            variables.tweenService
                :Create(stroke, outInfo, { Color = self.theme.SurfaceStroke, Transparency = 0.85 })
                :Play()
        end
        if glow then
            variables.tweenService
                :Create(glow, outInfo, { Color = self.theme.FieldGlow, Transparency = element._glowIdle or 1 })
                :Play()
        end
    end)
end

function Window:CreateHoverOverlay(parent)
    local overlay = self:Create("Frame", {
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 1,
        Size = UDim2.fromScale(1, 1),
        BorderSizePixel = 0,
        ZIndex = 1,

        Parent = parent,
    })

    self:Create("UICorner", {
        Parent = overlay,
    }, { CornerRadius = "ElementCornerRadius" })

    return overlay
end

function Window:_wireElementHover(element)
    local info = TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
    local theme = self.theme

    self:ConnectFor(element, element.main.MouseEnter, function()
        if not self:_interactive() then
            return
        end
        variables.tweenService
            :Create(
                element.stroke,
                info,
                { Transparency = theme.ElementStrokeHoverTransparency, Color = theme.ElementStrokeHover }
            )
            :Play()
        variables.tweenService:Create(element.title, info, { TextColor3 = theme.ElementTextHoverColor }):Play()
        if element.hoverOverlay then
            variables.tweenService:Create(element.hoverOverlay, info, { BackgroundTransparency = 0.97 }):Play()
        end
    end)

    self:ConnectFor(element, element.main.MouseLeave, function()
        variables.tweenService
            :Create(
                element.stroke,
                info,
                { Transparency = theme.ElementStrokeTransparency, Color = theme.ElementStroke }
            )
            :Play()
        variables.tweenService:Create(element.title, info, { TextColor3 = theme.ContentColor }):Play()
        if element.hoverOverlay then
            variables.tweenService:Create(element.hoverOverlay, info, { BackgroundTransparency = 1 }):Play()
        end
    end)
end

function Window:_runGuarded(element, fn, ...)

    if element.locked then
        return
    end

    local args = table.pack(...)
    task.spawn(function()
        local ok, err = pcall(function()
            return fn(table.unpack(args, 1, args.n))
        end)
        if ok or element._errored then
            return
        end
        element._errored = true

        local flashFrame = element.flashTarget or element.main
        local quickOut = TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
        variables.tweenService:Create(flashFrame, quickOut, { BackgroundColor3 = self.theme.ErrorColor }):Play()
        variables.tweenService:Create(element.stroke, quickOut, { Color = self.theme.ErrorStrokeColor }):Play()

        if element.title then
            element.title.Text = locale.resolve("Error, log recorded in console.")
        end

        log.warn(
            `Rayfield encountered an error, with the callback for a {element.__type} component named '{element.name}':`
        )
        log.print(err)

        task.wait(1)

        if element.title then
            element.title.Text = locale.resolve(element.name)
        end
        variables.tweenService
            :Create(
                flashFrame,
                TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.In),
                { BackgroundColor3 = Color3.fromRGB(255, 255, 255) }
            )
            :Play()
        variables.tweenService
            :Create(
                element.stroke,
                TweenInfo.new(0.6, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
                { Color = self.theme.ElementStroke }
            )
            :Play()
        element._errored = false
    end)
end

function Window:StyleElementBody(main)
    self:Create("UIGradient", {
        Rotation = 270,

        Parent = main,
    }, { Color = "ElementGradient" })

    self:Create("UICorner", {
        Parent = main,
    }, { CornerRadius = "ElementCornerRadius" })

    return self:Create("UIStroke", {
        Transparency = 1,

        Parent = main,
    }, { Color = "ElementStroke", Transparency = "ElementStrokeTransparency" })
end

function Window:_buildCompactRow(host, name, interactZIndex)
    local main = self:Create("Frame", {
        Name = name,
        Size = UDim2.fromOffset(0, compactRowHeight),
        AutomaticSize = Enum.AutomaticSize.X,
        ClipsDescendants = true,
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BorderSizePixel = 0,

        BackgroundTransparency = 1,

        Parent = host.tabPage,
    }, { BackgroundTransparency = "ElementTransparency" })

    local stroke = self:StyleElementBody(main)

    self:Create("UIFlexItem", {
        FlexMode = Enum.UIFlexMode.Fill,
        Parent = main,
    })

    self:Create("UIListLayout", {
        FillDirection = Enum.FillDirection.Horizontal,
        VerticalAlignment = Enum.VerticalAlignment.Center,
        HorizontalFlex = Enum.UIFlexAlignment.Fill,

        Parent = main,
    })

    local interact = self:Create("TextButton", {
        Text = "",
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 1,
        AutomaticSize = Enum.AutomaticSize.X,
        Size = UDim2.fromOffset(0, compactRowHeight),
        BorderSizePixel = 0,
        TextTransparency = 1,
        ZIndex = interactZIndex or 1,

        Parent = main,
    })

    self:Create("UICorner", {
        Parent = interact,
    }, { CornerRadius = "ElementCornerRadius" })

    return main, stroke, interact
end

function Window:StyleElementPanel(frame)
    self:Create("UIGradient", {
        Rotation = 270,

        Parent = frame,
    }, { Color = "ElementGradient" })

    self:Create("UICorner", {
        Parent = frame,
    }, { CornerRadius = "ElementCornerRadius" })

    local stroke = self:Create("UIStroke", {
        Color = Color3.fromRGB(255, 255, 255),
        Transparency = 1,

        Parent = frame,
    })

    self:Create("UIGradient", {
        Rotation = 270,

        Parent = stroke,
    }, { Color = "ElementStrokeGradient" })

    return stroke
end

function Window:_reveal(instance, props, animate, info)
    if not instance then
        return
    end
    if animate then
        variables.tweenService:Create(instance, info or revealInfo, props):Play()
    else
        for property, value in props do
            instance[property] = value
        end
    end
end

function Window:_revealCommon(element, animate)
    self:_reveal(element.stroke, { Transparency = self.theme.ElementStrokeTransparency }, animate)
    self:_reveal(element.title, { TextTransparency = 0 }, animate)
    self:_reveal(element.main, { BackgroundTransparency = self.theme.ElementTransparency or 0 }, animate)
    if element.iconLabel then
        self:_reveal(element.iconLabel, { ImageTransparency = 0 }, animate)
    end
    if element.descriptor then
        self:_reveal(element.descriptor.titleLabel, { TextTransparency = 0.7 }, animate)
    end
end

function Window:_hideCommon(element, animate)
    self:_reveal(element.stroke, { Transparency = 1 }, animate)
    self:_reveal(element.title, { TextTransparency = 1 }, animate)
    self:_reveal(element.main, { BackgroundTransparency = 1 }, animate)
    if element.iconLabel then
        self:_reveal(element.iconLabel, { ImageTransparency = 1 }, animate)
    end
    if element.descriptor then
        self:_reveal(element.descriptor.titleLabel, { TextTransparency = 1 }, animate)
    end
end

function Window:_collapsedRect()
    local size = if self.showIconOnly then collapsedIconSize else collapsedSize

    if self._collapsedPosition then
        return self._collapsedPosition, size
    end
    local home = UDim2.new(
        collapsedTop.X.Scale,
        collapsedTop.X.Offset,
        collapsedTop.Y.Scale,
        collapsedTop.Y.Offset + size.Y.Offset / 2
    )
    return home, size
end

function Window:_interactive()
    return not self.animating and not self.hidden
end

function Window:_settled()
    return not self.hidden and not self._revealing
end

function Window:Connect(signal, callback)
    local connection = signal:Connect(callback)
    table.insert(self.connections, connection)
    return connection
end

function Window:ConnectFor(owner, signal, callback)
    local connection = self:Connect(signal, callback)
    owner.connections = owner.connections or {}
    table.insert(owner.connections, connection)
    return connection
end

function Window:Disconnect(connection)
    if not connection then
        return
    end
    local index = table.find(self.connections, connection)
    if index then
        table.remove(self.connections, index)
    end
    connection:Disconnect()
end

function Window:DestroySubtree(root)
    if not root then
        return
    end

    local inSubtree = { [root] = true }
    for _, descendant in root:GetDescendants() do
        inSubtree[descendant] = true
    end
    for i = #self.instances, 1, -1 do
        local instance = self.instances[i]
        if inSubtree[instance] then
            table.remove(self.instances, i)
            self.themeProperties[instance] = nil
            self.localeProperties[instance] = nil
        end
    end

    root:Destroy()
end

function Window:DisconnectMany(owner, connections)
    if not connections or #connections == 0 then
        return
    end

    local dropping = {}
    for _, connection in connections do
        dropping[connection] = true
        connection:Disconnect()
    end

    local function filter(list)
        if not list then
            return
        end
        local kept = 0
        for index = 1, #list do
            local entry = list[index]
            if not dropping[entry] then
                kept += 1
                list[kept] = entry
            end
        end
        for index = #list, kept + 1, -1 do
            list[index] = nil
        end
    end

    filter(self.connections)
    if owner and owner ~= self then
        filter(owner.connections)
    end
end

function Window:DestroySubtrees(roots)
    if not roots or #roots == 0 then
        return
    end

    local inSubtree = {}
    for _, root in roots do
        inSubtree[root] = true
        for _, descendant in root:GetDescendants() do
            inSubtree[descendant] = true
        end
    end

    local kept = 0
    for index = 1, #self.instances do
        local instance = self.instances[index]
        if inSubtree[instance] then
            self.themeProperties[instance] = nil
            self.localeProperties[instance] = nil
        else
            kept += 1
            self.instances[kept] = instance
        end
    end
    for index = #self.instances, kept + 1, -1 do
        self.instances[index] = nil
    end

    for _, root in roots do
        root:Destroy()
    end
end

function Window:Unload()
    self.unloaded = true

    hapticEngine.teardown()
    hapticEngine.releaseContainer(self.screenGui)
    if self._liveTween then
        self._liveTween:Cancel()
        self._liveTween = nil
    end
    for i = #self.connections, 1, -1 do
        self.connections[i]:Disconnect()
    end
    for i = #self.instances, 1, -1 do
        self.instances[i]:Destroy()
    end

    table.clear(self.connections)
    table.clear(self.instances)
    table.clear(self.themeProperties)
    table.clear(self.localeProperties)
    table.clear(self.controls)
    table.clear(self.tabs)
end

return Window
end

-- Types
Root.types = { Name = "types", Parent = Root }
Root.types.FindFirstChild = function(self, k) return self[k] end
Root.types.__loader = function(script, require)
export type Theme = string | { [string]: any }

export type Translator = (source: string, localeId: string) -> string?

export type Translations = { [string]: { [string]: string } }

export type WindowConfiguration = {
    autoSave: boolean?,
    autoLoad: boolean?,
    fileName: string?,
    customFolder: string?,
}

export type WindowProps = {
    name: string?,
    subtitle: string?,
    theme: Theme?,
    icon: (string | number)?,
    showName: string?,
    showIcon: (string | number)?,
    showIconOnly: boolean?,
    sidebarLayout: boolean?,
    profile: string?,
    configuration: WindowConfiguration?,
    fallbackFont: (Font | Enum.Font)?,
    locale: string?,
    translations: Translations?,
    translator: Translator?,
}

export type TabProps = {
    name: string?,
    icon: (string | number)?,
}

export type TagProps = {
    text: string?,
    title: string?,
    icon: (string | number)?,
    color: Color3?,
    order: number?,
}

export type SectionProps = {
    name: string?,
    icon: (string | number)?,
}

export type TextProps = {
    name: string?,
    text: string?,
    icon: (string | number)?,
}

export type DividerProps = {
    text: string?,
    spacing: number?,
    line: boolean?,
}

export type GroupProps = {
    direction: string?,
}

export type ButtonProps = {
    name: string?,
    description: string?,
    icon: (string | number)?,
    callback: (() -> ())?,
}

export type ToggleProps = {
    name: string?,
    description: string?,
    icon: (string | number)?,
    flag: string?,
    value: boolean?,
    forgetState: boolean?,
    callback: ((value: boolean) -> ())?,
}

export type SliderProps = {
    name: string?,
    description: string?,
    icon: (string | number)?,
    flag: string?,
    range: { number }?,
    increment: number?,
    value: number?,
    suffix: string?,
    minimal: boolean?,
    forgetState: boolean?,

    callback: ((value: number, dragging: boolean) -> ())?,
}

export type DropdownProps = {
    name: string?,
    description: string?,
    icon: (string | number)?,
    flag: string?,
    options: { string }?,
    value: (string | { string })?,
    multiSelect: boolean?,
    placeholder: string?,
    forgetState: boolean?,
    callback: ((value: any) -> ())?,
}

export type InputProps = {
    name: string?,
    description: string?,
    icon: (string | number)?,
    flag: string?,
    value: string?,
    placeholder: string?,
    numeric: boolean?,
    clearOnFocus: boolean?,
    forgetState: boolean?,
    callback: ((value: string) -> ())?,
}

export type KeybindProps = {
    name: string?,
    description: string?,
    icon: (string | number)?,
    flag: string?,
    value: (EnumItem | string)?,
    forgetState: boolean?,
    isMenuToggle: boolean?,
    hold: boolean?,
    holdThreshold: number?,
    callback: ((value: EnumItem | boolean) -> ())?,
    onChanged: ((key: EnumItem) -> ())?,
}

export type ColorPickerProps = {
    name: string?,
    description: string?,
    icon: (string | number)?,
    flag: string?,
    color: Color3?,
    alpha: number?,
    forgetState: boolean?,
    callback: ((value: Color3, alpha: number) -> ())?,
}

export type StatProps = {
    name: string?,
    description: string?,
    icon: (string | number)?,
    prefix: string?,
    suffix: string?,
    value: number?,
    display: string?,
    compact: boolean?,
    changeMode: string?,
    changeBaseline: string?,
    numberEasing: boolean?,
}

export type ProgressProps = {
    name: string?,
    description: string?,
    icon: (string | number)?,
    range: { number }?,
    value: number?,
    steps: number?,
    text: string?,
    format: ((value: number, min: number, max: number) -> string)?,
    showValue: boolean?,
    indeterminate: boolean?,
}

export type ConsoleProps = {
    name: string?,
    description: string?,
    text: string?,
    height: number?,
    follow: boolean?,
    maxLines: number?,
}

export type NotifyProps = {
    title: string?,
    content: string?,
    icon: (string | number)?,
    duration: number?,
}

export type ToastProps = {
    title: string?,
    subtitle: string?,
    subtitleAbove: boolean?,
    icon: (string | number)?,
    avatar: number?,
    minWidth: number?,
    duration: number?,
    position: "Top" | "Bottom"?,
}

export type PopupBox = {
    title: string?,
    description: string?,
    icon: (string | number)?,
}

export type PopupOption = {
    text: string?,
    style: string?,
    callback: (() -> ())?,
}

export type PopupProps = {
    title: string?,
    subtitle: string?,
    icon: (string | number)?,
    content: string?,
    boxes: { PopupBox }?,
    options: { PopupOption }?,
    dismissable: boolean?,
}

export type Moveable = {
    MoveTo: (self: any, index: number) -> (),
    MoveToTop: (self: any) -> (),
    MoveToBottom: (self: any) -> (),
    MoveUp: (self: any) -> (),
    MoveDown: (self: any) -> (),
}

export type Lockable = {
    Lock: (self: any, reason: string?) -> (),
    Unlock: (self: any) -> (),
    IsLocked: (self: any) -> boolean,
}

export type Button = Moveable & Lockable & {}

export type Toggle = Moveable & Lockable & {
    value: boolean,
    Set: (self: Toggle, value: boolean, skipCallback: boolean?) -> (),
}

export type Slider = Moveable & Lockable & {
    value: number,
    Set: (self: Slider, value: number, skipCallback: boolean?) -> (),
}

export type Dropdown = Moveable & Lockable & {
    value: { string },
    Set: (self: Dropdown, value: string | { string }, skipCallback: boolean?) -> (),
    Refresh: (self: Dropdown, options: { string }) -> (),
    Add: (self: Dropdown, option: string) -> (),
    Remove: (self: Dropdown, option: string) -> (),
}

export type Input = Moveable & Lockable & {
    value: string,
    Set: (self: Input, value: string, skipCallback: boolean?) -> (),
}

export type Keybind = Moveable & Lockable & {
    value: EnumItem,
    Set: (self: Keybind, value: EnumItem | string, skipChanged: boolean?) -> (),
}

export type ColorPicker = Moveable & Lockable & {
    value: Color3,
    alpha: number,
    Set: (self: ColorPicker, value: Color3 | string, skipCallback: boolean?) -> (),
    SetAlpha: (self: ColorPicker, alpha: number, skipCallback: boolean?) -> (),
}

export type Stat = Moveable & {
    value: number,
    Set: (self: Stat, value: number) -> (),
    ResetBaseline: (self: Stat, value: number?) -> (),
}

export type Progress = Moveable & {
    value: number,
    Set: (self: Progress, value: number) -> (),
    Get: (self: Progress) -> number,
    GetPercentage: (self: Progress) -> number,
    SetRange: (self: Progress, min: number, max: number) -> (),
    SetText: (self: Progress, text: string?) -> (),
    SetIndeterminate: (self: Progress, state: boolean) -> (),
    Remove: (self: Progress) -> (),
}

export type Console = Moveable & {
    Set: (self: Console, text: string) -> (),
    Append: (self: Console, line: string) -> (),
    Clear: (self: Console) -> (),
    Get: (self: Console) -> string,
    Copy: (self: Console) -> boolean,
    SetHeight: (self: Console, height: number) -> (),
    Remove: (self: Console) -> (),
}

export type Section = Moveable & {}

export type TabSection = {
    Remove: (self: TabSection) -> (),
}

export type Text = Moveable & {
    name: string,
    text: string,
    Set: (self: Text, text: string) -> (),
    SetTitle: (self: Text, title: string) -> (),
}

export type Divider = Moveable & {
    text: string,
    Set: (self: Divider, text: string?) -> (),
}

export type Tag = {
    Set: (self: Tag, props: TagProps) -> (),
    SetColor: (self: Tag, color: Color3) -> (),
    SetText: (self: Tag, text: string?) -> (),
    SetIcon: (self: Tag, icon: (string | number)?) -> (),
    Remove: (self: Tag) -> (),
}

export type Popup = {
    Close: (self: Popup) -> (),
}

export type Group = Moveable & {
    CreateButton: (self: Group, props: ButtonProps) -> Button,
    CreateToggle: (self: Group, props: ToggleProps) -> Toggle,
    CreateSwitch: (self: Group, props: ToggleProps) -> Toggle,
    CreateStat: (self: Group, props: StatProps) -> Stat,
    CreateSlider: (self: Group, props: SliderProps) -> Slider,

    CreateDropdown: (self: Group, props: DropdownProps) -> Dropdown?,
    CreateSection: (self: Group, props: SectionProps) -> Section?,
    CreateText: (self: Group, props: TextProps) -> Text?,
    CreateDivider: (self: Group, props: DividerProps?) -> Divider?,
    CreateGroup: (self: Group, props: GroupProps?) -> Group,
}

export type Tab = {
    Select: (self: Tab, noAnimation: boolean?) -> (),
    Deselect: (self: Tab, noAnimation: boolean?) -> (),
    Remove: (self: Tab) -> (),
    CreateButton: (self: Tab, props: ButtonProps) -> Button,
    CreateToggle: (self: Tab, props: ToggleProps) -> Toggle,
    CreateSwitch: (self: Tab, props: ToggleProps) -> Toggle,
    CreateSlider: (self: Tab, props: SliderProps) -> Slider,
    CreateDropdown: (self: Tab, props: DropdownProps) -> Dropdown,
    CreateInput: (self: Tab, props: InputProps) -> Input,
    CreateKeybind: (self: Tab, props: KeybindProps) -> Keybind,
    CreateColorPicker: (self: Tab, props: ColorPickerProps) -> ColorPicker,
    CreateStat: (self: Tab, props: StatProps) -> Stat,
    CreateProgress: (self: Tab, props: ProgressProps) -> Progress,
    CreateConsole: (self: Tab, props: ConsoleProps) -> Console,
    CreateSection: (self: Tab, props: SectionProps) -> Section,
    CreateText: (self: Tab, props: TextProps) -> Text,
    CreateDivider: (self: Tab, props: DividerProps?) -> Divider,
    CreateGroup: (self: Tab, props: GroupProps?) -> Group,
}

export type Window = {
    unloaded: boolean,

    Flags: { [string]: any },
    CreateTab: (self: Window, props: TabProps) -> Tab,

    CreateSection: (self: Window, props: SectionProps) -> TabSection,
    CreateTag: (self: Window, props: TagProps) -> Tag,
    Notify: (self: Window, props: NotifyProps) -> (),
    Toast: (self: Window, props: ToastProps) -> (),
    Popup: (self: Window, props: PopupProps) -> Popup?,
    Show: (self: Window) -> (),
    Hide: (self: Window) -> (),
    ToggleHide: (self: Window) -> (),
    ToggleMinimise: (self: Window) -> (),
    Navigate: (self: Window, tab: string | Tab) -> (),
    ChangeTheme: (self: Window, theme: Theme) -> (),
    SetLocale: (self: Window, localeId: string) -> (),
    SetTranslator: (self: Window, translator: Translator?) -> (),
    RegisterTranslations: (self: Window, translations: Translations) -> (),
    Save: (self: Window, name: string?) -> boolean,
    Load: (self: Window, name: string?) -> boolean,
    ListConfigs: (self: Window) -> { string },
    DeleteConfig: (self: Window, name: string) -> boolean,
    GetPath: (self: Window) -> (string, string),
    Get: (self: Window, flag: string) -> any,
    Set: (self: Window, flag: string, value: any) -> boolean,
    Unload: (self: Window) -> (),
}

export type Rayfield = {
    CreateWindow: (self: Rayfield, props: WindowProps) -> Window,
}

return {}
end

-- Entry point
Root.__loader = function(script, require)
local variables = require(script.utility.variables)
local image = require(script.utility.image)
local locale = require(script.utility.locale)
local constants = require(script.utility.constants)
local types = require(script.types)

export type Theme = types.Theme
export type Translator = types.Translator
export type Translations = types.Translations
export type WindowConfiguration = types.WindowConfiguration

export type WindowProps = types.WindowProps
export type TabProps = types.TabProps
export type TagProps = types.TagProps
export type SectionProps = types.SectionProps
export type GroupProps = types.GroupProps
export type ButtonProps = types.ButtonProps
export type ToggleProps = types.ToggleProps
export type SliderProps = types.SliderProps
export type DropdownProps = types.DropdownProps
export type InputProps = types.InputProps
export type KeybindProps = types.KeybindProps
export type ColorPickerProps = types.ColorPickerProps
export type StatProps = types.StatProps
export type ProgressProps = types.ProgressProps
export type ConsoleProps = types.ConsoleProps
export type TextProps = types.TextProps
export type DividerProps = types.DividerProps
export type NotifyProps = types.NotifyProps
export type ToastProps = types.ToastProps
export type PopupBox = types.PopupBox
export type PopupOption = types.PopupOption
export type PopupProps = types.PopupProps

export type Moveable = types.Moveable
export type Lockable = types.Lockable
export type Window = types.Window
export type Tab = types.Tab
export type Group = types.Group
export type Button = types.Button
export type Toggle = types.Toggle
export type Slider = types.Slider
export type Dropdown = types.Dropdown
export type Input = types.Input
export type Keybind = types.Keybind
export type ColorPicker = types.ColorPicker
export type Stat = types.Stat
export type Progress = types.Progress
export type Console = types.Console
export type Section = types.Section
export type TabSection = types.TabSection
export type Text = types.Text
export type Divider = types.Divider
export type Tag = types.Tag
export type Popup = types.Popup
export type Rayfield = types.Rayfield

type WindowModule = { new: (types.WindowProps) -> types.Window }

local rayfield = {} :: Rayfield

local function createBanner()
    local ui = Instance.new("ScreenGui")
    ui.Name = variables.httpService:GenerateGUID(false)
    ui.ClipToDeviceSafeArea = false
    ui.DisplayOrder = constants.displayOrder.banner
    ui.IgnoreGuiInset = true
    ui.ResetOnSpawn = false
    ui.Enabled = true
    ui.SafeAreaCompatibility = Enum.SafeAreaCompatibility.None
    ui.ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets
    ui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ui.Parent = variables.guiContainer

    local banner = Instance.new("ImageLabel")
    banner.Name = "Banner"
    banner.AnchorPoint = Vector2.new(0.5, 0.5)
    banner.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    banner.BackgroundTransparency = 1
    banner.BorderColor3 = Color3.fromRGB(0, 0, 0)
    banner.BorderSizePixel = 0
    banner.Image = image.resolve(constants.icons.banner)
    banner.Position = UDim2.fromScale(0.5, 0.5)
    banner.Size = UDim2.fromOffset(262, 60)
    banner.Parent = ui

    return ui
end

function rayfield:CreateWindow(properties: types.WindowProps): types.Window
    local banner = createBanner()

    local window: types.Window?

    local queuedNotify: (() -> ())?

    if variables.secureMode then

        image.preload(function(failed)
            if failed <= 0 then
                return
            end
            local function notify()
                if not window or window.unloaded then
                    return
                end
                window:Notify({
                    title = locale.resolve("Secure mode"),
                    content = if failed == 1
                        then locale.resolve("An asset couldn't be cached and won't appear.")
                        else locale.resolve("Some assets couldn't be cached and won't appear."),
                })
            end
            if window then
                notify()
            else
                queuedNotify = notify
            end
        end)
    end

    local made, result = pcall(function()
        return (require(script.components.window) :: WindowModule).new(properties)
    end)
    if not made then
        banner:Destroy()
        error(result, 0)
    end

    local built = result :: types.Window
    window = built

    if queuedNotify then
        task.spawn(queuedNotify)
        queuedNotify = nil
    end

    if variables.secureMode then

        task.spawn(function()
            local body = variables.fontManager:loadFont(constants.fontAsset, Enum.FontWeight.Medium)
            local title = variables.fontManager:loadFont(constants.fontAsset, Enum.FontWeight.SemiBold)

            if
                not built.unloaded
                and body
                and title
                and body ~= variables.fallbackFont
                and title ~= variables.fallbackFont
            then
                built:ChangeTheme({ Font = body, TitleFont = title })
            end
        end)
    end

    task.spawn(function()
        task.wait(0.5)

        banner:Destroy()

        task.wait(0.5)

        if not built.unloaded then
            built:Show()
        end
    end)

    return built
end

return rayfield
end

return required(Root)