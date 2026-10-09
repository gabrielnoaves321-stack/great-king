
--==================================================
-- GREAT KING PREMIUM 🐇
-- LocalScript | Roblox Studio
-- Interface + movimento funcional
--==================================================

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

local C = {
    bg = Color3.fromRGB(9, 12, 20),
    panel = Color3.fromRGB(16, 22, 34),
    card = Color3.fromRGB(24, 33, 49),
    hover = Color3.fromRGB(38, 52, 73),
    blue = Color3.fromRGB(112, 175, 255),
    white = Color3.fromRGB(242, 246, 255),
    muted = Color3.fromRGB(150, 163, 185),
    green = Color3.fromRGB(105, 225, 170),
    red = Color3.fromRGB(255, 115, 130)
}

local old = PlayerGui:FindFirstChild("GreatKingPremium")
if old then old:Destroy() end

local function make(class, props, parent)
    local obj = Instance.new(class)
    for k, v in pairs(props or {}) do
        obj[k] = v
    end
    obj.Parent = parent
    return obj
end

local function corner(obj, radius)
    make("UICorner", {
        CornerRadius = UDim.new(0, radius)
    }, obj)
end

local function outline(obj, color)
    make("UIStroke", {
        Color = color or C.hover,
        Transparency = 0.25,
        Thickness = 1
    }, obj)
end

local function animate(obj, props)
    TweenService:Create(obj, TweenInfo.new(
        0.18, Enum.EasingStyle.Quart,
        Enum.EasingDirection.Out
    ), props):Play()
end

local function label(parent, text, pos, size, fontSize, color)
    return make("TextLabel", {
        BackgroundTransparency = 1,
        Position = pos,
        Size = size,
        Text = text,
        TextSize = fontSize or 14,
        TextColor3 = color or C.white,
        Font = Enum.Font.GothamMedium,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextWrapped = true
    }, parent)
end

-- ESTADO

local speedEnabled = false
local speedValue = 24
local flyEnabled = false
local flySpeed = 50
local spinEnabled = false
local spinSpeed = 2

local character, humanoid, root
local attachment, velocity, orientation
local connections = {}

local function cleanupFly()
    if velocity then velocity:Destroy() velocity = nil end
    if orientation then orientation:Destroy() orientation = nil end
    if attachment then attachment:Destroy() attachment = nil end
end

local function setupCharacter(char)
    character = char
    humanoid = char:WaitForChild("Humanoid")
    root = char:WaitForChild("HumanoidRootPart")

    humanoid.WalkSpeed = speedEnabled and speedValue or 16

    cleanupFly()

    if flyEnabled then
        flyEnabled = false
    end
end

if Player.Character then
    task.spawn(setupCharacter, Player.Character)
end

Player.CharacterAdded:Connect(setupCharacter)

local function applySpeed()
    if humanoid then
        humanoid.WalkSpeed = speedEnabled and speedValue or 16
    end
end

-- GUI

local gui = make("ScreenGui", {
    Name = "GreatKingPremium",
    ResetOnSpawn = false,
    IgnoreGuiInset = true,
    DisplayOrder = 20
}, PlayerGui)

local main = make("Frame", {
    Name = "Main",
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.fromScale(0.5, 0.5),
    Size = UDim2.fromOffset(620, 460),
    BackgroundColor3 = C.bg,
    BorderSizePixel = 0
}, gui)

corner(main, 18)
outline(main, C.blue)

make("UISizeConstraint", {
    MinSize = Vector2.new(310, 350),
    MaxSize = Vector2.new(620, 600)
}, main)

local header = make("Frame", {
    Size = UDim2.new(1, 0, 0, 65),
    BackgroundColor3 = C.panel,
    BorderSizePixel = 0
}, main)
corner(header, 18)

label(header, "兔  GREAT KING", UDim2.new(0, 20, 0, 0),
    UDim2.new(1, -80, 1, 0), 21, C.blue).Font =
    Enum.Font.GothamBold

local close = make("TextButton", {
    Position = UDim2.new(1, -49, 0, 13),
    Size = UDim2.fromOffset(36, 36),
    BackgroundColor3 = C.card,
    Text = "×",
    TextSize = 24,
    TextColor3 = C.white,
    Font = Enum.Font.Gotham,
    AutoButtonColor = false
}, header)
corner(close, 10)

local sidebar = make("Frame", {
    Position = UDim2.new(0, 12, 0, 77),
    Size = UDim2.new(0, 145, 1, -89),
    BackgroundColor3 = C.panel
}, main)
corner(sidebar, 12)

local content = make("Frame", {
    Position = UDim2.new(0, 169, 0, 77),
    Size = UDim2.new(1, -181, 1, -89),
    BackgroundTransparency = 1
}, main)

local pages = {}
local tabs = {}
local activePage

