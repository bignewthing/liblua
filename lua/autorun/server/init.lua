
AddCSLuaFile("autorun/client/cl_init.lua")
include("autorun/server/sv_meta.lua")

concommand.Add("particles", function(caller)
    PrintTable(PrettyParticles:New("VALVe", "bouh.png", 2, caller))
end)
