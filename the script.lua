-- // Locals
local Players = game.Players
local Lp = Players.LocalPlayer
local FullBright = false
local InfStam = false
local Fall = false
local Barb = false
local noJump = false
local noRecoil = false
local Mouse = Lp:GetMouse()
local Fovcircle = false
local HBE = false

-- // TABLES
local Bright
local BarbFall
local StaminaInf


StaminaInf = hookfunction(getupvalue(getrenv()._G.S_Take,2),function(v1,...)
    if (InfStam) then
        v1 = 0
    end
    return StaminaInf(v1,...)
end)

local gunModder
gunModder = hookmetamethod(game, "__index", function(name,value)
    if (noRecoil and not checkcaller() and tostring(name) == "AimNum" and value == "Value") then
        return 0
    end
    if (not checkcaller() and name:IsA("Part") and value == "Size") then
        if (gunModder(name, "Name") == "Head") then
            return Lp.Character.Head.Size
        end
    end
    return gunModder(name,value)
end)

Bright = hookmetamethod(game, "__newindex", function(t,b,k)
    if (FullBright and not checkcaller() and t == game.Lighting and b == "Ambient") then
        k = Color3.new(0.9,0.9,0.9)
    end
    if (noJump and not checkcaller() and t:IsDescendantOf(game.Players.LocalPlayer.Character) and b == "Jump" and k == false) then
        return
    end
    return Bright(t,b,k)
end)

BarbFall = hookmetamethod(game, "__namecall", function(Name,...)
    local Args = {...}
    local Method = getnamecallmethod()
    if (Fall) then
        if Method == "FireServer" and tostring(Name) == "__DFfDD" and Args[1] == "FlllD" then
            return
        end
    end
    if (Barb) then
        if Method == "FireServer" and tostring(Name) == "__DFfDD" and Args[1] == "BHHh" then
            return
        end
    end
    return BarbFall(Name,...)
end)

game:GetService'RunService'.RenderStepped:Connect(function()
    for i,v in next, game.Players:GetPlayers() do
        if (v ~= Lp and v.Character and v.Character:FindFirstChild("Head")) then
            if (HBE and v.Character:FindFirstChild("Head")) then
                v.Character.Head.Size = Vector3.new(5,5,5)
                v.Character.Head.Transparency = 0.5
            else
                v.Character.Head.Size = Lp.Character.Head.Size
                v.Character.Head.Transparency = 0
            end
        end
    end
end)


-- // Fov circle
local Circle = Drawing.new("Circle")
Circle.Thickness = 1
Circle.NumSides = 15
Circle.Radius = 1
Circle.Filled = false
Circle.Color = Color3.fromRGB(255,255,255)
Circle.Visible = false


game.RunService.RenderStepped:Connect(function()
    Circle.Position = Vector2.new(Mouse.X, Mouse.Y + 35)
end)

-- // ESP
local Esp = loadstring(game:HttpGet("https://raw.githubusercontent.com/HUJEHJIO3EU5HGU9IW3HNWEUJHNWI/my-esp/masterrr/esp_lib.lua"))()
Esp.UseText = false
Esp.Distance = false
Esp.Boxes = false

-- // UI
local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/HUJEHJIO3EU5HGU9IW3HNWEUJHNWI/myUIlib/masterrr/source"))()

library.theme.background = "rbxassetid://0"
library.theme.accentcolor = Color3.fromRGB(255,0,0)
library.theme.accentcolor2 = Color3.fromRGB(255,0,0)

local window = library:CreateWindow("Fucker",Vector2.new(492, 598), Enum.KeyCode.Home)

local maintab = window:CreateTab("Criminality")
local mainsec = maintab:CreateSector("Main", "left")
mainsec:AddToggle("Fov",false,function(state)
    Circle.Visible = state
    Fovcircle = state
end)
mainsec:AddSlider("Radius",1,50,500,false,function(value)
    Circle.Radius = value
end)
mainsec:AddSlider("Shapes",3,15,100,false,function(value)
    Circle.NumSides = value
end)
mainsec:AddToggle("FullBright",false,function(state)
    FullBright = state
end)
mainsec:AddToggle("Inf Stam",false,function(state)
    InfStam = state
end)
mainsec:AddToggle("No Fall Damage",false,function(state)
    Fall = state
end)
mainsec:AddToggle("Anti Barbwire",false,function(state)
    Barb = state
end)
mainsec:AddToggle("No Jump cooldown",false,function(state)
    noJump = state
end)
mainsec:AddToggle("No Recoil",false,function(state)
    noRecoil = state
end)
mainsec:AddToggle("HBE",false,function(state)
    HBE = state
end)
mainsec:AddToggle("Esp",false,function(state)
    Esp:Toggle(state)
end)
mainsec:AddToggle("Names",false,function(state)
    Esp.UseText = state
    Esp.Distance = state
end)
