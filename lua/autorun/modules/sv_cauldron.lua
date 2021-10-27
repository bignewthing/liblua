LibC = LibC or {}
-- The Pickups
LibC.Pickups = LibC.Pickups or {
    Create = function(self)
        local Cauldron = ents.Create("cauldron");
        Cauldron:SetPos(Vector(190.129089, -342.967682, 64.031250)) ;
        Cauldron:SetAngles(Angle(-0.980034, 89.959778, 0.000000));
        Cauldron:Spawn();

        return IsValid(Cauldron);
    end,
}

hook.Add("OnStartRound", "LSR Cauldron", function()
    RunConsoleCommand("generateCauldron");
end)

LibC:AddCommand("generateCauldron", function()
    if LibC.Pickups:Create() then LibC:Log("Created Cauldron for " .. game.GetMap()); end
end, {["superadmin"] = { true }, ["fondateur"] = { true }})