
LibC = LibC or {}
-- The Pickups
LibC.Pickups = LibC.Pickups or {
    Create = function(self)
        local boss = ents.Create("Boss");
        boss:SetPos(Vector(6315.320801, 814.581604, 309.322266));
        boss:SetAngles(Angle(0.131998, 34.712036, 0.000000));
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