
--[[
    LibC - LibClassic - The standard ClassiC Library
	Copyright Amlal El Mahrouss & ClassiC all rights reserved

    Core functionalities.
]]

LibC = LibC or {}
LibC.Promise = {};

function LibC.Promise:Then(Func, ...)
    if !self.Done.Failed then Func(...) else
        self:Catch();
    end

    return self
end

function LibC.Promise:Catch()
    LibC:Log(self.Done.Reason);
    LibC:Log("Failed? " .. tostring(self.Done.Failed));

    return self
end

function LibC.Promise:Throw(reason)
    self.Done.Failed = true;
    self.Done = { Failed = true, Reason = reason };
    error(self.Reason, self.Failed);
    
    return self
end

-- ctor
function LibC.Promise:Init(Func)
    if !isfunction(Func) then return nil else
        local proto = setmetatable({}, LibC.Promise);
        proto.__index = LibC.Promise;
    
        proto.Func = Func;
        proto.Done = {};
    
        proto.Do = LibC.Promise.Do;
        proto.Then = LibC.Promise.Then;
        proto.Catch = LibC.Promise.Catch;
        proto.Throw = LibC.Promise.Throw;
    
        return proto
    end
end

function LibC.Promise:Do(...)
    if isfunction(self.Func) then self.Func(...); else
        LibC:Log("Promise failed!");

        self.Done.Failed = true;
        self.Done.Reason = "self.Func is not a function!";
        self:Catch();
    end
    
    return self;
end

function LibC:Log(...)
    MsgC(...);
    print();
end

function LibC:Ternary(Condition, Yes, No, YesArgs, NoArgs)
    if (Condition) then
        Yes(unpack(YesArgs))
    else
        No(NoArgs)
    end
end