
--[[
    LibC - LibClassic - The standard ClassiC Library
	Copyright Amlal El Mahrouss & ClassiC all rights reserved

    Core functionalities.
]]

LibC = LibC or {}

-- Defines the Promise structure
-- a Promise prototype
LibC.Promise = LibC.Promise or {
    Event = nil,
    Done = false,
    Failed = false,
    Then = nil, 
    Catch = nil, 
}

--[[
    Gets the promise failure Status
    returns false if it fails

    otherwise returns a prototype "promise"
]]
function LibC.Promise:Then(Hook, ...)
    if !isfunction(Hook) || Hook == nil then return self:Throw("Event is nil/not a function!!") else
        LibC:Log("-------------------------------------------");
        LibC:Log("Making Promise....");
        LibC:Log("-------------------------------------------");
        Hook(...) -- execute then the Hook

        return self
    end
end

function LibC.Promise:Catch()
    if !self.failed then return {} else
        LibC:Log(self.Done.Reason)
        LibC:Log("Done? ", tostring(self.Done.Status))
    
        return self
    end
end

function LibC.Promise:What()
    LibC:Log(self.Done.Reason);
end

function LibC.Promise:Throw(reason)
    self.Failed = true;
    LibC:Log("-------------------------------------------");
    LibC:Log("LibC: Promise failed!");
    LibC:Log("-------------------------------------------");

    if self.Done then self.Done.Reason = reason return self end
    self.Done = { Status = true, Reason = reason };

    return self
end

--[[
    Creates a promise object and returns a "proto"
    NOTE : Function must be first arg!
]]
function LibC.Promise:Do(Hook, ...)
    if !isfunction(Hook) then return nil end
    LibC:Log("-------------------------------------------");
    LibC:Log("Setting up new Promise...")
    LibC:Log("-------------------------------------------");

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
