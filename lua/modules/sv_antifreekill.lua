hook.Add("PlayerShouldTakeDamage", "CC Death", function(victim, attacker) 
    if (attacker:IsPlayer() && attacker:GetMurderer() && victim:GetMurderer()) then return false end
    if PowerRounds && istable(PowerRounds.CurrentPR) then return true end
    if (!attacker:IsPlayer()) then return false end

    if (victim != attacker && attacker:IsPlayer() && !victim:GetMurderer()) then
        if (!attacker:GetMurderer()) then 
            attacker:Kill();

            victim:Give("weapon_mu_magnum");
            victim:CalculateSpeed();

            return false;
        end
    end

    return true;
end)


hook.Add("OnStartRound", "CC ASK", function()
    for _, ply in ipairs(team.GetPlayers(2)) do
        ply:GodEnable();
    end

    timer.Create("CStart_Round", 20, 1, function()
        for _, ply in ipairs(team.GetPlayers(2)) do
            ply:GodDisable();
        end

        ClassicLib.Announce({"AntiSpawnKill est OFF!", "Que le meilleur gagne!"})
    end)
end)

hook.Add("OnEndRound", "CC Rm Ask", function()
    if timer.Exists("CStart_Round") then
        timer.Remove("CStart_Round")
    end
end)