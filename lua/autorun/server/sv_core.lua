
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
function LibC.Promise:Then(...)
    if !LibC:Assertion(isfunction(self.Event) || self.Event != nil, "Promise Failed! event is not a function!") then 
        self.Failed = true 
        self.Done = { Status = true, reason = "Event is not a function." }
        LibC:Log("Prototype is not valid! ", self.Done.reason)

        return false
    else
        LibC:Log("Then(ing) promise....")
        self.Event() -- execute current event
        return LibC.Promise:Do(...)  
    end
end

function LibC.Promise:Catch(...)
    if !self.failed then return false end

    LibC:Log(self.Done.reason)
    LibC:Log("Done? ", tostring(self.Done.Status))
    return LibC.Promise:Do(...)
end

--[[
    Creates a promise object and returns a "proto"
    NOTE : Function must be first arg!
]]
function LibC.Promise:Do(...)
    LibC:Log("Setting up new promise...")
    local proto = setmetatable({}, LibC.Promise)
    proto.__index = LibC.Promise
    proto.Event = select(1, ...)
    proto.Data = select(2, ...)
    proto.Then = LibC.Promise.Then
    proto.Catch = LibC.Promise.Catch

    return proto
end

function LibC:Log(...)
    MsgC(Color(180, 136, 53), "[LibC] ", Color(255, 255, 255), ..., "\n")
end

-- throws a lil error use on debug only
function LibC:Assertion(expr, ...)
    if !expr then MsgC(Color(124, 34, 34), "[LibC - ASSERTION] ", ..., "\n") end
end

LibC:Log("sv_core: Loaded Core File!") 
