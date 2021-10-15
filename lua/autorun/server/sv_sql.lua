
--[[
    LibC - LibClassic - The standard ClassiC Library
	Copyright Amlal El Mahrouss & ClassiC all rights reserved

    Promise and core functionalities.
]]

-- MySQLOO Wrapper
LibC = LibC or {}

LibC.SQL = LibC.SQL or {
    Enable = false,
    Database = util.JSONToTable(file.Read("sql.json", "DATA")) -- TODO DO THIS
}

function LibC.SQL:Query()
    if !LibC.SQL.Enable then return false end

end

function LibC.SQL:Commit()
    if !LibC.SQL.Enable then return false end

end