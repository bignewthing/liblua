
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

function ENT:Initialize()
	self:PhysicsInit( SOLID_NONE )
	self:SetMoveType( MOVETYPE_NONE )
	self:SetSolid( SOLID_NONE )
	self:DrawShadow(false)
	self:SetNoDraw(true)

	local phys = self:GetPhysicsObject()

	if IsValid(phys) then
		phys:Wake()
	end

	if isfunction(self.OnSpawn) then self.OnSpawn() end
end

function ENT:OnRemove()
	if isfunction(self.OnDelete) then self.OnDelete() end

end

function ENT:Use(activator, caller, useType, value)
	if isfunction(self.OnUse) then self.OnUse(activator, caller, useType, value) end

end

function ENT:Touch(ent)
	if isfunction(self.OnUse) then self.OnUse(ent) end

end

function ENT:Think()
	if isfunction(self.OnUse) then self.OnThink() end
end

function ENT:SetTouch(method)
	if !isfunction(method) then return false end

	self.OnTouch = method
	return true
end

function ENT:SetUse(method)
	if !isfunction(method) then return false end

	self.OnUse = method
	return true
end

function ENT:SetThink(method)
	if !isfunction(method) then return false end

	self.OnThink = method
	return true
end

function ENT:SetDelete(method)
	if !isfunction(method) then return false end

	self.OnDelete = method
	return true
end