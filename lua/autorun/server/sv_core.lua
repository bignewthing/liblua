
--[[
    LibC - LibClassic - The standard ClassiC Library
	Copyright Amlal El Mahrouss & ClassiC all rights reserved

    Core functionalities.
]]

LibC = LibC or {}

-- Defines the Promise structure
-- a Promise prototype
LibC.Promise = LibC.Promise or { }

--[[
    Gets the promise failure Status
    returns false if it fails

    otherwise returns a prototype "promise"
]]
function LibC.Promise:Then(Hook, ...)
    if !isfunction(Hook) || Hook == nil then return self:Throw("Event is nil/not a function!!") else
        Hook(...) -- execute then the Hook
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
function LibC.Promise:Do(Hook, ...)
    if !isfunction(Hook) then return nil end

    local proto = setmetatable({}, LibC.Promise);
    proto.__index = LibC.Promise;

    proto.Event = Hook;
    proto.Done = false;

    proto.Do = LibC.Promise.Do;
    proto.Then = LibC.Promise.Then;
    proto.Catch = LibC.Promise.Catch;
    proto.Throw = LibC.Promise.Throw;
    proto.What = LibC.Promise.What;

    proto.Event(...);
    return proto;
end

function LibC:Log(...)
    MsgC(Color(180, 136, 53), "[LibC] ", ...);
    MsgC("\n");
end
