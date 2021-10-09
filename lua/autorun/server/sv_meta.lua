
-- Pretty Particles GMod addon
-- All of the serversided particles settings goes there
PrettyParticles = {
    Info = {
        Start = function(self)
            if !IsValid(self.Owner) then return false end
            if self.AdminOnly && !owner:IsSuperAdmin() then return false end
            if !self.Groups.Users[self.Owner:GetUserGroup()] || !self.Groups.Admin[self.Owner:GetUserGroup()] then return false end
        
            self.Effect(ents.Create("pretty_particle"))
            self.Effect:SetName(self.Manager.ID)
            self.Effect:SetOwner(self.Owner)
            self.Effect.Texture = self.Material
            self.Effect:Spawn()
        
            self.Count = self.Count + 1
            return IsValid(self.Particle)
        end,

        Maximum = 15,
        Count = 0,
        ID = "uwu",
        Material = "uwu.png",
        Owner = Entity(-1),
        Effect = Entity(-1),

        Groups = {
            AdminOnly = true,
            Admins = { ["superadmin"] = true },
            Users = { ["user"] = true },
        },
    },
}

function PrettyParticles:New(id, mat, max, owner)
    local prototype setmetatable({}, self)
    prototype.Info.ID = id
    prototype.Info.Material = mat
    prototype.Info.Maximum = max
    prototype.Info.Owner = owner

    return prototype
end