local module = {}

function module.clamp(x,a,b)
	return x < a and a or x > b and b or x
end
function module.round(x)
	return math.floor(x + 0.5)
end

function module.DecimalToBinary(length, decimal)
	if decimal == 0 then
		return string.rep("0", length)
	end
	
	local binary = ""
	while decimal > 0 do
		binary = tostring(decimal % 2) .. binary
		decimal = math.floor(decimal / 2)
	end
	binary = string.rep("0", length - binary:len()) .. binary

	return binary
end

function module.BinaryToDecimal(binaryNumber)
	return tonumber(binaryNumber, 2)
end

function module.BoolListToDecimal(binaryList)
	local total = 0
	local binaryAmount = 1
	for i = #binaryList, 1, -1 do
		if binaryList[i] then
			total = total + binaryAmount
		end
		binaryAmount = binaryAmount * 2
	end
	return total
end



for i,v in pairs(math) do
	if not module[i] then
		module[i] = v
	end
end

return module