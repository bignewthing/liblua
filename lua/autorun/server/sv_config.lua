
--[[
    LibC - LibClassic - The standard ClassiC Library
	Copyright Amlal El Mahrouss & ClassiC all rights reserved

    Configs
]]

LibC = LibC or {}

-- Configuration classes
-- Very useful.
LibC.Config = {};

function LibC.Config:Append(path, makeTable, where)
    self.Data = {};
    local configs = file.Find(path .. "*", where or "DATA");

    for _, cfg in ipairs(configs) do
        local cfg = util.JSONToTable(file.Read(path .. cfg, where or "DATA"));
        if !makeTable then self.Data = cfg; LibC:Log("Replace config to Config!"); break end
        self.Data[#self.Data + 1] = cfg;
    end
end

function LibC.Config:Compress()
    if self.Data == nil then return nil end
    local copy = table.Copy(self.Data);

    util.Compress(copy);
    return copy;
end

function LibC.Config:Init(name)
    if !isstring(name) then return {} end

    local proto = setmetatable({}, LibC.Config);
    proto.__index = LibC.Config;
    proto.Append = LibC.Config.Append;

    proto.Active = true;
    proto.Name = name;

    LibC:Log("CFG Added " .. name);
    return proto
end