local function createPage(id, title, subtitle)
    local page = make("ScrollingFrame", {
        Name = id,
        Size = UDim2.fromScale(1, 1),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ScrollBarThickness = 3,
        ScrollBarImageColor3 = C.blue,
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        CanvasSize = UDim2.new(),
        Visible = false
    }, content)

    make("UIListLayout", {
        Padding = UDim.new(0, 10),
        SortOrder = Enum.SortOrder.LayoutOrder
    }, page)

    label(page, title, UDim2.new(), UDim2.new(1, -5, 0, 34),
        22, C.white).Font = Enum.Font.GothamBold

    label(page, subtitle, UDim2.new(),
        UDim2.new(1, -5, 0, 25), 12, C.muted)

    pages[id] = page
    return page
end

local function showPage(id)
    activePage = id

    for name, page in pairs(pages) do
        page.Visible = name == id
    end

    for name, tab in pairs(tabs) do
        animate(tab, {
            BackgroundColor3 = name == id and C.hover or C.panel,
            TextColor3 = name == id and C.blue or C.muted
        })
    end
end

local function createTab(id, text, order)
    local tab = make("TextButton", {
        Position = UDim2.new(0, 8, 0, 12 + (order - 1) * 49),
        Size = UDim2.new(1, -16, 0, 41),
        BackgroundColor3 = C.panel,
        Text = text,
        TextSize = 11,
        TextColor3 = C.muted,
        Font = Enum.Font.GothamBold,
        AutoButtonColor = false
    }, sidebar)

    corner(tab, 9)
    tabs[id] = tab
    tab.Activated:Connect(function()
        showPage(id)
    end)
end

local function card(parent, height)
    local f = make("Frame", {
        Size = UDim2.new(1, -3, 0, height),
        BackgroundColor3 = C.card
    }, parent)
    corner(f, 12)
    outline(f)
    return f
end

local function toggle(parent, title, initial, callback)
    local f = card(parent, 58)

    label(f, title, UDim2.new(0, 13, 0, 0),
        UDim2.new(1, -78, 1, 0), 13, C.white)

    local btn = make("TextButton", {
        Position = UDim2.new(1, -57, 0.5, -12),
        Size = UDim2.fromOffset(44, 24),
        BackgroundColor3 = initial and C.blue or C.hover,
        Text = "",
        AutoButtonColor = false
    }, f)
    corner(btn, 20)

    local knob = make("Frame", {
        Position = initial and UDim2.new(1, -21, 0, 3)
            or UDim2.new(0, 3, 0, 3),
        Size = UDim2.fromOffset(18, 18),
        BackgroundColor3 = C.white
    }, btn)
    corner(knob, 20)

    local enabled = initial

    btn.Activated:Connect(function()
        enabled = not enabled

        animate(btn, {
            BackgroundColor3 = enabled and C.blue or C.hover
        })
        animate(knob, {
            Position = enabled and UDim2.new(1, -21, 0, 3)
                or UDim2.new(0, 3, 0, 3)
        })

        callback(enabled)
    end)
end

local function slider(parent, title, minValue, maxValue, default, callback)
    local f = card(parent, 82)

    label(f, title, UDim2.new(0, 13, 0, 5),
        UDim2.new(1, -70, 0, 25), 12, C.white)

    local number = label(f, tostring(default),
        UDim2.new(1, -55, 0, 5), UDim2.new(0, 42, 0, 25),
        12, C.blue)
    number.TextXAlignment = Enum.TextXAlignment.Right

    local bar = make("TextButton", {
        Position = UDim2.new(0, 13, 0, 48),
        Size = UDim2.new(1, -26, 0, 8),
        BackgroundColor3 = C.hover,
        Text = "",
        AutoButtonColor = false
    }, f)
    corner(bar, 10)

    local percent = (default - minValue) / (maxValue - minValue)
    local fill = make("Frame", {
        Size = UDim2.new(percent, 0, 1, 0),
        BackgroundColor3 = C.blue
    }, bar)
    corner(fill, 10)

    local dragging = false

    local function update(x)
        local p = math.clamp(
            (x - bar.AbsolutePosition.X) / bar.AbsoluteSize.X, 0, 1
        )
        local value = math.floor(
            minValue + p * (maxValue - minValue) + 0.5
        )

        number.Text = tostring(value)
        fill.Size = UDim2.new(p, 0, 1, 0)
        callback(value)
    end

    bar.Activated:Connect(function()
        update(UIS:GetMouseLocation().X)
    end)

    bar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            update(input.Position.X)
        end
    end)

    local moveConnection = UIS.InputChanged:Connect(function(input)
        if dragging and (
            input.UserInputType == Enum.UserInputType.MouseMovement
            or input.UserInputType == Enum.UserInputType.Touch
        ) then
            update(input.Position.X)
        end
    end)

    local endConnection = UIS.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)

    table.insert(connections, moveConnection)
    table.insert(connections, endConnection)
end

-- PÁGINAS

local home = createPage("Home", "Visão geral", "GREAT KING • PREMIUM")
local characterPage = createPage("Character", "Personagem",
    "Movimento do seu personagem")
local visualPage = createPage("Visual", "Interface",
    "Personalização do painel")

