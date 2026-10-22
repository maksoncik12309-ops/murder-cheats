
local UIS         = game:GetService("UserInputService")
local RunService  = game:GetService("RunService")
local Players     = game:GetService("Players")
local Lighting    = game:GetService("Lighting")
local VirtualUser = game:GetService("VirtualUser")
local TweenService= game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local Teleport    = game:GetService("TeleportService")
local Stats       = game:GetService("Stats")
local StarterGui  = game:GetService("StarterGui")
local GuiService  = game:GetService("GuiService")

local player = Players.LocalPlayer
local cam    = workspace.CurrentCamera


local C_BG      = Color3.fromRGB(6, 8, 10)
local C_PANEL   = Color3.fromRGB(16, 20, 24)
local C_ITEM    = Color3.fromRGB(22, 28, 34)
local C_ITEM_H  = Color3.fromRGB(32, 40, 48)
local C_ACCENT  = Color3.fromRGB(0, 255, 150)
local C_AMBER   = Color3.fromRGB(255, 160, 60)
local C_DANGER  = Color3.fromRGB(255, 60, 80)
local C_TEXT    = Color3.fromRGB(230, 240, 245)
local C_SUB     = Color3.fromRGB(110, 130, 145)

-- ============================================================
--  🔐 PASSWORD GATE
-- ============================================================
local PASSWORD = "murder"
local passwordCorrect = false
local pg = player:WaitForChild("PlayerGui")
if pg:FindFirstChild("MC_PasswordGate") then pg.MC_PasswordGate:Destroy() end

local pwdGui = Instance.new("ScreenGui")
pwdGui.Name = "MC_PasswordGate"
pwdGui.IgnoreGuiInset = true
pwdGui.ResetOnSpawn = false
pwdGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
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
pwdCard.Active = true
pwdCard.Parent = pwdBg
Instance.new("UICorner", pwdCard).CornerRadius = UDim.new(0, 14)

local pwdStroke = Instance.new("UIStroke", pwdCard)
pwdStroke.Color = C_ACCENT; pwdStroke.Thickness = 2; pwdStroke.Transparency = 0.2

task.spawn(function()
    while pwdCard.Parent do
        TweenService:Create(pwdStroke, TweenInfo.new(1.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Transparency = 0.75}):Play()
        task.wait(1.2)
        TweenService:Create(pwdStroke, TweenInfo.new(1.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Transparency = 0.2}):Play()
        task.wait(1.2)
    end
end)

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

local submitting = false

local function shakeCard()
    local origPos = pwdCard.Position
    for i = 1, 8 do
        local offset = (i % 2 == 0) and 8 or -8
        TweenService:Create(pwdCard, TweenInfo.new(0.05), {Position = origPos + UDim2.new(0, offset, 0, 0)}):Play()
        task.wait(0.05)
    end
    TweenService:Create(pwdCard, TweenInfo.new(0.1), {Position = origPos}):Play()
end

local function tryUnlock()
    if submitting then return end
    submitting = true
    if pwdInput.Text == PASSWORD then
        pwdStatus.TextColor3 = C_ACCENT
        pwdStatus.Text = "✓ access granted"
        pwdBtn.Text = "LOADING..."
        TweenService:Create(pwdStroke, TweenInfo.new(0.15), {Transparency = 0, Thickness = 4}):Play()
        task.wait(0.5)
        TweenService:Create(pwdCard, TweenInfo.new(0.35), {
            BackgroundTransparency = 1,
            Size = UDim2.new(0, 320, 0, 220),
        }):Play()
        TweenService:Create(pwdTitle, TweenInfo.new(0.3), {TextTransparency = 1}):Play()
        TweenService:Create(pwdSub,   TweenInfo.new(0.3), {TextTransparency = 1}):Play()
        TweenService:Create(pwdInput, TweenInfo.new(0.3), {BackgroundTransparency = 1, TextTransparency = 1}):Play()
        TweenService:Create(pwdBtn,   TweenInfo.new(0.3), {BackgroundTransparency = 1, TextTransparency = 1}):Play()
        TweenService:Create(pwdStatus,TweenInfo.new(0.3), {TextTransparency = 1}):Play()
        TweenService:Create(pwdInputStroke, TweenInfo.new(0.3), {Transparency = 1}):Play()
        TweenService:Create(pwdBg, TweenInfo.new(0.35), {BackgroundTransparency = 1}):Play()
        task.wait(0.4)
        pwdGui:Destroy()
        passwordCorrect = true
    else
        pwdStatus.TextColor3 = C_DANGER
        pwdStatus.Text = "✕ wrong password"
        pwdInputStroke.Color = C_DANGER
        pwdInputStroke.Transparency = 0
        shakeCard()
        task.wait(0.6)
        pwdInputStroke.Color = C_ACCENT
        pwdInputStroke.Transparency = 0.5
        pwdInput.Text = ""
        submitting = false
    end
end
pwdBtn.MouseButton1Click:Connect(tryUnlock)
pwdInput.FocusLost:Connect(tryUnlock)
pwdInput.Focused:Connect(function()
    pwdInputStroke.Transparency = 0
    pwdInputStroke.Thickness = 2
end)

pwdCard.BackgroundTransparency = 1
TweenService:Create(pwdCard, TweenInfo.new(0.3), {BackgroundTransparency = 0}):Play()
pwdCard.Size = UDim2.new(0, 320, 0, 220)
TweenService:Create(pwdCard, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
    {Size = UDim2.new(0, 360, 0, 260)}):Play()

repeat task.wait(0.1) until passwordCorrect

-- ============================================================
--  МУЛЬТИКОНФИГИ
-- ============================================================
local CONFIG_FILE = "MurderCheats_configs.json"

local configData = {
    configs = { default = { toggles = {}, sliders = {} } },
    active  = "default",
    menuBind = "RightShift",
}

local lastFlash = 0
local flashBadge
local function saveConfig()
    -- Синхронизируем активный конфиг и сохраняем весь configData
    configData.configs[configData.active] = {
        toggles = config.toggles,
        sliders = config.sliders,
    }
    if writefile then
        pcall(function() writefile(CONFIG_FILE, HttpService:JSONEncode(configData)) end)
    end
    if flashBadge and tick() - lastFlash > 0.5 then lastFlash = tick(); flashBadge() end
end

-- Загрузка (с миграцией со старого формата)
if isfile and readfile and isfile(CONFIG_FILE) then
    local ok, data = pcall(function() return HttpService:JSONDecode(readfile(CONFIG_FILE)) end)
    if ok and type(data) == "table" then
        if data.configs and data.active then
            if type(data.configs) == "table" then configData.configs = data.configs end
            if type(data.active) == "string" and configData.configs[data.active] then
                configData.active = data.active
            end
            if type(data.menuBind) == "string" then configData.menuBind = data.menuBind end
        elseif data.toggles or data.sliders then
            configData.configs.default = { toggles = data.toggles or {}, sliders = data.sliders or {} }
            configData.active = "default"
            if type(data.menuBind) == "string" then configData.menuBind = data.menuBind end
        end
    end
end
if not configData.configs[configData.active] then
    configData.active = next(configData.configs) or "default"
    if not configData.configs[configData.active] then
        configData.configs[configData.active] = { toggles = {}, sliders = {} }
    end
end
if not configData.configs[configData.active].toggles then
    configData.configs[configData.active].toggles = {}
end
if not configData.configs[configData.active].sliders then
    configData.configs[configData.active].sliders = {}
end

-- config — ссылки на таблицы активного конфига
local config = {
    toggles = configData.configs[configData.active].toggles,
    sliders = configData.configs[configData.active].sliders,
}

local menuBind = Enum.KeyCode[configData.menuBind] or Enum.KeyCode.RightShift

-- ============================================================
--  GUI CORE
-- ============================================================
local gui = Instance.new("ScreenGui")
gui.Name = "MurderCheats"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = pg

