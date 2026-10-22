-- ============================================================
--  MURDER CHEATS v24 | Fixed Tabs & Perfect Sliders
-- ============================================================
local UIS, RS, Plr, Lgt = game:GetService("UserInputService"), game:GetService("RunService"), game:GetService("Players"), game:GetService("Lighting")
local VU, Http, Tp, Gui = game:GetService("VirtualUser"), game:GetService("HttpService"), game:GetService("TeleportService"), game:GetService("GuiService")
local Twn = game:GetService("TweenService")
local player, cam, pg = Plr.LocalPlayer, workspace.CurrentCamera, Plr.LocalPlayer:WaitForChild("PlayerGui")

-- ТЕМА (Dark Slate)
local C_BG = Color3.fromRGB(25, 25, 30)
local C_PNL = Color3.fromRGB(32, 32, 40)
local C_ITM = Color3.fromRGB(45, 45, 55)
local C_ACC = Color3.fromRGB(88, 101, 242)
local C_TXT = Color3.fromRGB(240, 240, 240)
local C_SUB = Color3.fromRGB(160, 160, 170)
local C_DNG = Color3.fromRGB(237, 66, 69)

-- ОЧИСТКА СТАРЫХ ГУИ (Защита от наложений)
if pg:FindFirstChild("MC_Pwd") then pg.MC_Pwd:Destroy() end
if pg:FindFirstChild("MurderCheats") then pg.MurderCheats:Destroy() end

-- 🔐 ПАРОЛЬ
local pG = Instance.new("ScreenGui", pg); pG.Name="MC_Pwd"; pG.IgnoreGuiInset=true; pG.DisplayOrder=999
local pB = Instance.new("Frame", pG); pB.Size=UDim2.fromScale(1,1); pB.BackgroundColor3=Color3.new(0,0,0); pB.BackgroundTransparency=0.4
local pC = Instance.new("Frame", pB); pC.Size=UDim2.new(0,360,0,260); pC.Position=UDim2.new(0.5,-180,0.5,-130); pC.BackgroundColor3=C_BG
Instance.new("UICorner", pC).CornerRadius=UDim.new(0,12); local pStr=Instance.new("UIStroke", pC); pStr.Color=C_ACC
local pT = Instance.new("TextLabel", pC); pT.Size=UDim2.new(1,-32,0,34); pT.Position=UDim2.new(0,16,0,20); pT.BackgroundTransparency=1; pT.Font=Enum.Font.GothamBold; pT.TextSize=24; pT.TextColor3=C_TXT; pT.Text="MURDER CHEATS"; pT.TextXAlignment=Enum.TextXAlignment.Left
local pI = Instance.new("TextBox", pC); pI.Size=UDim2.new(1,-32,0,45); pI.Position=UDim2.new(0,16,0,90); pI.BackgroundColor3=C_ITM; pI.Font=Enum.Font.Code; pI.TextSize=16; pI.TextColor3=C_TXT; pI.PlaceholderText="password (murder)"; pI.Text=""
Instance.new("UICorner", pI).CornerRadius=UDim.new(0,8)
local pBtn = Instance.new("TextButton", pC); pBtn.Size=UDim2.new(1,-32,0,45); pBtn.Position=UDim2.new(0,16,0,150); pBtn.BackgroundColor3=C_ACC; pBtn.Font=Enum.Font.GothamBold; pBtn.TextSize=14; pBtn.TextColor3=C_TXT; pBtn.Text="UNLOCK"
Instance.new("UICorner", pBtn).CornerRadius=UDim.new(0,8)
local pOk = false
local function unlock() if pI.Text == "murder" then pOk = true; pG:Destroy() else pI.Text = ""; pI.PlaceholderText = "WRONG!" end end
pBtn.MouseButton1Click:Connect(unlock); pI.FocusLost:Connect(unlock)
repeat task.wait(0.1) until pOk

-- КОНФИГИ
local CF = "MC_v24.json"; local cfg = { c={default={t={},s={}}}, a="default", b="RightShift" }; local c = { t=cfg.c.default.t, s=cfg.c.default.s }
local function save() cfg.c[cfg.a]={t=c.t,s=c.s}; if writefile then pcall(function() writefile(CF, Http:JSONEncode(cfg)) end) end end
if isfile and readfile and isfile(CF) then local ok, d = pcall(function() return Http:JSONDecode(readfile(CF)) end); if ok and d.c then cfg=d; if cfg.c[cfg.a] then c.t=cfg.c[cfg.a].t; c.s=cfg.c[cfg.a].s end end end
local bind = Enum.KeyCode[cfg.b] or Enum.KeyCode.RightShift

