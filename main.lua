-- ============================================================
--  MURDER CHEATS v14 | FULL WORKING BUILD (Optimized)
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

-- 🔐 PASSWORD GATE
local PASSWORD = "murder"
local passwordCorrect = false
if pg:FindFirstChild("MC_PasswordGate") then pg.MC_PasswordGate:Destroy() end
local pwdGui = Instance.new("ScreenGui", pg)
pwdGui.Name = "MC_PasswordGate"
pwdGui.IgnoreGuiInset = true; pwdGui.ResetOnSpawn = false; pwdGui.DisplayOrder = 999999

local pwdBg = Instance.new("Frame", pwdGui)
pwdBg.Size = UDim2.new(1, 0, 1, 0); pwdBg.BackgroundColor3 = Color3.fromRGB(0, 0, 0); pwdBg.BackgroundTransparency = 0.3

local pwdCard = Instance.new("Frame", pwdBg)
pwdCard.Size = UDim2.new(0, 360, 0, 260); pwdCard.Position = UDim2.new(0.5, -180, 0.5, -130); pwdCard.BackgroundColor3 = C_BG
Instance.new("UICorner", pwdCard).CornerRadius = UDim.new(0, 14)
local pwdStroke = Instance.new("UIStroke", pwdCard); pwdStroke.Color = C_ACCENT; pwdStroke.Thickness = 2

local pwdTitle = Instance.new("TextLabel", pwdCard)
pwdTitle.Size = UDim2.new(1, -32, 0, 34); pwdTitle.Position = UDim2.new(0, 16, 0, 20)
pwdTitle.BackgroundTransparency = 1; pwdTitle.Font = Enum.Font.GothamBlack; pwdTitle.TextSize = 22
pwdTitle.RichText = true; pwdTitle.Text = '<font color="#00FF96">MURDER</font> <font color="#FFA03C">CHEATS</font>'; pwdTitle.TextXAlignment = Enum.TextXAlignment.Left

local pwdSub = Instance.new("TextLabel", pwdCard)
pwdSub.Size = UDim2.new(1, -32, 0, 16); pwdSub.Position = UDim2.new(0, 16, 0, 58)
pwdSub.BackgroundTransparency = 1; pwdSub.Font = Enum.Font.Code; pwdSub.TextSize = 11
pwdSub.TextColor3 = C_SUB; pwdSub.Text = "enter password to unlock"; pwdSub.TextXAlignment = Enum.TextXAlignment.Left

local pwdInput = Instance.new("TextBox", pwdCard)
pwdInput.Size = UDim2.new(1, -32, 0, 40); pwdInput.Position = UDim2.new(0, 16, 0, 96)
pwdInput.BackgroundColor3 = C_ITEM; pwdInput.BorderSizePixel = 0; pwdInput.Font = Enum.Font.Code
pwdInput.TextSize = 16; pwdInput.TextColor3 = C_TEXT; pwdInput.PlaceholderText = "password..."
pwdInput.PlaceholderColor3 = C_SUB; pwdInput.Text = ""; pwdInput.ClearTextOnFocus = false
Instance.new("UICorner", pwdInput).CornerRadius = UDim.new(0, 8)
local pwdInputStroke = Instance.new("UIStroke", pwdInput); pwdInputStroke.Color = C_ACCENT

local pwdBtn = Instance.new("TextButton", pwdCard)
pwdBtn.Size = UDim2.new(1, -32, 0, 40); pwdBtn.Position = UDim2.new(0, 16, 0, 148)
pwdBtn.BackgroundColor3 = C_ACCENT; pwdBtn.BorderSizePixel = 0; pwdBtn.AutoButtonColor = false
pwdBtn.Font = Enum.Font.GothamBold; pwdBtn.TextSize = 14; pwdBtn.TextColor3 = C_BG; pwdBtn.Text = "UNLOCK"
Instance.new("UICorner", pwdBtn).CornerRadius = UDim.new(0, 8)