local watermark = Instance.new("TextLabel")
watermark.Size = UDim2.new(0, 200, 0, 22)
watermark.Position = UDim2.new(0, 12, 0, 12)
watermark.BackgroundTransparency = 1
watermark.Font = Enum.Font.GothamBold
watermark.TextSize = 12
watermark.RichText = true
watermark.Text = '<font color="#00FF96">●</font> MURDER CHEATS  <font color="#FFA03C">v11</font>'
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
fStroke.Color = C_ACCENT
fStroke.Thickness = 1.5
fStroke.Transparency = 0.35

task.spawn(function()
    local phase = 0
    while gui.Parent do
        phase = (phase + 0.03) % 1
        fStroke.Color = Color3.fromHSV(0.4 + 0.15 * math.sin(phase * math.pi * 2), 0.8, 1)
        task.wait(0.05)
    end
end)

local sidebar = Instance.new("Frame")
sidebar.Size = UDim2.new(0, 140, 1, -20)
sidebar.Position = UDim2.new(0, 10, 0, 10)
sidebar.BackgroundColor3 = C_PANEL
sidebar.BackgroundTransparency = 0.05
sidebar.BorderSizePixel = 0
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
tabLayout.SortOrder = Enum.SortOrder.LayoutOrder
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
closeBtn.BorderSizePixel = 0
closeBtn.AutoButtonColor = false
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 13
closeBtn.TextColor3 = C_TEXT
closeBtn.Text = "✕"
closeBtn.ZIndex = 5
closeBtn.Parent = frame
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 6)
local cbStroke = Instance.new("UIStroke", closeBtn)
cbStroke.Color = C_DANGER; cbStroke.Thickness = 1.2

local tabs = {}
local activeTab = nil
local function createTab(name)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 30)
    btn.BackgroundColor3 = C_ITEM
    btn.BackgroundTransparency = 0.4
    btn.BorderSizePixel = 0
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
    ind.BorderSizePixel = 0
    ind.BackgroundTransparency = 1
    ind.Parent = btn
    Instance.new("UICorner", ind).CornerRadius = UDim.new(1, 0)

    local scroll = Instance.new("ScrollingFrame")
    scroll.Size = UDim2.new(1, 0, 1, 0)
    scroll.BackgroundTransparency = 1
    scroll.BorderSizePixel = 0
    scroll.ScrollBarThickness = 3
    scroll.ScrollBarImageColor3 = C_ACCENT
    scroll.CanvasSize = UDim2.new(0,0,0,0)
    scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
    scroll.Visible = false
    scroll.Parent = contentArea

    local lay = Instance.new("UIListLayout")
    lay.Padding = UDim.new(0, 5)
    lay.SortOrder = Enum.SortOrder.LayoutOrder
    lay.Parent = scroll

    local p = Instance.new("UIPadding")
    p.PaddingRight = UDim.new(0, 6)
    p.PaddingBottom = UDim.new(0, 10)
    p.Parent = scroll

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
        TweenService:Create(t.ind, TweenInfo.new(0.15), {
            BackgroundTransparency = on and 0 or 1,
        }):Play()
    end
    activeTab = name
end
for _, n in ipairs({"Combat", "Visuals", "Movement", "Utility", "Config", "Settings"}) do
    createTab(n)
    tabs[n].btn.MouseButton1Click:Connect(function() switchTab(n) end)
end

local activeDrag = nil
UIS.InputChanged:Connect(function(input)
    if activeDrag and (input.UserInputType == Enum.UserInputType.MouseMovement or
       input.UserInputType == Enum.UserInputType.Touch) then
        if not frame.Visible then activeDrag = nil; return end
        local track = activeDrag.track
        local rel = (input.Position.X - track.AbsolutePosition.X) / track.AbsoluteSize.X
        activeDrag.applyPct(math.clamp(rel, 0, 1))
    end
end)
UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or
       input.UserInputType == Enum.UserInputType.Touch then activeDrag = nil end
end)

local toggleRegistry, sliderRegistry, resets = {}, {}, {}
local function addReset(fn) table.insert(resets, fn) end
local function resetAll() for _, fn in ipairs(resets) do pcall(fn) end end

local function section(parent, name)
    local wrap = Instance.new("Frame")
    wrap.Size = UDim2.new(1, 0, 0, 26)
    wrap.BackgroundTransparency = 1
    wrap.Parent = parent
    local bar = Instance.new("Frame")
    bar.Size = UDim2.new(0, 3, 0, 14)
    bar.Position = UDim2.new(0, 0, 0.5, -7)
    bar.BackgroundColor3 = C_AMBER
    bar.BorderSizePixel = 0
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
    btn.BorderSizePixel = 0
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
    ind.BorderSizePixel = 0
    ind.Parent = btn
    Instance.new("UICorner", ind).CornerRadius = UDim.new(1, 0)

    local knob = Instance.new("Frame")
    knob.Size = UDim2.new(0, 12, 0, 12)
    knob.Position = UDim2.new(0, 2, 0.5, -6)
    knob.BackgroundColor3 = C_SUB
    knob.BorderSizePixel = 0
    knob.Parent = ind
    Instance.new("UICorner", knob).CornerRadius = UDim.new(1, 0)

    local stroke = Instance.new("UIStroke", btn)
    stroke.Color = C_ACCENT; stroke.Thickness = 1; stroke.Transparency = 1
    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.12), {BackgroundColor3 = C_ITEM_H}):Play()
        TweenService:Create(stroke, TweenInfo.new(0.12), {Transparency = 0.4}):Play()
    end)
    btn.MouseLeave:Connect(function()
        if not state then TweenService:Create(btn, TweenInfo.new(0.12), {BackgroundColor3 = C_ITEM}):Play() end
        TweenService:Create(stroke, TweenInfo.new(0.12), {Transparency = 1}):Play()
    end)

    local function setState(v, persist)
        state = v
        if v then
            TweenService:Create(ind, TweenInfo.new(0.18, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
                {BackgroundColor3 = C_ACCENT}):Play()
            TweenService:Create(knob, TweenInfo.new(0.18, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
                {Position = UDim2.new(1, -14, 0.5, -6), BackgroundColor3 = C_BG}):Play()
            TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(20, 44, 36)}):Play()
            if onEnable then pcall(onEnable) end
        else
            TweenService:Create(ind, TweenInfo.new(0.15), {BackgroundColor3 = C_ITEM_H}):Play()
            TweenService:Create(knob, TweenInfo.new(0.15),
                {Position = UDim2.new(0, 2, 0.5, -6), BackgroundColor3 = C_SUB}):Play()
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
    btn.BorderSizePixel = 0
    btn.AutoButtonColor = false
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 12
    btn.TextColor3 = accent or C_AMBER
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.Text = "  ▸ " .. name
    btn.Parent = parent
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    local s = Instance.new("UIStroke", btn)
    s.Color = accent or C_AMBER; s.Thickness = 1; s.Transparency = 0.55
    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.12), {BackgroundColor3 = Color3.fromRGB(44, 32, 50)}):Play()
        TweenService:Create(s, TweenInfo.new(0.12), {Transparency = 0}):Play()
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.12), {BackgroundColor3 = Color3.fromRGB(26, 20, 30)}):Play()
        TweenService:Create(s, TweenInfo.new(0.12), {Transparency = 0.55}):Play()
    end)
    btn.MouseButton1Click:Connect(function() pcall(onClick) end)
    return btn
end

