
--[[
    LibC - LibClassic - The standard ClassiC Library
	Copyright Amlal El Mahrouss & ClassiC all rights reserved
]]

LibC = LibC or {}

function LibC:AddCommand(Name, Func, perms)
    LibC.Promise:Init(function(Name, Func, perms)
        return isfunction(Func) && istable(perms) && isstring(Name)
    end, Name, Func, perms):Do():Then(function(Name)
        concommand.Add(Name, function(target, cmd, args, argStr)
            if target:IsPlayer() && perms[target:GetUserGroup()] then Func(target, cmd, args, argStr); end
        end);

        LibC:Log(Color(0, 255, 0), "Added ", Name, " to commands list!");
        return true;
    end, Name):Catch();
end
