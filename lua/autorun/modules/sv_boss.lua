
LibC = LibC or {}
-- The Pickups
LibC.Pickups = LibC.Pickups or {
    Create = function(self)
        local boss = ents.Create("Boss");
        boss:SetPos(Vector(8062.346191, -1063.838013, 48.031250));

        boss:SetAngles(Angle(5.016287, 177.114731, 0.000000));
        boss:Spawn();

        return IsValid(boss);
    end,
}

hook.Add("OnStartRound", "CDN Boss", function()
    if LibC.Pickups:Create() then LibC:Log("Created Boss"); end

end)

LibC:AddCommand("callBoss", function()
    if LibC.Pickups:Create() then LibC:Log("Created Boss"); end
end, {["superadmin"] = { true }})