local function createSlider(parent, name, min, max, default, onChange)
    local currentVal = default
    local holder = Instance.new("Frame")
    holder.Size = UDim2.new(1, 0, 0, 58)
    holder.BackgroundColor3 = C_ITEM
    holder.BorderSizePixel = 0
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
    valBox.BorderSizePixel = 0
    valBox.Font = Enum.Font.Code
    valBox.TextSize = 12
    valBox.TextColor3 = C_ACCENT
    valBox.Text = tostring(default)
    valBox.ClearTextOnFocus = false
    valBox.Parent = holder
    Instance.new("UICorner", valBox).CornerRadius = UDim.new(0, 5)
    local vbStroke = Instance.new("UIStroke", valBox)
    vbStroke.Color = C_ACCENT; vbStroke.Thickness = 1; vbStroke.Transparency = 0.7

    local trackHit = Instance.new("TextButton")
    trackHit.Size = UDim2.new(1, -24, 0, 22)
    trackHit.Position = UDim2.new(0, 12, 0, 30)
    trackHit.BackgroundTransparency = 1
    trackHit.Text = ""
    trackHit.BorderSizePixel = 0
    trackHit.AutoButtonColor = false
    trackHit.Parent = holder

    local track = Instance.new("Frame")
    track.Size = UDim2.new(1, 0, 0, 5)
    track.Position = UDim2.new(0, 0, 0.5, -2)
    track.BackgroundColor3 = Color3.fromRGB(12, 16, 20)
    track.BorderSizePixel = 0
    track.Parent = trackHit
    Instance.new("UICorner", track).CornerRadius = UDim.new(1, 0)

    local fill = Instance.new("Frame")
    fill.Size = UDim2.new(0, 0, 1, 0)
    fill.BackgroundColor3 = C_ACCENT
    fill.BorderSizePixel = 0
    fill.Parent = track
    Instance.new("UICorner", fill).CornerRadius = UDim.new(1, 0)
    local grad = Instance.new("UIGradient")
    grad.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, C_ACCENT),
        ColorSequenceKeypoint.new(1, C_AMBER),
    })
    grad.Parent = fill

    local knob = Instance.new("Frame")
    knob.Size = UDim2.new(0, 14, 0, 14)
    knob.Position = UDim2.new(0, 0, 0.5, -7)
    knob.BackgroundColor3 = Color3.fromRGB(245, 250, 245)
    knob.BorderSizePixel = 0
    knob.Parent = track
    Instance.new("UICorner", knob).CornerRadius = UDim.new(1, 0)
    local kStroke = Instance.new("UIStroke", knob)
    kStroke.Color = C_ACCENT; kStroke.Thickness = 2

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
        if input.UserInputType == Enum.UserInputType.MouseButton1 or
           input.UserInputType == Enum.UserInputType.Touch then
            valBox:ReleaseFocus()
            activeDrag = { track = track, applyPct = function(pct)
                setValue(min + (max - min) * pct, true, true)
            end }
            local rel = (input.Position.X - track.AbsolutePosition.X) / track.AbsoluteSize.X
            setValue(min + (max - min) * math.clamp(rel, 0, 1), true, true)
        end
    end)
    valBox.FocusLost:Connect(function()
        local num = tonumber(valBox.Text)
        if num then setValue(num, true, true) else valBox.Text = tostring(currentVal) end
        TweenService:Create(vbStroke, TweenInfo.new(0.15), {Transparency = 0.7}):Play()
    end)
    valBox.Focused:Connect(function()
        TweenService:Create(vbStroke, TweenInfo.new(0.15), {Transparency = 0}):Play()
    end)
    local hovering = false
    holder.MouseEnter:Connect(function() hovering = true end)
    holder.MouseLeave:Connect(function() hovering = false end)
    UIS.InputChanged:Connect(function(input)
        if hovering and input.UserInputType == Enum.UserInputType.MouseWheel then
            local delta = input.Position.Z
            if delta ~= 0 then
                local step = (max - min) / 100
                setValue(currentVal + delta * step, true, true)
            end
        end
    end)
    setValue(default, false, false)
    addReset(function() setValue(default, true, true) end)
    sliderRegistry[name] = { setValue = setValue, getValue = function() return currentVal end, default = default }
end

local function getHum()
    local c = player.Character
    return c and c:FindFirstChildOfClass("Humanoid")
end
local function getTeamColor(p)
    if p.Team then return p.Team.TeamColor.Color end
    return C_ACCENT
end

-- ============================================================
--  FEATURE LOGIC (сокращено до значимых частей — как в предыдущих версиях)
-- ============================================================
-- FLY
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
    if on then
        if not char or not hum then return end
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if not hrp then return end
        flyBV = Instance.new("BodyVelocity")
        flyBV.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        flyBV.Velocity = Vector3.zero
        flyBV.Parent = hrp
        flyBG = Instance.new("BodyGyro")
        flyBG.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
        flyBG.P = 10000
        flyBG.CFrame = hrp.CFrame
        flyBG.Parent = hrp
        hum.PlatformStand = true
        flyActive = true
    end
end
RunService.RenderStepped:Connect(function()
    if not flyActive then return end
    local char = player.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp or not flyBV or not flyBG then return end
    cam = workspace.CurrentCamera
    local dir = Vector3.zero
    if flyKeys.W then dir = dir + cam.CFrame.LookVector end
    if flyKeys.S then dir = dir - cam.CFrame.LookVector end
    if flyKeys.A then dir = dir - cam.CFrame.RightVector end
    if flyKeys.D then dir = dir + cam.CFrame.RightVector end
    if flyKeys.Space then dir = dir + Vector3.new(0,1,0) end
    if flyKeys.LCtrl then dir = dir - Vector3.new(0,1,0) end
    if dir.Magnitude > 0 then dir = dir.Unit end
    flyBV.Velocity = dir * flySpeed
    flyBG.CFrame = cam.CFrame
end)

local infJumpOn = false
UIS.JumpRequest:Connect(function()
    if infJumpOn then local h = getHum(); if h then h:ChangeState(Enum.HumanoidStateType.Jumping) end end
end)
local noclipOn = false
RunService.Stepped:Connect(function()
    if not noclipOn then return end
    local char = player.Character
    if not char then return end
    for _, p in ipairs(char:GetDescendants()) do
        if p:IsA("BasePart") then p.CanCollide = false end
    end
end)
local sprintOn, sprintHeld, sprintSpeed = false, false, 40
UIS.InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.KeyCode == Enum.KeyCode.LeftShift then sprintHeld = true end
end)
UIS.InputEnded:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.LeftShift then sprintHeld = false end
end)
RunService.Heartbeat:Connect(function()
    local h = getHum()
    if not h then return end
    if sprintOn and sprintHeld then h.WalkSpeed = sprintSpeed
    elseif sprintOn and not sprintHeld then
        local base = sliderRegistry["Speed"] and sliderRegistry["Speed"].getValue() or 16
        h.WalkSpeed = base
    end
end)

-- FULLBRIGHT / POSTFX
local origB, origA, origO
local function setFullbright(on)
    if on then
        origB, origA, origO = Lighting.Brightness, Lighting.Ambient, Lighting.OutdoorAmbient
        Lighting.Brightness = 3
        Lighting.Ambient = Color3.fromRGB(180,180,180)
        Lighting.OutdoorAmbient = Color3.fromRGB(180,180,180)
    else
        if origB then Lighting.Brightness = origB end
        if origA then Lighting.Ambient = origA end
        if origO then Lighting.OutdoorAmbient = origO end
    end
end
local postDisabled = {}
local function setNoPost(on)
    if on then
        for _, e in ipairs(Lighting:GetChildren()) do
            if e:IsA("PostEffect") and e.Enabled then postDisabled[e] = true; e.Enabled = false end
        end
    else
        for e in pairs(postDisabled) do if e.Parent then e.Enabled = true end end
        postDisabled = {}
    end
end

-- ESP
local espOn, espTeamChk, espNames, espHP, espDist = false, false, false, false, false
local rainbowEsp = false
local espH, espBB = {}, {}
local function clearESP()
    for _, h in pairs(espH) do h:Destroy() end
    for _, b in pairs(espBB) do b:Destroy() end
    espH, espBB = {}, {}
