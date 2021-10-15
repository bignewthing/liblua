
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

function ENT:Initialize()
	self:SetModel("models/w_models/weapons/w_eq_pipebomb.mdl")
	self:SetModelScale(3, 0.2)
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )

	self:DrawShadow(false)

	local phys = self:GetPhysicsObject()

	if IsValid(phys) then
		phys:Wake()
	end
end

function ENT:Dissolve()
	self:SetName("to_dissolve")
	self.dissolver = ents.Create( "env_entity_dissolver" )
	self.dissolver:SetPos( self:GetPos() )
	self.dissolver:Spawn()
	self.dissolver:Activate()
	self.dissolver:SetKeyValue( "target", "to_dissolve" )
	self.dissolver:SetKeyValue( "magnitude", 1 )
	self.dissolver:SetKeyValue( "dissolvetype", 0 )
	self.dissolver:Fire( "Dissolve" )
end
