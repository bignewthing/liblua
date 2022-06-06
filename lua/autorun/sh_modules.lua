
--[[
    LibC - LibClassic - The standard ClassiC Library
	Copyright Amlal El Mahrouss & ClassiC all rights reserved

    Automatic includes.
]]

LibC = {}

LibC.RootDirectory = "autorun/modules/";
LibC.SoundDirectory = "sound/";

if SERVER then
    util.AddNetworkString("UpdateSharedScript")
    
    LibC.Allowed = { ["superadmin"] = true, };
    
    function LibC:ReloadModules(ply, cmd, args, args_str)
        if (!LibC.Allowed[ply:GetUserGroup()]) then return end

        LibC:Find(LibC.RootDirectory, false);
        LibC:Find(LibC.SoundDirectory, true);
    end

    concommand.Add("chrld", function(ply, cmd, args, args_str)
        LibC:ReloadModules(ply, cmd, args, args_str)
    end);

    function LibC:Find(root, res)
        local files, dir = file.Find( root .. "*", "LUA" )
     
        for _, file in ipairs(files) do
            if !res then
                local prefix = string.lower( string.Left( file, 3 ) )

                if prefix == "cl_" then print( "[AUTOLOAD] SKIPPING CLIENTSIDE...") continue end
                
                include( root .. file );
                print("[AUTOLOAD] INCLUDE: " .. file); 
            else
                resource.AddSingleFile( root .. file);
                print("[AUTOLOAD] ADD RES: " .. file);
            end
        end
    end

    LibC:Find(LibC.RootDirectory, false);
    LibC:Find(LibC.SoundDirectory, true);
end