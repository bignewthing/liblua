LibC = LibC or {}
-- The Pickups
LibC.Pickups = LibC.Pickups or {
    Create = function(self)
        local Cauldron = ents.Create("cauldron");
        Cauldron:Spawn();

        return IsValid(Cauldron);
    end,
}

hook.Add("OnStartRound", "LSR::Cauldron", function()
    RunConsoleCommand("generateCauldron");
end)

LibC:AddCommand("generateCauldron", function()
    if LibC.Pickups:Create() then LibC:Log("Created Cauldron for " .. game.GetMap()); end
end, {["superadmin"] = { true }})