local pwdStatus = Instance.new("TextLabel", pwdCard)
pwdStatus.Size = UDim2.new(1, -32, 0, 18); pwdStatus.Position = UDim2.new(0, 16, 1, -28)
pwdStatus.BackgroundTransparency = 1; pwdStatus.Font = Enum.Font.GothamBold; pwdStatus.TextSize = 12
pwdStatus.TextColor3 = C_DANGER; pwdStatus.Text = ""; pwdStatus.TextXAlignment = Enum.TextXAlignment.Left

local function tryUnlock()
    if pwdInput.Text == PASSWORD then
        pwdStatus.TextColor3 = C_ACCENT; pwdStatus.Text = "✓ access granted"; pwdBtn.Text = "LOADING..."
        task.wait(0.4); pwdGui:Destroy(); passwordCorrect = true
    else
        pwdStatus.TextColor3 = C_DANGER; pwdStatus.Text = "✕ wrong password"
        pwdInputStroke.Color = C_DANGER; pwdInput.Text = ""
    end
end
pwdBtn.MouseButton1Click:Connect(tryUnlock); pwdInput.FocusLost:Connect(tryUnlock)
repeat task.wait(0.1) until passwordCorrect

-- CONFIG SYSTEM
local CONFIG_FILE = "MurderCheats_configs.json"
local configData = { configs = { default = { toggles = {}, sliders = {} } }, active = "default", menuBind = "RightShift" }
local config = { toggles = configData.configs.default.toggles, sliders = configData.configs.default.sliders }
local lastFlash = 0; local flashBadge

local function saveConfig()
    configData.configs[configData.active] = { toggles = config.toggles, sliders = config.sliders }
    if writefile then pcall(function() writefile(CONFIG_FILE, HttpService:JSONEncode(configData)) end) end
    if flashBadge and tick() - lastFlash > 0.5 then lastFlash = tick(); flashBadge() end
end

if isfile and readfile and isfile(CONFIG_FILE) then
    local ok, data = pcall(function() return HttpService:JSONDecode(readfile(CONFIG_FILE)) end)
    if ok and type(data) == "table" and data.configs then
        configData = data
        if configData.configs[configData.active] then
            config.toggles = configData.configs[configData.active].toggles
            config.sliders = configData.configs[configData.active].sliders
        end
    end
end
local menuBind = Enum.KeyCode[configData.menuBind] or Enum.KeyCode.RightShift

-- GUI CORE
local gui = Instance.new("ScreenGui", pg)
gui.Name = "MurderCheats"; gui.ResetOnSpawn = false; gui.IgnoreGuiInset = true

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 600, 0, 420); frame.Position = UDim2.new(0.5, -300, 0.5, -210)
frame.BackgroundColor3 = C_BG; frame.BackgroundTransparency = 0.02; frame.Visible = false; frame.Draggable = true
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 12)
local uiScale = Instance.new("UIScale", frame)

local sidebar = Instance.new("Frame", frame)
sidebar.Size = UDim2.new(0, 140, 1, -20); sidebar.Position = UDim2.new(0, 10, 0, 10); sidebar.BackgroundColor3 = C_PANEL
Instance.new("UICorner", sidebar).CornerRadius = UDim.new(0, 10)

local brand = Instance.new("TextLabel", sidebar)
brand.Size = UDim2.new(1, -16, 0, 20); brand.Position = UDim2.new(0, 10, 0, 12); brand.BackgroundTransparency = 1
brand.Font = Enum.Font.GothamBlack; brand.TextSize = 16; brand.RichText = true; brand.Text = '<font color="#00FF96">MURDER</font>'; brand.TextXAlignment = Enum.TextXAlignment.Left

local brand2 = Instance.new("TextLabel", sidebar)
brand2.Size = UDim2.new(1, -16, 0, 20); brand2.Position = UDim2.new(0, 10, 0, 30); brand2.BackgroundTransparency = 1
brand2.Font = Enum.Font.GothamBlack; brand2.TextSize = 16; brand2.RichText = true; brand2.Text = '<font color="#FFA03C">CHEATS</font>'; brand2.TextXAlignment = Enum.TextXAlignment.Left

