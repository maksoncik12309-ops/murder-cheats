-- ============================================================
--  FAKE CHOICE (KICK ON BOTH)
-- ============================================================
local player = game:GetService("Players").LocalPlayer
local pg = player:WaitForChild("PlayerGui")

local gui = Instance.new("ScreenGui")
gui.Name = "FakeChoice"
gui.IgnoreGuiInset = true
gui.DisplayOrder = 999999
gui.Parent = pg

-- Задний фон
local bg = Instance.new("Frame", gui)
bg.Size = UDim2.fromScale(1, 1)
bg.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
bg.BackgroundTransparency = 0.4

-- Само меню
local frm = Instance.new("Frame", bg)
frm.Size = UDim2.new(0, 400, 0, 220)
frm.Position = UDim2.new(0.5, -200, 0.5, -110)
frm.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
frm.BorderSizePixel = 0
Instance.new("UICorner", frm).CornerRadius = UDim.new(0, 12)
local stroke = Instance.new("UIStroke", frm)
stroke.Color = Color3.fromRGB(237, 66, 69)
stroke.Thickness = 2

-- Заголовок
local title = Instance.new("TextLabel", frm)
title.Size = UDim2.new(1, -40, 0, 40)
title.Position = UDim2.new(0, 20, 0, 20)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 20
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Text = "ВЫБЕРИ СВОЮ СУДЬБУ"

local sub = Instance.new("TextLabel", frm)
sub.Size = UDim2.new(1, -40, 0, 20)
sub.Position = UDim2.new(0, 20, 0, 60)
sub.BackgroundTransparency = 1
sub.Font = Enum.Font.Gotham
sub.TextSize = 14
sub.TextColor3 = Color3.fromRGB(160, 160, 170)
sub.Text = "Оба варианта приведут к одному исходу..."

-- Функция кика
local function kickPlayer(reason)
    pcall(function()
        player:Kick(reason)
    end)
end

-- Кнопка 1
local btn1 = Instance.new("TextButton", frm)
btn1.Size = UDim2.new(1, -60, 0, 40)
btn1.Position = UDim2.new(0, 30, 0, 100)
btn1.BackgroundColor3 = Color3.fromRGB(237, 66, 69)
btn1.Text = "Пойти нахуй"
btn1.Font = Enum.Font.GothamBold
btn1.TextSize = 14
btn1.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", btn1).CornerRadius = UDim.new(0, 6)
btn1.MouseButton1Click:Connect(function()
    kickPlayer("Ты выбрал пойти нахуй. Скатертью дорога.")
end)

-- Кнопка 2
local btn2 = Instance.new("TextButton", frm)
btn2.Size = UDim2.new(1, -60, 0, 40)
btn2.Position = UDim2.new(0, 30, 0, 150)
btn2.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
btn2.Text = "Не идти нахуй"
btn2.Font = Enum.Font.GothamBold
btn2.TextSize = 14
btn2.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", btn2).CornerRadius = UDim.new(0, 6)
btn2.MouseButton1Click:Connect(function()
    kickPlayer("Ты пытался съехать, но всё равно пошёл нахуй. GG.")
end)

-- Анимация появления
frm.Size = UDim2.new(0, 300, 0, 180)
frm.Position = UDim2.new(0.5, -150, 0.5, -90)
game:GetService("TweenService"):Create(frm, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
    Size = UDim2.new(0, 400, 0, 220),
    Position = UDim2.new(0.5, -200, 0.5, -110)
}):Play()
