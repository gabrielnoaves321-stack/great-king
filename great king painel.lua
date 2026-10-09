-- GREAT KING PREMIUM 🐇
-- LocalScript | Roblox Studio

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")

local C = {
    Background = Color3.fromRGB(8, 11, 19),
    Panel = Color3.fromRGB(15, 21, 33),
    Card = Color3.fromRGB(22, 31, 47),
    Hover = Color3.fromRGB(32, 45, 65),
    Blue = Color3.fromRGB(113, 174, 255),
    White = Color3.fromRGB(240, 245, 255),
    Muted = Color3.fromRGB(145, 160, 184),
    Border = Color3.fromRGB(45, 60, 82),
    Green = Color3.fromRGB(105, 220, 165),
    Red = Color3.fromRGB(245, 115, 130),
}

local Keys = {
    ["RIPGB-7K2M"] = true,
    ["RIPGB-9Q4X"] = true,
    ["RIPGB-3T8P"] = true,
}

local old = PlayerGui:FindFirstChild("GreatKingPremium")
if old then old:Destroy() end

local function New(class, props, parent)
    local obj = Instance.new(class)
    for k, v in pairs(props or {}) do
        obj[k] = v
    end
    obj.Parent = parent
    return obj
end

local function Round(obj, radius)
    New("UICorner", {
        CornerRadius = UDim.new(0, radius)
    }, obj)
end

local function Outline(obj, color)
    New("UIStroke", {
        Color = color or C.Border,
        Transparency = 0.2,
        Thickness = 1
    }, obj)
end

local function Label(parent, text, size, pos, textSize, color)
    return New("TextLabel", {
        BackgroundTransparency = 1,
        Text = text,
        Size = size,
        Position = pos,
        TextColor3 = color or C.White,
        TextSize = textSize or 14,
        Font = Enum.Font.GothamMedium,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextWrapped = true
    }, parent)
end

local function Animate(obj, props)
    TweenService:Create(
        obj,
        TweenInfo.new(0.18, Enum.EasingStyle.Quart,
            Enum.EasingDirection.Out),
        props
    ):Play()
end

local Gui = New("ScreenGui", {
    Name = "GreatKingPremium",
    ResetOnSpawn = false,
    IgnoreGuiInset = true
}, PlayerGui)

-- TELA DE KEY

local Login = New("Frame", {
    Size = UDim2.fromOffset(370, 285),
    Position = UDim2.fromScale(0.5, 0.5),
    AnchorPoint = Vector2.new(0.5, 0.5),
    BackgroundColor3 = C.Panel
}, Gui)

Round(Login, 20)
Outline(Login, C.Blue)

Label(Login, "兔", UDim2.new(1, 0, 0, 55),
    UDim2.new(0, 0, 0, 18), 38, C.Blue).TextXAlignment =
    Enum.TextXAlignment.Center

Label(Login, "GREAT KING", UDim2.new(1, -30, 0, 35),
    UDim2.new(0, 15, 0, 75), 24, C.White).TextXAlignment =
    Enum.TextXAlignment.Center

Label(Login, "PREMIUM CONTROL CENTER",
    UDim2.new(1, -30, 0, 20),
    UDim2.new(0, 15, 0, 110), 10, C.Muted).TextXAlignment =
    Enum.TextXAlignment.Center

local KeyBox = New("TextBox", {
    Position = UDim2.new(0, 25, 0, 145),
    Size = UDim2.new(1, -50, 0, 43),
    BackgroundColor3 = C.Background,
    PlaceholderText = "Digite sua key",
    PlaceholderColor3 = C.Muted,
    Text = "",
    TextColor3 = C.White,
    TextSize = 14,
    Font = Enum.Font.Gotham,
    ClearTextOnFocus = false
}, Login)

Round(KeyBox, 10)
Outline(KeyBox)

local Enter = New("TextButton", {
    Position = UDim2.new(0, 25, 0, 200),
    Size = UDim2.new(1, -50, 0, 42),
    BackgroundColor3 = C.Blue,
    Text = "ENTRAR  →",
    TextColor3 = C.Background,
    TextSize = 14,
    Font = Enum.Font.GothamBold,
    AutoButtonColor = false
}, Login)

Round(Enter, 10)

local Message = Label(Login, "Aguardando acesso",
    UDim2.new(1, -30, 0, 20),
    UDim2.new(0, 15, 1, -27), 11, C.Muted)
Message.TextXAlignment = Enum.TextXAlignment.Center

-- PAINEL

local Main = New("Frame", {
    Size = UDim2.fromOffset(720, 460),
    Position = UDim2.fromScale(0.5, 0.5),
    AnchorPoint = Vector2.new(0.5, 0.5),
    BackgroundColor3 = C.Background,
    Visible = false,
    ClipsDescendants = true
}, Gui)

Round(Main, 18)
Outline(Main, C.Border)

