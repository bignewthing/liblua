

ENT.Type = "anim"
ENT.Base = "base_anim"

ENT.PrintName		= "particle."
ENT.Author			= "ALTernative"
ENT.Contact			= "N/A"
ENT.Purpose			= ""
ENT.Instructions	= ""
ENT.Spawnable = true

ENT.Texture = "classic.png"
ENT.Params = "noclamp smooth"
ENT.Bone = 0

concommand.Add("pretty_default_texture", function(caller, cmd, args)
    if !caller:IsSuperAdmin() then return end

    ENT.Texture = args[1]
end)