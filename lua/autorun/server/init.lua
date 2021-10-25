
--[[
    LibC - LibClassic - The standard ClassiC Library
	Copyright Amlal El Mahrouss & ClassiC all rights reserved

    Promise and core functionalities.
]]

LibC = LibC or {}

include("autorun/server/sv_core.lua");
include("autorun/server/sv_config.lua");
include("autorun/server/sv_command.lua");
include("autorun/server/sv_moduleLoad.lua");
AddCSLuaFile("autorun/client/cl_init.lua");
-- si t'es upluine tu peux ajouter a la liste des "pieces".
LibC.AddCommand("pd", function(target)
    LibC:Log("PD")
end, {["superadmin"] = { true }});