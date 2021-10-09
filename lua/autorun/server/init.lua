
AddCSLuaFile("autorun/client/cl_init.lua")
include("autorun/server/sv_meta.lua")

concommand.Add("particles", function(caller)
    local proto = PrettyParticles:New("VALVe", "bouh.png", 2, caller)
    PrintTable(proto)
end)
 