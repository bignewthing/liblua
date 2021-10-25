
--[[
    LibC - LibClassic - The standard ClassiC Library
	Copyright Amlal El Mahrouss & ClassiC all rights reserved

    Promise and core functionalities.
]]

LibC = LibC or {}

include("autorun/server/sv_core.lua")
include("autorun/server/sv_config.lua")
include("autorun/server/sv_moduleld.lua")
AddCSLuaFile("autorun/client/cl_init.lua")

LibC:Log("--------------------------------")
LibC:Find(LibC.RootDirectory);
LibC:Find(LibC.ResDirectory, true);
LibC:Log("--------------------------------")
LibC:Log("LibC: has been Loaded.") 
LibC:Log("--------------------------------")        