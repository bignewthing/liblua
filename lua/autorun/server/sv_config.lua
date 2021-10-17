
--[[
    LibC - LibClassic - The standard ClassiC Library
	Copyright Amlal El Mahrouss & ClassiC all rights reserved

    Promise and core functionalities.
]]

LibC = LibC or {}

-- MySQLOO Wrapper
-- Default Database Interface
LibC.SQL = LibC.SQL or {
    SQLite = false,
    Enable = false,
    Database = {} -- TODO DO THIS
}

function LibC.SQL:Init(sqlite, database)
    if !isstring(database) then return {} end
    LibC:Log("Setting up new Database...")

    local proto = setmetatable({}, LibC.SQL)
    proto.__index = LibC.SQL
    proto.SQLite = sqlite
    proto.Enable = true
    proto.Database = util.JSONToTable(file.Read(database, "DATA")) or {}

    return proto
end

--[[
    Configuration interface
]]
LibC.Config = LibC.Config or {
    Name = "Configuration",
    Active = false,
    Data = {}
}

function LibC.Config:IsActive()
    return self.Active
end

function LibC.Config:GetName()
    return self.Name
end

function LibC.Config:Init(name, blob)
    if !isstring(blob) then return {} end
    LibC:Log("Setting up new Config...")
    
    local proto = setmetatable({}, LibC.Config)
    proto.__index = LibC.Config
    proto.Active = true
    proto.Name = name
    proto.Data = util.JSONToTable(file.Read(blob, "DATA")) or {}
    
    proto.IsActive =  LibC.Config.IsActive;
    proto.GetName =  LibC.Config.GetName;

    return proto
end

LibC:Log("sv_config: Loaded Config+SQL File!") 