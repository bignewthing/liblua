
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

-- Basic Interpreter
function LibC:Execute(Target, Function)
    return Target:Function();
end

function LibC:Evaluate(Expression, Events)
    LibC.Promise:Init(function()
        return Expression
    end):Do():Then(function()
        for _, v in pairs(Events) do
            if !self:Execute(v.Target, v.Function) then return false end
        end

        return true;
    end):Catch();
end

LibC.Interpreter = {};

function LibC.Interpreter:Init()
    local proto = setmetatable({}, LibC.Interpreter);
    proto.__index = LibC.Interpreter;

    proto.Evaluate = LibC.Evaluate;
    proto.Execute = LibC.Execute;

    return proto
end