-- ГЛАВНОЕ ОКНО
local gui = Instance.new("ScreenGui", pg); gui.Name="MurderCheats"; gui.ResetOnSpawn=false
local frm = Instance.new("Frame", gui); frm.Size=UDim2.new(0,600,0,420); frm.Position=UDim2.new(0.5,-300,0.5,-210); frm.BackgroundColor3=C_BG; frm.Visible=false; frm.ClipsDescendants=true
Instance.new("UICorner", frm).CornerRadius=UDim.new(0,12); local fStr=Instance.new("UIStroke", frm); fStr.Color=C_ACC; fStr.Thickness=1.5
local uisc = Instance.new("UIScale", frm); uisc.Scale = 0.9

local sb = Instance.new("Frame", frm); sb.Size=UDim2.new(0,140,1,-20); sb.Position=UDim2.new(0,10,0,10); sb.BackgroundColor3=C_PNL
Instance.new("UICorner", sb).CornerRadius=UDim.new(0,10)
local brd = Instance.new("TextLabel", sb); brd.Size=UDim2.new(1,-16,0,40); brd.Position=UDim2.new(0,10,0,10); brd.BackgroundTransparency=1; brd.Font=Enum.Font.GothamBold; brd.TextSize=16; brd.TextColor3=C_TXT; brd.Text="MURDER\nCHEATS"; brd.TextXAlignment=Enum.TextXAlignment.Left
local tl = Instance.new("Frame", sb); tl.Size=UDim2.new(1,-16,1,-70); tl.Position=UDim2.new(0,8,0,60); tl.BackgroundTransparency=1; Instance.new("UIListLayout", tl).Padding=UDim.new(0,4)
local ca = Instance.new("Frame", frm); ca.Size=UDim2.new(1,-170,1,-20); ca.Position=UDim2.new(0,160,0,10); ca.BackgroundTransparency=1; ca.ClipsDescendants = true
local cls = Instance.new("TextButton", frm); cls.Size=UDim2.new(0,26,0,26); cls.Position=UDim2.new(1,-36,0,12); cls.BackgroundColor3=C_ITM; cls.Text="✕"; cls.TextColor3=C_TXT; cls.Font=Enum.Font.GothamBold; Instance.new("UICorner", cls).CornerRadius=UDim.new(0,6)

-- ИСПРАВЛЕННЫЕ ВКЛАДКИ
local tabs = {}
local function mkTab(n)
    local b = Instance.new("TextButton", tl); b.Size=UDim2.new(1,0,0,30); b.BackgroundColor3=C_ITM; b.BackgroundTransparency=0.5; b.Text="  "..n; b.Font=Enum.Font.GothamBold; b.TextSize=12; b.TextColor3=C_SUB; b.TextXAlignment=Enum.TextXAlignment.Left
    Instance.new("UICorner", b).CornerRadius=UDim.new(0,6)
    local s = Instance.new("ScrollingFrame", ca); s.Size=UDim2.fromScale(1,1); s.BackgroundTransparency=1; s.ScrollBarThickness=3; s.ScrollBarImageColor3=C_ACC; s.AutomaticCanvasSize=Enum.AutomaticSize.Y; s.Visible=false; s.Active = false
    Instance.new("UIListLayout", s).Padding=UDim.new(0,6); tabs[n]={b=b, s=s}
end
for _, n in ipairs({"Combat", "Visuals", "Movement", "Utility", "Config", "Settings"}) do mkTab(n); tabs[n].b.MouseButton1Click:Connect(function()
    for n2, t in pairs(tabs) do 
        local isA = (n2 == n)
        t.s.Visible = isA
        t.s.Active = isA -- Отключает клики на скрытых вкладках
        t.b.BackgroundTransparency = isA and 0 or 0.5
        t.b.TextColor3 = isA and C_TXT or C_SUB 
    end
end) end

-- 🛠 ИДЕАЛЬНЫЕ ПОЛЗУНКИ
local draggingSlider = nil
UIS.InputChanged:Connect(function(input)
    if draggingSlider and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        if not frm.Visible then draggingSlider = nil; return end
        local rel = (input.Position.X - draggingSlider.track.AbsolutePosition.X) / draggingSlider.track.AbsoluteSize.X
        draggingSlider.applyPct(math.clamp(rel, 0, 1))
    end
end)
UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then draggingSlider = nil end
end)

