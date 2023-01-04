LibC.Prefix = "RollTheDice";
LibC.CommandPrefix = {"!", "."};
LibC.Actions = {};

function LibC.RegisterAction(NewFunc)
    table.insert(LibC.Actions, {
        Func = NewFunc
    });
end

function LibC.IsPrefixPresent(text)
    return string.StartWith(text, LibC.CommandPrefix[1]) || string.StartWith(text, LibC.CommandPrefix[2]);
end

hook.Add("PlayerSay", "LibC::Fun::Commands", function(sender, text, teamChat)
    if string.find(text, LibC.Prefix) && (LibC.IsPrefixPresent(text)) then
        table.Random(LibC.Actions).Func(sender);
    end
end)

LibC.RegisterAction(function(sender)
    if (sender:Alive()) then 
        sender:EmitSound("garrysmod/save_load1.wav");
        LibC.Explode(sender:GetPos(), sender);
        sender:Say("dsl g pété ^^'", false);
    end
end)

LibC.RegisterAction(function(sender)
    if (sender:Alive()) then 
        sender:EmitSound("garrysmod/save_load1.wav");
        sender:Say("whoooosh!", false);
        sender:Kill()
        LibC.Fizzle(sender)
    end
end)

LibC.RegisterAction(function(sender)
    if (sender:Alive()) then 
        timer.Create(sender:SteamID() .. "_RTD::HealthVial", 0.5, 15, function()
            local ent = ents.Create("item_healthvial");
            ent:SetPos(sender:GetPos());
            ent:Spawn();
            ent:EmitSound("garrysmod/save_load1.wav");
        end)
    end
end)

LibC.RegisterAction(function(sender)
    if (sender:Alive()) then 
        local ent = ents.Create("npc_grenade_frag");
        ent:SetPos(sender:GetPos());
        ent:Spawn();
        ent:Activate();
    end
end)

LibC.RegisterAction(function(sender)
    if (sender:Alive()) then 
        sender:Give("clown_base");
    end
end)

LibC.RegisterAction(function(sender)
    if (sender:Alive()) then 
        local ent = ents.Create("npc_metropolice");
        ent:Spawn();
        ent:SetPos(sender:GetPos());
        ent:SetModel(sender:GetModel());
        ent:Give("weapon_pistol");
        sender:KillSilent();
    end
end)

LibC.RegisterAction(function(sender)
    if (sender:Alive()) then
        sender:Give("graffiti-swep");
    end
end)