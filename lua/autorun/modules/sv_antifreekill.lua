hook.Add("PlayerShouldTakeDamage", "CC Death", function(victim,attacker) 
    if (victim != attacker && attacker:IsPlayer() && !attacker:GetMurderer()) then
        if (!attacker:GetMurderer()) then 
            attacker:Kill();

            victim:Give("weapon_mu_magnum");
            victim:CalculateSpeed();
        
            return false;
        end
    end

    return true;
end)