local tg, sl, rst = {}, {}, {}
local function sect(p, n) local w=Instance.new("Frame", p); w.Size=UDim2.new(1,0,0,24); w.BackgroundTransparency=1; local l=Instance.new("TextLabel", w); l.Size=UDim2.new(1,-10,1,0); l.Position=UDim2.new(0,10,0,0); l.BackgroundTransparency=1; l.Font=Enum.Font.GothamBold; l.TextSize=11; l.TextColor3=C_ACC; l.Text=string.upper(n); l.TextXAlignment=Enum.TextXAlignment.Left end
local function toggle(p, n, en, dis)
    local st = false; local b = Instance.new("TextButton", p); b.Size=UDim2.new(1,0,0,34); b.BackgroundColor3=C_ITM; b.Text="  "..n; b.Font=Enum.Font.Gotham; b.TextSize=12; b.TextColor3=C_TXT; b.TextXAlignment=Enum.TextXAlignment.Left
    Instance.new("UICorner", b).CornerRadius=UDim.new(0,6); local ind=Instance.new("Frame", b); ind.Size=UDim2.new(0,34,0,16); ind.Position=UDim2.new(1,-44,0.5,-8); ind.BackgroundColor3=Color3.fromRGB(60,60,70); Instance.new("UICorner", ind).CornerRadius=UDim.new(1,0)
    local k=Instance.new("Frame", ind); k.Size=UDim2.new(0,14,0,14); k.Position=UDim2.new(0,2,0.5,-7); k.BackgroundColor3=C_SUB; Instance.new("UICorner", k).CornerRadius=UDim.new(1,0)
    local function set(v, prs) st=v; Twn:Create(ind, TweenInfo.new(0.2), {BackgroundColor3=v and C_ACC or Color3.fromRGB(60,60,70)}):Play(); Twn:Create(k, TweenInfo.new(0.2), {Position=UDim2.new(v and 1 or 0, v and -16 or 2, 0.5, -7), BackgroundColor3=v and C_TXT or C_SUB}):Play(); if v and en then pcall(en) elseif not v and dis then pcall(dis) end; if prs~=false then c.t[n]=v; save() end end
    b.MouseButton1Click:Connect(function() set(not st) end); table.insert(rst, function() if st then set(false, true) end end); tg[n] = { set = set, get = function() return st end }
end
local function btn(p, n, cl, clr) local b=Instance.new("TextButton", p); b.Size=UDim2.new(1,0,0,34); b.BackgroundColor3=C_ITM; b.Text="  ▸ "..n; b.Font=Enum.Font.GothamBold; b.TextSize=12; b.TextColor3=clr or C_TXT; b.TextXAlignment=Enum.TextXAlignment.Left; Instance.new("UICorner", b).CornerRadius=UDim.new(0,6); b.MouseButton1Click:Connect(function() pcall(cl) end); return b end

local function slider(p, n, mn, mx, df, ch)
    local v = df
    local h=Instance.new("Frame", p); h.Size=UDim2.new(1,0,0,65); h.BackgroundColor3=C_ITM; Instance.new("UICorner", h).CornerRadius=UDim.new(0,6)
    local l=Instance.new("TextLabel", h); l.Size=UDim2.new(1,-80,0,20); l.Position=UDim2.new(0,12,0,6); l.BackgroundTransparency=1; l.Font=Enum.Font.Gotham; l.TextSize=13; l.TextColor3=C_TXT; l.Text=n; l.TextXAlignment=Enum.TextXAlignment.Left
    local bx=Instance.new("TextBox", h); bx.Size=UDim2.new(0,60,0,22); bx.Position=UDim2.new(1,-72,0,6); bx.BackgroundColor3=C_BG; bx.Font=Enum.Font.Code; bx.TextSize=13; bx.TextColor3=C_TXT; bx.Text=tostring(df); Instance.new("UICorner", bx).CornerRadius=UDim.new(0,4)
    
    local trkHit = Instance.new("TextButton", h); trkHit.Size=UDim2.new(1,-24,0,24); trkHit.Position=UDim2.new(0,12,0,36); trkHit.BackgroundTransparency=1; trkHit.Text=""
    local trk=Instance.new("Frame", trkHit); trk.Size=UDim2.new(1,0,0,6); trk.Position=UDim2.new(0,0,0.5,-3); trk.BackgroundColor3=Color3.fromRGB(20,20,25); Instance.new("UICorner", trk).CornerRadius=UDim.new(1,0)
    local f=Instance.new("Frame", trk); f.Size=UDim2.new(0,0,1,0); f.BackgroundColor3=C_ACC; Instance.new("UICorner", f).CornerRadius=UDim.new(1,0)
    local k=Instance.new("Frame", trk); k.Size=UDim2.new(0,14,0,14); k.Position=UDim2.new(0,-7,0.5,-7); k.BackgroundColor3=C_TXT; Instance.new("UICorner", k).CornerRadius=UDim.new(1,0)
    
    local function setV(val, ap, prs) 
        val=math.clamp(val,mn,mx); v=val; local pct=(val-mn)/(mx-mn); f.Size=UDim2.new(pct,0,1,0); k.Position=UDim2.new(pct,-7,0.5,-7)
        if not bx:IsFocused() then bx.Text=tostring(math.floor(val*100+0.5)/100) end
        if ap and ch then pcall(ch, val) end; if prs~=false then c.s[n]=val; save() end 
    end
    
    trkHit.InputBegan:Connect(function(i) 
        if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then 
            draggingSlider = { track = trk, applyPct = function(pct) setV(mn+(mx-mn)*pct, true, true) end }
            local r=(i.Position.X-trk.AbsolutePosition.X)/trk.AbsoluteSize.X; setV(mn+(mx-mn)*math.clamp(r,0,1),true,true) 
        end 
    end)
    bx.FocusLost:Connect(function() setV(tonumber(bx.Text) or df, true, true) end)
    setV(df,false,false); table.insert(rst, function() setV(df,true,true) end); sl[n]={set=setV, get=function() return v end, def=df}
