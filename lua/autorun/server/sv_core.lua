
--[[
    LibC - LibClassic - The standard ClassiC Library
	Copyright Amlal El Mahrouss & ClassiC all rights reserved

    Promise and core functionalities.
]]

LibC = LibC or {}

function LibC:Log(...)
    MsgC(Color(180, 136, 53), ...)
end

-- throws a lil error use on debug only
function LibC:Assertion(expr, ...)
    if !expr then MsgC(Color(124, 34, 34), ...) end
end

-- Defines the Promise class
LibC.Promise = {
    event = nil,
    name = nil,
    done = false,
    failed = false,
    callback = nil, 
}

function LibC.Promise:Then(promise)
    if self.failed then return false end
    if !istable(promise) then return false end
    
    return LibC.Promise:Do(unpack(promise)).failed
end

function LibC.Promise:Do(event, name)
    LibC:Log("Setting up promise...")
    local proto = setmetatable({}, LibC.Promise)
    proto.__index = LibC.Promise

    proto.event = event
    proto.name = name
    proto.Then = LibC.Promise.Then

    -- now heres comme the do thing
    if !LibC:Assertion(isfunction(proto.event) || proto.event != nil, "Promise failed! event is not a function!") then 
        proto.failed = true 
        proto.done = { status = true, reason = "Event is not a function. If you see this error please contact a administrator" }
        LibC:Log("Prototype is not valid! ", proto.done.reason)
    else
        if LibC:Assertion(proto.event(), "Promise failed, Function failed!") then 
            proto.failed = true 
            proto.done = { status = true, reason = "Function has failed, please contact a server administrator" } 
        end
    end

    return proto
end

LibC:Log("sv_core: Loaded.") 

LibC.Promise:Do(function()
    LibC:Log("OOOOOH, Burning through the sky yeaaaahhhh")
    return true
end, "Freddie Mercury"):Then(
    {
        function()
            LibC:Log("Cause i'm having a good time!")
            return true    
        end,
        "Freddie Mercury (again)"
    }
) 