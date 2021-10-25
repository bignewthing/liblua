LibC = LibC or {}
-- The current chauldron
LibC.Quests =  LibC.Quests or {
    Blaster = "weapon_blaster",
    Active = false,
    Model = Model("models/zerochain/props_halloween/witchcauldron.mdl"),
    Pos = Vector(190.129089, -342.967682, 64.031250), 
    Ang = Angle(-0.980034, 89.959778, 0.000000),

    Init = function(self)
        if !self.Active then return false end

        self.Cauldron = ents.Create("cauldron");
        self.Cauldron:SetModel(self.Model)
        self.Cauldron:Spawn();
        self.Cauldron:SetPos(self.Pos);
        self.Cauldron:SetAngles(self.Ang);
        self.Cauldron.List = LibC.Quests.ConfigPoses or {};

        return true
    end,

    Create = function(self)
        LibC:Log("Setting up new Cauldron...")
        local proto = setmetatable({}, LibC.Quests.Cauldron)
        proto.__index = LibC.Quests.Cauldron
        proto.Active = true
        proto.Pos = LibC.Quests.Pos
        proto.Ang = LibC.Quests.Ang
        proto.Model = LibC.Quests.Model
        proto.Init = LibC.Quests.Init

        LibC:Log("Cauldron was created with success!")
        return proto
    end,

    Spawn = function(self)
        LibC.Quests.ConfigPoses = LibC.Config:Init("Coins_" .. game.GetMap(), game.GetMap(), "DATA");
        LibC.Quests.ConfigPoses:Add(game.GetMap() .. "/", true, "DATA");
    end,

    List = {},
    CurrentInstance = {}
}

hook.Add("OnStartRound", "LSR::OnStartRound::Cauldron", function()
    if istable(PowerRounds.CurrentPR) then return end

    LibC.Quests.CurrentInstance = LibC.Quests:Create();
    LibC.Quests.CurrentInstance:Init();
    LibC.Quests.CurrentInstance:Spawn();
end)

hook.Add("PlayerUse", "LSR::PlayerUse::Quest", function(target, ent)
    if ent:GetClass() != "mu_loot" || target:GetLootCollected() <= 5 || target:HasWeapon(LibC.Quests.Blaster) then return end
    if !target:GetTKer() then target:Give(LibC.Quests.Blaster); end
end)
