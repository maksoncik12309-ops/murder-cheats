-- ============================================================
--  MURDER CHEATS  v12  |  FULL WORKING BUILD
-- ============================================================
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local VirtualUser = game:GetService("VirtualUser")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local Teleport = game:GetService("TeleportService")
local Stats = game:GetService("Stats")
local GuiService = game:GetService("GuiService")

local player = Players.LocalPlayer
local cam = workspace.CurrentCamera
local pg = player:WaitForChild("PlayerGui")

local C_BG = Color3.fromRGB(6, 8, 10)
local C_PANEL = Color3.fromRGB(16, 20, 24)
local C_ITEM = Color3.fromRGB(22, 28, 34)
local C_ITEM_H = Color3.fromRGB(32, 40, 48)
local C_ACCENT = Color3.fromRGB(0, 255, 150)
local C_AMBER = Color3.fromRGB(255, 160, 60)
local C_DANGER = Color3.fromRGB(255, 60, 80)
local C_TEXT = Color3.fromRGB(230, 240, 245)
local C_SUB = Color3.fromRGB(110, 130, 145)

-- ============================================================
--  🔐 PASSWORD GATE (murder)
-- ============================================================
local PASSWORD = "murder"
local passwordCorrect = false

if pg:FindFirstChild("MC_PasswordGate") then pg.MC_PasswordGate:Destroy() end
local pwdGui = Instance.new("ScreenGui")
pwdGui.Name = "MC_PasswordGate"
pwdGui.IgnoreGuiInset = true
pwdGui.ResetOnSpawn = false
pwdGui.DisplayOrder = 999999
pwdGui.Parent = pg

local pwdBg = Instance.new("Frame")
pwdBg.Size = UDim2.new(1, 0, 1, 0)
pwdBg.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
pwdBg.BackgroundTransparency = 0.3
pwdBg.BorderSizePixel = 0
pwdBg.Parent = pwdGui

local pwdCard = Instance.new("Frame")
pwdCard.Size = UDim2.new(0, 360, 0, 260)
pwdCard.Position = UDim2.new(0.5, -180, 0.5, -130)
pwdCard.BackgroundColor3 = C_BG
pwdCard.BorderSizePixel = 0
pwdCard.Parent = pwdBg
Instance.new("UICorner", pwdCard).CornerRadius = UDim.new(0, 14)
local pwdStroke = Instance.new("UIStroke", pwdCard)
pwdStroke.Color = C_ACCENT; pwdStroke.Thickness = 2; pwdStroke.Transparency = 0.2

local pwdTitle = Instance.new("TextLabel")
pwdTitle.Size = UDim2.new(1, -32, 0, 34)
pwdTitle.Position = UDim2.new(0, 16, 0, 20)
pwdTitle.BackgroundTransparency = 1
pwdTitle.Font = Enum.Font.GothamBlack
pwdTitle.TextSize = 22
pwdTitle.RichText = true
pwdTitle.Text = '<font color="#00FF96">MURDER</font> <font color="#FFA03C">CHEATS</font>'
pwdTitle.TextXAlignment = Enum.TextXAlignment.Left
pwdTitle.Parent = pwdCard

local pwdSub = Instance.new("TextLabel")
pwdSub.Size = UDim2.new(1, -32, 0, 16)
pwdSub.Position = UDim2.new(0, 16, 0, 58)
pwdSub.BackgroundTransparency = 1
pwdSub.Font = Enum.Font.Code
pwdSub.TextSize = 11
pwdSub.TextColor3 = C_SUB
pwdSub.TextXAlignment = Enum.TextXAlignment.Left
pwdSub.Text = "enter password to unlock"
pwdSub.Parent = pwdCard

local pwdInput = Instance.new("TextBox")
pwdInput.Size = UDim2.new(1, -32, 0, 40)
pwdInput.Position = UDim2.new(0, 16, 0, 96)
pwdInput.BackgroundColor3 = C_ITEM
pwdInput.BorderSizePixel = 0
pwdInput.Font = Enum.Font.Code
pwdInput.TextSize = 16
pwdInput.TextColor3 = C_TEXT
pwdInput.PlaceholderText = "password..."
pwdInput.PlaceholderColor3 = C_SUB
pwdInput.Text = ""
pwdInput.ClearTextOnFocus = false
pwdInput.Parent = pwdCard
Instance.new("UICorner", pwdInput).CornerRadius = UDim.new(0, 8)
local pwdInputStroke = Instance.new("UIStroke", pwdInput)
pwdInputStroke.Color = C_ACCENT; pwdInputStroke.Thickness = 1; pwdInputStroke.Transparency = 0.5

local pwdBtn = Instance.new("TextButton")
pwdBtn.Size = UDim2.new(1, -32, 0, 40)
pwdBtn.Position = UDim2.new(0, 16, 0, 148)
pwdBtn.BackgroundColor3 = C_ACCENT
pwdBtn.BorderSizePixel = 0
pwdBtn.AutoButtonColor = false
pwdBtn.Font = Enum.Font.GothamBold
pwdBtn.TextSize = 14
pwdBtn.TextColor3 = C_BG
pwdBtn.Text = "UNLOCK"
pwdBtn.Parent = pwdCard
Instance.new("UICorner", pwdBtn).CornerRadius = UDim.new(0, 8)

local pwdStatus = Instance.new("TextLabel")
pwdStatus.Size = UDim2.new(1, -32, 0, 18)
pwdStatus.Position = UDim2.new(0, 16, 1, -28)
pwdStatus.BackgroundTransparency = 1
pwdStatus.Font = Enum.Font.GothamBold
pwdStatus.TextSize = 12
pwdStatus.TextColor3 = C_DANGER
pwdStatus.TextXAlignment = Enum.TextXAlignment.Left
pwdStatus.Text = ""
pwdStatus.Parent = pwdCard

