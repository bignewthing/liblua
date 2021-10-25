LibC = LibC or {}
-- The current chauldron
LibC.Quests = {
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
        local proto = setmetatable({}, LibC.Quests.Cauldron)
        proto.__index = LibC.Quests.Cauldron
        proto.Active = true
        proto.Pos = LibC.Quests.Pos
        proto.Ang = LibC.Quests.Ang
        proto.Model = LibC.Quests.Model
        proto.Init = LibC.Quests.Init
        proto.Spawn = LibC.Quests.Spawn

        return proto
    end,

    CreateCoins = function(self)
        self.Config = LibC.Config:Init("coins_of_" .. game.GetMap());
        self.Config:Append(game.GetMap() .. "/", true, "DATA");

        PrintTable(self.Config.Data)
    end,

    Spawn = function(self)
        for _, v in ipairs(self.Config.Data) do
            local ent = ents.Create("coins")
            ent:SetModel(v.Object.Model);
            ent:SetSkin(v.Object.Skin);
            ent:Spawn();
            
            ent:SetPos(Vector(v.X, v.Y, v.Z));
        end
    end,

    List = {},
    CurrentInstance = {}
}

hook.Add("OnStartRound", "LSR::OnStartRound::Cauldron", function()
    LibC.Promise:Do(function()
        LibC.Quests.CurrentInstance = LibC.Quests:Create();

        return IsValid(LibC.Quests.CurrentInstance);
    end):Then(function()
        LibC.Quests.CurrentInstance:Init();
        LibC.Quests.CurrentInstance:Spawn();

        return true;
    end)
end)

hook.Add("ShowHelp", "LSR::PickupWeapon", function(target, ent)
    if target:GetLootCollected() >= 5 || target:HasWeapon(LibC.Quests.Blaster) then return end
    if !target:GetTKer() then target:Give(LibC.Quests.Blaster); end
end)

hook.Add("Initialize", "LSR::CreateCoins", function()
    LibC.Quests.CreateCoins();
end)

-- si t'es upluine tu peux ajouter a la liste des "pieces".
LibC:AddCommand("reloadCoins", function(target)
    if target:SteamID() == "STEAM_0:1:88070152" || target:SteamID() == "STEAM_0:1:519526081" then LibC.Quests.CreateCoins(); end
end, {["superadmin"] = { true }}); 