
--[[
    LibC - LibClassic - The standard ClassiC Library
	Copyright Amlal El Mahrouss & ClassiC all rights reserved

    Promise and core functionalities.
]]

LibC = LibC or {}

-- Defines the Promise class
LibC.Promise = LibC.Promise or {
    Event = nil,
    Done = false,
    Failed = false,
    Then = nil, 
    Catch = nil, 
    Data = {}
}

--[[
    gets the promise failure Status
    returns false if it fails

    otherwise returns a prototype "promise"
]]
function LibC.Promise:Then(event, ...)
    if !isfunction(event) || event == nil then return self:Throw("Event is not valid!") else
        event(select(1, ...)) -- execute then the event
        LibC:Log("Making another promise....")
        return self:Do(event, ...)
    end
end

function LibC.Promise:Catch(...)
    if !self.failed then return {} end
    LibC:Log(self.Done.Reason)
    LibC:Log("Done? ", tostring(self.Done.Status))
    return self:Do(...)
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
function LibC.Promise:Do(...)
    LibC:Log("Setting up new promise...")
    local proto = setmetatable({}, LibC.Promise)

    proto.__index = LibC.Promise
    proto.Event = select(1, ...) or nil
    proto.Data = select(2, ...) or {}
    proto.Do = LibC.Promise.Do
    proto.Then = LibC.Promise.Then
    proto.Done = false
    proto.Catch = LibC.Promise.Catch
    proto.Throw = LibC.Promise.Throw
    
    proto.Event(select(2, ...))
    return proto
end

function LibC:Log(...)
    MsgC(Color(180, 136, 53), "[LibC] ", Color(255, 255, 255), ..., "\n")
end

-- throws a lil error use on debug only
function LibC:Assertion(expr, ...)
    if !expr then MsgC(Color(124, 34, 34), "[LibC - ASSERTION] ", ..., "\n") end
end

-- Pretty wrapper for libc_trigger uwu
function LibC:Trigger()
    return ents.Create("libc_trigger")
end

LibC:Log("sv_core: Loaded Core File!") 
