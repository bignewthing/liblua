
--[[
    LibC - LibClassic - The standard ClassiC Library
	Copyright Amlal El Mahrouss & ClassiC all rights reserved

    Promise and core functionalities.
]]

-- MySQLOO Wrapper
LibC = LibC or {}

-- Default Database
LibC.SQL = LibC.SQL or {
    Enable = false,
    Database = {} -- TODO DO THIS
}

function LibC.SQL:Init(database)
    if !isstring(database) then return {} end

    LibC:Log("Setting up new Database...")
    local proto = setmetatable({}, LibC.SQL)
    proto.__index = LibC.SQL
    proto.Enable = true
    proto.Database = util.JSONToTable(file.Read(database, "DATA"))

    LibC:Log("Database created with success!")
    return proto
end

--[[
    LibC - Configuration file
]]
LibC.Config = LibC.Config or {
    Name = "Configuration",
    Active = false,
    Data = {}
}

function LibC.Config:Init(name, blob)
    if !isstring(blob) then return {} end

    LibC:Log("Setting up new Config...")
    local proto = setmetatable({}, LibC.Config)
    proto.__index = LibC.Config
    proto.Active = true
    proto.Name = name
    proto.Data = util.JSONToTable(file.Read(blob, "DATA"))

    LibC:Log("Config created with success!")
    return proto
end

LibC:Log("sv_sql: Loaded SQL File!") 