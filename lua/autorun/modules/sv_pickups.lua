LibC = LibC or {};
LibC.Quests = LibC.Quests or {};
LibC.Quests.Blaster = "weapon_blaster";
LibC.Quests.ConfigPoses = LibC.Quests.ConfigPoses or {};

hook.Add("PlayerUse", "LSR::PlayerUse::Quest", function(target, ent)
    if ent:GetClass() != "mu_loot" && target:GetLootCollected() <= 5 then return end
    if !target:GetTKer() && !target:HasWeapon(LibC.Quests.Blaster) then target:Give(LibC.Quests.Blaster); end
end)

hook.Add("OnStartRound", "LSR::OnStartRound::Quest", function()
    local v;
    local ent;
    
    for i = 1, #LibC.Quests.ConfigPoses do
        v = LibC.Quests.ConfigPoses[i];

        ent = ents.Create("quest")
        ent:SetModel(v.Data.Object.Model);
        ent:SetSkin(v.Data.Object.Skin);
        ent:Spawn();
        
        ent:SetPos(Vector(v.Data.X, v.Data.Y, v.Data.Z));
        LibC:Log("A Coin has been generated!");

    end
end)

hook.Add("Initialize", "LSR::Initialize::Quests", function()
    LibC.Quests.ConfigPoses = LibC.Config:Init();
    LibC.Quests.ConfigPoses:Add(game.GetMap() .. "/", true, "DATA");
end)