local function tryUnlock()
    if pwdInput.Text == PASSWORD then
        pwdStatus.TextColor3 = C_ACCENT
        pwdStatus.Text = "✓ access granted"
        pwdBtn.Text = "LOADING..."
        TweenService:Create(pwdStroke, TweenInfo.new(0.15), {Transparency = 0, Thickness = 4}):Play()
        task.wait(0.5)
        TweenService:Create(pwdCard, TweenInfo.new(0.35), {BackgroundTransparency = 1, Size = UDim2.new(0, 320, 0, 220)}):Play()
        TweenService:Create(pwdTitle, TweenInfo.new(0.3), {TextTransparency = 1}):Play()
        TweenService:Create(pwdSub, TweenInfo.new(0.3), {TextTransparency = 1}):Play()
        TweenService:Create(pwdInput, TweenInfo.new(0.3), {BackgroundTransparency = 1, TextTransparency = 1}):Play()
        TweenService:Create(pwdBtn, TweenInfo.new(0.3), {BackgroundTransparency = 1, TextTransparency = 1}):Play()
        TweenService:Create(pwdStatus, TweenInfo.new(0.3), {TextTransparency = 1}):Play()
        TweenService:Create(pwdInputStroke, TweenInfo.new(0.3), {Transparency = 1}):Play()
        TweenService:Create(pwdBg, TweenInfo.new(0.35), {BackgroundTransparency = 1}):Play()
        task.wait(0.4)
        pwdGui:Destroy()
        passwordCorrect = true
    else
        pwdStatus.Text = "✕ wrong password"
        pwdInputStroke.Color = C_DANGER
        pwdInputStroke.Transparency = 0
        local op = pwdCard.Position
        for i = 1, 6 do
            TweenService:Create(pwdCard, TweenInfo.new(0.05), {Position = op + UDim2.new(0, (i%2==0 and 8 or -8), 0, 0)}):Play()
            task.wait(0.05)
        end
        TweenService:Create(pwdCard, TweenInfo.new(0.1), {Position = op}):Play()
        task.wait(0.4)
        pwdInputStroke.Color = C_ACCENT
        pwdInputStroke.Transparency = 0.5
        pwdInput.Text = ""
    end
end
pwdBtn.MouseButton1Click:Connect(tryUnlock)
pwdInput.FocusLost:Connect(tryUnlock)

repeat task.wait(0.1) until passwordCorrect

-- ============================================================
--  CONFIG SYSTEM
-- ============================================================
local CONFIG_FILE = "MurderCheats_configs.json"
local configData = { configs = { default = { toggles = {}, sliders = {} } }, active = "default", menuBind = "RightShift" }
local lastFlash = 0
local flashBadge

local function saveConfig()
    configData.configs[configData.active] = { toggles = config.toggles, sliders = config.sliders }
    if writefile then pcall(function() writefile(CONFIG_FILE, HttpService:JSONEncode(configData)) end) end
    if flashBadge and tick() - lastFlash > 0.5 then lastFlash = tick(); flashBadge() end
end

if isfile and readfile and isfile(CONFIG_FILE) then
    local ok, data = pcall(function() return HttpService:JSONDecode(readfile(CONFIG_FILE)) end)
    if ok and type(data) == "table" and data.configs and data.active then
        configData.configs = data.configs
        if configData.configs[data.active] then configData.active = data.active end
        if type(data.menuBind) == "string" then configData.menuBind = data.menuBind end
    end
end
if not configData.configs[configData.active] then
    configData.active = next(configData.configs) or "default"
end
if not configData.configs[configData.active].toggles then configData.configs[configData.active].toggles = {} end
if not configData.configs[configData.active].sliders then configData.configs[configData.active].sliders = {} end

local config = { toggles = configData.configs[configData.active].toggles, sliders = configData.configs[configData.active].sliders }
local menuBind = Enum.KeyCode[configData.menuBind] or Enum.KeyCode.RightShift

-- ============================================================
--  GUI CORE
-- ============================================================
local gui = Instance.new("ScreenGui")
gui.Name = "MurderCheats"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.Parent = pg

local watermark = Instance.new("TextLabel")
watermark.Size = UDim2.new(0, 200, 0, 22)
watermark.Position = UDim2.new(0, 12, 0, 12)
watermark.BackgroundTransparency = 1
watermark.Font = Enum.Font.GothamBold
watermark.TextSize = 12
watermark.RichText = true
watermark.Text = '<font color="#00FF96">●</font> MURDER CHEATS  <font color="#FFA03C">v12</font>'
watermark.TextXAlignment = Enum.TextXAlignment.Left
watermark.Parent = gui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 600, 0, 420)
frame.Position = UDim2.new(0.5, -300, 0.5, -210)
frame.BackgroundColor3 = C_BG
frame.BackgroundTransparency = 0.02
frame.BorderSizePixel = 0
frame.Visible = false
frame.Active = true
frame.Draggable = true
frame.Parent = gui
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 12)

local uiScale = Instance.new("UIScale")
uiScale.Scale = 1
uiScale.Parent = frame

local fStroke = Instance.new("UIStroke", frame)
fStroke.Color = C_ACCENT; fStroke.Thickness = 1.5; fStroke.Transparency = 0.35

local sidebar = Instance.new("Frame")
sidebar.Size = UDim2.new(0, 140, 1, -20)
sidebar.Position = UDim2.new(0, 10, 0, 10)
sidebar.BackgroundColor3 = C_PANEL
sidebar.BackgroundTransparency = 0.05
sidebar.Parent = frame
Instance.new("UICorner", sidebar).CornerRadius = UDim.new(0, 10)

local brand = Instance.new("TextLabel")
brand.Size = UDim2.new(1, -16, 0, 20)
brand.Position = UDim2.new(0, 10, 0, 12)
brand.BackgroundTransparency = 1
brand.Font = Enum.Font.GothamBlack
brand.TextSize = 16
brand.RichText = true
brand.Text = '<font color="#00FF96">MURDER</font>'
brand.TextXAlignment = Enum.TextXAlignment.Left
brand.Parent = sidebar

