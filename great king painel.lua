--==================================================
-- GREAT KING 🐇
-- LocalScript - use no seu próprio jogo Roblox
--==================================================

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")
local Camera = workspace.CurrentCamera

--==================================================
-- CONFIGURAÇÃO
--==================================================

local BLUE = Color3.fromRGB(0, 120, 255)
local DARK_BLUE = Color3.fromRGB(0, 35, 70)
local BLACK = Color3.fromRGB(5, 5, 5)
local DARK = Color3.fromRGB(12, 12, 12)
local WHITE = Color3.fromRGB(235, 235, 235)

--==================================================
-- REMOVE PAINEL ANTIGO
--==================================================

local OldGui = PlayerGui:FindFirstChild("RIPGB_PANEL")
if OldGui then
	OldGui:Destroy()
end

--==================================================
-- KEYS
--==================================================

local SENHAS = {
	["RIPGB-7K2M"] = true,
	["RIPGB-9Q4X"] = true,
	["RIPGB-3T8P"] = true,
	["RIPGB-6N5V"] = true,
	["RIPGB-2H9R"] = true,
	["RIPGB-8W3L"] = true,
	["RIPGB-4F7Z"] = true,
	["RIPGB-5C2J"] = true,
	["RIPGB-1M8K"] = true,
	["RIPGB-0X6Q"] = true,
	["RIPGB-A7P3"] = true,
	["RIPGB-B9L5"] = true,
	["RIPGB-C4N8"] = true,
	["RIPGB-D2V6"] = true,
	["RIPGB-E8R1"] = true,
	["RIPGB-F5K9"] = true,
	["RIPGB-G3T7"] = true,
	["RIPGB-H6M2"] = true,
	["RIPGB-J9Q4"] = true,
	["RIPGB-K1W8"] = true,
	["RIPGB-L5X3"] = true,
	["RIPGB-M7C9"] = true,
	["RIPGB-N2F6"] = true,
	["RIPGB-P8H4"] = true,
	["RIPGB-Q3V7"] = true,
	["RIPGB-R6Z1"] = true,
	["RIPGB-S9K5"] = true,
	["RIPGB-T4M8"] = true,
	["RIPGB-V2L6"] = true,
	["RIPGB-W7P3"] = true,
	["RIPGB-X5N9"] = true,
	["RIPGB-Y1C4"] = true,
	["RIPGB-Z8F2"] = true,
	["RIPGB-3H6K"] = true,
	["RIPGB-9J2M"] = true,
	["RIPGB-4Q7R"] = true,
	["RIPGB-6V1X"] = true,
	["RIPGB-8L5T"] = true,
	["RIPGB-2P9W"] = true,
	["RIPGB-7C3Z"] = true,
	["RIPGB-5M8F"] = true,
	["RIPGB-1R6H"] = true,
	["RIPGB-9X4K"] = true,
	["RIPGB-3N7Q"] = true,
	["RIPGB-6T2V"] = true,
	["RIPGB-8Z5L"] = true,
	["RIPGB-4W1P"] = true,
	["RIPGB-7F9C"] = true,
	["RIPGB-2K6M"] = true,
	["RIPGB-5Q8X"] = true
}

--==================================================
-- VARIÁVEIS
--==================================================

local SpeedEnabled = false
local SpeedValue = 16

local FlyEnabled = false
local FlySpeed = 50
local FlyVelocity

local SpinEnabled = false
local SpinSpeed = 20

local NoClipEnabled = false

local AimbotEnabled = false
local AimPart = "Head"
local AimFOV = 150

local ESPBoxEnabled = false
local ESPLineEnabled = false
local ESPHealthEnabled = false

local Unlocked = false

--==================================================
-- GUI
--==================================================

local Gui = Instance.new("ScreenGui")
Gui.Name = "RIPGB_PANEL"
Gui.ResetOnSpawn = false
Gui.IgnoreGuiInset = true
Gui.Parent = PlayerGui

--==================================================
-- FUNÇÕES VISUAIS
--==================================================

local function Corner(obj, radius)
	local c = Instance.new("UICorner")
	c.CornerRadius = UDim.new(0, radius)
	c.Parent = obj
end

local function Border(obj)
	local s = Instance.new("UIStroke")
	s.Color = BLUE
	s.Thickness = 1.5
	s.Transparency = 0.15
	s.Parent = obj
