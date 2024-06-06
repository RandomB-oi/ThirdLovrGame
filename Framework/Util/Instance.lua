local module = {}

module.Classes = {}
function module.GetClass(className)
    return module.Classes[className]
end

module.RegisterClass = function(class)
    local className = rawget(class, "__type")
    assert(not module.GetClass(className), className.." is already registered")
    local parentClassPath = rawget(class, "__parent")

    if parentClassPath then
        local base = require(parentClassPath)
        rawset(class, "Base", base)
        setmetatable(class, base)
    end

    module.Classes[className] = class
end

module.new = function(className, ...)
    local objectClass = module.GetClass(className)
    assert(objectClass, "Class "..className.." doesn't exist")

    local newObject = objectClass.new(...)
    
    local initFunction = newObject.InitInstance
    if initFunction then
        initFunction(newObject)
    end

    return newObject
end

return module