local brand2 = Instance.new("TextLabel")
brand2.Size = UDim2.new(1, -16, 0, 20)
brand2.Position = UDim2.new(0, 10, 0, 30)
brand2.BackgroundTransparency = 1
brand2.Font = Enum.Font.GothamBlack
brand2.TextSize = 16
brand2.RichText = true
brand2.Text = '<font color="#FFA03C">CHEATS</font>'
brand2.TextXAlignment = Enum.TextXAlignment.Left
brand2.Parent = sidebar

local savedBadge = Instance.new("TextLabel")
savedBadge.Size = UDim2.new(1, -16, 0, 14)
savedBadge.Position = UDim2.new(0, 10, 0, 52)
savedBadge.BackgroundTransparency = 1
savedBadge.Font = Enum.Font.GothamBold
savedBadge.TextSize = 10
savedBadge.TextColor3 = C_ACCENT
savedBadge.Text = "● SAVED"
savedBadge.TextTransparency = 1
savedBadge.TextXAlignment = Enum.TextXAlignment.Left
savedBadge.Parent = sidebar
flashBadge = function()
    savedBadge.TextTransparency = 0
    TweenService:Create(savedBadge, TweenInfo.new(0.9), {TextTransparency = 1}):Play()
end

local tabList = Instance.new("Frame")
tabList.Size = UDim2.new(1, -16, 1, -80)
tabList.Position = UDim2.new(0, 8, 0, 72)
tabList.BackgroundTransparency = 1
tabList.Parent = sidebar
local tabLayout = Instance.new("UIListLayout")
tabLayout.Padding = UDim.new(0, 3)
tabLayout.Parent = tabList

local contentArea = Instance.new("Frame")
contentArea.Size = UDim2.new(1, -170, 1, -20)
contentArea.Position = UDim2.new(0, 160, 0, 10)
contentArea.BackgroundTransparency = 1
contentArea.Parent = frame

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 26, 0, 26)
closeBtn.Position = UDim2.new(1, -36, 0, 12)
closeBtn.BackgroundColor3 = C_DANGER
closeBtn.BackgroundTransparency = 0.7
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 13
closeBtn.TextColor3 = C_TEXT
closeBtn.Text = "✕"
closeBtn.Parent = frame
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 6)

local tabs = {}
local activeTab = nil
local function createTab(name)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 30)
    btn.BackgroundColor3 = C_ITEM
    btn.BackgroundTransparency = 0.4
    btn.AutoButtonColor = false
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 12
    btn.TextColor3 = C_SUB
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.Text = "  " .. name
    btn.Parent = tabList
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)

    local ind = Instance.new("Frame")
    ind.Size = UDim2.new(0, 3, 0, 16)
    ind.Position = UDim2.new(0, 3, 0.5, -8)
    ind.BackgroundColor3 = C_ACCENT
    ind.BackgroundTransparency = 1
    ind.Parent = btn
    Instance.new("UICorner", ind).CornerRadius = UDim.new(1, 0)

    local scroll = Instance.new("ScrollingFrame")
    scroll.Size = UDim2.new(1, 0, 1, 0)
    scroll.BackgroundTransparency = 1
    scroll.BorderSizePixel = 0
    scroll.ScrollBarThickness = 3
    scroll.ScrollBarImageColor3 = C_ACCENT
    scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
    scroll.Visible = false
    scroll.Parent = contentArea

    local lay = Instance.new("UIListLayout")
    lay.Padding = UDim.new(0, 5)
    lay.Parent = scroll

    tabs[name] = { btn = btn, scroll = scroll, ind = ind }
end

local function switchTab(name)
    if activeTab == name then return end
    for n, t in pairs(tabs) do
        local on = (n == name)
        t.scroll.Visible = on
        TweenService:Create(t.btn, TweenInfo.new(0.15), {
            BackgroundTransparency = on and 0 or 0.4,
            BackgroundColor3 = on and C_ITEM_H or C_ITEM,
            TextColor3 = on and C_TEXT or C_SUB,
        }):Play()
        TweenService:Create(t.ind, TweenInfo.new(0.15), {BackgroundTransparency = on and 0 or 1}):Play()
    end
    activeTab = name
end

for _, n in ipairs({"Combat", "Visuals", "Movement", "Utility", "Config", "Settings"}) do
    createTab(n)
    tabs[n].btn.MouseButton1Click:Connect(function() switchTab(n) end)
end

local activeDrag = nil
UIS.InputChanged:Connect(function(input)
    if activeDrag and input.UserInputType == Enum.UserInputType.MouseMovement then
        if not frame.Visible then activeDrag = nil; return end
        local track = activeDrag.track
        local rel = (input.Position.X - track.AbsolutePosition.X) / track.AbsoluteSize.X
        activeDrag.applyPct(math.clamp(rel, 0, 1))
    end
end)
UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then activeDrag = nil end
end)

local toggleRegistry, sliderRegistry, resets = {}, {}, {}
local function addReset(fn) table.insert(resets, fn) end
local function resetAll() for _, fn in ipairs(resets) do pcall(fn) end end

-- UI HELPERS
local function section(parent, name)
    local wrap = Instance.new("Frame")
    wrap.Size = UDim2.new(1, 0, 0, 26)
    wrap.BackgroundTransparency = 1
    wrap.Parent = parent
    local bar = Instance.new("Frame")
    bar.Size = UDim2.new(0, 3, 0, 14)
    bar.Position = UDim2.new(0, 0, 0.5, -7)
    bar.BackgroundColor3 = C_AMBER
    bar.Parent = wrap
    Instance.new("UICorner", bar).CornerRadius = UDim.new(1, 0)
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, -12, 1, 0)
    lbl.Position = UDim2.new(0, 12, 0, 0)
    lbl.BackgroundTransparency = 1
    lbl.Font = Enum.Font.GothamBold
    lbl.TextSize = 11
    lbl.TextColor3 = C_AMBER
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Text = string.upper(name)
    lbl.Parent = wrap