end

local function Label(parent, text, size, position)
	local l = Instance.new("TextLabel")
	l.Size = size
	l.Position = position
	l.BackgroundTransparency = 1
	l.Text = text
	l.TextColor3 = WHITE
	l.TextScaled = true
	l.Font = Enum.Font.GothamBold
	l.Parent = parent
	return l
end

--==================================================
-- TELA DA KEY
--==================================================

local PasswordFrame = Instance.new("Frame")
PasswordFrame.Size = UDim2.new(0, 400, 0, 250)
PasswordFrame.Position = UDim2.new(0.5, -200, 0.5, -125)
PasswordFrame.BackgroundColor3 = BLACK
PasswordFrame.Parent = Gui

Corner(PasswordFrame, 15)
Border(PasswordFrame)

local KeyTitle = Label(
	PasswordFrame,
	"🐇  GREAT KING",
	UDim2.new(1, -30, 0, 55),
	UDim2.new(0, 15, 0, 15)
)

KeyTitle.TextColor3 = BLUE

local KeySub = Label(
	PasswordFrame,
	"DIGITE SUA KEY",
	UDim2.new(1, -40, 0, 30),
	UDim2.new(0, 20, 0, 70)
)

local PasswordBox = Instance.new("TextBox")
PasswordBox.Size = UDim2.new(1, -50, 0, 48)
PasswordBox.Position = UDim2.new(0, 25, 0, 108)
PasswordBox.BackgroundColor3 = DARK
PasswordBox.PlaceholderText = "RIPGB-XXXX"
PasswordBox.Text = ""
PasswordBox.TextColor3 = WHITE
PasswordBox.PlaceholderColor3 = Color3.fromRGB(100, 100, 100)
PasswordBox.TextScaled = true
PasswordBox.Font = Enum.Font.Gotham
PasswordBox.ClearTextOnFocus = false
PasswordBox.Parent = PasswordFrame

Corner(PasswordBox, 10)
Border(PasswordBox)

local EnterButton = Instance.new("TextButton")
EnterButton.Size = UDim2.new(1, -50, 0, 48)
EnterButton.Position = UDim2.new(0, 25, 0, 170)
EnterButton.BackgroundColor3 = BLUE
EnterButton.Text = "ENTRAR"
EnterButton.TextColor3 = Color3.fromRGB(255,255,255)
EnterButton.TextScaled = true
EnterButton.Font = Enum.Font.GothamBold
EnterButton.Parent = PasswordFrame

Corner(EnterButton, 10)

--==================================================
-- PAINEL PRINCIPAL
--==================================================

local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 700, 0, 470)
Main.Position = UDim2.new(0.5, -350, 0.5, -235)
Main.BackgroundColor3 = BLACK
Main.Visible = false
Main.Parent = Gui

Corner(Main, 15)
Border(Main)

--==================================================
-- TÍTULO
--==================================================

local MainTitle = Label(
	Main,
	"🐇  GREAT KING",
	UDim2.new(1, -70, 0, 55),
	UDim2.new(0, 15, 0, 5)
)

MainTitle.TextColor3 = BLUE

--==================================================
-- FECHAR
--==================================================

local Close = Instance.new("TextButton")
Close.Size = UDim2.new(0, 42, 0, 42)
Close.Position = UDim2.new(1, -52, 0, 8)
Close.BackgroundColor3 = BLUE
Close.Text = "X"
Close.TextColor3 = Color3.fromRGB(255,255,255)
Close.TextScaled = true
Close.Font = Enum.Font.GothamBold
Close.Parent = Main

Corner(Close, 10)

--==================================================
-- ABAS
--==================================================

local Tabs = Instance.new("Frame")
Tabs.Size = UDim2.new(0, 155, 1, -75)
Tabs.Position = UDim2.new(0, 10, 0, 65)
Tabs.BackgroundColor3 = DARK
Tabs.Parent = Main

Corner(Tabs, 12)
Border(Tabs)

local Pages = Instance.new("Frame")
Pages.Size = UDim2.new(1, -180, 1, -75)
Pages.Position = UDim2.new(0, 170, 0, 65)
Pages.BackgroundTransparency = 1
Pages.Parent = Main

