local module = {}
module.__index = module
module.__type = "Camera"
module.__parent = "Framework/Classes/Instances/InstanceBase"

module.new = function(...)
	local self = setmetatable(module.Base.new(...), module)
	-- self.Fov = math.pi / 2
	self.Fov = math.rad(70)
	self.NearPlane = 0.01

	self.UpVector = Vector.new(0, 1, 0)
	self.Position = Vector.new(0, 0, 0)
	self.Radius = 0.1

	self.Sensitivity = 1.0

	self.RenderPosition = Vector.new(0, 0, 0)

	self.Rotation = {
		x = math.pi/2,
		y = 0,
	}

	self.MinAngle = 0.01
	self.MaxAngle = math.pi - 0.01

	self.Pose = lovr.math.newMat4():target(self.RenderPosition:GetVector(), self.Position:GetVector(), self.UpVector:GetVector())
	self.Projection = nil
	self:UpdateProjection()

	return self
end

function module:Turn(deltaX, deltaY)
	local deltaX = (deltaX or 0) * (self.Sensitivity * 0.0025)
	local deltaY = (deltaY or 0) *-(self.Sensitivity * 0.0025)

	self.Rotation.y = self.Rotation.y + deltaX
	self.Rotation.x = math.clamp(self.Rotation.x + deltaY, self.MinAngle, self.MaxAngle)

	self.RenderPosition.x = self.Position.x + self.Radius * math.sin(self.Rotation.x) * math.cos(self.Rotation.y)
	self.RenderPosition.y = self.Position.y + self.Radius * math.cos(self.Rotation.x)
	self.RenderPosition.z = self.Position.z + self.Radius * math.sin(self.Rotation.x) * math.sin(self.Rotation.y)

	self.Pose:target(self.RenderPosition:GetVector(), self.Position:GetVector(), self.UpVector:GetVector())
end

function module:UpdateProjection()
	local width, height = lovr.system.getWindowDimensions()
	local aspect = width / height
	self.Projection = lovr.math.newMat4():perspective(self.Fov, aspect, self.NearPlane, 0)
end

function module:Render(pass)
	pass:setViewPose(1, self.Pose)
	pass:setProjection(1, self.Projection)
end

Instance.RegisterClass(module)

return module