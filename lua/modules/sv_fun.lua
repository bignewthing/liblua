LibC = LibC or {}

function LibC:FakeCorpse()
    local zombie = ents.Create("npc_ragdoll");
    zombie:Spawn();
    zombie:SetModel("models/Gibs/Fast_Zombie_Torso.mdl");
    return zombie;
end

function LibC.Explode(pos, owner)
    local explode = ents.Create( "env_explosion" )
    explode:SetPos( pos )
    explode:SetOwner( owner )
    explode:Spawn()
    explode:SetKeyValue( "iMagnitude", "0" )
    explode:Fire( "Explode", 0, 0 )
    explode:EmitSound( "weapon_AWP.Single", 100, 100 )
end

function LibC.Fizzle(owner)
    owner:GetRagdollEntity():SetName( "fizzled" )
    local dissolver = ents.Create( "env_entity_dissolver" )
    dissolver:SetPos( owner:GetPos() )
    dissolver:Spawn()
    dissolver:Activate()
    dissolver:SetKeyValue( "target", "fizzled" )
    dissolver:SetKeyValue( "magnitude", 100 )
    dissolver:SetKeyValue( "dissolvetype", 0 )
    dissolver:Fire( "Dissolve" )
end

hook.Add("PlayerDeath", "Modules::Effect::CustomDefaultDeath", function(victim)
    local pos = victim:GetRagdollEntity():GetPos()
    local cnt = 0
    timer.Create(victim:SteamID() .. "_DefaultEffect", 0.05, 50, function()
        local money = ents.Create("money");
        money:SetPos(pos + Vector(math.random(-20, 20), 0, math.random(-50, 50)))
        money:Spawn()
        cnt = cnt + 1
        if cnt == 50 && IsValid(victim) && !victim:Alive() then
            LibC.Fizzle(victim)
        end
    end)
end)