end

local function getHum() local ch=player.Character; return ch and ch:FindFirstChildOfClass("Humanoid") end
local function getTeam(p) return p.Team and p.Team.TeamColor.Color or C_ACC end

-- ЛОГИКА
local fK = {W=false, A=false, S=false, D=false, Space=false, Ctrl=false}
local shiftHeld, sprintOn, sprintSpd, baseSpeed = false, false, 60, 16
local flyAct, bv, bg, fSpd = false, nil, nil, 50
local function setFly(on) if bv then bv:Destroy() end; if bg then bg:Destroy() end; local ch, hu = player.Character, getHum(); if hu then hu.PlatformStand=false end; flyAct=false; if on and ch and hu then local hrp=ch:FindFirstChild("HumanoidRootPart"); if hrp then bv=Instance.new("BodyVelocity",hrp); bv.MaxForce=Vector3.new(9e9,9e9,9e9); bg=Instance.new("BodyGyro",hrp); bg.MaxTorque=Vector3.new(9e9,9e9,9e9); bg.P=10000; hu.PlatformStand=true; flyAct=true end end end
local infJ, noclp, bhop, spin, sSpd, freecam, fPos, fRot, clickTP, antiAfk = false, false, false, false, 5, false, nil, nil, false, false

RS.Heartbeat:Connect(function()
    local hu = getHum()
    if hu then if sprintOn then hu.WalkSpeed = shiftHeld and sprintSpd or baseSpeed else hu.WalkSpeed = baseSpeed end end
    if spin then local hrp=player.Character and player.Character:FindFirstChild("HumanoidRootPart"); if hrp then hrp.CFrame=hrp.CFrame*CFrame.Angles(0,math.rad(sSpd),0) end end
end)
RS.RenderStepped:Connect(function()
    if flyAct then local hrp=player.Character and player.Character:FindFirstChild("HumanoidRootPart"); if hrp and bv and bg then cam=workspace.CurrentCamera; local d=Vector3.zero; if fK.W then d=d+cam.CFrame.LookVector end; if fK.S then d=d-cam.CFrame.LookVector end; if fK.A then d=d-cam.CFrame.RightVector end; if fK.D then d=d+cam.CFrame.RightVector end; if fK.Space then d=d+Vector3.new(0,1,0) end; if fK.Ctrl then d=d-Vector3.new(0,1,0) end; bv.Velocity=d.Magnitude>0 and d.Unit*fSpd or Vector3.zero; bg.CFrame=cam.CFrame end end
    if freecam then cam=workspace.CurrentCamera; local d=Vector3.zero; if fK.W then d=d+fRot end; if fK.S then d=d-fRot end; if fK.A then d=d-fRot:Cross(Vector3.new(0,1,0)).Unit end; if fK.D then d=d+fRot:Cross(Vector3.new(0,1,0)).Unit end; fPos=fPos+d*1.5; cam.CFrame=CFrame.new(fPos, fPos+fRot) end
end)
RS.Stepped:Connect(function()
    if noclp then local ch=player.Character; if ch then for _,p in ipairs(ch:GetDescendants()) do if p:IsA("BasePart") then p.CanCollide=false end end end end
    if bhop then local hu=getHum(); if hu and (hu:GetState()==Enum.HumanoidStateType.Landed or hu:GetState()==Enum.HumanoidStateType.Running) then hu:ChangeState(Enum.HumanoidStateType.Jumping) end end
end)
UIS.JumpRequest:Connect(function() local hu=getHum(); if infJ and hu then hu:ChangeState(Enum.HumanoidStateType.Jumping) end end)
UIS.InputBegan:Connect(function(i,g)
    if i.KeyCode==Enum.KeyCode.LeftShift then shiftHeld = true end
    if clickTP and i.UserInputType==Enum.UserInputType.MouseButton1 and UIS:IsKeyDown(Enum.KeyCode.LeftControl) then
        local m=UIS:GetMouseLocation(); local r=workspace.CurrentCamera:ViewportPointToRay(m.X, m.Y); local prm=RaycastParams.new(); prm.FilterDescendantsInstances={player.Character}; prm.FilterType=Enum.RaycastFilterType.Exclude; local hit=workspace:Raycast(r.Origin, r.Direction*1000, prm)
        if hit and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then player.Character.HumanoidRootPart.CFrame=CFrame.new(hit.Position+Vector3.new(0,3,0)) end
    end
end)
UIS.InputEnded:Connect(function(i) if i.KeyCode==Enum.KeyCode.LeftShift then shiftHeld = false end end)
Plr.LocalPlayer.Idled:Connect(function() if antiAfk then VU:CaptureController(); VU:Button2Down(Vector2.new(0,0)); task.wait(1); VU:Button2Up(Vector2.new(0,0)) end end)

