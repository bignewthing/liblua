
--[[
    LibC - LibClassic - The standard ClassiC Library
	Copyright Amlal El Mahrouss & ClassiC all rights reserved
]]

LibC = LibC or {}

function LibC:AddCommand(Name, Func, Perms)
    LibC.Promise:Init(function(Name, Func, Perms)
        return isfunction(Func) && istable(Perms) && isstring(Name)
    end, Name, Func, Perms):Do():Then(function(Name)
        concommand.Add(Name, function(target, cmd, args, argStr)
            if target:IsPlayer() && Perms[target:GetUserGroup()] then Func(target, cmd, args, argStr); end
        end);

        LibC:Log(Color(0, 255, 0), "Added ", Name, " to commands list!");
        return true;
    end, Name):Catch();
end
