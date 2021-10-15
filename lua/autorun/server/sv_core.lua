
--[[
    LibC - LibClassic - The standard ClassiC Library
	Copyright Amlal El Mahrouss & ClassiC all rights reserved

    Promise and core functionalities.
]]

LibC = LibC or {}

function LibC:Log(...)
    MsgC(Color(180, 136, 53), "[LibC] ", Color(255, 255, 255), ..., "\n")
end

-- throws a lil error use on debug only
function LibC:Assertion(expr, ...)
    if !expr then MsgC(Color(124, 34, 34), "[LibC - ASSERTION] ", ..., "\n") end
end

-- Defines the Promise class
LibC.Promise = {
    Event = nil,
    done = false,
    failed = false,
    Then = nil, 
    Catch = nil, 
    Data = {}
}

--[[
    gets the promise failure status
    returns false if it fails

    otherwise returns a prototype "promise"
]]
function LibC.Promise:Then(...)
    if self.failed then return false end

    LibC:Log("Then(ing) promise....")
    LibC.Promise:Do(select(1, ...))
    return true
end

--[[
    Catch catches a promise exception and executes a onFailed promise
    

]]
function LibC.Promise:Catch(...)
    if !self.failed then return false end

    LibC:Log(self.done.reason)
    LibC:Log("Done? ", tostring(self.done.status))
    return LibC.Promise:Do(select(1, ...))
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

    -- now heres comme the do thing
    if LibC:Assertion(isfunction(proto.Event) || proto.Event != nil, "Promise failed! event is not a function!") then 
        proto.failed = true 
        proto.done = { status = true, reason = "Event is not a function. If you see this error please contact a administrator" }
        LibC:Log("Prototype is not valid! ", proto.done.reason)
    end

    return proto
end

LibC:Log("sv_core: Loaded Core file!") 