-- ESP & AIM (Сжато)
local espOn, espEn, espNm, espHp, espDs = false, false, false, false, false
local hl, bb = {}, {}
local function clrEsp() for _,h in pairs(hl) do h:Destroy() end; for _,b in pairs(bb) do b:Destroy() end; hl, bb = {}, {} end
local function mkEsp(t)
    if t==player or not t.Character or hl[t] or (espEn and t.Team==player.Team and player.Team) then return end
    local h=Instance.new("Highlight", gui); h.FillColor=getTeam(t); h.FillTransparency=0.65; h.DepthMode=Enum.HighlightDepthMode.AlwaysOnTop; h.Adornee=t.Character; hl[t]=h
    if espNm or espHp or espDs then local hd=t.Character:FindFirstChild("Head") or t.Character:FindFirstChild("HumanoidRootPart"); if hd then local bg=Instance.new("BillboardGui", gui); bg.Size=UDim2.new(0,130,0,60); bg.StudsOffsetWorldSpace=Vector3.new(0,2.6,0); bg.AlwaysOnTop=true; bg.Adornee=hd; bb[t]=bg
        if espNm then local n=Instance.new("TextLabel", bg); n.Size=UDim2.new(1,0,0,16); n.BackgroundTransparency=1; n.Font=Enum.Font.GothamBold; n.TextSize=12; n.TextColor3=C_TXT; n.Text=t.Name end
        if espHp then local b=Instance.new("Frame", bg); b.Size=UDim2.new(0.8,0,0,5); b.Position=UDim2.new(0.1,0,0,20); b.BackgroundColor3=C_DNG; local f=Instance.new("Frame", b); f.Size=UDim2.fromScale(1,1); f.BackgroundColor3=C_ACC; f.Name="HP" end
        if espDs then local d=Instance.new("TextLabel", bg); d.Size=UDim2.new(1,0,0,14); d.Position=UDim2.new(0,0,0,30); d.BackgroundTransparency=1; d.Font=Enum.Font.Code; d.TextSize=10; d.TextColor3=C_ACC; d.Name="Ds"; d.Text="0m" end
    end end
end
task.spawn(function() while gui.Parent do task.wait(0.5); if espOn then for _,p in ipairs(Plr:GetPlayers()) do if p~=player then mkEsp(p) end end; local myH=player.Character and player.Character:FindFirstChild("HumanoidRootPart"); for p,h in pairs(hl) do if not p.Parent or not p.Character or (espEn and p.Team==player.Team and player.Team) then h:Destroy(); hl[p]=nil; if bb[p] then bb[p]:Destroy(); bb[p]=nil end else h.Adornee=p.Character; if bb[p] then local hu=p.Character:FindFirstChildOfClass("Humanoid"); local hp=bb[p]:FindFirstChild("HP",true); if hp and hu then hp.Size=UDim2.fromScale(math.clamp(hu.Health/hu.MaxHealth,0,1),1); hp.BackgroundColor3=hu.Health<hu.MaxHealth*0.3 and C_DNG or C_ACC end; local ds=bb[p]:FindFirstChild("Ds",true); if ds and myH and p.Character:FindFirstChild("HumanoidRootPart") then ds.Text=string.format("%.0fm",(myH.Position-p.Character.HumanoidRootPart.Position).Magnitude) end end end end end end end)

