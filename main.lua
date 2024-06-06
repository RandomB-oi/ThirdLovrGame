function lovr.load()
    require("Framework/main")
    require("Game/main")

    function lovr.update(dt)
        LovrUpdate:Fire(dt)
    end
    function lovr.draw(pass)
        LovrDraw:Fire(pass)
    end
end