end
local function makeESP(t)
    if t == player or not t.Character or espH[t] then return end
    if espTeamChk and t.Team == player.Team and player.Team ~= nil then return end
    local h = Instance.new("Highlight")
    h.FillColor = getTeamColor(t)
    h.OutlineColor = Color3.fromRGB(255,255,255)
    h.FillTransparency = 0.65
    h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    h.Adornee = t.Character
    h.Parent = gui
    espH[t] = h
    if espNames or espHP or espDist then
        local head = t.Character:FindFirstChild("Head") or t.Character:FindFirstChild("HumanoidRootPart")
        if head then
            local bb = Instance.new("BillboardGui")
            bb.Size = UDim2.new(0, 130, 0, 60)
            bb.StudsOffsetWorldSpace = Vector3.new(0, 2.6, 0)
            bb.AlwaysOnTop = true
            bb.Adornee = head
            bb.Parent = gui
            espBB[t] = bb
            if espNames then
                local nm = Instance.new("TextLabel")
                nm.Size = UDim2.new(1, 0, 0, 16)
                nm.BackgroundTransparency = 1
                nm.Font = Enum.Font.GothamBold
                nm.TextSize = 12
                nm.TextStrokeTransparency = 0.3
                nm.TextColor3 = C_TEXT
                nm.Text = t.Name
                nm.Parent = bb
            end
            if espHP then
                local bar = Instance.new("Frame")
                bar.Size = UDim2.new(0.8, 0, 0, 5)
                bar.Position = UDim2.new(0.1, 0, 0, 20)
                bar.BackgroundColor3 = Color3.fromRGB(40, 20, 20)
                bar.BorderSizePixel = 0
                bar.Parent = bb
                Instance.new("UICorner", bar).CornerRadius = UDim.new(0, 3)
                local hpFill = Instance.new("Frame")
                hpFill.Size = UDim2.new(1, 0, 1, 0)
                hpFill.BackgroundColor3 = C_ACCENT
                hpFill.BorderSizePixel = 0
                hpFill.Name = "HP"
                hpFill.Parent = bar
                Instance.new("UICorner", hpFill).CornerRadius = UDim.new(0, 3)
            end
            if espDist then
                local dl = Instance.new("TextLabel")
                dl.Size = UDim2.new(1, 0, 0, 14)
                dl.Position = UDim2.new(0, 0, 0, 30)
                dl.BackgroundTransparency = 1
                dl.Font = Enum.Font.Code
                dl.TextSize = 10
                dl.TextStrokeTransparency = 0.3
                dl.TextColor3 = C_AMBER
                dl.Name = "Dist"
                dl.Text = "0m"
                dl.Parent = bb
            end
        end
    end
end
task.spawn(function()
    local hue = 0
    while gui.Parent do
        task.wait(0.4)
        if espOn then
            for _, p in ipairs(Players:GetPlayers()) do
                if p ~= player then makeESP(p) end
            end
            local myHrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
            for p, h in pairs(espH) do
                if not p.Parent or not p.Character then
                    h:Destroy(); espH[p] = nil
                    if espBB[p] then espBB[p]:Destroy(); espBB[p] = nil end
                elseif espTeamChk and p.Team == player.Team and player.Team ~= nil then
                    h:Destroy(); espH[p] = nil
                    if espBB[p] then espBB[p]:Destroy(); espBB[p] = nil end
                else
                    h.Adornee = p.Character
                    if rainbowEsp then
                        hue = (hue + 0.05) % 1
                        h.FillColor = Color3.fromHSV(hue, 1, 1)
                    else
                        h.FillColor = getTeamColor(p)
                    end
                    if espBB[p] then
                        local hum = p.Character:FindFirstChildOfClass("Humanoid")
                        local hp = espBB[p]:FindFirstChild("HP", true)
                        if hp and hum then
                            hp.Size = UDim2.new(math.clamp(hum.Health/hum.MaxHealth, 0, 1), 0, 1, 0)
                            hp.BackgroundColor3 = hum.Health < hum.MaxHealth*0.3 and C_DANGER or C_ACCENT
                        end
                        local dl = espBB[p]:FindFirstChild("Dist", true)
                        if dl and myHrp and p.Character:FindFirstChild("HumanoidRootPart") then
                            local d = (myHrp.Position - p.Character.HumanoidRootPart.Position).Magnitude
                            dl.Text = string.format("%.0fm", d)
                        end
                    end
                end
            end
        end
    end
end)

-- TRACERS / SKELETON
local tracerOn = false
local skeletonOn = false
local tracerLines, skelLines = {}, {}
local hasDrawing = pcall(function() local l = drawing.new("Line"); l:Remove() end)
RunService.RenderStepped:Connect(function()
    if not hasDrawing then return end
    cam = workspace.CurrentCamera
    if tracerOn then
        local bottomCenter = Vector2.new(cam.ViewportSize.X/2, cam.ViewportSize.Y)
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= player and p.Character then
                local head = p.Character:FindFirstChild("Head")
                if head then
                    local sp, onScreen = cam:WorldToViewportPoint(head.Position)
                    if onScreen and sp.Z > 0 then
                        local line = tracerLines[p]
                        if not line then
                            line = drawing.new("Line")
                            line.Thickness = 1.2
                            line.Transparency = 0.8
                            tracerLines[p] = line
                        end
                        line.From = bottomCenter
                        line.To = Vector2.new(sp.X, sp.Y)
                        line.Color = getTeamColor(p)
                        line.Visible = true
                    else
                        if tracerLines[p] then tracerLines[p].Visible = false end
                    end
                end
            end
        end
    end
    if skeletonOn then
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= player and p.Character then
                local char = p.Character
                if not skelLines[p] then
                    skelLines[p] = {}
                    for i = 1, 14 do
                        local l = drawing.new("Line")
                        l.Thickness = 1
                        l.Transparency = 0.85
                        l.Visible = false
                        skelLines[p][i] = l
                    end
                end
                local lines = skelLines[p]
                local col = getTeamColor(p)
                local bones = {
                    {"Head","UpperTorso"},{"UpperTorso","LowerTorso"},
                    {"UpperTorso","LeftUpperArm"},{"LeftUpperArm","LeftLowerArm"},
                    {"LeftLowerArm","LeftHand"},
                    {"UpperTorso","RightUpperArm"},{"RightUpperArm","RightLowerArm"},
                    {"RightLowerArm","RightHand"},
                    {"LowerTorso","LeftUpperLeg"},{"LeftUpperLeg","LeftLowerLeg"},
                    {"LeftLowerLeg","LeftFoot"},
                    {"LowerTorso","RightUpperLeg"},{"RightUpperLeg","RightLowerLeg"},
                    {"RightLowerLeg","RightFoot"},
                }
                if char:FindFirstChild("Torso") then
                    bones = {{"Head","Torso"},{"Torso","Left Arm"},{"Torso","Right Arm"},
                             {"Torso","Left Leg"},{"Torso","Right Leg"}}
                end
                for i, pair in ipairs(bones) do
                    local a = char:FindFirstChild(pair[1])
                    local b = char:FindFirstChild(pair[2])
                    if a and b and lines[i] then
                        local sp1, on1 = cam:WorldToViewportPoint(a.Position)
                        local sp2, on2 = cam:WorldToViewportPoint(b.Position)
                        if on1 and on2 and sp1.Z > 0 and sp2.Z > 0 then
                            lines[i].From = Vector2.new(sp1.X, sp1.Y)
                            lines[i].To = Vector2.new(sp2.X, sp2.Y)
                            lines[i].Color = col
                            lines[i].Visible = true
                        else
                            lines[i].Visible = false
                        end
                    elseif lines[i] then lines[i].Visible = false end
                end
            end
        end
    end
end)
local function clearTracers()
    for _, l in pairs(tracerLines) do pcall(function() l:Remove() end) end
    tracerLines = {}
end
local function clearSkeleton()
    for _, ls in pairs(skelLines) do
        for _, l in ipairs(ls) do pcall(function() l:Remove() end) end
    end
    skelLines = {}
end

-- CHAMS / OUTLINE / NAMETAG / HAT / CROSSHAIR
local chamsOn = false
local chamsColor = Color3.fromRGB(0, 255, 150)
RunService.Heartbeat:Connect(function()
    if not chamsOn then return end
    local char = player.Character
    if not char then return end
    for _, p in ipairs(char:GetDescendants()) do
        if p:IsA("BasePart") and p.Name ~= "HumanoidRootPart" then p.Color = chamsColor end
    end
end)
local selfHighlight
local function setSelfOutline(on)
    if on then
        if selfHighlight then selfHighlight:Destroy() end
        selfHighlight = Instance.new("Highlight")
        selfHighlight.FillTransparency = 1
        selfHighlight.OutlineColor = C_ACCENT
        selfHighlight.OutlineTransparency = 0
        selfHighlight.Adornee = player.Character
        selfHighlight.Parent = gui
    else
        if selfHighlight then selfHighlight:Destroy(); selfHighlight = nil end
    end