createTab("Home", "⌂   INÍCIO", 1)
createTab("Character", "◇   PERSONAGEM", 2)
createTab("Visual", "◈   VISUAL", 3)

local welcome = card(home, 90)
label(welcome, "Bem-vindo ao Great King",
    UDim2.new(0, 14, 0, 12), UDim2.new(1, -25, 0, 30),
    17, C.blue).Font = Enum.Font.GothamBold
label(welcome, "Painel de controle do seu personagem.",
    UDim2.new(0, 14, 0, 45), UDim2.new(1, -25, 0, 25),
    12, C.muted)

toggle(characterPage, "Ativar velocidade", false, function(state)
    speedEnabled = state
    applySpeed()
end)

slider(characterPage, "Velocidade de caminhada", 16, 100, speedValue,
    function(value)
        speedValue = value
        applySpeed()
    end)

toggle(characterPage, "Ativar voo", false, function(state)
    flyEnabled = state
    cleanupFly()

    if not state or not root or not root.Parent then
        return
    end

    attachment = Instance.new("Attachment")
    attachment.Name = "GreatKingFlightAttachment"
    attachment.Parent = root

    velocity = Instance.new("LinearVelocity")
    velocity.Name = "GreatKingFlightVelocity"
    velocity.Attachment0 = attachment
    velocity.RelativeTo = Enum.ActuatorRelativeTo.World
    velocity.VelocityConstraintMode =
        Enum.VelocityConstraintMode.Vector
    velocity.MaxForce = 100000
    velocity.VectorVelocity = Vector3.zero
    velocity.Parent = root

    orientation = Instance.new("AlignOrientation")
    orientation.Attachment0 = attachment
    orientation.Mode = Enum.OrientationAlignmentMode.OneAttachment
    orientation.MaxTorque = 100000
    orientation.Responsiveness = 15
    orientation.Parent = root
end)

slider(characterPage, "Velocidade de voo", 10, 100, flySpeed,
    function(value)
        flySpeed = value
    end)

toggle(characterPage, "Rotação contínua", false, function(state)
    spinEnabled = state
end)

slider(characterPage, "Velocidade de rotação", 1, 10, spinSpeed,
    function(value)
        spinSpeed = value
    end)

toggle(visualPage, "Mostrar contorno do personagem",
    false, function(state)
        local char = Player.Character
        if not char then return end

        local highlight = char:FindFirstChild("GK_Highlight")

        if state and not highlight then
            highlight = Instance.new("Highlight")
            highlight.Name = "GK_Highlight"
            highlight.FillColor = C.blue
            highlight.OutlineColor = C.blue
            highlight.FillTransparency = 0.85
            highlight.Parent = char
        elseif not state and highlight then
            highlight:Destroy()
        end
    end)

showPage("Home")

-- VOO E ROTAÇÃO

local renderConnection = RunService.RenderStepped:Connect(function(dt)
    if not root or not root.Parent then return end

    if flyEnabled and velocity then
        local camera = workspace.CurrentCamera
        if not camera then return end

        local direction = Vector3.zero

        if UIS:IsKeyDown(Enum.KeyCode.W) then
            direction += camera.CFrame.LookVector
        end
        if UIS:IsKeyDown(Enum.KeyCode.S) then
            direction -= camera.CFrame.LookVector
        end
        if UIS:IsKeyDown(Enum.KeyCode.A) then
            direction -= camera.CFrame.RightVector
        end
        if UIS:IsKeyDown(Enum.KeyCode.D) then
            direction += camera.CFrame.RightVector
        end
        if UIS:IsKeyDown(Enum.KeyCode.Space) then
            direction += Vector3.yAxis
        end
        if UIS:IsKeyDown(Enum.KeyCode.LeftControl) then
            direction -= Vector3.yAxis
        end

        velocity.VectorVelocity = direction.Magnitude > 0
            and direction.Unit * flySpeed
            or Vector3.zero

        if humanoid then
            humanoid:ChangeState(Enum.HumanoidStateType.Physics)
        end
    end

    if spinEnabled and humanoid and not flyEnabled then
        root.CFrame = root.CFrame
            * CFrame.Angles(0, math.rad(spinSpeed * 60 * dt), 0)
    end
end)

table.insert(connections, renderConnection)

-- ARRASTAR JANELA

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

UIS.InputChanged:Connect(function(input)
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

UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
        draggingWindow = false
    end
end)

-- BOTÃO FLUTUANTE

local floating = make("TextButton", {
    Position = UDim2.new(0, 18, 0.5, -28),
    Size = UDim2.fromOffset(56, 56),
    BackgroundColor3 = C.panel,
    Text = "兔",
    TextColor3 = C.blue,
    TextSize = 28,
    Font = Enum.Font.GothamBold,
    Visible = false,
    AutoButtonColor = false
}, gui)
corner(floating, 18)
outline(floating, C.blue)

floating.Activated:Connect(function()
    main.Visible = not main.Visible
    floating.Visible = not main.Visible
end)

close.Activated:Connect(function()
    main.Visible = false
    floating.Visible = true
end)
