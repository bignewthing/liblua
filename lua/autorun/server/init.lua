-- All of the serversided particles settings goes there
PrettyParticlesMeta = PrettyParticlesMeta or {
    Settings = Settings or {
        Max = 15, -- I want 15 maximum particles of this instance
        SpawnableBy = SpawnableBy or {
            Admin = Admin or { "superadmin" },
            Users = Users or { "user" },
            AdminOnly = true,
        }
    },
    Manager = Manager or {
        ID = "MyParticle",
        Owner = nil,
        Spawn = function(self)
           print(self.ID .. " has just spawned!")
        end
    }
}

local function CreateParticleInfo(instance)
    setmetatable(instance, PrettyParticlesMeta)
end

local instance
CreateParticleInfo(instance)
instance.ID = "PD"
instance.Spawn()