-- Pretty Particles GMod addon
-- All of the serversided particles settings goes there
PrettyMeta = PrettyMeta or {
    Settings = Settings or {
        Max = 15, -- I want 15 maximum particles of this instance
        AdminOnly = true,
        Groups = Groups or {
            Admin = Admin or { "superadmin" },
            Users = Users or { "user" },
        }
    },
    Manager = Manager or {
        Count = 0,
        ID = "Halloween",
        Material = "halloween.png",
        Owner = nil,
        Particle = nil,
        Spawn = function(self, pos, owner)
            if self.Settings.Max >= self.Count then return false end
            if self.Settings.AdminOnly && !owner:IsSuperAdmin() then return false end

            if !IsValid(owner) then return false end
            self.Manager.Owner = owner

            self.Manager.Particle = ents.Create("pretty_particle")
            self.Manager.Particle:SetName(self.Manager.ID)
            self.Manager.Particle:SetOwner(self.Owner)
            self.Manager.Particle.Texture = self.Material
            self.Manager.Particle:Spawn()

            self.Count = self.Count + 1
            return IsValid(self.Manager.Particle)
        end
    }
}

function CreatePrettyParticle(instance)
    setmetatable(instance, PrettyMeta)
end

concommand.Add("pretty_particle_test", function(caller)
    local instance = {}
    
    CreateParticleInfo(instance)
    instance.ID = "UwU"
    instance.Material = "uwu.png"
    instance.Manager.Spawn(instance, Vector(0, 0, 0), caller)
end)