
--[[
    LibC - LibClassic - The standard ClassiC Library
	Copyright Amlal El Mahrouss & ClassiC all rights reserved

    Promise and core functionalities.
]]

LibC = LibC or {}
LibC.RootDirectory = "autorun/modules/"

function LibC:FindModules()
    local files, dir = file.Find( LibC.RootDirectory .. "*", "LUA" )

    for _, file in ipairs(files) do
        local prefix = string.lower( string.Left( file, 3 ) )
        
        if prefix == "sh_" then
            AddCSLuaFile( LibC.RootDirectory .. file )
            LibC:Log( "[AUTOLOAD] SHARED ADDCS: " .. file )
            include( LibC.RootDirectory .. file )
            LibC:Log( "[AUTOLOAD] SHARED INCLUDE: " .. file )
        end
    end
end
