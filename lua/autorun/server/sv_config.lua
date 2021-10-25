
--[[
    LibC - LibClassic - The standard ClassiC Library
	Copyright Amlal El Mahrouss & ClassiC all rights reserved

    Promise and core functionalities.
]]

LibC = LibC or {}

-- MySQLOO Wrapper
-- Default Database Interface
LibC.SQL = LibC.SQL or {};

function LibC.SQL:Init(sqlite, database)
    if !isstring(database) then return {} end

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
LibC.Config = LibC.Config or {};

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
        if !makeTable then self.Data = cfg; LibC:Log("Replace config to Config!"); break end
        self.Data[#self.Data + 1] = cfg;

        LibC:Log(Color(182, 122, 43), "Appended", Color(255, 255, 255), " CFG!");
    end
end

function LibC.Config:Compress()
    if !istable(self.Data) then return false end
    local copy = table.Copy(self.Data);

    util.Compress(copy);
    return copy;
end

function LibC.Config:Init(name)
    if !isstring(name) then return {} end

    local proto = setmetatable({}, LibC.Config);
    proto.__index = LibC.Config;

    proto.IsActive =  LibC.Config.IsActive;
    proto.GetName =  LibC.Config.GetName;
    proto.Append = LibC.Config.Append;

    proto.Active = true;
    proto.Name = name;
    proto.Data = {};

    return proto
end  