local aim, aAuto, aHold, aWall = false, false, false, false
local aFov, aSmth, aPrt, aIdx = 150, 0.35, "Head", 1
local aPrts = {"Head", "HumanoidRootPart", "UpperTorso"}
local fovC = Instance.new("Frame", gui); fovC.Size=UDim2.new(0,aFov*2,0,aFov*2); fovC.AnchorPoint=Vector2.new(0.5,0.5); fovC.BackgroundTransparency=1; fovC.Visible=false; Instance.new("UICorner", fovC).CornerRadius=UDim.new(1,0); local fStr2 = Instance.new("UIStroke", fovC); fStr2.Color=C_ACC
local function hasLOS(part) local prm=RaycastParams.new(); prm.FilterDescendantsInstances={player.Character}; prm.FilterType=Enum.RaycastFilterType.Exclude; local r=workspace:Raycast(cam.CFrame.Position, part.Position-cam.CFrame.Position, prm); if r then return r.Instance:IsDescendantOf(part.Parent) end; return true end
local function getTgt(fv) cam=workspace.CurrentCamera; local m=UIS:GetMouseLocation()-Vector2.new(0,Gui:GetGuiInset().Y); local best, dist = nil, fv or aFov; for _,p in ipairs(Plr:GetPlayers()) do if p~=player and p.Character and not (espEn and p.Team==player.Team and player.Team) then local pt=p.Character:FindFirstChild(aPrt); local hu=p.Character:FindFirstChildOfClass("Humanoid"); if pt and hu and hu.Health>0 and (not aWall or hasLOS(pt)) then local s,o=cam:WorldToViewportPoint(pt.Position); if o and s.Z>0 then local d=(Vector2.new(s.X,s.Y)-m).Magnitude; if d<dist then dist=d; best=pt end end end end end; return best end
RS.RenderStepped:Connect(function()
    if fovC.Visible then fovC.Position=UDim2.fromOffset(UIS:GetMouseLocation().X, UIS:GetMouseLocation().Y) end
    if aim and aHold then local t=getTgt(); if t then cam.CFrame=cam.CFrame:Lerp(CFrame.new(cam.CFrame.Position, t.Position), 1-math.clamp(aSmth,0,0.99)) end end
    if aim and aAuto and aHold and getTgt() then VU:CaptureController(); VU:ClickButton1(Vector2.new(cam.ViewportSize.X/2, cam.ViewportSize.Y/2)) end
end)

