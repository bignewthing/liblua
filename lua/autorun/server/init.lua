AddCSLuaFile("autorun/client/cl_init.lua")

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
           Msg(Color(0, 255, 0), self.ID .. " has spawned!\n")
        end
    }
}

local function CreateParticleInfo(instance)
    return setmetatable(instance, PrettyParticlesMeta)
end

local instance = CreateParticleInfo(instance)
instance.ID = "TEST"
instance.Manager.Spawn()