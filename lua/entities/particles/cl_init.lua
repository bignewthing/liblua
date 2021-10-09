
include('shared.lua')

function ENT:Initialize()
	self.Pos = IsValid(self.Owner) && self.Owner:GetPos() or self:GetPos()
	self.Emitter = ParticleEmitter(self.Pos)
	self.Material = Material(self.Texture, "noclamp smooth")
	self.NextPart = CurTime()
	self.Size = 5
	self.EndSize = 6.5

end

function ENT:SetSize(start, endNumber)
	self.Size = start
	self.EndSize = endNumber
end

function ENT:SetParticleSpeed(vec)
	if !istable(vec) then return end
	self.Vel = vec
end

function ENT:Draw()
	self:DrawModel()
end

function ENT:Think()
	self.Vel = Vector(math.random(30, 90), math.random(30, 90), math.random(30, 90))

	if self.NextPart < CurTime() then
		self.Emitter:SetPos(self.Owner:GetPos())
		self.NextPart = CurTime() + math.Rand(0, 0.02)
		local vec = VectorRand() * 3
		local pos = self:LocalToWorld(vec)
		local particle = self.Emitter:Add(self.Material, self.Owner:GetPos())

		particle:SetVelocity( self.Vel )
		particle:SetDieTime( 30 )
		particle:SetStartAlpha( 255 )
		particle:SetEndAlpha( 40 )
		particle:SetStartSize( self.Size )
		particle:SetEndSize( self.EndSize )   
		particle:SetRoll( math.random(30, 90) )
		particle:SetRollDelta( 0 )
	end
end

function ENT:OnRemove()
	self.Emitter:Finish()
end