local savedBadge = Instance.new("TextLabel", sidebar)
savedBadge.Size = UDim2.new(1, -16, 0, 14); savedBadge.Position = UDim2.new(0, 10, 0, 52); savedBadge.BackgroundTransparency = 1
savedBadge.Font = Enum.Font.GothamBold; savedBadge.TextSize = 10; savedBadge.TextColor3 = C_ACCENT; savedBadge.Text = "● SAVED"; savedBadge.TextTransparency = 1
flashBadge = function() savedBadge.TextTransparency = 0; TweenService:Create(savedBadge, TweenInfo.new(0.9), {TextTransparency = 1}):Play() end

local tabList = Instance.new("Frame", sidebar)
tabList.Size = UDim2.new(1, -16, 1, -80); tabList.Position = UDim2.new(0, 8, 0, 72); tabList.BackgroundTransparency = 1
Instance.new("UIListLayout", tabList).Padding = UDim.new(0, 3)

local contentArea = Instance.new("Frame", frame)
contentArea.Size = UDim2.new(1, -170, 1, -20); contentArea.Position = UDim2.new(0, 160, 0, 10); contentArea.BackgroundTransparency = 1

local closeBtn = Instance.new("TextButton", frame)
closeBtn.Size = UDim2.new(0, 26, 0, 26); closeBtn.Position = UDim2.new(1, -36, 0, 12)
closeBtn.BackgroundColor3 = C_DANGER; closeBtn.BackgroundTransparency = 0.7; closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 13; closeBtn.TextColor3 = C_TEXT; closeBtn.Text = "✕"
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 6)

local tabs, activeTab = {}, nil
local function createTab(name)
    local btn = Instance.new("TextButton", tabList)
    btn.Size = UDim2.new(1, 0, 0, 30); btn.BackgroundColor3 = C_ITEM; btn.BackgroundTransparency = 0.4; btn.AutoButtonColor = false
    btn.Font = Enum.Font.GothamBold; btn.TextSize = 12; btn.TextColor3 = C_SUB; btn.TextXAlignment = Enum.TextXAlignment.Left; btn.Text = "  " .. name
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    local scroll = Instance.new("ScrollingFrame", contentArea)
    scroll.Size = UDim2.new(1, 0, 1, 0); scroll.BackgroundTransparency = 1; scroll.BorderSizePixel = 0
    scroll.ScrollBarThickness = 3; scroll.ScrollBarImageColor3 = C_ACCENT; scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y; scroll.Visible = false
    Instance.new("UIListLayout", scroll).Padding = UDim.new(0, 5)
    tabs[name] = { btn = btn, scroll = scroll }
end
for _, n in ipairs({"Combat", "Visuals", "Movement", "Utility", "Config", "Settings"}) do createTab(n); tabs[n].btn.MouseButton1Click:Connect(function()
    for n2, t in pairs(tabs) do
        local on = (n2 == n); t.scroll.Visible = on
        TweenService:Create(t.btn, TweenInfo.new(0.15), {BackgroundTransparency = on and 0 or 0.4, TextColor3 = on and C_TEXT or C_SUB}):Play()
    end; activeTab = n
end) end

local toggleRegistry, sliderRegistry, resets = {}, {}, {}
local function addReset(fn) table.insert(resets, fn) end
local function section(parent, name)
    local wrap = Instance.new("Frame", parent); wrap.Size = UDim2.new(1, 0, 0, 26); wrap.BackgroundTransparency = 1
    local lbl = Instance.new("TextLabel", wrap); lbl.Size = UDim2.new(1, -12, 1, 0); lbl.Position = UDim2.new(0, 12, 0, 0)
    lbl.BackgroundTransparency = 1; lbl.Font = Enum.Font.GothamBold; lbl.TextSize = 11; lbl.TextColor3 = C_AMBER; lbl.Text = string.upper(name); lbl.TextXAlignment = Enum.TextXAlignment.Left
