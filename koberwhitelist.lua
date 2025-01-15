
release = "0.1"

function onInit()
    print("koberwhitelist " .. release .. " loaded\n")
    MP.RegisterEvent("onPlayerAuth", "authHandler")
end
local function readWhiteFile()
    local path = "whitelist.txt"
    local whiteFile = io.open(path, "r")

	if not whiteFile then
		print("koberwhitelist: whitelist file not found - creating...")
		whiteFile = io.open(path, "w")
        whiteFile:close()
        whiteFile = io.open(path, "r")
	end
    
	local whitelist = whiteFile:read("*all")

	whiteFile:close()

	return whitelist
end

function authHandler(name, role, is_guest, identifiers)
    if string.match(readWhiteFile(), name) then
        print(name .. " in whitelist - allowing to join")
        return 0
    else
        print(name .. " NOT in whitelist - kicking player")
        return "You need to be on a whitelist to join this server."
    end
end


