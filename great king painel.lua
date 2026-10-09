--==================================================
-- GREAT KING PREMIUM 🐇
-- Roblox Studio | LocalScript
-- UI + VELOCIDADE FUNCIONAL
--==================================================

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local Theme = {
    Background = Color3.fromRGB(9, 12, 20),
    Panel = Color3.fromRGB(16, 23, 36),
    Card = Color3.fromRGB(24, 34, 51),
    Hover = Color3.fromRGB(34, 48, 70),
    Blue = Color3.fromRGB(112, 175, 255),
    White = Color3.fromRGB(240, 245, 255),
    Muted = Color3.fromRGB(145, 160, 183),
    Green = Color3.fromRGB(100, 220, 165),
    Red = Color3.fromRGB(245, 115, 130),
}

local old = playerGui:FindFirstChild("GreatKingPremium")
if old then old:Destroy() end

local function create(class, props, parent)
    local obj = Instance.new(class)

    for key, value in pairs(props or {}) do
        obj[key] = value
    end

    obj.Parent = parent
    return obj
end

local function round(obj, radius)
    create("UICorner", {
        CornerRadius = UDim.new(0, radius)
    }, obj)
end

local function stroke(obj, color)
    create("UIStroke", {
        Color = color or Theme.Hover,
        Transparency = 0.25,
        Thickness = 1
    }, obj)
end

local function tween(obj, props, duration)
    TweenService:Create(
        obj,
        TweenInfo.new(
            duration or 0.18,
            Enum.EasingStyle.Quart,
            Enum.EasingDirection.Out
        ),
        props
    ):Play()
end

local function label(parent, text, pos, size, textSize, color)
    return create("TextLabel", {
        BackgroundTransparency = 1,
        Position = pos,
        Size = size,
        Text = text,
        TextColor3 = color or Theme.White,
        TextSize = textSize or 14,
        Font = Enum.Font.GothamMedium,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextWrapped = true
    }, parent)
end

-- ESTADO DO PERSONAGEM

local speedEnabled = false
local speedValue = 24
local defaultSpeed = 16

local function applySpeed()
    local character = player.Character
    local humanoid = character
        and character:FindFirstChildOfClass("Humanoid")

    if humanoid then
        humanoid.WalkSpeed = speedEnabled
            and speedValue
            or defaultSpeed
    end
end

player.CharacterAdded:Connect(function(character)
    local humanoid = character:WaitForChild("Humanoid", 10)

    if humanoid then
        humanoid.WalkSpeed = speedEnabled
            and speedValue
            or defaultSpeed
    end
end)

-- GUI

local gui = create("ScreenGui", {
    Name = "GreatKingPremium",
    ResetOnSpawn = false,
    IgnoreGuiInset = true
}, playerGui)

-- JANELA PRINCIPAL

local main = create("Frame", {
    Name = "Main",
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.fromScale(0.5, 0.5),
    Size = UDim2.new(0.9, 0, 0, 440),
    BackgroundColor3 = Theme.Background,
    BorderSizePixel = 0
}, gui)

main.Size = UDim2.new(
    0.9, 0,
    0, math.min(440, workspace.CurrentCamera.ViewportSize.Y - 30)
)

create("UISizeConstraint", {
    MaxSize = Vector2.new(700, 520),
    MinSize = Vector2.new(300, 330)
}, main)

round(main, 18)
stroke(main, Theme.Blue)

-- CABEÇALHO

local header = create("Frame", {
    Size = UDim2.new(1, 0, 0, 65),
    BackgroundColor3 = Theme.Panel,
    BorderSizePixel = 0
}, main)

round(header, 18)

label(
    header,
    "兔  GREAT KING",
    UDim2.new(0, 18, 0, 0),
    UDim2.new(1, -75, 1, 0),
    21,
    Theme.Blue
).Font = Enum.Font.GothamBold

local close = create("TextButton", {
    Position = UDim2.new(1, -48, 0, 13),
    Size = UDim2.fromOffset(35, 35),
    BackgroundColor3 = Theme.Card,
    Text = "×",
    TextColor3 = Theme.White,
    TextSize = 23,
    Font = Enum.Font.Gotham,
    AutoButtonColor = false
}, header)

round(close, 10)

-- ÁREA DE CONTEÚDO

local content = create("ScrollingFrame", {
    Position = UDim2.new(0, 14, 0, 80),
    Size = UDim2.new(1, -28, 1, -94),
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    ScrollBarThickness = 3,
    ScrollBarImageColor3 = Theme.Blue,
    AutomaticCanvasSize = Enum.AutomaticSize.Y,
    CanvasSize = UDim2.new(0, 0, 0, 0)
}, main)

create("UIListLayout", {
    Padding = UDim.new(0, 12),
    SortOrder = Enum.SortOrder.LayoutOrder
}, content)

label(
    content,
    "PERSONAGEM",
    UDim2.new(),
    UDim2.new(1, 0, 0, 30),
    21,
    Theme.White
).Font = Enum.Font.GothamBold

label(
    content,
    "Controles de movimento",
    UDim2.new(),
    UDim2.new(1, 0, 0, 23),
    12,
    Theme.Muted
)

-- CARTÃO DE VELOCIDADE