local CharacterPage = Instance.new("Frame")
CharacterPage.Size = UDim2.fromScale(1,1)
CharacterPage.BackgroundTransparency = 1
CharacterPage.Parent = Pages

local CombatPage = CharacterPage:Clone()
CombatPage.Parent = Pages
CombatPage.Visible = false

local ESPPage = CharacterPage:Clone()
ESPPage.Parent = Pages
ESPPage.Visible = false

local function TabButton(text, y)
	local b = Instance.new("TextButton")
	b.Size = UDim2.new(1, -20, 0, 50)
	b.Position = UDim2.new(0, 10, 0, y)
	b.BackgroundColor3 = DARK
	b.Text = text
	b.TextColor3 = WHITE
	b.TextScaled = true
	b.Font = Enum.Font.GothamBold
	b.Parent = Tabs

	Corner(b, 10)
	Border(b)

	return b
end

local CharacterTab = TabButton("PERSONAGEM", 15)
local CombatTab = TabButton("COMBATE", 75)
local ESPTab = TabButton("ESP", 135)

local function ShowPage(page)
	CharacterPage.Visible = false
	CombatPage.Visible = false
	ESPPage.Visible = false
	page.Visible = true
end

CharacterTab.MouseButton1Click:Connect(function()
	ShowPage(CharacterPage)
end)

CombatTab.MouseButton1Click:Connect(function()
	ShowPage(CombatPage)
end)

ESPTab.MouseButton1Click:Connect(function()
	ShowPage(ESPPage)
end)

--==================================================
-- BOTÕES
--==================================================

local function Toggle(parent, text, y, callback)

	local b = Instance.new("TextButton")
	b.Size = UDim2.new(0, 300, 0, 48)
	b.Position = UDim2.new(0, 20, 0, y)
	b.BackgroundColor3 = DARK
	b.Text = text .. " : OFF"
	b.TextColor3 = WHITE
	b.TextScaled = true
	b.Font = Enum.Font.GothamBold
	b.Parent = parent

	Corner(b, 10)
	Border(b)

	local state = false

	b.MouseButton1Click:Connect(function()

		state = not state

		if state then
			b.Text = text .. " : ON"
			b.BackgroundColor3 = BLUE
		else
			b.Text = text .. " : OFF"
			b.BackgroundColor3 = DARK
		end

		callback(state)
	end)

	return b
end

--==================================================
-- SLIDERS
--==================================================

local function Slider(parent, text, y, min, max, default, callback)

	local title = Label(
		parent,
		text .. ": " .. default,
		UDim2.new(0, 300, 0, 30),
		UDim2.new(0, 20, 0, y)
	)

	title.TextColor3 = BLUE

	local bar = Instance.new("Frame")
	bar.Size = UDim2.new(0, 300, 0, 12)
	bar.Position = UDim2.new(0, 20, 0, y + 35)
	bar.BackgroundColor3 = DARK
	bar.Parent = parent

	Corner(bar, 8)
	Border(bar)

	local fill = Instance.new("Frame")
	fill.Size = UDim2.new(
		(default - min) / (max - min),
		0,
		1,
		0
	)

	fill.BackgroundColor3 = BLUE
	fill.Parent = bar

	Corner(fill, 8)

	local dragging = false

	local function update(x)

		local percent = math.clamp(
			(x - bar.AbsolutePosition.X) /
			bar.AbsoluteSize.X,
			0,
			1
		)

		local value = math.floor(
			min + (max - min) * percent
		)

		fill.Size = UDim2.new(percent,0,1,0)
		title.Text = text .. ": " .. value

		callback(value)
	end

	bar.InputBegan:Connect(function(input)

		if input.UserInputType ==
			Enum.UserInputType.MouseButton1 then

			dragging = true
			update(input.Position.X)
		end
	end)

	UserInputService.InputChanged:Connect(function(input)

		if dragging and
			input.UserInputType ==
			Enum.UserInputType.MouseMovement then

			update(input.Position.X)
		end
	end)

	UserInputService.InputEnded:Connect(function(input)

		if input.UserInputType ==
			Enum.UserInputType.MouseButton1 then

			dragging = false
		end
	end)
end

--==================================================
-- PERSONAGEM
--==================================================

Toggle(CharacterPage, "SPEED", 15, function(state)
	SpeedEnabled = state
end)

