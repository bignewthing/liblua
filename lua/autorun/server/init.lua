
--[[
    LibC - LibClassic - The standard ClassiC Library
	Copyright Amlal El Mahrouss & ClassiC all rights reserved

    Promise and core functionalities.
]]

LibC = LibC or {}

-- Creates a libc_trigger
function LibC:Trigger()
    return ents.Create("libc_trigger")
end

include("autorun/server/sv_core.lua")
include("autorun/server/svl_sql.lua")
AddCSLuaFile("autorun/client/cl_init.lua")

LibC:Log("LibC: Loaded.")
