local module = {}
module.__index = module
module.__type = "BasePart"
module.__parent = "Framework/Classes/Instances/InstanceBase"

module.new = function(...)
	local self = setmetatable(module.Base.new(...), module)
    self.Position = Vector.new(0, 0, 0)
    self.Size = Vector.new(1, 1, 1)
    self.Orientation = Vector.new(0, 0, 0, 0)

    self.Maid:GiveTask(self.Maid:GiveTask(self.Scene.Draw:Connect(function(pass)
        self:Render(pass)
    end)))

	return self
end

function module:Render(pass)
    pass:setColor(1,1,1,1)
    pass:box(self.Position:GetVector(), self.Size:GetVector(), self.Orientation:GetQuat(), "fill")
end

Instance.RegisterClass(module)

return module