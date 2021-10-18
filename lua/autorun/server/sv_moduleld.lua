
--[[
    LibC - LibClassic - The standard ClassiC Library
	Copyright Amlal El Mahrouss & ClassiC all rights reserved

    Promise and core functionalities.
]]

LibC = LibC or {}
LibC.RootDirectory = "addons/classic-content/lua/autorun/"

function LibC:FindModules()
    local files, dir = file.Find( LibC.RootDirectory .. "*", "GAME" )

    for k, file in ipairs(files) do
        print(file)
        local prefix = string.lower( string.Left( file, 3 ) )
        
        if prefix == "sh_" then
            AddCSLuaFile( file )
            LibC:Log( "[AUTOLOAD] SHARED ADDCS: " .. file )
            include( file )
            LibC:Log( "[AUTOLOAD] SHARED INCLUDE: " .. file )
        end
    end
end