local Header = New("Frame", {
    Size = UDim2.new(1, 0, 0, 65),
    BackgroundColor3 = C.Panel
}, Main)

Label(Header, "兔  GREAT KING",
    UDim2.new(1, -100, 1, 0),
    UDim2.new(0, 20, 0, 0), 21, C.Blue).Font =
    Enum.Font.GothamBold

local Close = New("TextButton", {
    Size = UDim2.fromOffset(38, 38),
    Position = UDim2.new(1, -49, 0, 13),
    BackgroundColor3 = C.Card,
    Text = "×",
    TextColor3 = C.White,
    TextSize = 23,
    Font = Enum.Font.Gotham
}, Header)

Round(Close, 10)

local Sidebar = New("Frame", {
    Position = UDim2.new(0, 12, 0, 77),
    Size = UDim2.new(0, 155, 1, -89),
    BackgroundColor3 = C.Panel
}, Main)

Round(Sidebar, 13)
Outline(Sidebar)

local Content = New("Frame", {
    Position = UDim2.new(0, 180, 0, 77),
    Size = UDim2.new(1, -192, 1, -89),
    BackgroundTransparency = 1
}, Main)

local Pages = {}
local Tabs = {}
local ActiveTab

local function CreatePage(id, title, subtitle)
    local page = New("ScrollingFrame", {
        Name = id,
        Size = UDim2.fromScale(1, 1),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ScrollBarThickness = 3,
        ScrollBarImageColor3 = C.Blue,
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        CanvasSize = UDim2.new(0, 0, 0, 0),
        Visible = false
    }, Content)

    New("UIListLayout", {
        Padding = UDim.new(0, 10),
        SortOrder = Enum.SortOrder.LayoutOrder
    }, page)

    Label(page, title, UDim2.new(1, -8, 0, 35),
        UDim2.new(), 23, C.White).Font = Enum.Font.GothamBold

    Label(page, subtitle, UDim2.new(1, -8, 0, 25),
        UDim2.new(), 11, C.Muted)

    Pages[id] = page
    return page
end

local function ShowPage(id)
    ActiveTab = id
    for name, page in pairs(Pages) do
        page.Visible = name == id
    end
    for name, tab in pairs(Tabs) do
        Animate(tab, {
            BackgroundColor3 = name == id and C.Hover or C.Panel,
            TextColor3 = name == id and C.Blue or C.Muted
        })
    end
end

local function CreateTab(id, text, order)
    local tab = New("TextButton", {
        Position = UDim2.new(0, 8, 0, 12 + (order - 1) * 51),
        Size = UDim2.new(1, -16, 0, 43),
        BackgroundColor3 = C.Panel,
        Text = text,
        TextColor3 = C.Muted,
        TextSize = 12,
        Font = Enum.Font.GothamSemibold,
        AutoButtonColor = false
    }, Sidebar)

    Round(tab, 9)
    Tabs[id] = tab

    tab.MouseButton1Click:Connect(function()
        ShowPage(id)
    end)

    tab.MouseEnter:Connect(function()
        if ActiveTab ~= id then
            Animate(tab, {BackgroundColor3 = C.Hover})
        end
    end)

    tab.MouseLeave:Connect(function()
        if ActiveTab ~= id then
            Animate(tab, {BackgroundColor3 = C.Panel})
        end
    end)
end

local function Card(parent, height)
    local card = New("Frame", {
        Size = UDim2.new(1, -4, 0, height),
        BackgroundColor3 = C.Card
    }, parent)
    Round(card, 12)
    Outline(card)
    return card
end

local function Toggle(parent, title, callback)
    local card = Card(parent, 62)

    Label(card, title, UDim2.new(1, -85, 1, 0),
        UDim2.new(0, 13, 0, 0), 13, C.White)

    local switch = New("TextButton", {
        Size = UDim2.fromOffset(43, 24),
        Position = UDim2.new(1, -55, 0.5, -12),
        BackgroundColor3 = C.Hover,
        Text = "",
        AutoButtonColor = false
    }, card)

    Round(switch, 20)

    local knob = New("Frame", {
        Size = UDim2.fromOffset(18, 18),
        Position = UDim2.new(0, 3, 0, 3),
        BackgroundColor3 = C.White
    }, switch)

    Round(knob, 20)

    local enabled = false

    switch.MouseButton1Click:Connect(function()
        enabled = not enabled

        Animate(switch, {
            BackgroundColor3 = enabled and C.Blue or C.Hover
        })

        Animate(knob, {
            Position = enabled
                and UDim2.new(1, -21, 0, 3)
                or UDim2.new(0, 3, 0, 3)
        })

        callback(enabled)
    end)
end

