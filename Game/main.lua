local shader = lovr.graphics.newShader("Game/Shaders/vertex.vs", "Game/Shaders/fragment.fs", {})

-- light x,y,z,range, r,g,b,a
local light = {
    Transform = Vector.new(0,0,0, 10),
    Color = Vector.new(1,1,1, 2),
}

local function MainShaderPass(pass)
    pass:setShader(shader)
    pass:send('ambience', { 70/255, 70/255, 70/255, 1.0 })
    pass:send('fogColor', { 147/255, 204/255, 234/255, 1.0 })
    pass:send('fogStart', 2)
    pass:send('fogEnd', 30)

    pass:send("sunDirection", { -0.558276355266571, 0.727559506893158, -0.39872872829437256 })
    pass:send("sunLightColor", { 0.5, 0.5, 0.5, 1.0 })

    local width, height = lovr.system.getWindowDimensions()
    pass:send("screenWidth", width)
    pass:send("screenHeight", height)
end

local mainScene = Instance.new("Scene", "MainScene")
mainScene:Enable()
mainScene:Unpause()
mainScene.ApplyShader = MainShaderPass

mainScene.Camera.Position.z = 3
mainScene.Camera.Rotation.y = math.pi/2

local part1 = Instance.new("BasePart", mainScene)
-- part1.Color = Vector.new(1,0,0, 1)

part1.Color.yz = Vector.new(0, 0)
part1.Position = Vector.new(0, 0, 0)