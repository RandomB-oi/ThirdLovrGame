local shader = lovr.graphics.newShader("Game/Shaders/vertex.vs", "Game/Shaders/fragment.fs", {})

-- light x,y,z,range, r,g,b,a
local light = {
    Transform = Vector.new(0,0,0, 10),
    Color = Vector.new(1,1,1, 2),
}

local skybox = lovr.graphics.newTexture(
    {
        right = 'Game/Textures/sky512_rt.png',
        left = 'Game/Textures/sky512_lf.png',
        top = 'Game/Textures/sky512_up.png',
        bottom = 'Game/Textures/sky512_dn.png',
        back = 'Game/Textures/sky512_bk.png',
        front = 'Game/Textures/sky512_ft.png'
    },
    {type = "cube"}
)

local function ApplyShaders(pass)
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

LovrDraw:Connect(function(pass)
    pass:skybox(skybox)
    ApplyShaders(pass)
end)



local mainScene = Instance.new("Scene", "MainScene")
mainScene:Enable()
mainScene:Unpause()


local part = Instance.new("BasePart", mainScene)



local firstVector = Vector.new(10,20,30,40)