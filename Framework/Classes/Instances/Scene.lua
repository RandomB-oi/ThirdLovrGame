local module = {}
module.__index = module
module.__type = "Scene"

module.All = {}

local DefaultSkybox = lovr.graphics.newTexture(
    {
        right = 'Framework/Textures/DefaultSkybox/sky512_rt.png',
        left = 'Framework/Textures/DefaultSkybox/sky512_lf.png',
        top = 'Framework/Textures/DefaultSkybox/sky512_up.png',
        bottom = 'Framework/Textures/DefaultSkybox/sky512_dn.png',
        back = 'Framework/Textures/DefaultSkybox/sky512_bk.png',
        front = 'Framework/Textures/DefaultSkybox/sky512_ft.png'
    },
    {type = "cube"}
)

module.new = function(name)
	if module.All[name] then
		return module.All[name]
	end

	local self = setmetatable({}, module)
	self.Name = name

	self.Skybox = DefaultSkybox
	self.ApplyShader = function(pass)
	end
	
	self.IsPaused = false
	self.Enabled = true
	
	self.Update = Instance.new("Signal")
	self.Draw = Instance.new("Signal")
	-- self.GuiDraw = Instance.new("Signal")
	
	-- self.GuiInputBegan = Instance.new("Signal")
	-- self.GuiInputEnded = Instance.new("Signal")
	-- self.InputBegan = Instance.new("Signal")
	-- self.InputEnded = Instance.new("Signal")
	
	self.Maid = Instance.new("Maid")
	
	self.Maid:GiveTask(self.Update)
	self.Maid:GiveTask(self.Draw)
	-- self.Maid:GiveTask(self.GuiDraw)

	-- self.Maid:GiveTask(self.GuiInputBegan)
	-- self.Maid:GiveTask(self.GuiInputEnded)
	-- self.Maid:GiveTask(self.InputBegan)
	-- self.Maid:GiveTask(self.InputEnded)

	module.All[name] = self
	self.Maid:GiveTask(function()
		module.All[name] = nil
	end)
	self.Maid.Draw = LovrDraw:Connect(function(pass)
		if self.Enabled then
			pass:setColor(1,1,1,1)
			self.Camera:Render(pass)

			if self.Skybox then
				pass:skybox(self.Skybox)
			end
			if self.ApplyShader then
				self.ApplyShader(pass)
			end

			self.Draw:Fire(pass)

			if self.ApplyShader then
				pass:setShader(nil)
			end
		end
	end)
	self.Maid.Update = LovrUpdate:Connect(function(...)
		if self.Enabled and not self.IsPaused then
			self.Camera:Turn(0, 0)
			self.Update:Fire(...)
		end
	end)

	self.Camera = Instance.new("Camera", self) -- defined down here, because the camera class binds the connections right when its made
	
	-- self.Maid.GuiInputBegan = GuiInputBegan:Connect(function(...) if self.Enabled and not self.IsPaused then self.GuiInputBegan:Fire(...) end end)
	-- self.Maid.GuiInputEnded = GuiInputEnded:Connect(function(...) if self.Enabled and not self.IsPaused then self.GuiInputEnded:Fire(...) end end)
	-- self.Maid.InputBegan = InputBegan:Connect(function(...) if self.Enabled and not self.IsPaused then self.InputBegan:Fire(...) end end)
	-- self.Maid.InputEnded = InputEnded:Connect(function(...) if self.Enabled and not self.IsPaused then self.InputEnded:Fire(...) end end)

	-- self.Camera = Instance.new("camera", self)
	-- self.Maid:GiveTask(self.camera)

	return self
end

function module:Pause()
	self.IsPaused = true
end
function module:Unpause()
	self.IsPaused = false
end
function module:Enable()
	self.Enabled = true
end
function module:Disable()
	self.Enabled = false
end

function module:Destroy()
	self.Maid:Destroy()
end

Instance.RegisterClass(module)

return module