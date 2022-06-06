hook.Add("PlayerShouldTakeDamage", "CC Death", function(victim, attacker) 
    if istable(PowerRounds.CurrentPR) then return true end

    if (victim != attacker && attacker:IsPlayer() && !victim:GetMurderer()) then
        if (attacker:GetMurderer() && victim:GetMurderer()) then return false end

        if (!attacker:GetMurderer()) then 
            attacker:Kill();

            victim:Give("weapon_mu_magnum");
            victim:CalculateSpeed();

            return false;
        end
    end

    return true;
end)
