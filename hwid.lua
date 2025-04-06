local ffi = require("ffi")
local base64 = require("gamesense/base64")

ffi.cdef[[
    typedef long(__thiscall* GetRegistryString)(void* this, const char* pFileName, const char* pPathID);
    typedef bool(__thiscall* Wrapper)(void* this, const char* pFileName, const char* pPathID);
]]

local type = ffi.typeof("void***")
local interface = client.create_interface("filesystem_stdio.dll", "VBaseFileSystem011")
local system10 = ffi.cast(type, interface)
local systemxwrapper = ffi.cast("Wrapper", system10[0][10])
local gethwid = ffi.cast("GetRegistryString", system10[0][13])

local function file_checker()
    for i = 65, 90 do
        local file_check = string.char(i) .. ":\\Windows\\Setup\\State\\State.ini"

        if systemxwrapper(system10, file_check, "hexcodes") then
            return file_check
        end
    end
    return nil
end

local function get_hwid()
    local file_check = file_checker()
    if file_check then
        local hwid = gethwid(system10, file_check, "hexcodes")
        return hwid
    else
        return nil
    end
end

return { get_hwid = get_hwid }
