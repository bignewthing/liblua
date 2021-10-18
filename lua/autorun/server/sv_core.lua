
--[[
    LibC - LibClassic - The standard ClassiC Library
	Copyright Amlal El Mahrouss & ClassiC all rights reserved

    Promise and core functionalities.
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
function LibC.Promise:Then(event, ...)
    if !isfunction(event) || event == nil then return self:Throw("Event is not valid!") else
        LibC:Log("Making promise....")
        event(...) -- execute then the event

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

function LibC.Promise:Throw(reason)
    self.Failed = true 
    self.Done = { Status = true, Reason = reason }
    LibC:Log("Promise is not valid! " .. self.Done.Reason)

    return self
end

--[[
    Creates a promise object and returns a "proto"
    NOTE : Function must be first arg!
]]
function LibC.Promise:Do(event, ...)
    if !isfunction(event) then return {} end
    LibC:Log("Setting up new promise...")

    local proto = setmetatable({}, LibC.Promise)
    proto.__index = LibC.Promise

    proto.Event = event
    proto.Done = false

    proto.Do = LibC.Promise.Do
    proto.Then = LibC.Promise.Then
    proto.Catch = LibC.Promise.Catch
    proto.Throw = LibC.Promise.Throw
    
    proto.Event(...)
    return proto
end

function LibC:Log(...)
    MsgC(Color(180, 136, 53), "[LibC] ", Color(255, 255, 255), ..., "\n")
end

LibC:Log("sv_core: Loaded Core File!")
