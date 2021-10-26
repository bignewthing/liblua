
--[[
    LibC - LibClassic - The standard ClassiC Library
	Copyright Amlal El Mahrouss & ClassiC all rights reserved

    command module
]]

LibC = LibC or {}

function LibC:AddCommand(name, func, perms)
    LibC.Promise:Init(function(name, func, perms)
        return isfunction(func) && istable(perms) && isstring(name)
    end, name, func, perms):Then(function(name)
        concommand.Add(name, function(target, cmd, args, argStr)
            if target:IsPlayer() && perms[target:GetUserGroup()] then func(target, cmd, args, argStr); end
        end);

        LibC:Log(Color(0, 255, 0), "Added ", name, " to commands list!");
        return true;
    end, name):Catch();
end