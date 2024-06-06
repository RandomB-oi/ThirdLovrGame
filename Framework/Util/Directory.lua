local module = {}

module.RecurseRequire = function(directory, ignoreList)
	local tbl = {}

	local directories = {}
	
	for i, fileName in pairs(lovr.filesystem.getDirectoryItems(directory)) do
		local fullName = directory.."/"..fileName
		if not table.find(ignoreList, fullName) then
			local isDirectory do
				if lovr.filesystem.getInfo then
					isDirectory = lovr.filesystem.getInfo(fullName).type == "directory"
				else
					isDirectory = lovr.filesystem.isDirectory(fullName)
				end
			end

			if isDirectory then
				table.insert(directories, {name = fileName, directory = fullName})
			elseif fileName:find(".lua") then
				local objectName = string.split(fileName, ".")[1]
				local fileDir = directory.."/"..objectName

				local required = require(fileDir)
				if type(required) == "table" then
					rawset(required,"_fileName", objectName)
				end
				tbl[objectName] = required
			end
		end
	end

	for _ , info in ipairs(directories) do
		tbl[info.name] = module.RecurseRequire(info.directory)
	end
	
	return tbl
end

return module