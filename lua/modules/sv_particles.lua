LibC = LibC or {}
LibC.ParticleStruct = {
    Name = "Particle",
    Id = "null",
}

function LibC.AddParticle(ply, cmd, args, args_str)
    if !IsValid(ply) then return false end
    local ent = ents.Create(args[1]);
    ent:SetPos(ply:GetPos());
    ent:SetParent(ply);
    ent:SetOwner(ply);
    ent:Spawn();
    ent:SetSolid(SOLID_NONE);
    ent:GetPhysicsObject():Wake();

    ent.RootChild = ent.RootChild or {};
    ent.RootChild.Elements = ent.RootChild.Elements or {};

    ent.RootChild.Elements[args[1]] = LibC.ParticleStruct;
    ent.RootChild.Elements[args[1]].Name = args[2] or "Particle";
    ent.RootChild.Elements[args[1]].Id = args[1] or "null";

    return true
end

function LibC.RemoveParticle(victim, cmd, args, args_str) 
    victim.RootChild = victim.RootChild or {};
    victim.RootChild.Elements = victim.RootChild.Elements or {};

    for _, ent in pairs(ents.FindByClass( args[1] )) do
        if ent:GetOwner() == victim then
            ent:Remove();
        end
    end
end