end
local nametagGui
local function setNametag(on)
    if on and player.Character then
        if nametagGui then nametagGui:Destroy() end
        local head = player.Character:FindFirstChild("Head")
        if head then
            nametagGui = Instance.new("BillboardGui")
            nametagGui.Size = UDim2.new(0, 160, 0, 24)
            nametagGui.StudsOffsetWorldSpace = Vector3.new(0, 2.6, 0)
            nametagGui.AlwaysOnTop = true
            nametagGui.Adornee = head
            nametagGui.Parent = gui
            local lbl = Instance.new("TextLabel")
            lbl.Size = UDim2.new(1, 0, 1, 0)
            lbl.BackgroundTransparency = 1
            lbl.Font = Enum.Font.GothamBlack
            lbl.TextSize = 14
            lbl.TextStrokeTransparency = 0.3
            lbl.TextColor3 = C_ACCENT
            lbl.Text = "★ MURDER CHEATS ★"
            lbl.Parent = nametagGui
        end
    else
        if nametagGui then nametagGui:Destroy(); nametagGui = nil end
    end
end
local chinaHatPart
local function setChinaHat(on)
    if on then
        local char = player.Character
        local head = char and char:FindFirstChild("Head")
        if not head then return end
        if chinaHatPart then chinaHatPart:Destroy() end
        chinaHatPart = Instance.new("Part")
        chinaHatPart.Shape = Enum.PartType.Cylinder
        chinaHatPart.Size = Vector3.new(0.2, 4, 4)
        chinaHatPart.Color = C_ACCENT
        chinaHatPart.Material = Enum.Material.Neon
        chinaHatPart.CanCollide = false
        chinaHatPart.Massless = true
        chinaHatPart.Parent = char
        local weld = Instance.new("Weld")
        weld.Part0 = head
        weld.Part1 = chinaHatPart
        weld.C0 = CFrame.new(0, 1.4, 0) * CFrame.Angles(0, 0, math.rad(90))
        weld.Parent = chinaHatPart
    else
        if chinaHatPart then chinaHatPart:Destroy(); chinaHatPart = nil end
    end
end
local crosshairGui
local function setCrosshair(on)
    if on then
        if crosshairGui then crosshairGui:Destroy() end
        crosshairGui = Instance.new("ScreenGui")
        crosshairGui.IgnoreGuiInset = true
        crosshairGui.ResetOnSpawn = false
        crosshairGui.Parent = pg
        local function mkLine(sx, sy, px, py)
            local f = Instance.new("Frame")
            f.Size = UDim2.new(0, sx, 0, sy)
            f.Position = UDim2.new(0.5, px, 0.5, py)
            f.BackgroundColor3 = C_ACCENT
            f.BorderSizePixel = 0
            f.Parent = crosshairGui
            Instance.new("UICorner", f).CornerRadius = UDim.new(1, 0)
        end
        mkLine(2, 14, -1, -16); mkLine(2, 14, -1, 2)
        mkLine(14, 2, -16, -1); mkLine(14, 2, 2, -1)
    else
        if crosshairGui then crosshairGui:Destroy(); crosshairGui = nil end
    end
end

-- ATMOSPHERE
local atmosIdx = 1
local atmosPresets = {
    { name = "Default", ambient = Color3.fromRGB(70,70,70),   out = Color3.fromRGB(128,128,128), bright = 2,   clock = 14 },
    { name = "Night",   ambient = Color3.fromRGB(15,20,40),   out = Color3.fromRGB(20,25,50),    bright = 0.3, clock = 0 },
    { name = "Dusk",    ambient = Color3.fromRGB(90,60,80),   out = Color3.fromRGB(120,80,100),  bright = 1,   clock = 18 },
    { name = "Red",     ambient = Color3.fromRGB(120,20,20),  out = Color3.fromRGB(160,40,40),   bright = 1,   clock = 14 },
}
local function applyAtmos()
    local p = atmosPresets[atmosIdx]
    Lighting.Ambient = p.ambient
    Lighting.OutdoorAmbient = p.out
    Lighting.Brightness = p.bright
    Lighting.ClockTime = p.clock
end

-- HITBOX
local hitboxOn = false
local hitboxScale = 1.6
local hitboxTransparency = 0.5
local function applyHitbox()
    if not hitboxOn then return end
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= player and p.Character then
            for _, part in ipairs(p.Character:GetDescendants()) do
                if part:IsA("BasePart") and (part.Name == "Head" or part.Name == "HumanoidRootPart"
                    or part.Name == "UpperTorso" or part.Name == "Torso") then
                    if not part:GetAttribute("origSize") then
                        part:SetAttribute("origSize", part.Size)
                        part:SetAttribute("origTransparency", part.Transparency)
                        part:SetAttribute("origCanCollide", part.CanCollide)
                    end
                    part.Size = part:GetAttribute("origSize") * hitboxScale
                    part.Transparency = hitboxTransparency
                    part.CanCollide = true
                end
            end
        end
    end
end
local function restoreHitbox()
    for _, p in ipairs(Players:GetPlayers()) do
        if p.Character then
            for _, part in ipairs(p.Character:GetDescendants()) do
                if part:IsA("BasePart") and part:GetAttribute("origSize") then
                    part.Size = part:GetAttribute("origSize")
                    part.Transparency = part:GetAttribute("origTransparency") or 0
                    part.CanCollide = part:GetAttribute("origCanCollide") or false
                    part:SetAttribute("origSize", nil)
                    part:SetAttribute("origTransparency", nil)
                    part:SetAttribute("origCanCollide", nil)
                end
            end
        end
    end
end
RunService.Heartbeat:Connect(applyHitbox)

-- AIMBOT
local aimOn, aimAutoShoot, aimKeyHeld, aimWallcheck, aimSnap = false, false, false, false, false
local aimHold = Enum.UserInputType.MouseButton2
local aimFOV, aimSmooth = 150, 0.35
local aimPart = "Head"
local aimPartIdx = 1
local aimBodyParts = {"Head", "HumanoidRootPart", "UpperTorso"}
local aimPrediction = 0
local aimPriority = "Nearest"
local priorityList = {"Nearest", "Lowest HP", "Highest HP"}
local triggerOn, triggerFOV = false, 30

local topInset = 36
pcall(function() topInset = GuiService:GetGuiInset().Y end)
local function getMouseViewport() return UIS:GetMouseLocation() - Vector2.new(0, topInset) end

local fovCircle = Instance.new("Frame")
fovCircle.Size = UDim2.new(0, aimFOV*2, 0, aimFOV*2)
fovCircle.Position = UDim2.fromOffset(0, 0)
fovCircle.AnchorPoint = Vector2.new(0.5, 0.5)
fovCircle.BackgroundTransparency = 1
fovCircle.Visible = false
fovCircle.Parent = gui
Instance.new("UICorner", fovCircle).CornerRadius = UDim.new(1, 0)
local fovStroke = Instance.new("UIStroke", fovCircle)
fovStroke.Color = C_ACCENT; fovStroke.Thickness = 1.5; fovStroke.Transparency = 0.4
local function refreshFOVCircle() fovCircle.Size = UDim2.new(0, aimFOV*2, 0, aimFOV*2) end

local function hasLOS(part)
    local origin = cam.CFrame.Position
    local params = RaycastParams.new()
    params.FilterType = Enum.RaycastFilterType.Exclude
    params.FilterDescendantsInstances = {player.Character}
    local res = workspace:Raycast(origin, part.Position - origin, params)
    if res and res.Instance then return res.Instance:IsDescendantOf(part.Parent) end
    return true
end
local function predictPos(part)
    if aimPrediction <= 0 then return part.Position end
    return part.Position + part.AssemblyLinearVelocity * aimPrediction
