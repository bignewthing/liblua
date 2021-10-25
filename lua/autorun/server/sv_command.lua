
--[[
    LibC - LibClassic - The standard ClassiC Library
	Copyright Amlal El Mahrouss & ClassiC all rights reserved

    command module
]]

LibC = LibC or {}
LibC.Commands = LibC.Commands or {}

function LibC:AddCommand(name, func, perms)
    if !isfunction(func) || !istable(perms) || !isstring(name) then return false end
    -- and then add the command
    concommand.Add(name, function(target, cmd, args, argStr)
        if perms[target:GetUserGroup()] then func(); end
    end, nil, "LibC Command " .. name);

    return true;
end