end

local function createToggle(parent, name, onEnable, onDisable)
    local state = false
    local btn = Instance.new("TextButton", parent); btn.Size = UDim2.new(1, 0, 0, 32); btn.BackgroundColor3 = C_ITEM; btn.AutoButtonColor = false
    btn.Font = Enum.Font.Gotham; btn.TextSize = 12; btn.TextColor3 = C_TEXT; btn.TextXAlignment = Enum.TextXAlignment.Left; btn.Text = "  " .. name
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    local ind = Instance.new("Frame", btn); ind.Size = UDim2.new(0, 32, 0, 16); ind.Position = UDim2.new(1, -42, 0.5, -8); ind.BackgroundColor3 = C_ITEM_H
    Instance.new("UICorner", ind).CornerRadius = UDim.new(1, 0)
    local knob = Instance.new("Frame", ind); knob.Size = UDim2.new(0, 12, 0, 12); knob.Position = UDim2.new(0, 2, 0.5, -6); knob.BackgroundColor3 = C_SUB
    Instance.new("UICorner", knob).CornerRadius = UDim.new(1, 0)
    local function setState(v, persist)
        state = v
        TweenService:Create(ind, TweenInfo.new(0.15), {BackgroundColor3 = v and C_ACCENT or C_ITEM_H}):Play()
        TweenService:Create(knob, TweenInfo.new(0.15), {Position = UDim2.new(v and 1 or 0, v and -14 or 2, 0.5, -6), BackgroundColor3 = v and C_BG or C_SUB}):Play()
        if v and onEnable then pcall(onEnable) elseif not v and onDisable then pcall(onDisable) end
        if persist ~= false then config.toggles[name] = v; saveConfig() end
    end
    btn.MouseButton1Click:Connect(function() setState(not state) end); addReset(function() if state then setState(false, true) end end)
    toggleRegistry[name] = { setState = setState, getState = function() return state end }
end

local function createButton(parent, name, onClick, accent)
    local btn = Instance.new("TextButton", parent); btn.Size = UDim2.new(1, 0, 0, 32); btn.BackgroundColor3 = Color3.fromRGB(26, 20, 30); btn.AutoButtonColor = false
    btn.Font = Enum.Font.GothamBold; btn.TextSize = 12; btn.TextColor3 = accent or C_AMBER; btn.TextXAlignment = Enum.TextXAlignment.Left; btn.Text = "  ▸ " .. name
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    btn.MouseButton1Click:Connect(function() pcall(onClick) end)
    return btn
end

