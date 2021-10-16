
--[[
    LibC - LibClassic - The standard ClassiC Library
	Copyright Amlal El Mahrouss & ClassiC all rights reserved

    Promise and core functionalities.
]]

LibC = LibC or {}

function LibC:Log(...)
    MsgC(Color(180, 136, 53), "[LibC] ", Color(255, 255, 255), ..., "\n")
end

-- throws a lil error use on debug only
function LibC:Assertion(expr, ...)
    if !expr then MsgC(Color(124, 34, 34), "[LibC - ASSERTION] ", ..., "\n") end
end

-- Creates a libc_trigger
function LibC:Trigger()
    return ents.Create("libc_trigger")
end

include("autorun/server/sv_core.lua")
include("autorun/server/svl_sql.lua")
AddCSLuaFile("autorun/client/cl_init.lua")

LibC:Log("LibC: Loaded.")
