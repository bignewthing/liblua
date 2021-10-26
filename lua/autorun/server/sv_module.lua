
--[[
    LibC - LibClassic - The standard ClassiC Library
	Copyright Amlal El Mahrouss & ClassiC all rights reserved

    Promise and core functionalities.
]]

LibC = LibC or {}

LibC.RootDirectory = "autorun/modules/";
LibC.ResDirectory = "autorun/content/";

function LibC:Find(root, res)
    local files, dir = file.Find( root .. "*", "LUA" )

    for _, file in ipairs(files) do
        if !res then
            local prefix = string.lower( string.Left( file, 3 ) )
            if prefix == "sh_" || prefix == "cl_" then AddCSLuaFile( LibC.RootDirectory .. file ) LibC:Log( "[AUTOLOAD] ADDCS: " .. file ) end
            if prefix == "cl_" then LibC:Log( "[AUTOLOAD] SKIPPING CLIENTSIDE...") continue end
    
            include( LibC.RootDirectory .. file );
            LibC:Log("[AUTOLOAD] INCLUDE: " .. file); 
        else
            resource.AddFile(file);
            LibC:Log("[AUTOLOAD] ADD RES: " .. file);
        end
    end
end

local function reload()
    LibC:Find(LibC.RootDirectory);
    LibC:Find(LibC.ResDirectory .. "materials/", true);
    -- you can add this
    LibC:Find(LibC.ResDirectory .. "sound/", true);
end

LibC:AddCommand("reloadModules", function()
    reload()
end, "superadmin"); 