end
local function getTarget(fovOverride)
    cam = workspace.CurrentCamera
    local mousePos = getMouseViewport()
    local maxFov = fovOverride or aimFOV
    local best, bestScore
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= player and p.Character then
            if not (espTeamChk and p.Team == player.Team and player.Team ~= nil) then
                local part = p.Character:FindFirstChild(aimPart)
                local hum  = p.Character:FindFirstChildOfClass("Humanoid")
                if part and hum and hum.Health > 0 then
                    if not aimWallcheck or hasLOS(part) then
                        local sp, onScreen = cam:WorldToViewportPoint(predictPos(part))
                        if onScreen and sp.Z > 0 then
                            local d = (Vector2.new(sp.X, sp.Y) - mousePos).Magnitude
                            if d < maxFov then
                                local score
                                if aimPriority == "Nearest" then score = d
                                elseif aimPriority == "Lowest HP" then score = hum.Health
                                elseif aimPriority == "Highest HP" then score = -hum.Health end
                                if not bestScore or score < bestScore then
                                    bestScore = score; best = part
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    return best
end
RunService.RenderStepped:Connect(function()
    if fovCircle.Visible then
        local m = UIS:GetMouseLocation()
        fovCircle.Position = UDim2.fromOffset(m.X, m.Y)
    end
    if aimOn and aimKeyHeld then
        local target = getTarget()
        if target then
            cam = workspace.CurrentCamera
            cam.CFrame = cam.CFrame:Lerp(CFrame.new(cam.CFrame.Position, predictPos(target)),
                1 - math.clamp(aimSmooth, 0, 0.99))
        end
    end
    if triggerOn then
        if getTarget(triggerFOV) then
            VirtualUser:CaptureController()
            VirtualUser:ClickButton1(Vector2.new(cam.ViewportSize.X/2, cam.ViewportSize.Y/2))
        end
    end
end)
UIS.InputBegan:Connect(function(input, gp)
    if gp then return end
    if aimSnap and input.UserInputType == Enum.UserInputType.MouseButton1 then
        local t = getTarget()
        if t then cam.CFrame = CFrame.new(cam.CFrame.Position, predictPos(t)) end
    end
end)
task.spawn(function()
    while gui.Parent do
        task.wait(0.05)
        if aimOn and aimAutoShoot and aimKeyHeld and getTarget() then
            VirtualUser:CaptureController()
            VirtualUser:ClickButton1(Vector2.new(cam.ViewportSize.X/2, cam.ViewportSize.Y/2))
        end
    end
end)

-- FREECAM / CLICK TP / RESPAWN / SPIN / BODY
local freecamOn = false
local freecamPos, freecamLook
local origCameraSubject
local function setFreecam(on)
    if on then
        cam = workspace.CurrentCamera
        origCameraSubject = cam.CameraSubject
        cam.CameraType = Enum.CameraType.Scriptable
        freecamPos = cam.CFrame.Position
        freecamLook = cam.CFrame.LookVector
    else
        cam = workspace.CurrentCamera
        cam.CameraType = Enum.CameraType.Custom
        if origCameraSubject then cam.CameraSubject = origCameraSubject end
    end
end
RunService.RenderStepped:Connect(function()
    if not freecamOn then return end
    cam = workspace.CurrentCamera
    local dir = Vector3.zero
    if flyKeys.W then dir = dir + freecamLook end
    if flyKeys.S then dir = dir - freecamLook end
    if flyKeys.A then dir = dir - freecamLook:Cross(Vector3.new(0,1,0)).Unit end
    if flyKeys.D then dir = dir + freecamLook:Cross(Vector3.new(0,1,0)).Unit end
    if flyKeys.Space then dir = dir + Vector3.new(0,1,0) end
    if flyKeys.LCtrl then dir = dir - Vector3.new(0,1,0) end
    freecamPos = freecamPos + dir * 1.5
    cam.CFrame = CFrame.new(freecamPos, freecamPos + freecamLook)
end)

local clickTPOn, ctrlHeld = false, false
UIS.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.LeftControl then ctrlHeld = true end
end)
UIS.InputEnded:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.LeftControl then ctrlHeld = false end
end)
UIS.InputBegan:Connect(function(input, gp)
    if gp then return end
    if clickTPOn and ctrlHeld and input.UserInputType == Enum.UserInputType.MouseButton1 then
        cam = workspace.CurrentCamera
        local m = UIS:GetMouseLocation()
        local ray = cam:ViewportPointToRay(m.X, m.Y)
        local params = RaycastParams.new()
        params.FilterDescendantsInstances = {player.Character}
        params.FilterType = Enum.RaycastFilterType.Exclude
        local res = workspace:Raycast(ray.Origin, ray.Direction * 1000, params)
        if res then
            local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
            if hrp then hrp.CFrame = CFrame.new(res.Position + Vector3.new(0, 3, 0)) end
        end
    end
end)

local autoRespawnOn = false
local function hookAutoRespawn()
    local h = getHum()
    if h and autoRespawnOn then
        h.Died:Connect(function()
            if autoRespawnOn then task.wait(0.5); pcall(function() player:LoadCharacter() end) end
        end)
    end
end
player.CharacterAdded:Connect(hookAutoRespawn)

local spinOn, spinSpeed = false, 5
RunService.Heartbeat:Connect(function()
    if not spinOn then return end
    local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    if hrp then hrp.CFrame = hrp.CFrame * CFrame.Angles(0, math.rad(spinSpeed), 0) end
end)

local function applyBodyScale(s)
    local h = getHum()
    if not h then return end
    h.BodyDepthScale.Value = s; h.BodyWidthScale.Value = s
    h.BodyHeightScale.Value = s; h.HeadScale.Value = s
end

-- SAVE/LOAD POS / BHOP / LONG JUMP / WALL CLIMB / SPEED
local savedPosition = nil
local bhopOn = false
RunService.Heartbeat:Connect(function()
    if not bhopOn then return end
    local h = getHum()
    if not h then return end
    local state = h:GetState()
    if state == Enum.HumanoidStateType.Landed or state == Enum.HumanoidStateType.Running then
        h:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)
local longJumpOn = false
UIS.JumpRequest:Connect(function()
    if longJumpOn then
        local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
        if hrp then
            local bv = Instance.new("BodyVelocity")
            bv.Velocity = hrp.CFrame.LookVector * 80 + Vector3.new(0, 40, 0)
            bv.MaxForce = Vector3.new(1e5, 1e5, 1e5)
            bv.Parent = hrp
            task.delay(0.2, function() bv:Destroy() end)
        end
    end
end)
local wallClimbOn = false
local wallClimbBV
RunService.Heartbeat:Connect(function()
    if not wallClimbOn then return end
    local char = player.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    local params = RaycastParams.new()
    params.FilterDescendantsInstances = {char}
    params.FilterType = Enum.RaycastFilterType.Exclude
    local res = workspace:Raycast(hrp.Position, hrp.CFrame.LookVector * 3, params)
    if res and (flyKeys.W or flyKeys.A or flyKeys.D) then
        if not wallClimbBV then
            wallClimbBV = Instance.new("BodyVelocity")
            wallClimbBV.MaxForce = Vector3.new(1e5, 1e5, 1e5)
        end
        wallClimbBV.Parent = hrp
        wallClimbBV.Velocity = Vector3.new(0, 25, 0)
    else
        if wallClimbBV then wallClimbBV:Destroy(); wallClimbBV = nil end
    end
end)
local speedBoostOn, speedBoostVal = false, 50
RunService.Heartbeat:Connect(function()
    if not speedBoostOn then return end
    local h = getHum()
    if h then h.WalkSpeed = speedBoostVal end
end)
local antiafkOn = false
player.Idled:Connect(function()
    if not antiafkOn then return end
    VirtualUser:CaptureController()
    VirtualUser:Button2Down(Vector2.new(0,0))
    task.wait(1)
    VirtualUser:Button2Up(Vector2.new(0,0))
end)
local spectateIdx = 1
local function spectateNext()
    local list = {}
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= player and p.Character then table.insert(list, p) end
    end
    if #list == 0 then return end
    spectateIdx = spectateIdx % #list + 1
    local t = list[spectateIdx]
    cam = workspace.CurrentCamera
    cam.CameraSubject = t.Character:FindFirstChildOfClass("Humanoid") or t.Character:FindFirstChild("HumanoidRootPart")
