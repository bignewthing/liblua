
--[[
    LibC - LibClassic - The standard ClassiC Library
	Copyright Amlal El Mahrouss & ClassiC all rights reserved

    Core functionalities.
]]

LibC = LibC or {}
LibC.Promise = {};

function LibC.Promise:Then(Func, ...)
    if !self.Done.Failed then Func(...) end
    self:Catch();

    return self
end

function LibC.Promise:Catch()
    if !self.Done.Failed then return nil else
        LibC:Log(self.Done.Reason);
        return self
    end
end

function LibC.Promise:Throw(reason)
    self.Done.Failed = true;
    self.Done = { Failed = true, Reason = reason };

    return self
end

function LibC.Promise:Init(Func)
    if !isfunction(Func) then return nil end

    local proto = setmetatable({}, LibC.Promise);
    proto.__index = LibC.Promise;

    proto.Func = Func;
    proto.Done = { Failed = false, Reason = "success!" };

    proto.Do = LibC.Promise.Do;
    proto.Then = LibC.Promise.Then;
    proto.Catch = LibC.Promise.Catch;
    proto.Throw = LibC.Promise.Throw;

    return proto
end

--[[
    Creates a promise object and returns a "proto"
    NOTE : Function must be first arg!
]]
function LibC.Promise:Do(...)
    if isfunction(self.Func) then proto.Func(...); else
        LibC:Log("Promise failed!");

        self.Done.Failed = true;
        self.Done.Reason = "self.Func is not a function!";
        self:Catch();
    end
    
    return self;
end

function LibC:Log(...)
    MsgC(...);
    MsgC("\n");
end
