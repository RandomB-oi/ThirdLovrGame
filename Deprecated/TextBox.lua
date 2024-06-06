local module = {}
module.__index = module
module.__type = "TextBox"
module.Derives = "Classes/Instances/TextLabel"

-- defaultFont = lovr.graphics.newFont(64,"normal")

NewFocus = Instance.new("Signal")

local upperReplace = {
    ["1"] = "!",
    ["2"] = "@",
    ["3"] = "#",
    ["4"] = "$",
    ["5"] = "%",
    ["6"] = "^",
    ["7"] = "&",
    ["8"] = "*",
    ["9"] = "(",
    ["0"] = ")",
    ["["] = "{",
    ["]"] = "}",
    [";"] = ":",
    ["'"] = '"',
    [","] = "<",
    ["."] = ">",
    ["/"] = "?",
    ["-"] = "_",
    ["="] = "+",
    ["`"] = "~",
}

module.new = function(self)
	self.Clicked:Connect(function()
        self.Scene.Maid.TextboxInputBegan = self.Scene.GuiInputBegan:Connect(function(key, isMouse)
            if isMouse and key == 1 and not self:IsHovering() then
                self:ReleaseFocus()
                return
            end
            if isMouse then return end

            if key == "return" then
                self:ReleaseFocus()
                return
            elseif key == "backspace" then
                self:SetText(self.CurrentText:sub(1, self.CurrentText:len()-1))
            elseif key == "lctrl" or key == "rctrl" or key == "lshift" or key == "rshift" then

            elseif key == "space" then
                self:SetText(self.CurrentText.." ")
            else
                if lovr.keyboard.isDown("lshift") or lovr.keyboard.isDown("rshift") then
                    key = upperReplace[key] or key:upper()
                end
                self:SetText(self.CurrentText..key)
            end
            return
        end, 1)
    end, 2)
	
	return self
end

function module:ReleaseFocus()
    self.Scene.Maid.TextboxInputBegan = nil
end

Instance.RegisterClass(module)

return module