
--[[
    LibC - LibClassic - The standard ClassiC Library
	Copyright Amlal El Mahrouss & ClassiC all rights reserved

    command module
]]

LibC = LibC or {}
LibC.Commands = LibC.Commands or {}

function LibC:AddCommand(name, func, perms)
    if LibC.Commands[name] then LibC:Log("Command already exists! returning!") return false end

    LibC.Commands[name] = {
        Function = func,
        Perms = perms
    };

    return true
end

concommand.Add("libexec", function(target, cmd, args)
    if !LibC.Commands[args[1]] then LibC:Log("Command does not point to any existing command!") end
    if target:IsUserGroup(LibC.Commands[args[1]].Perms) then LibC.Commands[args[1]].Function(target, select(2, args)); end
end, nil, "LibC Commands");