end

local function createToggle(parent, name, onEnable, onDisable)
    local state = false
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 32)
    btn.BackgroundColor3 = C_ITEM
    btn.AutoButtonColor = false
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 12
    btn.TextColor3 = C_TEXT
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.Text = "  " .. name
    btn.Parent = parent
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)

    local ind = Instance.new("Frame")
    ind.Size = UDim2.new(0, 32, 0, 16)
    ind.Position = UDim2.new(1, -42, 0.5, -8)
    ind.BackgroundColor3 = C_ITEM_H
    ind.Parent = btn
    Instance.new("UICorner", ind).CornerRadius = UDim.new(1, 0)

    local knob = Instance.new("Frame")
    knob.Size = UDim2.new(0, 12, 0, 12)
    knob.Position = UDim2.new(0, 2, 0.5, -6)
    knob.BackgroundColor3 = C_SUB
    knob.Parent = ind
    Instance.new("UICorner", knob).CornerRadius = UDim.new(1, 0)

    local function setState(v, persist)
        state = v
        if v then
            TweenService:Create(ind, TweenInfo.new(0.18), {BackgroundColor3 = C_ACCENT}):Play()
            TweenService:Create(knob, TweenInfo.new(0.18), {Position = UDim2.new(1, -14, 0.5, -6), BackgroundColor3 = C_BG}):Play()
            TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(20, 44, 36)}):Play()
            if onEnable then pcall(onEnable) end
        else
            TweenService:Create(ind, TweenInfo.new(0.15), {BackgroundColor3 = C_ITEM_H}):Play()
            TweenService:Create(knob, TweenInfo.new(0.15), {Position = UDim2.new(0, 2, 0.5, -6), BackgroundColor3 = C_SUB}):Play()
            TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundColor3 = C_ITEM}):Play()
            if onDisable then pcall(onDisable) end
        end
        if persist ~= false then config.toggles[name] = v; saveConfig() end
    end
    btn.MouseButton1Click:Connect(function() setState(not state) end)
    addReset(function() if state then setState(false, true) end end)
    toggleRegistry[name] = { setState = setState, getState = function() return state end }
end

local function createButton(parent, name, onClick, accent)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 32)
    btn.BackgroundColor3 = Color3.fromRGB(26, 20, 30)
    btn.AutoButtonColor = false
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 12
    btn.TextColor3 = accent or C_AMBER
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.Text = "  ▸ " .. name
    btn.Parent = parent
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    btn.MouseButton1Click:Connect(function() pcall(onClick) end)
    return btn
end

local function createSlider(parent, name, min, max, default, onChange)
    local currentVal = default
    local holder = Instance.new("Frame")
    holder.Size = UDim2.new(1, 0, 0, 58)
    holder.BackgroundColor3 = C_ITEM
    holder.Parent = parent
    Instance.new("UICorner", holder).CornerRadius = UDim.new(0, 6)

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, -100, 0, 18)
    lbl.Position = UDim2.new(0, 12, 0, 6)
    lbl.BackgroundTransparency = 1
    lbl.Font = Enum.Font.Gotham
    lbl.TextSize = 12
    lbl.TextColor3 = C_TEXT
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Text = name
    lbl.Parent = holder

    local valBox = Instance.new("TextBox")
    valBox.Size = UDim2.new(0, 68, 0, 20)
    valBox.Position = UDim2.new(1, -80, 0, 5)
    valBox.BackgroundColor3 = C_ITEM_H
    valBox.Font = Enum.Font.Code
    valBox.TextSize = 12
    valBox.TextColor3 = C_ACCENT
    valBox.Text = tostring(default)
    valBox.Parent = holder
    Instance.new("UICorner", valBox).CornerRadius = UDim.new(0, 5)

    local trackHit = Instance.new("TextButton")
    trackHit.Size = UDim2.new(1, -24, 0, 22)
    trackHit.Position = UDim2.new(0, 12, 0, 30)
    trackHit.BackgroundTransparency = 1
    trackHit.Text = ""
    trackHit.Parent = holder

    local track = Instance.new("Frame")
    track.Size = UDim2.new(1, 0, 0, 5)
    track.Position = UDim2.new(0, 0, 0.5, -2)
    track.BackgroundColor3 = Color3.fromRGB(12, 16, 20)
    track.Parent = trackHit
    Instance.new("UICorner", track).CornerRadius = UDim.new(1, 0)

    local fill = Instance.new("Frame")
    fill.Size = UDim2.new(0, 0, 1, 0)
    fill.BackgroundColor3 = C_ACCENT
    fill.Parent = track
    Instance.new("UICorner", fill).CornerRadius = UDim.new(1, 0)

    local knob = Instance.new("Frame")
    knob.Size = UDim2.new(0, 14, 0, 14)
    knob.Position = UDim2.new(0, 0, 0.5, -7)
    knob.BackgroundColor3 = Color3.fromRGB(245, 250, 245)
    knob.Parent = track
    Instance.new("UICorner", knob).CornerRadius = UDim.new(1, 0)

    local function setValue(v, apply, persist)
        v = math.clamp(v, min, max)
        currentVal = v
        local pct = (v - min) / (max - min)
        fill.Size = UDim2.new(pct, 0, 1, 0)
        knob.Position = UDim2.new(pct, -7, 0.5, -7)
        if not valBox:IsFocused() then valBox.Text = tostring(math.floor(v * 100 + 0.5) / 100) end
        if apply and onChange then pcall(onChange, v) end
        if persist ~= false then config.sliders[name] = v; saveConfig() end
    end
    trackHit.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            valBox:ReleaseFocus()
            activeDrag = { track = track, applyPct = function(pct) setValue(min + (max - min) * pct, true, true) end }
            local rel = (input.Position.X - track.AbsolutePosition.X) / track.AbsoluteSize.X
            setValue(min + (max - min) * math.clamp(rel, 0, 1), true, true)
        end
    end)
    valBox.FocusLost:Connect(function()
        local num = tonumber(valBox.Text)
        if num then setValue(num, true, true) else valBox.Text = tostring(currentVal) end
    end)
    setValue(default, false, false)
    addReset(function() setValue(default, true, true) end)
    sliderRegistry[name] = { setValue = setValue, getValue = function() return currentVal end, default = default }