local function createSlider(parent, name, min, max, default, onChange)
    local currentVal = default
    local holder = Instance.new("Frame", parent); holder.Size = UDim2.new(1, 0, 0, 58); holder.BackgroundColor3 = C_ITEM
    Instance.new("UICorner", holder).CornerRadius = UDim.new(0, 6)
    local lbl = Instance.new("TextLabel", holder); lbl.Size = UDim2.new(1, -100, 0, 18); lbl.Position = UDim2.new(0, 12, 0, 6); lbl.BackgroundTransparency = 1
    lbl.Font = Enum.Font.Gotham; lbl.TextSize = 12; lbl.TextColor3 = C_TEXT; lbl.Text = name; lbl.TextXAlignment = Enum.TextXAlignment.Left
    local valBox = Instance.new("TextBox", holder); valBox.Size = UDim2.new(0, 68, 0, 20); valBox.Position = UDim2.new(1, -80, 0, 5)
    valBox.BackgroundColor3 = C_ITEM_H; valBox.Font = Enum.Font.Code; valBox.TextSize = 12; valBox.TextColor3 = C_ACCENT; valBox.Text = tostring(default)
    Instance.new("UICorner", valBox).CornerRadius = UDim.new(0, 5)
    local trackHit = Instance.new("TextButton", holder); trackHit.Size = UDim2.new(1, -24, 0, 22); trackHit.Position = UDim2.new(0, 12, 0, 30)
    trackHit.BackgroundTransparency = 1; trackHit.Text = ""
    local track = Instance.new("Frame", trackHit); track.Size = UDim2.new(1, 0, 0, 5); track.Position = UDim2.new(0, 0, 0.5, -2); track.BackgroundColor3 = Color3.fromRGB(12, 16, 20)
    Instance.new("UICorner", track).CornerRadius = UDim.new(1, 0)
    local fill = Instance.new("Frame", track); fill.Size = UDim2.new(0, 0, 1, 0); fill.BackgroundColor3 = C_ACCENT
    local knob = Instance.new("Frame", track); knob.Size = UDim2.new(0, 14, 0, 14); knob.Position = UDim2.new(0, 0, 0.5, -7); knob.BackgroundColor3 = Color3.fromRGB(245, 250, 245)
    local function setValue(v, apply, persist)
        v = math.clamp(v, min, max); currentVal = v; local pct = (v - min) / (max - min)
        fill.Size = UDim2.new(pct, 0, 1, 0); knob.Position = UDim2.new(pct, -7, 0.5, -7)
        if not valBox:IsFocused() then valBox.Text = tostring(math.floor(v * 100 + 0.5) / 100) end
        if apply and onChange then pcall(onChange, v) end; if persist ~= false then config.sliders[name] = v; saveConfig() end
    end
    trackHit.InputBegan:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 then
        local rel = (input.Position.X - track.AbsolutePosition.X) / track.AbsoluteSize.X
        setValue(min + (max - min) * math.clamp(rel, 0, 1), true, true)
    end end)
    valBox.FocusLost:Connect(function() setValue(tonumber(valBox.Text) or default, true, true) end)
    setValue(default, false, false); addReset(function() setValue(default, true, true) end)
    sliderRegistry[name] = { setValue = setValue, getValue = function() return currentVal end, default = default }
end

local function getHum() local c = player.Character; return c and c:FindFirstChildOfClass("Humanoid") end
local function getTeamColor(p) if p.Team then return p.Team.TeamColor.Color end return C_ACCENT end

-- FEATURES
local flyKeys = {W=false, A=false, S=false, D=false, Space=false, LCtrl=false}
local flyActive, flyBV, flyBG = false, nil, nil; local flySpeed = 50
local function setFly(on)
    if flyBV then flyBV:Destroy() flyBV = nil end; if flyBG then flyBG:Destroy() flyBG = nil end
    local char = player.Character; local hum = char and char:FindFirstChildOfClass("Humanoid")
    if hum then hum.PlatformStand = false end; flyActive = false
    if on and char and hum then local hrp = char:FindFirstChild("HumanoidRootPart")
        if hrp then flyBV = Instance.new("BodyVelocity", hrp); flyBV.MaxForce = Vector3.new(math.huge, math.huge, math.huge); flyBV.Velocity = Vector3.zero
            flyBG = Instance.new("BodyGyro", hrp); flyBG.MaxTorque = Vector3.new(math.huge, math.huge, math.huge); flyBG.P = 10000; flyBG.CFrame = hrp.CFrame
            hum.PlatformStand = true; flyActive = true end end
end
RunService.RenderStepped:Connect(function()
    if not flyActive then return end; local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    if hrp and flyBV and flyBG then cam = workspace.CurrentCamera; local dir = Vector3.zero
        if flyKeys.W then dir = dir + cam.CFrame.LookVector end; if flyKeys.S then dir = dir - cam.CFrame.LookVector end
        if flyKeys.A then dir = dir - cam.CFrame.RightVector end; if flyKeys.D then dir = dir + cam.CFrame.RightVector end
        if flyKeys.Space then dir = dir + Vector3.new(0,1,0) end; if flyKeys.LCtrl then dir = dir - Vector3.new(0,1,0) end
        flyBV.Velocity = dir.Magnitude > 0 and dir.Unit * flySpeed or Vector3.zero; flyBG.CFrame = cam.CFrame end
end)

