
LibC = LibC or {}
-- The Pickups
LibC.Pickups = LibC.Pickups or {
    Create = function(self)
        local boss = ents.Create("Boss");
        boss:SetPos(Vector(7049.595703, -961.522461, 48.031250));
        boss:SetAngles(Angle(1.159731, -179.610214, 0.000000));
        boss:Spawn();
        return IsValid(boss);
    end,
}

hook.Add("OnStartRound", "CDN Boss", function()
    if game.GetMap() != "gm_scarface" then return end
    if LibC.Pickups:Create() then LibC:Log("Created Boss"); end

end)

LibC:AddCommand("callBoss", function()
    if game.GetMap() != "gm_scarface" then return end
    if LibC.Pickups:Create() then LibC:Log("Created Boss"); end
end, {["superadmin"] = { true }})