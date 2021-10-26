LibC = LibC or {}
-- The Pickups

LibC.QuestConstructor = LibC.QuestConstructor or {
    Create = function(self, steps, recompense) -- is recompense english by the way?
        local proto = setmetatable({}, LibC.QuestConstructor);
        proto.__index = LibC.QuestConstructor;
        proto.Active = true;
        proto.Steps = steps;
        proto.Recompense = recompense;

        return proto
    end,
};