local infJumpOn = false
UIS.JumpRequest:Connect(function() if infJumpOn then local h = getHum(); if h then h:ChangeState(Enum.HumanoidStateType.Jumping) end end end)
local noclipOn = false
RunService.Stepped:Connect(function() if not noclipOn then return end; local char = player.Character
    if char then for _, p in ipairs(char:GetDescendants()) do if p:IsA("BasePart") then p.CanCollide = false end end end end)

-- ESP
local espOn, espTeamChk, espNames, espHP, espDist = false, false, false, false, false
local espH, espBB = {}, {}
local function clearESP() for _, h in pairs(espH) do h:Destroy() end for _, b in pairs(espBB) do b:Destroy() end espH, espBB = {}, {} end
local function makeESP(t)
    if t == player or not t.Character or espH[t] then return end
    if espTeamChk and t.Team == player.Team and player.Team ~= nil then return end
    local h = Instance.new("Highlight", gui); h.FillColor = getTeamColor(t); h.FillTransparency = 0.65; h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop; h.Adornee = t.Character; espH[t] = h
    if espNames or espHP or espDist then local head = t.Character:FindFirstChild("Head") or t.Character:FindFirstChild("HumanoidRootPart")
        if head then local bb = Instance.new("BillboardGui", gui); bb.Size = UDim2.new(0, 130, 0, 60); bb.StudsOffsetWorldSpace = Vector3.new(0, 2.6, 0); bb.AlwaysOnTop = true; bb.Adornee = head; espBB[t] = bb
            if espNames then local nm = Instance.new("TextLabel", bb); nm.Size = UDim2.new(1, 0, 0, 16); nm.BackgroundTransparency = 1; nm.Font = Enum.Font.GothamBold; nm.TextSize = 12; nm.TextStrokeTransparency = 0.3; nm.TextColor3 = C_TEXT; nm.Text = t.Name end
            if espHP then local bar = Instance.new("Frame", bb); bar.Size = UDim2.new(0.8, 0, 0, 5); bar.Position = UDim2.new(0.1, 0, 0, 20); bar.BackgroundColor3 = Color3.fromRGB(40,20,20); local hf = Instance.new("Frame", bar); hf.Size = UDim2.new(1,0,1,0); hf.BackgroundColor3 = C_ACCENT; hf.Name = "HP"; Instance.new("UICorner", hf).CornerRadius = UDim.new(0,3) end
            if espDist then local dl = Instance.new("TextLabel", bb); dl.Size = UDim2.new(1, 0, 0, 14); dl.Position = UDim2.new(0, 0, 0, 30); dl.BackgroundTransparency = 1; dl.Font = Enum.Font.Code; dl.TextSize = 10; dl.TextColor3 = C_AMBER; dl.Name = "Dist"; dl.Text = "0m" end
        end end
end
task.spawn(function() while gui.Parent do task.wait(0.5)
    if espOn then for _, p in ipairs(Players:GetPlayers()) do if p ~= player then makeESP(p) end end
        local myHrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
        for p, h in pairs(espH) do
            if not p.Parent or not p.Character or (espTeamChk and p.Team == player.Team and player.Team ~= nil) then h:Destroy(); espH[p] = nil; if espBB[p] then espBB[p]:Destroy(); espBB[p] = nil end
            else h.Adornee = p.Character; h.FillColor = getTeamColor(p); if espBB[p] then local hum = p.Character:FindFirstChildOfClass("Humanoid")
                local hp = espBB[p]:FindFirstChild("HP", true); if hp and hum then hp.Size = UDim2.new(math.clamp(hum.Health/hum.MaxHealth, 0, 1), 0, 1, 0); hp.BackgroundColor3 = hum.Health < hum.MaxHealth*0.3 and C_DANGER or C_ACCENT end
                local dl = espBB[p]:FindFirstChild("Dist", true); if dl and myHrp and p.Character:FindFirstChild("HumanoidRootPart") then dl.Text = string.format("%.0fm", (myHrp.Position - p.Character.HumanoidRootPart.Position).Magnitude) end end
            end end end
end end)

