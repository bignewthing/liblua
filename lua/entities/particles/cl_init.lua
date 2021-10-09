
include('shared.lua')

function ENT:Initialize()
	self.Pos = IsValid(self.Owner) && self.Owner:GetPos() or self:GetPos()
	self.Emitter = ParticleEmitter(self.Pos)
	self.Material = Material(self.Texture, self.Params)
	self.NextPart = CurTime()
	self.Size = 5
	self.EndSize = 6.5
	self.Multiplier = 1
end

function ENT:Next(time)
	if !isnumber(amount) then return false end
	self.NextPart = (CurTime() + math.Rand(0, time or 0.2)) + (self.Emitter:GetVelocity().x / self.Emitter:GetVelocity().y)

	return true
end

function ENT:SetSize(start, endNumber)
	self.Size = start
	self.EndSize = endNumber
end

function ENT:ChangeMultiplier(amount)
	if !isnumber(amount) then return false end

	self.Multiplier = (amount / self.Vel)
	return true
end

function ENT:Draw()
	self:DrawModel()
end

function ENT:Think()
	self.Vel = Vector(math.random(10, 50), math.random(50, 70), math.random(50, 100))

	if self.NextPart < CurTime() then
		self.Emitter:SetPos(self.Owner:GetPos())
		self:Next()

		local vec = VectorRand() * 3
		local pos = self:LocalToWorld(vec)
		local particle = self.Emitter:Add(self.Material, self.Owner:GetPos())

		particle:SetVelocity( self.Vel + self.Multiplier )
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