end

local function getHum() local c = player.Character; return c and c:FindFirstChildOfClass("Humanoid") end
local function getTeamColor(p) if p.Team then return p.Team.TeamColor.Color end return C_ACCENT end

-- ============================================================
--  FEATURE LOGIC
-- ============================================================
local flyKeys = {W=false, A=false, S=false, D=false, Space=false, LCtrl=false}
local flyActive, flyBV, flyBG = false, nil, nil
local flySpeed = 50
local function setFly(on)
    if flyBV then flyBV:Destroy() flyBV = nil end
    if flyBG then flyBG:Destroy() flyBG = nil end
    local char = player.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    if hum then hum.PlatformStand = false end
    flyActive = false
    if on and char and hum then
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if hrp then
            flyBV = Instance.new("BodyVelocity", hrp); flyBV.MaxForce = Vector3.new(math.huge, math.huge, math.huge); flyBV.Velocity = Vector3.zero
            flyBG = Instance.new("BodyGyro", hrp); flyBG.MaxTorque = Vector3.new(math.huge, math.huge, math.huge); flyBG.P = 10000; flyBG.CFrame = hrp.CFrame
            hum.PlatformStand = true; flyActive = true
        end
    end
end
RunService.RenderStepped:Connect(function()
    if not flyActive then return end
    local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    if hrp and flyBV and flyBG then
        cam = workspace.CurrentCamera
        local dir = Vector3.zero
        if flyKeys.W then dir = dir + cam.CFrame.LookVector end
        if flyKeys.S then dir = dir - cam.CFrame.LookVector end
        if flyKeys.A then dir = dir - cam.CFrame.RightVector end
        if flyKeys.D then dir = dir + cam.CFrame.RightVector end
        if flyKeys.Space then dir = dir + Vector3.new(0,1,0) end
        if flyKeys.LCtrl then dir = dir - Vector3.new(0,1,0) end
        flyBV.Velocity = dir.Magnitude > 0 and dir.Unit * flySpeed or Vector3.zero
        flyBG.CFrame = cam.CFrame
    end
end)

local infJumpOn = false
UIS.JumpRequest:Connect(function() if infJumpOn then local h = getHum(); if h then h:ChangeState(Enum.HumanoidStateType.Jumping) end end end)
local noclipOn = false
RunService.Stepped:Connect(function()
    if not noclipOn then return end
    local char = player.Character
    if char then for _, p in ipairs(char:GetDescendants()) do if p:IsA("BasePart") then p.CanCollide = false end end end
end)

local espOn, espTeamChk, espNames, espHP, espDist = false, false, false, false, false
local espH, espBB = {}, {}
local function clearESP() for _, h in pairs(espH) do h:Destroy() end for _, b in pairs(espBB) do b:Destroy() end espH, espBB = {}, {} end
local function makeESP(t)
    if t == player or not t.Character or espH[t] then return end
    if espTeamChk and t.Team == player.Team and player.Team ~= nil then return end
    local h = Instance.new("Highlight", gui); h.FillColor = getTeamColor(t); h.FillTransparency = 0.65; h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop; h.Adornee = t.Character; espH[t] = h
    if espNames or espHP or espDist then
        local head = t.Character:FindFirstChild("Head") or t.Character:FindFirstChild("HumanoidRootPart")
        if head then
            local bb = Instance.new("BillboardGui", gui); bb.Size = UDim2.new(0, 130, 0, 60); bb.StudsOffsetWorldSpace = Vector3.new(0, 2.6, 0); bb.AlwaysOnTop = true; bb.Adornee = head; espBB[t] = bb
            if espNames then local nm = Instance.new("TextLabel", bb); nm.Size = UDim2.new(1, 0, 0, 16); nm.BackgroundTransparency = 1; nm.Font = Enum.Font.GothamBold; nm.TextSize = 12; nm.TextStrokeTransparency = 0.3; nm.TextColor3 = C_TEXT; nm.Text = t.Name end
            if espHP then local bar = Instance.new("Frame", bb); bar.Size = UDim2.new(0.8, 0, 0, 5); bar.Position = UDim2.new(0.1, 0, 0, 20); bar.BackgroundColor3 = Color3.fromRGB(40,20,20); local hf = Instance.new("Frame", bar); hf.Size = UDim2.new(1,0,1,0); hf.BackgroundColor3 = C_ACCENT; hf.Name = "HP"; Instance.new("UICorner", hf).CornerRadius = UDim.new(0,3) end
            if espDist then local dl = Instance.new("TextLabel", bb); dl.Size = UDim2.new(1, 0, 0, 14); dl.Position = UDim2.new(0, 0, 0, 30); dl.BackgroundTransparency = 1; dl.Font = Enum.Font.Code; dl.TextSize = 10; dl.TextColor3 = C_AMBER; dl.Name = "Dist"; dl.Text = "0m" end
        end
    end