-- TRACERS & SKELETON
local tracerOn, skeletonOn = false, false
local tracerLines, skelLines = {}, {}
local hasDrawing = pcall(function() local l = drawing.new("Line"); l:Remove() end)
RunService.RenderStepped:Connect(function()
    if not hasDrawing then return end; cam = workspace.CurrentCamera
    if tracerOn then local bottomCenter = Vector2.new(cam.ViewportSize.X/2, cam.ViewportSize.Y)
        for _, p in ipairs(Players:GetPlayers()) do if p ~= player and p.Character then local head = p.Character:FindFirstChild("Head")
            if head then local sp, onScreen = cam:WorldToViewportPoint(head.Position)
                if onScreen and sp.Z > 0 then local line = tracerLines[p]
                    if not line then line = drawing.new("Line"); line.Thickness = 1.2; line.Transparency = 0.8; tracerLines[p] = line end
                    line.From = bottomCenter; line.To = Vector2.new(sp.X, sp.Y); line.Color = getTeamColor(p); line.Visible = true
                else if tracerLines[p] then tracerLines[p].Visible = false end end end end end end
    if skeletonOn then for _, p in ipairs(Players:GetPlayers()) do
        if p ~= player and p.Character then local char = p.Character
            if not skelLines[p] then skelLines[p] = {}; for i = 1, 14 do local l = drawing.new("Line"); l.Thickness = 1; l.Transparency = 0.85; l.Visible = false; skelLines[p][i] = l end end
            local lines, col = skelLines[p], getTeamColor(p)
            local bones = {{"Head","UpperTorso"},{"UpperTorso","LowerTorso"},{"UpperTorso","LeftUpperArm"},{"LeftUpperArm","LeftLowerArm"},{"LeftLowerArm","LeftHand"},{"UpperTorso","RightUpperArm"},{"RightUpperArm","RightLowerArm"},{"RightLowerArm","RightHand"},{"LowerTorso","LeftUpperLeg"},{"LeftUpperLeg","LeftLowerLeg"},{"LeftLowerLeg","LeftFoot"},{"LowerTorso","RightUpperLeg"},{"RightUpperLeg","RightLowerLeg"},{"RightLowerLeg","RightFoot"}}
            if char:FindFirstChild("Torso") then bones = {{"Head","Torso"},{"Torso","Left Arm"},{"Torso","Right Arm"},{"Torso","Left Leg"},{"Torso","Right Leg"}} end
            for i, pair in ipairs(bones) do local a, b = char:FindFirstChild(pair[1]), char:FindFirstChild(pair[2])
                if a and b and lines[i] then local sp1, on1 = cam:WorldToViewportPoint(a.Position); local sp2, on2 = cam:WorldToViewportPoint(b.Position)
                    if on1 and on2 and sp1.Z > 0 and sp2.Z > 0 then lines[i].From = Vector2.new(sp1.X, sp1.Y); lines[i].To = Vector2.new(sp2.X, sp2.Y); lines[i].Color = col; lines[i].Visible = true
                    else lines[i].Visible = false end elseif lines[i] then lines[i].Visible = false end end end end end
end)

-- HITBOX
local hitboxOn, hitboxScale = false, 1.6
local function applyHitbox() if not hitboxOn then return end
    for _, p in ipairs(Players:GetPlayers()) do if p ~= player and p.Character then for _, part in ipairs(p.Character:GetDescendants()) do
        if part:IsA("BasePart") and (part.Name == "Head" or part.Name == "HumanoidRootPart" or part.Name == "UpperTorso" or part.Name == "Torso") then
            if not part:GetAttribute("origSize") then part:SetAttribute("origSize", part.Size); part:SetAttribute("origTrans", part.Transparency) end
            part.Size = part:GetAttribute("origSize") * hitboxScale; part.Transparency = 0.5; part.CanCollide = true end end end end end