-- UI TABS
local cS = tabs["Combat"].s
sect(cS, "Aimbot")
toggle(cS, "Aimbot (RMB)", function() aim=true; fovC.Visible=true end, function() aim=false; fovC.Visible=false end)
toggle(cS, "FOV Circle", function() fovC.Visible=true end, function() fovC.Visible=false end)
slider(cS, "Aim FOV", 20, 500, 150, function(v) aFov=v; fovC.Size=UDim2.new(0,v*2,0,v*2) end)
slider(cS, "Smoothness", 0, 0.95, 0.35, function(v) aSmth=v end)
toggle(cS, "Auto Shoot", function() aAuto=true end, function() aAuto=false end)
toggle(cS, "Wallcheck", function() aWall=true end, function() aWall=false end)
do local b; b=btn(cS, "Part: "..aPrt, function() aIdx=aIdx%#aPrts+1; aPrt=aPrts[aIdx]; b.Text="  ▸ Part: "..aPrt end) end

local vS = tabs["Visuals"].s
sect(vS, "ESP")
toggle(vS, "Wallhack / ESP", function() espOn=true end, function() espOn=false; clrEsp() end)
toggle(vS, "Only enemies", function() espEn=true; clrEsp() end, function() espEn=false; clrEsp() end)
toggle(vS, "Names", function() espNm=true; clrEsp() end, function() espNm=false; clrEsp() end)
toggle(vS, "Health Bars", function() espHp=true; clrEsp() end, function() espHp=false; clrEsp() end)
toggle(vS, "Distance", function() espDs=true; clrEsp() end, function() espDs=false; clrEsp() end)

local mS = tabs["Movement"].s
sect(mS, "Speed & Jump")
slider(mS, "WalkSpeed (Base)", 16, 250, 16, function(v) baseSpeed=v end)
slider(mS, "JumpPower", 50, 400, 50, function(v) local h=getHum(); if h then h.JumpPower=v end end)
toggle(mS, "Infinite Jump", function() infJ=true end, function() infJ=false end)
toggle(mS, "Noclip", function() noclp=true end, function() noclp=false end)
toggle(mS, "Bhop", function() bhop=true end, function() bhop=false end)
sect(mS, "Sprint (Shift)")
toggle(mS, "Enable Sprint", function() sprintOn=true end, function() sprintOn=false; local h=getHum(); if h then h.WalkSpeed=baseSpeed end end)
slider(mS, "Sprint Speed", 20, 250, 60, function(v) sprintSpd=v end)
sect(mS, "Fly")
toggle(mS, "Fly (WASD)", function() setFly(true) end, function() setFly(false) end)
slider(mS, "Fly Speed", 10, 300, 50, function(v) fSpd=v end)

local uS = tabs["Utility"].s
sect(uS, "Teleport & Camera")
toggle(uS, "Freecam", function() freecam=true; local c=workspace.CurrentCamera; fPos=c.CFrame.Position; fRot=c.CFrame.LookVector; c.CameraType=Enum.CameraType.Scriptable end, function() freecam=false; workspace.CurrentCamera.CameraType=Enum.CameraType.Custom end)
toggle(uS, "Click TP (Ctrl+LMB)", function() clickTP=true end, function() clickTP=false end)
btn(uS, "TP to Spawn", function() local hrp=player.Character and player.Character:FindFirstChild("HumanoidRootPart"); if hrp then for _,o in ipairs(workspace:GetDescendants()) do if o:IsA("SpawnLocation") then hrp.CFrame=o.CFrame+Vector3.new(0,5,0); break end end end end)
sect(uS, "Automation")
toggle(uS, "Anti-AFK", function() antiAfk=true end, function() antiAfk=false end)
btn(uS, "Rejoin Server", function() Tp:Teleport(game.PlaceId) end, C_DNG)

local cS2 = tabs["Config"].s
local listF = Instance.new("Frame", cS2); listF.Size=UDim2.new(1,0,0,200); listF.BackgroundTransparency=1; Instance.new("UIListLayout", listF).Padding=UDim.new(0,5)
local function refCfg() for _,c in ipairs(listF:GetChildren()) do if c:IsA("TextButton") then c:Destroy() end end
    for n,_ in pairs(cfg.c) do local act=(n==cfg.a); local b=btn(listF, (act and "★ " or "")..n, function() cfg.a=n; c.t=cfg.c[n].t; c.s=cfg.c[n].s; save(); for tn,t in pairs(tg) do t.set(c.t[tn] or false, false) end; for sn,s in pairs(sl) do s.set(c.s[sn] or s.def, true, false) end; refCfg() end, act and C_ACC or C_TXT)
        if n~="default" then local d=Instance.new("TextButton", b); d.Size=UDim2.new(0,24,0,24); d.Position=UDim2.new(1,-28,0,4); d.BackgroundColor3=C_DNG; d.Text="X"; d.MouseButton1Click:Connect(function() cfg.c[n]=nil; if cfg.a==n then cfg.a=next(cfg.c) or "default"; c.t=cfg.c[cfg.a].t end; save(); refCfg() end) end
    end
end
refCfg()
btn(cS2, "+ Create Config", function()
    local m = Instance.new("Frame", gui); m.Size=UDim2.fromScale(1,1); m.BackgroundColor3=Color3.new(0,0,0); m.BackgroundTransparency=0.45; m.ZIndex=100
    local d = Instance.new("Frame", m); d.Size=UDim2.new(0,300,0,140); d.Position=UDim2.new(0.5,-150,0.5,-70); d.BackgroundColor3=C_BG; d.ZIndex=101; Instance.new("UICorner", d).CornerRadius=UDim.new(0,10)
    local t = Instance.new("TextBox", d); t.Size=UDim2.new(1,-40,0,34); t.Position=UDim2.new(0,20,0,20); t.BackgroundColor3=C_ITM; t.Text="NewConfig"; t.Font=Enum.Font.Code; t.TextColor3=C_TXT; t.ZIndex=102; Instance.new("UICorner", t).CornerRadius=UDim.new(0,6)
    local y = Instance.new("TextButton", d); y.Size=UDim2.new(0,120,0,30); y.Position=UDim2.new(0,20,1,-45); y.BackgroundColor3=C_ACC; y.Text="Создать"; y.TextColor3=C_TXT; y.Font=Enum.Font.GothamBold; y.ZIndex=102; Instance.new("UICorner", y).CornerRadius=UDim.new(0,6)
    local n = Instance.new("TextButton", d); n.Size=UDim2.new(0,120,0,30); n.Position=UDim2.new(1,-140,1,-45); n.BackgroundColor3=C_DNG; n.Text="Отмена"; n.TextColor3=C_TXT; n.Font=Enum.Font.GothamBold; n.ZIndex=102; Instance.new("UICorner", n).CornerRadius=UDim.new(0,6)
    n.MouseButton1Click:Connect(function() m:Destroy() end)
    y.MouseButton1Click:Connect(function() if t.Text ~= "" then cfg.c[t.Text]={t={},s={}}; cfg.a=t.Text; c.t=cfg.c[t.Text].t; c.s=cfg.c[t.Text].s; save(); refCfg(); m:Destroy() end end)
end, C_ACC)

local sS = tabs["Settings"].s
local function unloadCheat() 
    for _, f in ipairs(rst) do pcall(f) end; if bv then bv:Destroy() end; if bg then bg:Destroy() end
    local hu = getHum(); if hu then hu.PlatformStand=false; hu.WalkSpeed=16; hu.JumpPower=50 end
    clrEsp(); workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
    if gui then gui:Destroy() end; print("[Murder Cheats] UNLOADED.") 
end
sect(sS, "Danger Zone")
btn(sS, "UNLOAD CHEAT", function() 
    local m = Instance.new("Frame", gui); m.Size=UDim2.fromScale(1,1); m.BackgroundColor3=Color3.new(0,0,0); m.BackgroundTransparency=0.45; m.ZIndex=100
    local d = Instance.new("Frame", m); d.Size=UDim2.new(0,300,0,140); d.Position=UDim2.new(0.5,-150,0.5,-70); d.BackgroundColor3=C_BG; d.ZIndex=101; Instance.new("UICorner", d).CornerRadius=UDim.new(0,10)
    local l = Instance.new("TextLabel", d); l.Size=UDim2.new(1,-20,0,60); l.Position=UDim2.new(0,10,0,10); l.BackgroundTransparency=1; l.Font=Enum.Font.GothamBold; l.Text="Точно вырубить чит?"; l.TextColor3=C_TXT; l.ZIndex=102
    local y = Instance.new("TextButton", d); y.Size=UDim2.new(0,120,0,30); y.Position=UDim2.new(0,20,1,-45); y.BackgroundColor3=C_DNG; y.Text="Да"; y.TextColor3=C_TXT; y.ZIndex=102; Instance.new("UICorner", y).CornerRadius=UDim.new(0,6)
    local n = Instance.new("TextButton", d); n.Size=UDim2.new(0,120,0,30); n.Position=UDim2.new(1,-140,1,-45); n.BackgroundColor3=C_ITM; n.Text="Нет"; n.TextColor3=C_TXT; n.ZIndex=102; Instance.new("UICorner", n).CornerRadius=UDim.new(0,6)
    n.MouseButton1Click:Connect(function() m:Destroy() end); y.MouseButton1Click:Connect(function() m:Destroy(); unloadCheat() end)
end, C_DNG)

for n,v in pairs(c.t) do if tg[n] and v then tg[n].set(true, false) end end
for n,v in pairs(c.s) do if sl[n] then sl[n].set(v, true, false) end end

local function openMenu() frm.Visible = true; uisc.Scale = 0.9; Twn:Create(uisc, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale = 1}):Play() end
local function closeMenu() local t = Twn:Create(uisc, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Scale = 0.9}); t:Play(); t.Completed:Connect(function() frm.Visible = false end) end
cls.MouseButton1Click:Connect(closeMenu)