end
task.spawn(function()
    while gui.Parent do
        task.wait(0.5)
        if espOn then
            for _, p in ipairs(Players:GetPlayers()) do if p ~= player then makeESP(p) end end
            local myHrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
            for p, h in pairs(espH) do
                if not p.Parent or not p.Character or (espTeamChk and p.Team == player.Team and player.Team ~= nil) then
                    h:Destroy(); espH[p] = nil; if espBB[p] then espBB[p]:Destroy(); espBB[p] = nil end
                else
                    h.Adornee = p.Character; h.FillColor = getTeamColor(p)
                    if espBB[p] then
                        local hum = p.Character:FindFirstChildOfClass("Humanoid")
                        local hp = espBB[p]:FindFirstChild("HP", true); if hp and hum then hp.Size = UDim2.new(math.clamp(hum.Health/hum.MaxHealth, 0, 1), 0, 1, 0); hp.BackgroundColor3 = hum.Health < hum.MaxHealth*0.3 and C_DANGER or C_ACCENT end
                        local dl = espBB[p]:FindFirstChild("Dist", true); if dl and myHrp and p.Character:FindFirstChild("HumanoidRootPart") then dl.Text = string.format("%.0fm", (myHrp.Position - p.Character.HumanoidRootPart.Position).Magnitude) end
                    end
                end
            end
        end
    end
end)

-- AIMBOT
local aimOn, aimAutoShoot, aimKeyHeld, aimWallcheck = false, false, false, false
local aimHold = Enum.UserInputType.MouseButton2
local aimFOV, aimSmooth, aimPart = 150, 0.35, "Head"
local aimBodyParts, aimPartIdx = {"Head", "HumanoidRootPart", "UpperTorso"}, 1
local topInset = 36; pcall(function() topInset = GuiService:GetGuiInset().Y end)

local fovCircle = Instance.new("Frame", gui)
fovCircle.Size = UDim2.new(0, aimFOV*2, 0, aimFOV*2); fovCircle.AnchorPoint = Vector2.new(0.5, 0.5); fovCircle.BackgroundTransparency = 1; fovCircle.Visible = false
Instance.new("UICorner", fovCircle).CornerRadius = UDim.new(1, 0)
local fovStroke = Instance.new("UIStroke", fovCircle); fovStroke.Color = C_ACCENT; fovStroke.Thickness = 1.5

local function hasLOS(part)
    local params = RaycastParams.new(); params.FilterDescendantsInstances = {player.Character}; params.FilterType = Enum.RaycastFilterType.Exclude
    local res = workspace:Raycast(cam.CFrame.Position, part.Position - cam.CFrame.Position, params)
    if res then return res.Instance:IsDescendantOf(part.Parent) end; return true
end
local function getTarget(fovOverride)
    cam = workspace.CurrentCamera; local mousePos = UIS:GetMouseLocation() - Vector2.new(0, topInset); local best, bestDist = nil, fovOverride or aimFOV
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= player and p.Character and not (espTeamChk and p.Team == player.Team and player.Team ~= nil) then
            local part = p.Character:FindFirstChild(aimPart); local hum = p.Character:FindFirstChildOfClass("Humanoid")
            if part and hum and hum.Health > 0 and (not aimWallcheck or hasLOS(part)) then
                local sp, onScreen = cam:WorldToViewportPoint(part.Position)
                if onScreen and sp.Z > 0 then
                    local d = (Vector2.new(sp.X, sp.Y) - mousePos).Magnitude
                    if d < bestDist then bestDist = d; best = part end
                end
            end
        end
    end
    return best
end
RunService.RenderStepped:Connect(function()
    if fovCircle.Visible then fovCircle.Position = UDim2.fromOffset(UIS:GetMouseLocation().X, UIS:GetMouseLocation().Y) end
    if aimOn and aimKeyHeld then
        local t = getTarget()
        if t then cam.CFrame = cam.CFrame:Lerp(CFrame.new(cam.CFrame.Position, t.Position), 1 - math.clamp(aimSmooth, 0, 0.99)) end
    end
    if aimOn and aimAutoShoot and aimKeyHeld and getTarget() then VirtualUser:CaptureController(); VirtualUser:ClickButton1(Vector2.new(cam.ViewportSize.X/2, cam.ViewportSize.Y/2)) end
end)

-- UNLOAD
local function unloadCheat()
    pcall(resetAll); pcall(setFly, false); pcall(clearESP)
    local h = getHum(); if h then h.WalkSpeed = 16; h.JumpPower = 50 end
    cam.CameraType = Enum.CameraType.Custom; cam.FieldOfView = 70
    pcall(function() gui:Destroy() end); print("[Murder Cheats] Unloaded")
end

