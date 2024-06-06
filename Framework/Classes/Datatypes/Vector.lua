local module = {}
module.__type = "Vector"

local function isNumber(x)
	return type(x) == "number"
end

local vectorComponentOrder = {
    "x","y","z","w"
}

module.__index = function(self, index)
    local moduleHas = rawget(module, index)
    if moduleHas then
        return moduleHas
    end

    if isNumber(index) then
        return rawget(self, index)
    end

    local componentOrder = {}
    for i = 1, index:len() do
        local orderValue = table.find(vectorComponentOrder, index:sub(i,i):lower())
        if orderValue then
            componentOrder[i] = self[orderValue]
        end
    end

    if #componentOrder <= 1 then return componentOrder[1] end

    return module.new(table.unpack(componentOrder))
end

module.__newindex = function(self, index, value)
    if rawequal(self, module) then
        rawset(self, index, value)
        return
    end

    if isNumber(index) then
        rawset(self, index, value)
    else
        -- local orderValue = table.find(vectorComponentOrder, index:lower())
        -- if orderValue then
        --     rawset(self, orderValue, value)
        -- end
        
        local valIsNumber = isNumber(value)
        for i = 1, index:len() do
            local orderValue = table.find(vectorComponentOrder, index:sub(i,i):lower())
            if orderValue then
                rawset(self, orderValue, valIsNumber and value or value[i])
            end
        end
    end
end

module.new = function(...)
	local self = setmetatable({...}, module)
	return self
end

function module:LengthSquared()
    local total = 0
    for _,v in ipairs(self) do
        total = total + v ^ 2
    end
	return total
end

function module:Length()
    local totalComps = #self
	return self:LengthSquared() ^ (1/totalComps)
end

function module:Unit()
	return self/self:Length()
end

function module:Copy()
	return module.new(self:Unpack())
end

function module:__add(other)
    local new = self:Copy()
    for i, v in ipairs(other) do
        new[i] = new[i] + v
    end
	return new
end

function module:__sub(other)
    local new = self:Copy()
    for i, v in ipairs(other) do
        new[i] = new[i] - v
    end
	return new
end

function module:__unm(other)
    local inverted = {}
    for i,v in ipairs(self) do
        inverted[i] = -v
    end
	return module.new(table.unpack(inverted))
end

function module:__mul(other)
    local new = self:Copy()

    if isNumber(other) then
        for i, v in ipairs(new) do
            new[i] = new[i] * other
        end
    else
        for i, v in ipairs(other) do
            new[i] = new[i] * v
        end
    end
   
	return new
end

function module:__div(other)
    local new = self:Copy()
    if isNumber(other) then
        for i, v in ipairs(new) do
            new[i] = new[i] * other
        end
    else
        for i, v in ipairs(other) do
            new[i] = new[i] * v
        end
    end
   
	return new
end

function module:__lt(other)
    for i, v in ipairs(other) do
        if v >= self[i] then
            return false
        end
    end
    return true
end

function module:__le(other)
    for i, v in ipairs(other) do
        if v > self[i] then
            return false
        end
    end
    return true
end

function module:__eq(other)
    for i, v in ipairs(other) do
        if v ~= self[i] then
            return false
        end
    end
    return true
end

function module:__tostring()
    return table.concat(self, ", ")
end

local defaultVectors = {
    [2] = lovr.math.newVec2,
    [3] = lovr.math.newVec3,
    [4] = lovr.math.newVec4,
}

function module:GetQuat()
    return lovr.math.newQuat(self:Unpack())
end

function module:GetVector()
    return defaultVectors[#self](self:Unpack())
end

function module:Unpack()
    return table.unpack(self)
end

return module