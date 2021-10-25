
--[[
    LibC - LibClassic - The standard ClassiC Library
	Copyright Amlal El Mahrouss & ClassiC all rights reserved

    Promise and core functionalities.
]]

LibC = LibC or {}

-- MySQLOO Wrapper
-- Default Database Interface
LibC.SQL = LibC.SQL or {}

function LibC.SQL:Init(sqlite, database)
    if !isstring(database) then return {} end
    LibC:Log(Color(43, 80, 182), "-------------------------------------------");
    LibC:Log(Color(43, 80, 182), "Setting up new Database...");
    LibC:Log(Color(43, 80, 182), "-------------------------------------------");

    local proto = setmetatable({}, LibC.SQL)
    proto.__index = LibC.SQL
    proto.SQLite = sqlite
    proto.Enable = true
    if !sqlite then proto.Database = util.JSONToTable(file.Read(database, "DATA")) or {} end

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

function LibC.Config:Append(path, makeTable, where)
    local configs = file.Find(path .. "*", where or "DATA");

    for _, cfg in ipairs(configs) do
        local cfg = util.JSONToTable(file.Read(path .. cfg, where or "DATA"));
        if !makeTable then self.Data = cfg; LibC:Log("Replace cfg to Config!"); break end
        self.Data[#self.Data + 1] = cfg;

        LibC:Log(Color(182, 122, 43), "Appended cfg to Config!");
    end
end

function LibC.Config:Init(name, where)
    if !isstring(blob) then return {} end
    LibC:Log(Color(182, 122, 43), "-------------------------------------------");
    LibC:Log(Color(182, 122, 43), "Setting up new Config...");
    LibC:Log(Color(182, 122, 43), "-------------------------------------------");
    
    local proto = setmetatable({}, LibC.Config);
    proto.__index = LibC.Config;
    proto.Active = true;
    proto.Name = name;
    proto.Data = {};
    proto.Append = LibC.Config.Append;

    proto.IsActive =  LibC.Config.IsActive;
    proto.GetName =  LibC.Config.GetName;

    return proto
end