local function restoreHitbox() for _, p in ipairs(Players:GetPlayers()) do if p.Character then for _, part in ipairs(p.Character:GetDescendants()) do
    if part:IsA("BasePart") and part:GetAttribute("origSize") then part.Size = part:GetAttribute("origSize"); part.Transparency = part:GetAttribute("origTrans") or 0; part:SetAttribute("origSize", nil) end end end end end
RunService.Heartbeat:Connect(applyHitbox)

-- AIMBOT
local aimOn, aimAutoShoot, aimKeyHeld, aimWallcheck = false, false, false, false
local aimHold = Enum.UserInputType.MouseButton2; local aimFOV, aimSmooth, aimPart = 150, 0.35, "Head"
local aimBodyParts, aimPartIdx = {"Head", "HumanoidRootPart", "UpperTorso"}, 1
local topInset = 36; pcall(function() topInset = GuiService:GetGuiInset().Y end)
local fovCircle = Instance.new("Frame", gui); fovCircle.Size = UDim2.new(0, aimFOV*2, 0, aimFOV*2); fovCircle.AnchorPoint = Vector2.new(0.5, 0.5); fovCircle.BackgroundTransparency = 1; fovCircle.Visible = false
Instance.new("UICorner", fovCircle).CornerRadius = UDim.new(1, 0); local fovStroke = Instance.new("UIStroke", fovCircle); fovStroke.Color = C_ACCENT; fovStroke.Thickness = 1.5

local function hasLOS(part)
    local params = RaycastParams.new(); params.FilterDescendantsInstances = {player.Character}; params.FilterType = Enum.RaycastFilterType.Exclude
    local res = workspace:Raycast(cam.CFrame.Position, part.Position - cam.CFrame.Position, params); if res then return res.Instance:IsDescendantOf(part.Parent) end; return true end
local function getTarget(fovOverride)
    cam = workspace.CurrentCamera; local mousePos = UIS:GetMouseLocation() - Vector2.new(0, topInset); local best, bestDist = nil, fovOverride or aimFOV
    for _, p in ipairs(Players:GetPlayers()) do if p ~= player and p.Character and not (espTeamChk and p.Team == player.Team and player.Team ~= nil) then
        local part = p.Character:FindFirstChild(aimPart); local hum = p.Character:FindFirstChildOfClass("Humanoid")
        if part and hum and hum.Health > 0 and (not aimWallcheck or hasLOS(part)) then local sp, onScreen = cam:WorldToViewportPoint(part.Position)
            if onScreen and sp.Z > 0 then local d = (Vector2.new(sp.X, sp.Y) - mousePos).Magnitude; if d < bestDist then bestDist = d; best = part end end
        end end end return best end
RunService.RenderStepped:Connect(function()
    if fovCircle.Visible then fovCircle.Position = UDim2.fromOffset(UIS:GetMouseLocation().X, UIS:GetMouseLocation().Y) end
    if aimOn and aimKeyHeld then local t = getTarget(); if t then cam.CFrame = cam.CFrame:Lerp(CFrame.new(cam.CFrame.Position, t.Position), 1 - math.clamp(aimSmooth, 0, 0.99)) end end
    if aimOn and aimAutoShoot and aimKeyHeld and getTarget() then VirtualUser:CaptureController(); VirtualUser:ClickButton1(Vector2.new(cam.ViewportSize.X/2, cam.ViewportSize.Y/2)) end
end)

-- UNLOAD
local function unloadCheat() pcall(function() for _, fn in ipairs(resets) do fn() end end); pcall(setFly, false); pcall(clearESP)
    local h = getHum(); if h then h.WalkSpeed = 16;