end

-- PLAYER LIST
local playerListGui = Instance.new("ScreenGui")
playerListGui.Name = "MCPlayerList"
playerListGui.ResetOnSpawn = false
playerListGui.Parent = pg
local playerListFrame = Instance.new("Frame")
playerListFrame.Size = UDim2.new(0, 220, 0, 260)
playerListFrame.Position = UDim2.new(1, -232, 0, 40)
playerListFrame.BackgroundColor3 = C_BG
playerListFrame.BackgroundTransparency = 0.1
playerListFrame.BorderSizePixel = 0
playerListFrame.Visible = false
playerListFrame.Parent = playerListGui
Instance.new("UICorner", playerListFrame).CornerRadius = UDim.new(0, 8)
local plStroke = Instance.new("UIStroke", playerListFrame)
plStroke.Color = C_ACCENT; plStroke.Thickness = 1; plStroke.Transparency = 0.4
local plTitle = Instance.new("TextLabel")
plTitle.Size = UDim2.new(1, -12, 0, 22)
plTitle.Position = UDim2.new(0, 6, 0, 4)
plTitle.BackgroundTransparency = 1
plTitle.Font = Enum.Font.GothamBold
plTitle.TextSize = 12
plTitle.TextColor3 = C_ACCENT
plTitle.Text = "● Players"
plTitle.TextXAlignment = Enum.TextXAlignment.Left
plTitle.Parent = playerListFrame
local plScroll = Instance.new("ScrollingFrame")
plScroll.Size = UDim2.new(1, -12, 1, -32)
plScroll.Position = UDim2.new(0, 6, 0, 28)
plScroll.BackgroundTransparency = 1
plScroll.BorderSizePixel = 0
plScroll.ScrollBarThickness = 3
plScroll.CanvasSize = UDim2.new(0,0,0,0)
plScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
plScroll.Parent = playerListFrame
local plLayout = Instance.new("UIListLayout")
plLayout.Padding = UDim.new(0, 3)
plLayout.Parent = plScroll
task.spawn(function()
    while gui.Parent do
        task.wait(1)
        if playerListFrame.Visible then
            for _, child in ipairs(plScroll:GetChildren()) do
                if child:IsA("TextLabel") then child:Destroy() end
            end
            for _, p in ipairs(Players:GetPlayers()) do
                local lbl = Instance.new("TextLabel")
                lbl.Size = UDim2.new(1, 0, 0, 20)
                lbl.BackgroundTransparency = 1
                lbl.Font = Enum.Font.Code
                lbl.TextSize = 11
                lbl.TextXAlignment = Enum.TextXAlignment.Left
                if p == player then
                    lbl.TextColor3 = C_AMBER
                    lbl.Text = "  " .. p.Name .. " (you)"
                else
                    lbl.TextColor3 = C_TEXT
                    local hum = p.Character and p.Character:FindFirstChildOfClass("Humanoid")
                    lbl.Text = hum and string.format("  %s  [%d]", p.Name, math.floor(hum.Health)) or ("  " .. p.Name)
                end
                lbl.Parent = plScroll
            end
        end
    end
end)

-- UNLOAD
local function unloadCheat()
    pcall(resetAll)
    pcall(function() setFly(false) end)
    pcall(function() setFreecam(false) end)
    pcall(function() setNoPost(false) end)
    pcall(function() setFullbright(false) end)
    pcall(function() clearESP() end)
    pcall(function() clearTracers() end)
    pcall(function() clearSkeleton() end)
    pcall(function() restoreHitbox() end)
    pcall(function() setSelfOutline(false) end)
    pcall(function() setNametag(false) end)
    pcall(function() setChinaHat(false) end)
    pcall(function() setCrosshair(false) end)
    pcall(function()
        local h = getHum()
        if h then
            h.WalkSpeed = 16; h.JumpPower = 50
            h.BodyDepthScale.Value = 1; h.BodyWidthScale.Value = 1
            h.BodyHeightScale.Value = 1; h.HeadScale.Value = 1
        end
    end)
    pcall(function()
        cam = workspace.CurrentCamera
        cam.CameraType = Enum.CameraType.Custom
        cam.FieldOfView = 70
    end)
    pcall(function() playerListGui:Destroy() end)
    task.wait(0.1)
    pcall(function() gui:Destroy() end)
    print("[Murder Cheats] Unloaded")
end

local function showUnloadConfirm()
    local modal = Instance.new("Frame")
    modal.Size = UDim2.new(1, 0, 1, 0)
    modal.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    modal.BackgroundTransparency = 0.45
    modal.BorderSizePixel = 0
    modal.ZIndex = 100
    modal.Parent = gui
    local dialog = Instance.new("Frame")
    dialog.Size = UDim2.new(0, 340, 0, 170)
    dialog.Position = UDim2.new(0.5, -170, 0.5, -85)
    dialog.BackgroundColor3 = C_BG
    dialog.BorderSizePixel = 0
    dialog.ZIndex = 101
    dialog.Parent = modal
    Instance.new("UICorner", dialog).CornerRadius = UDim.new(0, 10)
    local dS = Instance.new("UIStroke", dialog)
    dS.Color = C_DANGER; dS.Thickness = 2
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, -32, 0, 90)
    lbl.Position = UDim2.new(0, 16, 0, 16)
    lbl.BackgroundTransparency = 1
    lbl.Font = Enum.Font.GothamBold
    lbl.TextSize = 15
    lbl.TextColor3 = C_TEXT
    lbl.TextWrapped = true
    lbl.RichText = true
    lbl.Text = 'Точно ли вырубить чит?\n<font size="12" color="#6E8291">Все функции будут отключены.\nВернуть — только перезапуском скрипта.</font>'
    lbl.ZIndex = 102
    lbl.Parent = dialog
    local yesBtn = Instance.new("TextButton")
    yesBtn.Size = UDim2.new(0, 140, 0, 36)
    yesBtn.Position = UDim2.new(0, 16, 1, -52)
    yesBtn.BackgroundColor3 = C_DANGER
    yesBtn.AutoButtonColor = false
    yesBtn.Font = Enum.Font.GothamBold
    yesBtn.TextSize = 13
    yesBtn.TextColor3 = C_TEXT
    yesBtn.Text = "Да, вырубить"
    yesBtn.ZIndex = 102
    yesBtn.Parent = dialog
    Instance.new("UICorner", yesBtn).CornerRadius = UDim.new(0, 6)
    local noBtn = Instance.new("TextButton")
    noBtn.Size = UDim2.new(0, 140, 0, 36)
    noBtn.Position = UDim2.new(1, -156, 1, -52)
    noBtn.BackgroundColor3 = C_ACCENT
    noBtn.AutoButtonColor = false
    noBtn.Font = Enum.Font.GothamBold
    noBtn.TextSize = 13
    noBtn.TextColor3 = C_BG
    noBtn.Text = "Нет, отмена"
    noBtn.ZIndex = 102
    noBtn.Parent = dialog
    Instance.new("UICorner", noBtn).CornerRadius = UDim.new(0, 6)
    noBtn.MouseButton1Click:Connect(function() modal:Destroy() end)
    yesBtn.MouseButton1Click:Connect(function() modal:Destroy(); task.wait(0.05); unloadCheat() end)
end

-- ============================================================
--  COMBAT TAB
-- ============================================================
local cScroll = tabs["Combat"].scroll
section(cScroll, "Aimbot")
createToggle(cScroll, "Aimbot  (hold RMB, от мыши)",
    function() aimOn = true; fovCircle.Visible = true end,
    function() aimOn = false; fovCircle.Visible = false end)
createToggle(cScroll, "FOV Circle",
    function() fovCircle.Visible = true end,
    function() fovCircle.Visible = false end)