local function Slider(parent, title, minimum, maximum, default)
    local card = Card(parent, 78)

    local value = default

    local heading = Label(card, title,
        UDim2.new(1, -65, 0, 25),
        UDim2.new(0, 13, 0, 5), 12, C.White)

    local number = Label(card, tostring(value),
        UDim2.new(0, 45, 0, 25),
        UDim2.new(1, -57, 0, 5), 12, C.Blue)

    number.TextXAlignment = Enum.TextXAlignment.Right

    local bar = New("Frame", {
        Position = UDim2.new(0, 13, 0, 47),
        Size = UDim2.new(1, -26, 0, 7),
        BackgroundColor3 = C.Hover
    }, card)

    Round(bar, 10)

    local fill = New("Frame", {
        Size = UDim2.new(
            (value - minimum) / (maximum - minimum), 0, 1, 0
        ),
        BackgroundColor3 = C.Blue
    }, bar)

    Round(fill, 10)

    local dragging = false

    local function Update(x)
        local percent = math.clamp(
            (x - bar.AbsolutePosition.X) / bar.AbsoluteSize.X,
            0, 1
        )

        value = math.floor(
            minimum + percent * (maximum - minimum) + 0.5
        )

        number.Text = tostring(value)
        TweenService:Create(fill, TweenInfo.new(0.08), {
            Size = UDim2.new(percent, 0, 1, 0)
        }):Play()
    end

    bar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            Update(input.Position.X)
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if dragging and (
            input.UserInputType == Enum.UserInputType.MouseMovement
            or input.UserInputType == Enum.UserInputType.Touch
        ) then
            Update(input.Position.X)
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
end

-- PÁGINAS

local Home = CreatePage("Home", "Bem-vindo", "Seu painel premium.")
local Character = CreatePage("Character", "Personagem", "Controles de demonstração.")
local Combat = CreatePage("Combat", "Combate", "Preferências visuais.")
local Visual = CreatePage("Visual", "Visual", "Indicadores de interface.")

CreateTab("Home", "⌂   INÍCIO", 1)
CreateTab("Character", "◇   PERSONAGEM", 2)
CreateTab("Combat", "◎   COMBATE", 3)
CreateTab("Visual", "◈   VISUAL", 4)

local welcome = Card(Home, 100)
Label(welcome, "GREAT KING PREMIUM",
    UDim2.new(1, -24, 0, 32),
    UDim2.new(0, 13, 0, 14), 19, C.Blue).Font =
    Enum.Font.GothamBold

Label(welcome, "Design moderno. Controle organizado.",
    UDim2.new(1, -24, 0, 25),
    UDim2.new(0, 13, 0, 51), 12, C.Muted)

Toggle(Character, "Velocidade", function() end)
Slider(Character, "Valor de velocidade", 16, 150, 16)
Toggle(Character, "Modo de voo", function() end)
Slider(Character, "Velocidade de voo", 10, 150, 50)
Toggle(Character, "Rotação", function() end)
Slider(Character, "Velocidade de rotação", 1, 100, 20)
Toggle(Character, "Modo de colisão", function() end)

Toggle(Combat, "Assistência visual de mira", function() end)
Slider(Combat, "Raio do indicador", 50, 400, 150)

Toggle(Visual, "Indicador de caixa", function() end)
Toggle(Visual, "Indicador de linha", function() end)
Toggle(Visual, "Indicador de vida", function() end)

ShowPage("Home")

-- ARRASTAR
local dragging = false
local dragStart
local startPosition

Header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPosition = Main.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and (
        input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch
    ) then
        local delta = input.Position - dragStart
        Main.Position = UDim2.new(
            startPosition.X.Scale,
            startPosition.X.Offset + delta.X,
            startPosition.Y.Scale,
            startPosition.Y.Offset + delta.Y
        )
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

-- BOTÃO FLUTUANTE
local Floating = New("TextButton", {
    Size = UDim2.fromOffset(58, 58),
    Position = UDim2.new(0, 20, 0.5, -29),
    BackgroundColor3 = C.Panel,
    Text = "兔",
    TextColor3 = C.Blue,
    TextSize = 29,
    Font = Enum.Font.GothamBold,
    Visible = false
}, Gui)

Round(Floating, 18)
Outline(Floating, C.Blue)

Floating.MouseButton1Click:Connect(function()
    Main.Visible = not Main.Visible
end)

Close.MouseButton1Click:Connect(function()
    Main.Visible = false
    Floating.Visible = true
end)

-- KEY
local unlocked = false

local function CheckKey()
    if unlocked then return end

    local key = string.upper(KeyBox.Text:gsub("%s+", ""))

    if Keys[key] then
        unlocked = true
        Login.Visible = false
        Main.Visible = true
        Floating.Visible = true
    else
        Message.Text = "KEY INCORRETA"
        Message.TextColor3 = C.Red
        KeyBox.Text = ""
    end
end

Enter.MouseButton1Click:Connect(CheckKey)

KeyBox.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        CheckKey()
    end
end)