-- Включаем первую вкладку
tabs["Combat"].s.Visible=true; tabs["Combat"].b.BackgroundTransparency=0; tabs["Combat"].b.TextColor3=C_TXT

UIS.InputBegan:Connect(function(i, g)
    if i.KeyCode==bind and not g then if frm.Visible then closeMenu() else openMenu() end return end
    if g then return end
    if i.KeyCode==Enum.KeyCode.W then fK.W=true elseif i.KeyCode==Enum.KeyCode.A then fK.A=true elseif i.KeyCode==Enum.KeyCode.S then fK.S=true elseif i.KeyCode==Enum.KeyCode.D then fK.D=true elseif i.KeyCode==Enum.KeyCode.Space then fK.Space=true elseif i.KeyCode==Enum.KeyCode.LeftControl then fK.Ctrl=true end
    if i.UserInputType==Enum.UserInputType.MouseButton2 then aHold=true end
end)
UIS.InputEnded:Connect(function(i)
    if i.KeyCode==Enum.KeyCode.W then fK.W=false elseif i.KeyCode==Enum.KeyCode.A then fK.A=false elseif i.KeyCode==Enum.KeyCode.S then fK.S=false elseif i.KeyCode==Enum.KeyCode.D then fK.D=false elseif i.KeyCode==Enum.KeyCode.Space then fK.Space=false elseif i.KeyCode==Enum.KeyCode.LeftControl then fK.Ctrl=false end
    if i.UserInputType==Enum.UserInputType.MouseButton2 then aHold=false end
end)
player.CharacterAdded:Connect(function() task.wait(0.5); for n,t in pairs(tg) do if t.get() then pcall(t.set, true, false) end end end)