Slider(
	CharacterPage,
	"VELOCIDADE",
	70,
	16,
	150,
	16,
	function(value)
		SpeedValue = value
	end
)

Toggle(CharacterPage, "FLY", 140, function(state)

	FlyEnabled = state

	local char = Player.Character
	local root = char and char:FindFirstChild("HumanoidRootPart")

	if state and root then

		if FlyVelocity then
			FlyVelocity:Destroy()
		end

		FlyVelocity = Instance.new("BodyVelocity")
		FlyVelocity.MaxForce =
			Vector3.new(math.huge, math.huge, math.huge)

		FlyVelocity.Velocity = Vector3.zero
		FlyVelocity.Parent = root

	elseif FlyVelocity then

		FlyVelocity:Destroy()
		FlyVelocity = nil
	end
end)

Slider(
	CharacterPage,
	"VELOCIDADE FLY",
	195,
	10,
	150,
	50,
	function(value)
		FlySpeed = value
	end
)

Toggle(CharacterPage, "SPIN", 265, function(state)
	SpinEnabled = state
end)

Slider(
	CharacterPage,
	"VELOCIDADE SPIN",
	320,
	1,
	100,
	20,
	function(value)
		SpinSpeed = value
	end
)

Toggle(CharacterPage, "NOCLIP", 390, function(state)
	NoClipEnabled = state
end)

--==================================================
-- COMBATE
--==================================================

Toggle(CombatPage, "AIMBOT", 15, function(state)
	AimbotEnabled = state
end)

local AimButton = Instance.new("TextButton")
AimButton.Size = UDim2.new(0, 300, 0, 48)
AimButton.Position = UDim2.new(0, 20, 0, 75)
AimButton.BackgroundColor3 = DARK
AimButton.Text = "MIRA: CABEÇA"
AimButton.TextColor3 = WHITE
AimButton.TextScaled = true
AimButton.Font = Enum.Font.GothamBold
AimButton.Parent = CombatPage

Corner(AimButton, 10)
Border(AimButton)

AimButton.MouseButton1Click:Connect(function()

	if AimPart == "Head" then

		AimPart = "HumanoidRootPart"
		AimButton.Text = "MIRA: TRONCO"

	else

		AimPart = "Head"
		AimButton.Text = "MIRA: CABEÇA"
	end
end)

Slider(
	CombatPage,
	"RAIO DO AIM",
	135,
	50,
	400,
	150,
	function(value)
		AimFOV = value
	end
)

--==================================================
-- ESP
--==================================================

Toggle(ESPPage, "ESP CAIXA", 15, function(state)
	ESPBoxEnabled = state
end)

Toggle(ESPPage, "ESP LINHA", 75, function(state)
	ESPLineEnabled = state
end)

Toggle(ESPPage, "ESP BARRA DE VIDA", 135, function(state)
	ESPHealthEnabled = state
end)

--==================================================
-- FOV
--==================================================

local FOVCircle = Instance.new("Frame")
FOVCircle.Size = UDim2.new(
	0,
	AimFOV * 2,
	0,
	AimFOV * 2
)

FOVCircle.AnchorPoint = Vector2.new(.5,.5)
FOVCircle.BackgroundTransparency = 1
FOVCircle.Visible = false
FOVCircle.Parent = Gui

Corner(FOVCircle, 999)

local FOVStroke = Instance.new("UIStroke")
FOVStroke.Color = BLUE
FOVStroke.Thickness = 2
FOVStroke.Parent = FOVCircle

--==================================================
-- ESP
--==================================================

local ESPObjects = {}

local function RemoveESP(target)

	local data = ESPObjects[target]

	if data then

		for _, obj in pairs(data) do

			if obj and obj.Parent then
				obj:Destroy()
			end
		end

		ESPObjects[target] = nil
	end
end

