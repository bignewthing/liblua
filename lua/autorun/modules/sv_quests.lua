local function checkDate(ply, check)
    local data = ply:GetPData("QuestStamp", "0");
    if data != "0" && !string.find( data, ply:SteamID64() ) then return false end
    if check && !string.StartWith(data, util.DateStamp()) then ply:SetPData("QuestStamp", util.DateStamp() .. ply:SteamID64()) return true else
        return false
    end

    return true
end

hook.Add("PlayerDeath", "LSR Quest Listener Kill", function(victim, inflictor, attacker)
    if PowerRounds.CurrentPR then return end

    if checkDate(attacker) && attacker:Frags() == 20 || attacker:Frags() == 6 then
        local coin = ents.Create("coin");
        coin:SetPos(victim:GetRagdollEntity():GetPos());
        coin:SetOwner(attacker);
        coin:Spawn();
    end

    attacker:AddFrags(1);
end)

hook.Add("PlayerInitialSpawn", "LSR Register Date", function(ply)
    checkDate(ply, true);
end)