createSlider(cScroll, "Aim FOV", 20, 500, 150, function(v) aimFOV = v; refreshFOVCircle() end)
createSlider(cScroll, "Aim Smoothness", 0, 0.95, 0.35, function(v) aimSmooth = v end)
createSlider(cScroll, "Prediction (сек)", 0, 0.5, 0, function(v) aimPrediction = v end)
createToggle(cScroll, "Auto Shoot", function() aimAutoShoot = true end, function() aimAutoShoot = false end)
createToggle(cScroll, "Wallcheck (не наводится через стены)",
    function() aimWallcheck = true end, function() aimWallcheck = false end)
createToggle(cScroll, "Snap Aim (клик -> мгновенно в цель)",
    function() aimSnap = true end, function() aimSnap = false end)
do
    local b
    b = createButton(cScroll, "Body Part: " .. aimPart, function()
        aimPartIdx = aimPartIdx % #aimBodyParts + 1
        aimPart = aimBodyParts[aimPartIdx]
        b.Text = "  ▸ Body Part: " .. aimPart
    end, C_AMBER)
end
do
    local b
    b = createButton(cScroll, "Priority: " .. aimPriority, function()
        local idx = 1
        for i, v in ipairs(priorityList) do if v == aimPriority then idx = i end end
        aimPriority = priorityList[idx % #priorityList + 1]
        b.Text = "  ▸ Priority: " .. aimPriority
    end, C_AMBER)
end

section(cScroll, "Trigger Bot")
createToggle(cScroll, "Trigger Bot", function() triggerOn = true end, function() triggerOn = false end)
createSlider(cScroll, "Trigger FOV", 5, 200, 30, function(v) triggerFOV = v end)

section(cScroll, "Hitbox")
createToggle(cScroll, "Hitbox Expander (с коллизией)",
    function() hitboxOn = true end,
    function() hitboxOn = false; restoreHitbox() end)
createSlider(cScroll, "Hitbox Scale", 1, 3, 1.6, function(v)
    hitboxScale = v
    if hitboxOn then restoreHitbox(); applyHitbox() end
end)
createSlider(cScroll, "Hitbox Transparency", 0, 0.9, 0.5, function(v)
    hitboxTransparency = v
    if hitboxOn then restoreHitbox(); applyHitbox() end
end)

-- ============================================================
--  VISUALS TAB
-- ============================================================
local vScroll = tabs["Visuals"].scroll
section(vScroll, "ESP")
createToggle(vScroll, "Wallhack / ESP", function() espOn = true end, function() espOn = false; clearESP() end)
createToggle(vScroll, "Only enemies", function() espTeamChk = true; clearESP() end, function() espTeamChk = false; clearESP() end)
createToggle(vScroll, "Player names", function() espNames = true; clearESP() end, function() espNames = false; clearESP() end)
createToggle(vScroll, "Health bars", function() espHP = true; clearESP() end, function() espHP = false; clearESP() end)
createToggle(vScroll, "Distance labels", function() espDist = true; clearESP() end, function() espDist = false; clearESP() end)
createToggle(vScroll, "Rainbow ESP", function() rainbowEsp = true end, function() rainbowEsp = false end)
createToggle(vScroll, "Tracers", function()
    if not hasDrawing then warn("[MC] Drawing API недоступен"); return end
    tracerOn = true
end, function() tracerOn = false; clearTracers() end)
createToggle(vScroll, "Skeleton ESP", function()
    if not hasDrawing then warn("[MC] Drawing API недоступен"); return end
    skeletonOn = true
end, function() skeletonOn = false; clearSkeleton() end)

section(vScroll, "Rendering")
createToggle(vScroll, "Fullbright", function() setFullbright(true) end, function() setFullbright(false) end)
createToggle(vScroll, "No post-processing", function() setNoPost(true) end, function() setNoPost(false) end)
createSlider(vScroll, "Field of View", 50, 130, 70, function(v) if cam then cam.FieldOfView = v end end)

section(vScroll, "Character")
createToggle(vScroll, "Chams", function() chamsOn = true end, function() chamsOn = false end)
createToggle(vScroll, "Self outline", function() setSelfOutline(true) end, function() setSelfOutline(false) end)
createToggle(vScroll, "Self nametag", function() setNametag(true) end, function() setNametag(false) end)
createToggle(vScroll, "China Hat", function() setChinaHat(true) end, function() setChinaHat(false) end)

section(vScroll, "HUD")
createToggle(vScroll, "Custom Crosshair", function() setCrosshair(true) end, function() setCrosshair(false) end)
createToggle(vScroll, "Player List",
    function() playerListFrame.Visible = true end,
    function() playerListFrame.Visible = false end)

section(vScroll, "Atmosphere")
do
    local b
    b = createButton(vScroll, "Atmosphere: " .. atmosPresets[atmosIdx].name, function()
        atmosIdx = atmosIdx % #atmosPresets + 1
        applyAtmos()
        b.Text = "  ▸ Atmosphere: " .. atmosPresets[atmosIdx].name
    end, C_ACCENT)
end

-- ============================================================
--  MOVEMENT TAB
-- ============================================================
local mScroll = tabs["Movement"].scroll
section(mScroll, "Speed")
createSlider(mScroll, "Speed", 16, 250, 16, function(v) local h = getHum() if h then h.WalkSpeed = v end end)
createSlider(mScroll, "Jump Power", 50, 400, 50, function(v) local h = getHum() if h then h.JumpPower = v end end)
createSlider(mScroll, "Sprint Speed (hold LShift)", 20, 200, 40, function(v) sprintSpeed = v end)
createToggle(mScroll, "Enable Sprint",
    function() sprintOn = true end,
    function() sprintOn = false; local h = getHum() if h then h.WalkSpeed = sliderRegistry["Speed"].getValue() end end)
createToggle(mScroll, "Speed Boost (постоянный)",
    function() speedBoostOn = true end, function() speedBoostOn = false end)
createSlider(mScroll, "Speed Boost Value", 20, 300, 50, function(v) speedBoostVal = v end)

section(mScroll, "Utility Moves")
createToggle(mScroll, "Infinite Jump", function() infJumpOn = true end, function() infJumpOn = false end)
createToggle(mScroll, "Noclip",
    function() noclipOn = true end,
    function()
        noclipOn = false
        local char = player.Character
        if char then
            for _, p in ipairs(char:GetDescendants()) do
                if p:IsA("BasePart") then p.CanCollide = true end
            end
        end
    end)
createToggle(mScroll, "Bhop", function() bhopOn = true end, function() bhopOn = false end)
createToggle(mScroll, "Long Jump", function() longJumpOn = true end, function() longJumpOn = false end)
createToggle(mScroll, "Wall Climb", function() wallClimbOn = true end, function() wallClimbOn = false end)
createToggle(mScroll, "Freecam (WASD)", function() setFreecam(true) end, function() setFreecam(false) end)
createToggle(mScroll, "Click TP (Ctrl+LMB)", function() clickTPOn = true end, function() clickTPOn = false end)
createToggle(mScroll, "Auto Respawn", function() autoRespawnOn = true; hookAutoRespawn() end, function() autoRespawnOn = false end)
createToggle(mScroll, "Spin Character", function() spinOn = true end, function() spinOn = false end)
createSlider(mScroll, "Spin Speed", 1, 30, 5, function(v) spinSpeed = v end)

section(mScroll, "Fly")
createToggle(mScroll, "Fly (WASD + Space/Ctrl)", function() setFly(true) end, function() setFly(false) end)
createSlider(mScroll, "Fly Speed", 10, 300, 50, function(v) flySpeed = v end)

section(mScroll, "Body")
createSlider(mScroll, "Body Scale", 0.3, 5, 1, function(v) applyBodyScale(v) end)

-- ============================================================
--  UTILITY TAB
-- ============================================================
local uScroll = tabs["Utility"].scroll
section(uScroll, "Positions")
createButton(uScroll, "Save Position", function()
    local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    if hrp then savedPosition = hrp.CFrame; print("[MC] saved:", tostring(hrp.Position)) end
end, C_ACCENT)
createButton(uScroll, "Load Position", function()
    if not savedPosition then return end
    local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    if hrp then hrp.CFrame = savedPosition end
end, C_ACCENT)
createButton(uScroll, "Copy Position", function()
    local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    if hrp then
        local p = hrp.Position
        local s = string.format("Vector3.new(%d, %d, %d
