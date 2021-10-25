
--[[
    LibC - LibClassic - The standard ClassiC Library
	Copyright Amlal El Mahrouss & ClassiC all rights reserved

    command module
]]

LibC = LibC or {}
LibC.Commands = LibC.Commands or {}

function LibC:AddCommand(name, func, perms)
    if !isstring(name) || !isfunction(func) then return false end
    
    LibC.Commands[name] = {
        Function = func,
        Perms = perms
    }
end

concommand.Add("classic", function(target, cmd, args)
    if !LibC.Commands[args[1]].Perms then target:ChatPrint("Command does not exist.") end
    if target:IsUserGroup(LibC.Commands[args[1]].Perms) then LibC.Commands[args[1]].Function(target, select(2, args)); end
end)