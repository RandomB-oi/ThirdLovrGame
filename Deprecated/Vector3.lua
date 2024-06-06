local module = {}
module.__index = module
module.__type = "Vector"

local function isNumber(x)
	return type(x) == "number"
end

module.new = function(x, y)
	local self = setmetatable({
		X = x or 0,
		Y = y or 0
	}, module)
	return self
end

function module:LengthSquared()
	return self.X^2 + self.Y^2
end

function module:Length()
	return math.sqrt(self:LengthSquared())
end

function module:Unit()
	return self/self:Length()
end

module.FromAngle = function(angle) -- in radians
	return module.new(math.sin(angle), -math.cos(angle))
end

function module:GetAngle()
	return math.atan2(-self.Y, self.X)
end

function module:Copy()
	return module.new(self.X, self.Y)
end

function module:__add(other)
	if type(self) == "number" then
		return other + self
	end
	return module.new(self.X + other.X, self.Y + other.Y)
end

function module:__sub(other)
	if type(self) == "number" then
		return other - self
	end
	return module.new(self.X - other.X, self.Y - other.Y)
end

function module:__unm(other)
	return module.new(-self.X, -self.Y)
end

function module:__mul(other)
	if isNumber(self) then
		return other * self
	end
	if isNumber(other) then
		return module.new(self.X * other, self.Y * other)
	end
	return module.new(self.X * other.X, self.Y * other.Y)
end

function module:__div(other)
	if isNumber(self) then
		return other / self
	end
	
	if isNumber(other) then
		return module.new(self.X / other, self.Y / other)
	end
	return module.new(self.X / other.X, self.Y / other.Y)
end

function module:__lt(other)
	return self.X < other.X and self.Y < other.Y
end

function module:__le(other)
	return self.X <= other.X and self.Y <= other.Y
end

function module:__eq(other)
	return self.X == other.X and self.Y == other.Y and self.Z == other.Z
end

function module:__tostring()
    return tostring(self.X)..", "..tostring(self.Y)..", "..tostring(self.Z)
end

function module:GetVector()
	return lovr.math.newVec3(self.X, self.Y, self.Z)
end

return module