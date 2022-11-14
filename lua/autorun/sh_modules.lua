
--[[
    LibC - LibClassic - The standard ClassiC Library
	Copyright Amlal El Mahrouss & ClassiC all rights reserved

    Automatic includes.
]]

LibC = LibC or {}

LibC.RootDirectory = "autorun/modules/";
LibC.SoundDirectory = "sound/";

LibC.Allowed = { ["superadmin"] = true, };

if SERVER then

function LibC:ReloadModules(ply, cmd, args, args_str)
    LibC:Find(LibC.RootDirectory, false);
    LibC:Find(LibC.SoundDirectory, true);
end

function LibC:Find(root, res)
    local files, dir = file.Find( root .. "*", "LUA" )
    
    for _, file in ipairs(files) do
        if !res then
            local prefix = string.lower( string.Left( file, 3 ) )

            if prefix == "cl_" then print( "[AUTOLOAD] SKIPPING CLIENTSIDE...") continue end

            if SERVER then
                include( root .. file );
                print("[AUTOLOAD] INCLUDE: " .. file); 
            end
        else
            resource.AddSingleFile( root .. file);
            print("[AUTOLOAD] ADD RES: " .. file);
        end
    end
end

LibC:Find(LibC.RootDirectory, false);
LibC:Find(LibC.SoundDirectory, true);

LibC:AddCommand("recl_reload_scripts", LibC.ReloadModules, LibC.Allowed);

end