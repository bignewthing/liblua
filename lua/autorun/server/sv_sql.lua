
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
    Database = util.JSONToTable(file.Read("sql.json", "DATA") or "") -- TODO DO THIS
}

function LibC.SQL:Init()
    LibC:Log("Setting up new Database...")
    local proto = setmetatable({}, LibC.SQL)
    proto.__index = LibC.SQL
    proto.Enable = true
    proto.Database = database

    return proto
end