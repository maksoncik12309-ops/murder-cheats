
local player = game:GetService("Players").LocalPlayer
local pg = player:WaitForChild("PlayerGui")
local Twn = game:GetService("TweenService")

-- Ждем 2 секунды, чтобы ты переключился в окно игры
task.wait(2)

local gui = Instance.new("ScreenGui")
gui.Name = "Screamer"
gui.IgnoreGuiInset = true
gui.DisplayOrder = 2147483647 -- Максимальный приоритет (поверх всего)
gui.Parent = pg

-- Черный фон на весь экран
local bg = Instance.new("Frame", gui)
bg.Size = UDim2.fromScale(1, 1)
bg.BackgroundColor3 = Color3.new(0, 0, 0)
bg.BorderSizePixel = 0

-- Сама страшная картинка
local img = Instance.new("ImageLabel", bg)
img.Size = UDim2.fromScale(1, 1)
img.BackgroundTransparency = 1
-- Ссылка на страшную рожу (стандартный ассет Roblox)
img.Image = "rbxassetid://1360716087" 
img.ImageTransparency = 1 -- Изначально невидима для плавного появления

-- Звук (громкий резкий бас/крик)
local sound = Instance.new("Sound", gui)
sound.SoundId = "rbxassetid://138062075" -- Громкий скример
sound.Volume = 10 -- Максимальная громкость
sound.PlayOnRemove = false
sound:Play()

-- Анимация резкого появления
task.wait(0.1)
Twn:Create(img, TweenInfo.new(0.05, Enum.EasingStyle.Linear), {ImageTransparency = 0}):Play()
Twn:Create(bg, TweenInfo.new(0.1), {BackgroundColor3 = Color3.new(1, 1, 1)}):Play()
task.wait(0.1)
Twn:Create(bg, TweenInfo.new(0.1), {BackgroundColor3 = Color3.new(0, 0, 0)}):Play()

-- Тряска экрана
for i = 1, 20 do
    local offsetX = math.random(-50, 50)
    local offsetY = math.random(-50, 50)
    bg.Position = UDim2.fromOffset(offsetX, offsetY)
    task.wait(0.02)
end

-- Через 3 секунды скример исчезает
task.wait(3)
Twn:Create(img, TweenInfo.new(0.5), {ImageTransparency = 1}):Play()
Twn:Create(bg, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
task.wait(0.5)
gui:Destroy()
