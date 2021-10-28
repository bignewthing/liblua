
hook.Add("PlayerDeath", "CDN Quest Listener", function(victim, inflictor, attacker)
    if PowerRounds.CurrentPR then return end
    if attacker == victim then return end

    if victim:GetNWBool("QuestCompleted", false) && attacker:Frags() == 20 || attacker:Frags() == 6 || victim:GetMurderer() then
        local bag = ents.Create("Bag");
        bag:SetOwner(attacker);
        bag:Spawn();
        bag:SetPos(attacker:GetPos());
    end

    attacker:AddFrags(1);
end)

hook.Add("PlayerSpawn", "CDN Season I Badass", function(ply)
    ply:SetModel("models/joshers/badasses/Playermodels/barney_closed.mdl");
end)