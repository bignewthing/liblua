LibC = LibC or {}
-- The current chauldron
LibC.Quests = {
    Blaster = "weapon_blaster",
    Active = false,
    Model = Model("models/zerochain/props_halloween/witchcauldron.mdl"),
    Pos = Vector(190.129089, -342.967682, 64.031250), 
    Ang = Angle(-0.980034, 89.959778, 0.000000),

    Init = function(self)
        self.Cauldron = ents.Create("cauldron");
        self.Cauldron:SetModel(self.Model)
        self.Cauldron:Spawn();
        self.Cauldron:SetPos(self.Pos);
        self.Cauldron:SetAngles(self.Ang);

        return IsValid(self.Cauldron);
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
        proto.CreateCoins = LibC.Quests.CreateCoins

        return proto
    end,

    CreateCoins = function(self)
        self.Config = LibC.Config:Init("coins_of_" .. game.GetMap());
        self.Config:Append(game.GetMap() .. "/", true, "DATA");
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

hook.Add("OnStartRound", "LSR::Cauldron", function()
    RunConsoleCommand("generateCoins");
end)

-- Pour Upluine
LibC:AddCommand("reloadCoins", function(TARGET)
    if TARGET:SteamID() == "STEAM_0:1:88070152" then LibC.Quests.CreateCoins(); end
end, {["superadmin"] = { true }});

LibC:AddCommand("generateCoins", function()
    LibC.Promise:Init(function()
        LibC.Quests.CurrentInstance = LibC.Quests:Create();
        LibC:Log("Created instance for " .. game.GetMap());

        return LibC.Quests.CurrentInstance:Init();
    end):Do():Then(function()
        LibC.Quests.CurrentInstance:CreateCoins();
        LibC:Log("Created coins for " .. game.GetMap());
        LibC.Quests.CurrentInstance:Spawn();
        LibC:Log("Spawned coins for " .. game.GetMap());

        return true;
    end):Catch();
end, {["superadmin"] = { true }})