-- ============================================================
--  TABS POPULATION
-- ============================================================
local cScroll = tabs["Combat"].scroll
section(cScroll, "Aimbot")
createToggle(cScroll, "Aimbot (RMB)", function() aimOn = true; fovCircle.Visible = true end, function() aimOn = false; fovCircle.Visible = false end)
createToggle(cScroll, "FOV Circle", function() fovCircle.Visible = true end, function() fovCircle.Visible = false end)
createSlider(cScroll, "Aim FOV", 20, 500, 150, function(v) aimFOV = v; fovCircle.Size = UDim2.new(0, v*2, 0, v*2) end)
createSlider(cScroll, "Smoothness", 0, 0.95, 0.35, function(v) aimSmooth = v end)
createToggle(cScroll, "Auto Shoot", function() aimAutoShoot = true end, function() aimAutoShoot = false end)
createToggle(cScroll, "Wallcheck", function() aimWallcheck = true end, function() aimWallcheck = false end)
do local b; b = createButton(cScroll, "Body Part: " .. aimPart, function() aimPartIdx = aimPartIdx % #aimBodyParts + 1; aimPart = aimBodyParts[aimPartIdx]; b.Text = "  ▸ Body Part: " .. aimPart end, C_AMBER) end

local vScroll = tabs["Visuals"].scroll
section(vScroll, "ESP")
createToggle(vScroll, "Wallhack / ESP", function() espOn = true end, function() espOn = false; clearESP() end)
createToggle(vScroll, "Only enemies", function() espTeamChk = true; clearESP() end, function() espTeamChk = false; clearESP() end)
createToggle(vScroll, "Names", function() espNames = true; clearESP() end, function() espNames = false; clearESP() end)
createToggle(vScroll, "Health Bars", function() espHP = true; clearESP() end, function() espHP = false; clearESP() end)
createToggle(vScroll, "Distance", function() espDist = true; clearESP() end, function() espDist = false; clearESP() end)

local mScroll = tabs["Movement"].scroll
section(mScroll, "Speed")
createSlider(mScroll, "WalkSpeed", 16, 250, 16, function(v) local h = getHum() if h then h.WalkSpeed = v end end)
createSlider(mScroll, "JumpPower", 50, 400, 50, function(v) local h = getHum() if h then h.JumpPower = v end end)
createToggle(mScroll, "Infinite Jump", function() infJumpOn = true end, function() infJumpOn = false end)
createToggle(mScroll, "Noclip", function() noclipOn = true end, function() noclipOn = false end)
section(mScroll, "Fly")
createToggle(mScroll, "Fly (WASD)", function() setFly(true) end, function() setFly(false) end)
createSlider(mScroll, "Fly Speed", 10, 300, 50, function(v) flySpeed = v end)

local uScroll = tabs["Utility"].scroll
section(uScroll, "Teleport")
createButton(uScroll, "TP to Spawn", function()
    local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    if hrp then for _, obj in ipairs(workspace:GetDescendants()) do if obj:IsA("SpawnLocation") then hrp.CFrame = obj.CFrame + Vector3.new(0, 5, 0); break end end end
end)
section(uScroll, "Unload")
createButton(uScroll, "UNLOAD CHEAT", function() unloadCheat() end, C_DANGER)

local cfgScroll = tabs["Config"].scroll
local configListFrame = Instance.new("Frame", cfgScroll)
configListFrame.Size = UDim2.new(1, 0, 0, 300); configListFrame.BackgroundTransparency = 1
local cfgLayout = Instance.new("UIListLayout", configListFrame); cfgLayout.Padding = UDim.new(0, 5)
local function refreshConfigList()
    for _, c in ipairs(configListFrame:GetChildren()) do if c:IsA("TextButton") then c:Destroy() end end
    for name, _ in pairs(configData.configs) do
        local isAct = (name == configData.active)
        local btn = createButton(configListFrame, (isAct and "★ " or "") .. name, function()
            configData.active = name; config.toggles = configData.configs[name].toggles; config.sliders = configData.configs[name].sliders; saveConfig()
            for tN, t in pairs(toggleRegistry) do t.setState(config.toggles[tN] or false, false) end
            for sN, s in pairs(sliderRegistry) do s.setValue(config.sliders[sN] or s.default, true, false) end
            refreshConfigList()
        end, isAct and C_ACCENT or C_ITEM_H)
        
        local del = Instance.new("TextButton", btn)
        del.Size = UDim2.new(0, 24, 0, 24); del.Position = UDim2.new(1, -28, 0, 4); del.BackgroundColor3 = C_DANGER; del.Text = "X"; del.TextColor3 = C_TEXT; del.Font = Enum.Font.GothamBold; del.ZIndex = 5
        Instance.new("UICorner", del).CornerRadius = UDim.new(0, 4)
        del.MouseButton1Click:Connect(function()
            if name == "default" then return end
            local modal = Instance.new("Frame", gui); modal.Size = UDim2.new(1,0,1,0); modal.BackgroundTransparency = 0.45; modal.BackgroundColor3 = Color3.new(0,0,0); modal.ZIndex = 100
            local d = Instance.new("Frame", modal); d.Size = UDim2.new(0, 300, 0, 140); d.Position = UDim2.new(0.5,-150,0.5,-70); d.BackgroundColor3 = C_BG; d.ZIndex = 101
            Instance.new("UICorner", d).CornerRadius = UDim.new(0, 10)
            local l = Instance.new("TextLabel", d); l.Size = UDim2.new(1,-20,0,60); l.Position = UDim2.new(0,10,0,10); l.BackgroundTransparency = 1; l.Font = Enum.Font.GothamBold; l.Text = "Удалить конфиг '"..name.."'?"; l.TextColor3 = C_TEXT; l.ZIndex = 102
            local y = Instance.new("TextButton", d); y.Size = UDim2.new(0,120,0,30); y.Position = UDim2.new(0,20,1,-45); y.BackgroundColor3 = C_DANGER; y.Text = "Удалить"; y.TextColor3 = C_TEXT; y.Font = Enum.Font.GothamBold; y.ZIndex = 102
            Instance.new("UICorner", y).CornerRadius = UDim.new(0, 6)
            local n = Instance.new("TextButton", d); n.Size = UDim2.new(0,120,0,30); n.Position = UDim2.new(1,-140,1,-45); n.BackgroundColor3 = C_ITEM_H; n.Text = "Отмена"; n.TextColor3 = C_TEXT; n.Font = Enum.Font.GothamBold; n.ZIndex = 102
            Instance.new("UICorner", n).CornerRadius = UDim.new(0, 6)
            n.MouseButton1Click:Connect(function() modal:Destroy() end)
            y.MouseButton1Click:Connect(function()
                configData.configs[name] = nil
                if configData.active == name then configData.active = next(configData.configs) or "default"; config.toggles = configData.configs[configData.active].toggles; config.sliders = configData.configs[configData.active].sliders end
                saveConfig(); refreshConfigList(); modal:Destroy()
            end)
        end)
    end
end
refreshConfigList()
section(cfgScroll, "Actions")
createButton(cfgScroll, "+ Create New Config", function()
    local modal = Instance.new("Frame", gui); modal.Size = UDim2.new(1,0,1,0); modal.BackgroundTransparency = 0.45; modal.BackgroundColor3 = Color3.new(0,0,0); modal.ZIndex = 100
    local d = Instance.new("Frame", modal); d.Size = UDim2.new(0, 300, 0, 150); d.Position = UDim2.new(0.5,-150,0.5,-75); d.BackgroundColor3 = C_BG; d.ZIndex = 101
    Instance.new("UICorner", d).CornerRadius = UDim.new(0, 10)
    local t = Instance.new("TextBox", d); t.Size = UDim2.new(1,-40,0,34); t.Position = UDim2.new(0,20,0,20); t.BackgroundColor3 = C_ITEM; t.Text = "NewConfig"; t.Font = Enum.Font.Code; t.TextColor3 = C_TEXT; t.ZIndex = 102
    Instance.new("UICorner", t).CornerRadius = UDim.new(0, 6)
    local y = Instance.new("TextButton", d); y.Size = UDim2.new(0,120,0,30); y.Position = UDim2.new(0,20,1,-45); y.BackgroundColor3 = C_ACCENT; y.Text = "Создать"; y.TextColor3 = C_BG; y.Font = Enum.Font.GothamBold; y.ZIndex = 102
    Instance.new("UICorner", y).CornerRadius = UDim.new(0, 6)
    local n = Instance.new("TextButton", d); n.Size = UDim2.new(0,120,0,30); n.Position = UDim2.new(1,-140,1,-45); n.BackgroundColor3 = C_ITEM_H; n.Text = "Отмена"; n.TextColor3 = C_TEXT; n.Font = Enum.Font.GothamBold; n.ZIndex = 102
    Instance.new("UICorner", n).CornerRadius = UDim.new(0, 6)
    n.MouseButton1Click:Connect(function() modal:Destroy() end)
    y.MouseButton1Click:Connect(function()
        if t.Text ~= "" then configData.configs[t.Text] = {toggles={}, sliders={}}; configData.active = t.Text; config.toggles = configData.configs[t.Text].toggles; config.sliders = configData.configs[t.Text].sliders; saveConfig(); refreshConfigList(); modal:Destroy() end
    end)
end, C_ACCENT)

local sScroll = tabs["Settings"].scroll
section(sScroll, "Menu Bind")
createButton(sScroll, "Change Bind: " .. menuBind.Name, function()
    local modal = Instance.new("Frame", gui); modal.Size = UDim2.new(1,0,1,0); modal.BackgroundTransparency = 0.45; modal.BackgroundColor3 = Color3.new(0,0,0); modal.ZIndex = 100
    local d = Instance.new("Frame", modal); d.Size = UDim2.new(0,300,0,100); d.Position = UDim2.new(0.5,-150,0.5,-50); d.BackgroundColor3 = C_BG; d.ZIndex = 101
    Instance.new("UICorner", d).CornerRadius = UDim.new(0, 10)
    local l = Instance.new("TextLabel", d); l.Size = UDim2.new(1,0,1,0); l.BackgroundTransparency = 1; l.Text = "Press any key..."; l.TextColor3 = C_ACCENT; l.Font = Enum.Font.GothamBold; l.ZIndex = 102
    local c; c = UIS.InputBegan:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.Keyboard then
            menuBind = inp.KeyCode; configData.menuBind = inp.KeyCode.Name; saveConfig(); c:Disconnect(); modal:Destroy()
            sScroll.Parent.Parent.Parent.Parent.MurderCheats.Settings.ScrollingFrame:FindFirstChild("Change Bind"):Destroy() -- dummy, just refresh
        end
    end)
end, C_ACCENT)
createButton(sScroll, "Reset All Settings", function() resetAll() end, C_DANGER)

