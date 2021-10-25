
--[[
    LibC - LibClassic - The standard ClassiC Library
	Copyright Amlal El Mahrouss & ClassiC all rights reserved

    Core functionalities.
]]

LibC = LibC or {}

-- Defines the Promise structure
-- a Promise prototype
LibC.Promise = {};

--[[
    Gets the promise failure Status
    returns false if it fails

    otherwise returns a prototype "promise"
]]
function LibC.Promise:Then(Func, ...)
    if !isfunction(Func) || Func == nil then return self:Throw("Func is nil/not a function!!") else
        Func(...) -- execute then the Func
        LibC:Log(Color(182, 122, 43), "Promise", Color(255, 255, 255) " was retained!");

        return self
    end
end

function LibC.Promise:Catch()
    if !self.Done.Failed then return {} else
        LibC:Log(self.Done.Reason)
        return self
    end
end

function LibC.Promise:What()
    LibC:Log(self.Done.Reason);
end

function LibC.Promise:Throw(reason)
    self.Failed = true;
    self.Done = { Failed = true, Reason = reason };

    return self
end

--[[
    Creates a promise object and returns a "proto"
    NOTE : Function must be first arg!
]]
function LibC.Promise:Do(Func, ...)
    if !isfunction(Func) then return nil end

    local proto = setmetatable({}, LibC.Promise);
    proto.__index = LibC.Promise;

    proto.Func = Func;
    proto.Done = false;

    proto.Do = LibC.Promise.Do;
    proto.Then = LibC.Promise.Then;
    proto.Catch = LibC.Promise.Catch;
    proto.Throw = LibC.Promise.Throw;
    proto.What = LibC.Promise.What;

    proto.Func(...);
    return proto;
end

function LibC:Log(...)
    MsgC(...);
    MsgC("\n");
end