local function CreateESP(target)

	if target == Player then
		return
	end

	local char = target.Character

	if not char then
		return
	end

	RemoveESP(target)

	local highlight = Instance.new("Highlight")
	highlight.Name = "GREATKING_ESP"
	highlight.Adornee = char
	highlight.FillColor = BLUE
	highlight.OutlineColor = BLUE
	highlight.FillTransparency = 0.8
	highlight.OutlineTransparency = 0
	highlight.Parent = char

	local healthGui = Instance.new("BillboardGui")
	healthGui.Name = "GREATKING_HEALTH"
	healthGui.Size = UDim2.new(0,100,0,30)
	healthGui.StudsOffset = Vector3.new(0,3,0)
	healthGui.AlwaysOnTop = true
	healthGui.Parent = char

	local healthBack = Instance.new("Frame")
	healthBack.Size = UDim2.new(.9,0,.35,0)
	healthBack.Position = UDim2.new(.05,0,.3,0)
	healthBack.BackgroundColor3 = DARK
	healthBack.Parent = healthGui

	Corner(healthBack,5)

	local healthFill = Instance.new("Frame")
	healthFill.Size = UDim2.new(1,0,1,0)
	healthFill.BackgroundColor3 = BLUE
	healthFill.Parent = healthBack

	Corner(healthFill,5)

	ESPObjects[target] = {
		Highlight = highlight,
		HealthGui = healthGui,
		HealthFill = healthFill
	}
end

--==================================================
-- AIMBOT
--==================================================

local function GetTarget()

	local closest = nil
	local distance = AimFOV

	local mouse = UserInputService:GetMouseLocation()

	for _, target in ipairs(Players:GetPlayers()) do

		if target ~= Player then

			local char = target.Character
			local hum = char and
				char:FindFirstChildOfClass("Humanoid")

			local part = char and
				char:FindFirstChild(AimPart)

			if hum and hum.Health > 0 and part then

				local screen, onScreen =
					Camera:WorldToViewportPoint(part.Position)

				if onScreen then

					local d =
						(Vector2.new(screen.X,screen.Y)-mouse).Magnitude

					if d < distance then

						distance = d
						closest = part
					end
				end
			end
		end
	end

	return closest
end

--==================================================
-- ARRASTAR
--==================================================

local function Draggable(obj)

	local dragging = false
	local dragStart
	local startPos

	obj.InputBegan:Connect(function(input)

		if input.UserInputType ==
			Enum.UserInputType.MouseButton1 then

			dragging = true
			dragStart = input.Position
			startPos = obj.Position

			input.Changed:Connect(function()

				if input.UserInputState ==
					Enum.UserInputState.End then

					dragging = false
				end
			end)
		end
	end)

	UserInputService.InputChanged:Connect(function(input)

		if dragging and
			input.UserInputType ==
			Enum.UserInputType.MouseMovement then

			local delta =
				input.Position - dragStart

			obj.Position = UDim2.new(
				startPos.X.Scale,
				startPos.X.Offset + delta.X,
				startPos.Y.Scale,
				startPos.Y.Offset + delta.Y
			)
		end
	end)
end

Draggable(Main)

--==================================================
-- COELHO FLUTUANTE 🐇
--==================================================

local Floating = Instance.new("TextButton")

Floating.Size = UDim2.new(0, 70, 0, 70)
Floating.Position = UDim2.new(0, 20, 0.5, -35)

-- FUNDO PRETO
Floating.BackgroundColor3 = Color3.fromRGB(0,0,0)

Floating.Text = "🐇"
Floating.TextColor3 = Color3.fromRGB(230,230,230)
Floating.TextScaled = true
Floating.Font = Enum.Font.GothamBold

Floating.Visible = false
Floating.Parent = Gui

Corner(Floating, 18)
Border(Floating)

--==================================================
-- COELHO ABRE/FECHA
--==================================================

Floating.MouseButton1Click:Connect(function()
	Main.Visible = not Main.Visible
end)

Draggable(Floating)

--==================================================
-- FECHAR PAINEL
--==================================================

Close.MouseButton1Click:Connect(function()
	Main.Visible = false
end)

--==================================================
-- LOOP
--==================================================

