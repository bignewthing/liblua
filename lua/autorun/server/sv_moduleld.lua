
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
        if prefix == "sh_" || prefix == "sh_" then AddCSLuaFile( LibC.RootDirectory .. file ) LibC:Log( "[AUTOLOAD] ADDCS: " .. file ) end
        if prefix == "cl_" then LibC:Log( "[AUTOLOAD] SKIPPING CLIENTSIDE...") continue end

        include( LibC.RootDirectory .. file )
        LibC:Log( "[AUTOLOAD] INCLUDE: " .. file )
    end
end

LibC:Log("sv_moduleld: Loaded Module loader!") 