local speedCard = create("Frame", {
    Size = UDim2.new(1, -4, 0, 82),
    BackgroundColor3 = Theme.Card,
    BorderSizePixel = 0
}, content)

round(speedCard, 13)
stroke(speedCard)

label(
    speedCard,
    "Velocidade",
    UDim2.new(0, 13, 0, 9),
    UDim2.new(1, -100, 0, 25),
    14,
    Theme.White
).Font = Enum.Font.GothamSemibold

label(
    speedCard,
    "Ativar movimento personalizado",
    UDim2.new(0, 13, 0, 37),
    UDim2.new(1, -100, 0, 23),
    11,
    Theme.Muted
)

local toggle = create("TextButton", {
    Position = UDim2.new(1, -59, 0.5, -13),
    Size = UDim2.fromOffset(46, 26),
    BackgroundColor3 = Theme.Hover,
    Text = "",
    AutoButtonColor = false
}, speedCard)

round(toggle, 20)

local knob = create("Frame", {
    Position = UDim2.new(0, 3, 0, 3),
    Size = UDim2.fromOffset(20, 20),
    BackgroundColor3 = Theme.White
}, toggle)

round(knob, 20)

local function updateToggle()
    tween(toggle, {
        BackgroundColor3 = speedEnabled
            and Theme.Blue
            or Theme.Hover
    })

    tween(knob, {
        Position = speedEnabled
            and UDim2.new(1, -23, 0, 3)
            or UDim2.new(0, 3, 0, 3)
    })

    applySpeed()
end

toggle.Activated:Connect(function()
    speedEnabled = not speedEnabled
    updateToggle()
end)

-- SLIDER FUNCIONAL

local sliderCard = create("Frame", {
    Size = UDim2.new(1, -4, 0, 100),
    BackgroundColor3 = Theme.Card,
    BorderSizePixel = 0
}, content)

round(sliderCard, 13)
stroke(sliderCard)

label(
    sliderCard,
    "Valor da velocidade",
    UDim2.new(0, 13, 0, 9),
    UDim2.new(1, -85, 0, 25),
    13,
    Theme.White
)

local valueLabel = label(
    sliderCard,
    tostring(speedValue),
    UDim2.new(1, -60, 0, 9),
    UDim2.new(0, 45, 0, 25),
    13,
    Theme.Blue
)

valueLabel.TextXAlignment = Enum.TextXAlignment.Right

local bar = create("Frame", {
    Position = UDim2.new(0, 14, 0, 55),
    Size = UDim2.new(1, -28, 0, 8),
    BackgroundColor3 = Theme.Hover,
    Active = true
}, sliderCard)

round(bar, 10)

local fill = create("Frame", {
    Size = UDim2.new((speedValue - 16) / 134, 0, 1, 0),
    BackgroundColor3 = Theme.Blue
}, bar)

round(fill, 10)

local dragging = false

local function updateSlider(x)
    local percent = math.clamp(
        (x - bar.AbsolutePosition.X) / bar.AbsoluteSize.X,
        0,
        1
    )

    speedValue = math.floor(16 + percent * 134 + 0.5)

    valueLabel.Text = tostring(speedValue)

    tween(fill, {
        Size = UDim2.new(percent, 0, 1, 0)
    }, 0.08)

    applySpeed()
end

bar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        updateSlider(input.Position.X)
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and (
        input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch
    ) then
        updateSlider(input.Position.X)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

-- BOTÃO DE RESTAURAÇÃO

local reset = create("TextButton", {
    Size = UDim2.new(1, -4, 0, 44),
    BackgroundColor3 = Theme.Panel,
    Text = "RESTAURAR PADRÃO",
    TextColor3 = Theme.Muted,
    TextSize = 12,
    Font = Enum.Font.GothamBold,
    AutoButtonColor = false
}, content)

round(reset, 12)
stroke(reset)

reset.Activated:Connect(function()
    speedEnabled = false
    speedValue = 24

    valueLabel.Text = tostring(speedValue)
    fill.Size = UDim2.new((speedValue - 16) / 134, 0, 1, 0)

    updateToggle()
end)

-- BOTÃO FLUTUANTE

local floating = create("TextButton", {
    Position = UDim2.new(0, 18, 0.5, -28),
    Size = UDim2.fromOffset(56, 56),
    BackgroundColor3 = Theme.Panel,
    Text = "兔",
    TextColor3 = Theme.Blue,
    TextSize = 27,
    Font = Enum.Font.GothamBold,
    Visible = false,
    AutoButtonColor = false
}, gui)

round(floating, 18)
stroke(floating, Theme.Blue)

floating.Activated:Connect(function()
    main.Visible = not main.Visible
end)

close.Activated:Connect(function()
    main.Visible = false
    floating.Visible = true
end)

-- ARRASTAR PELO CABEÇALHO

local draggingWindow = false
local dragStart
local startPosition

header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
        draggingWindow = true
        dragStart = input.Position
        startPosition = main.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if draggingWindow and (
        input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch
    ) then
        local delta = input.Position - dragStart

        main.Position = UDim2.new(
            startPosition.X.Scale,
            startPosition.X.Offset + delta.X,
            startPosition.Y.Scale,
            startPosition.Y.Offset + delta.Y
        )
    end
end)