-- ============================================================
--  INIT / OPEN / CLOSE
-- ============================================================
for name, val in pairs(config.toggles) do if toggleRegistry[name] and val then toggleRegistry[name].setState(true, false) end end
for name, val in pairs(config.sliders) do if sliderRegistry[name] then sliderRegistry[name].setValue(val, true, false) end end

local function openMenu() frame.Visible = true; uiScale.Scale = 0.85; TweenService:Create(uiScale, TweenInfo.new(0.3, Enum.EasingStyle.Back), {Scale = 1}):Play() end
local function closeMenu() local t = TweenService:Create(uiScale, TweenInfo.new(0.15), {Scale = 0.85}); t:Play(); t.Completed:Connect(function() frame.Visible = false end) end
closeBtn.MouseButton1Click:Connect(closeMenu)
switchTab("Combat")

UIS.InputBegan:Connect(function(input, gp)
    if input.KeyCode == menuBind and not gp then if frame.Visible then closeMenu() else openMenu() end return end
    if gp then return end
    if     input.KeyCode == Enum.KeyCode.W then flyKeys.W = true
    elseif input.KeyCode == Enum.KeyCode.A then flyKeys.A = true
    elseif input.KeyCode == Enum.KeyCode.S then flyKeys.S = true
    elseif input.KeyCode == Enum.KeyCode.D then flyKeys.D = true
    elseif input.KeyCode == Enum.KeyCode.Space then flyKeys.Space = true
    elseif input.KeyCode == Enum.KeyCode.LeftControl then flyKeys.LCtrl = true end
    if input.UserInputType == aimHold then aimKeyHeld = true end
end)
UIS.InputEnded:Connect(function(input)
    if     input.KeyCode == Enum.KeyCode.W then flyKeys.W = false
    elseif input.KeyCode == Enum.KeyCode.A then flyKeys.A = false
    elseif input.KeyCode == Enum.KeyCode.S then flyKeys.S = false
    elseif input.KeyCode == Enum.KeyCode.D then flyKeys.D = false
    elseif input.KeyCode == Enum.KeyCode.Space then flyKeys.Space = false
    elseif input.KeyCode == Enum.KeyCode.LeftControl then flyKeys.LCtrl = false end
    if input.UserInputType == aimHold then aimKeyHeld = false end
end)

player.CharacterAdded:Connect(function()
    task.wait(0.5)
    for name, t in pairs(toggleRegistry) do if t.getState() then pcall(t.setState, true, false) end end
    for name, s in pairs(sliderRegistry) do pcall(s.setValue, s.getValue(), true, false) end
end)
