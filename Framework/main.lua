-- load utilities
function typeof(thing)
    local t = typeof(thing)

    return t == "table" and thing.__type or t
end

math = require("Framework/Util/Math")
string = require("Framework/Util/String")
table = require("Framework/Util/Table")

Serializer = require("Framework/Util/Serializer")
Directory = require("Framework/Util/Directory")
Instance = require("Framework/Util/Instance")

-- load datatypes
ColorSequence = require("Framework/Classes/Datatypes/ColorSequence")
Datastore = require("Framework/Classes/Datatypes/Datastore")
NumberRange = require("Framework/Classes/Datatypes/NumberRange")
NumberSequence = require("Framework/Classes/Datatypes/NumberSequence")
UDim = require("Framework/Classes/Datatypes/UDim")
UDim2 = require("Framework/Classes/Datatypes/UDim2")
Color = require("Framework/Classes/Datatypes/Color")
Vector = require("Framework/Classes/Datatypes/Vector")

-- load basic classes
require("Framework/Classes/Instances/Maid")
require("Framework/Classes/Instances/Signal")

-- load instances
Directory.RecurseRequire("Framework", {"Framework/main.lua"})

-- load globals
GuiInputBegan = Instance.new("Signal")
GuiInputEnded = Instance.new("Signal")
InputBegan = Instance.new("Signal")
InputEnded = Instance.new("Signal")

LovrUpdate = Instance.new("Signal")
LovrDraw = Instance.new("Signal")