RunService.RenderStepped:Connect(function()

	if not Unlocked then
		return
	end

	local char = Player.Character
	local hum = char and
		char:FindFirstChildOfClass("Humanoid")

	local root = char and
		char:FindFirstChild("HumanoidRootPart")

	-- SPEED
	if hum then

		if SpeedEnabled then
			hum.WalkSpeed = SpeedValue
		else
			hum.WalkSpeed = 16
		end
	end

	-- NOCLIP
	if NoClipEnabled and char then

		for _, obj in ipairs(char:GetDescendants()) do

			if obj:IsA("BasePart") then
				obj.CanCollide = false
			end
		end
	end

	-- FLY
	if FlyEnabled and root and FlyVelocity then

		local direction = Vector3.zero

		if UserInputService:IsKeyDown(Enum.KeyCode.W) then
			direction += Camera.CFrame.LookVector
		end

		if UserInputService:IsKeyDown(Enum.KeyCode.S) then
			direction -= Camera.CFrame.LookVector
		end

		if UserInputService:IsKeyDown(Enum.KeyCode.A) then
			direction -= Camera.CFrame.RightVector
		end

		if UserInputService:IsKeyDown(Enum.KeyCode.D) then
			direction += Camera.CFrame.RightVector
		end

		if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
			direction += Vector3.new(0,1,0)
		end

		if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
			direction -= Vector3.new(0,1,0)
		end

		if direction.Magnitude > 0 then
			direction =
				direction.Unit * FlySpeed
		end

		FlyVelocity.Velocity = direction
	end

	-- SPIN
	if SpinEnabled and root then

		root.CFrame =
			root.CFrame *
			CFrame.Angles(
				0,
				math.rad(SpinSpeed),
				0
			)
	end

	-- FOV
	FOVCircle.Visible = AimbotEnabled

	if AimbotEnabled then

		local mouse =
			UserInputService:GetMouseLocation()

		FOVCircle.Position =
			UDim2.new(0, mouse.X, 0, mouse.Y)

		FOVCircle.Size =
			UDim2.new(
				0,
				AimFOV * 2,
				0,
				AimFOV * 2
			)

		local target = GetTarget()

		if target then

			Camera.CFrame =
				CFrame.new(
					Camera.CFrame.Position,
					target.Position
				)
		end
	end

	-- ESP
	for _, target in ipairs(Players:GetPlayers()) do

		if target ~= Player then

			local character = target.Character
			local data = ESPObjects[target]

			if character and
				(ESPBoxEnabled or
				ESPHealthEnabled or
				ESPLineEnabled) then

				if not data then
					CreateESP(target)
					data = ESPObjects[target]
				end

				if data then

					data.Highlight.Enabled =
						ESPBoxEnabled

					data.HealthGui.Enabled =
						ESPHealthEnabled

					local targetHum =
						character:FindFirstChildOfClass(
							"Humanoid"
						)

					if targetHum then

						local health =
							math.clamp(
								targetHum.Health /
								math.max(
									targetHum.MaxHealth,
									1
								),
								0,
								1
							)

						data.HealthFill.Size =
							UDim2.new(
								health,
								0,
								1,
								0
							)
					end
				end

			else
				RemoveESP(target)
			end
		end
	end
end)

--==================================================
-- RESPAWN
--==================================================

Player.CharacterAdded:Connect(function(character)

	task.wait(.5)

	local hum =
		character:WaitForChild("Humanoid")

	if SpeedEnabled then
		hum.WalkSpeed = SpeedValue
	end

	if FlyEnabled then

		local root =
			character:WaitForChild(
				"HumanoidRootPart"
			)

		if FlyVelocity then
			FlyVelocity:Destroy()
		end

		FlyVelocity =
			Instance.new("BodyVelocity")

		FlyVelocity.MaxForce =
			Vector3.new(
				math.huge,
				math.huge,
				math.huge
			)

		FlyVelocity.Velocity =
			Vector3.zero

		FlyVelocity.Parent = root
	end
end)

--==================================================
-- VERIFICAR KEY
--==================================================

local function CheckKey()

	local key = PasswordBox.Text

	if SENHAS[key] then

		Unlocked = true

		PasswordFrame.Visible = false
		Main.Visible = true

		-- COELHO SÓ APARECE DEPOIS DA KEY
		Floating.Visible = true

		ShowPage(CharacterPage)

	else

		PasswordBox.Text = ""
		PasswordBox.PlaceholderText = "KEY INCORRETA!"
	end
end

EnterButton.MouseButton1Click:Connect(CheckKey)

PasswordBox.FocusLost:Connect(function(enterPressed)

	if enterPressed then
		CheckKey()
	end
end)

--==================================================
-- ESTADO INICIAL
--==================================================

PasswordFrame.Visible = true
Main.Visible = false
Floating.Visible = false
FOVCircle.Visible = false
Unlocked = false

ShowPage(CharacterPage)