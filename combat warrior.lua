

local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/HUJEHJIO3EU5HGU9IW3HNWEUJHNWI/sdsdsadsdsdsdsds/masterrr/UI.lua"))()

library.theme.background = "rbxassetid://0"
library.theme.accentcolor = Color3.fromRGB(86,0,232)
library.theme.accentcolor2 = Color3.fromRGB(86,0,232)

local window = library:CreateWindow("leanhook", Vector2.new(492, 598), Enum.KeyCode.End)


local Lp = game:GetService'Players'.LocalPlayer
local Character = Lp.Character
local HBE = false
local HBESlider = Vector3.new(10,10,10)
local hbeColor = Color3.fromRGB(255,255,255)

-- // Hitbox
game:GetService'RunService'.RenderStepped:Connect(function()
    for i,v in next, game:GetService'Players':GetPlayers() do
        if v ~= Lp then
            pcall(function()
                if (v.Character and v.Character:FindFirstChild("HumanoidRootPart")) then
                    if (HBE and v.Character and v.Character:FindFirstChild("HumanoidRootPart")) then
                        v.Character.HumanoidRootPart.Size = HBESlider
                        v.Character.HumanoidRootPart.Transparency = 0.5
                        v.Character.HumanoidRootPart.Color = hbeColor
                    else
                        v.Character.HumanoidRootPart.Size = Lp.Character.HumanoidRootPart.Size
                        v.Character.HumanoidRootPart.Transparency = Lp.Character.HumanoidRootPart.Transparency
                        v.Character.HumanoidRootPart.Color = Lp.Character.HumanoidRootPart.Color
                    end
                end
            end)
        end
    end
end)

-- // Bypass
local noFall = false
local noJumpcod = false
local WsBypass = false
local infStam = false
local JpBypass = false

local BypassTable = {
    WalkSpeed = 16,
    JumpPower = 50
}

local Bypass
local Bypass2
local Bypass3

-- // Spoofs shit so it doesnt detect.
Bypass = hookmetamethod(game, "__index", function(Tab, Key)
    if (not checkcaller() and Tab:IsA("Humanoid") and (Key == "WalkSpeed" or Key == "JumpPower")) then
        return BypassTable[Key]
    end

    return Bypass(Tab, Key)
end)


-- // Trying to change Walkspeed shit
Bypass2 = hookmetamethod(game, "__newindex", function (Tab, Key, Value)
    if (not checkcaller() and Tab:IsA("Humanoid") and (Key == "WalkSpeed" or Key == "JumpPower")) then
        BypassTable[Key] = Value

        return
    end
    return Bypass2(Tab, Key, Value)
end)

Bypass3 = hookmetamethod(game, "__namecall", function(Self,...)
    local Args = {...}
    local Method = getnamecallmethod()
    if (noFall and Method == "FireServer" and tostring(Self) == "" and typeof(Args[2] == "Vector3")) then
        return
    end
    return Bypass3(Self,...)
end)

--[[
    -- Script generated by SimpleSpy - credits to exx#9394

local args = {
    [1] = 26.464847602622193,
    [2] = Vector3.new(0.25952857732772827, -0.9645774364471436, -0.04728052392601967)
}

game:GetService("ReplicatedStorage").Communication.Events:FindFirstChild(""):FireServer(unpack(args))

]]


-- // ESP
local Esp = loadstring(game:HttpGet("https://raw.githubusercontent.com/HUJEHJIO3EU5HGU9IW3HNWEUJHNWI/my-esp/masterrr/esp_lib.lua"))()
Esp.UseText = false
Esp.Distance = false
Esp.Boxes = false
Esp.FaceCamera = false
Esp.TeamMates = false
Esp.Players = false
Esp.Tracers = false
Esp.Color = Color3.fromRGB(255,255,255)
Esp.TextC3 = Color3.fromRGB(255,255,255)


local maintab = window:CreateTab("Combat Warriors")
local configtab = window:CreateTab("Config")
configtab:CreateConfigSystem("left")
local mainsec = maintab:CreateSector("Pvp", "left")
local misc = maintab:CreateSector("Misc", "right")
local sliderhbe = mainsec:AddToggle("Hitbox Expander",false,function(s)
    HBE = s
end)
sliderhbe:AddSlider(1,1,10,false,function(v)
    HBESlider = Vector3.new(v,v,v)
end)
sliderhbe:AddColorpicker(Color3.fromRGB(255,255,255),function(c)
    hbeColor = c
end)

local espsec = maintab:CreateSector("Visuals", "left")
local colorEspTog = espsec:AddToggle("ESP",false,function(s)
    Esp:Toggle(s)
end)
colorEspTog:AddColorpicker(Color3.fromRGB(255,255,255),function(c)
    Esp.Color = c
    Esp.TextC3 = c
end)
local keybindBox = espsec:AddToggle("Boxes",false,function(s)
    Esp.Boxes = s
end)
keybindBox:AddKeybind(Enum.KeyCode.G,function(s)
    Esp.Boxes = s
end)
espsec:AddToggle("Names",false,function(s)
    Esp.UseText = s
    Esp.Distance = s
end)
espsec:AddSeperator("")
espsec:AddToggle("Face camera",false,function(s)
    Esp.FaceCamera = s
end)
espsec:AddToggle("Show team",false,function(s)
    Esp.TeamMates = s
end)
espsec:AddToggle("Show players",false,function(s)
    Esp.Players = s
end)
espsec:AddSeperator("")
espsec:AddToggle("Tracers",false,function(s)
    Esp.Tracers = s
end)

-- // MISC
misc:AddToggle("No fall",false,function(s)
    noFall = s
end)
misc:AddSeperator("")
local WsTog = misc:AddToggle("WalkSpeed",false,function(s)
    WsBypass = s
end)
local WsSlider = 16
local JpSlider = 50
local JpTog = misc:AddToggle("JumpPower",false,function(s)
    JpBypass = s
end)
JpTog:AddSlider(50,50,100,false,function(v)
    JpSlider = v
end)

game:GetService'RunService'.RenderStepped:Connect(function()
    if WsBypass then
        Character.Humanoid.WalkSpeed = WsSlider
    else
        Character.Humanoid.WalkSpeed = 16
    end
    if JpBypass then
        Character.Humanoid.JumpPower = JpSlider
    else
        Character.Humanoid.JumpPower = 50
    end
end)

WsTog:AddSlider(16,16,30,false,function(v)
    WsSlider = v
end)
WsTog:AddKeybind(Enum.KeyCode.X,function(s)
    WsBypass = s
end)
JpTog:AddKeybind(Enum.KeyCode.J,function(s)
    JpTog = s
end)

game:GetService'StarterGui':SetCore("SendNotification",{
    Title = "leanhook",
    Text = "This is in beta (Lots of bugs)",
    Icon = "",
    Duration = 5
})
