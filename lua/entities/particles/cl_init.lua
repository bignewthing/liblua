
include('shared.lua')

function ENT:Initialize()
	self.Pos = self:GetPos()
	self.Emitter = ParticleEmitter(self.Pos)
	self.Material = Material(self.Texture, self.Params)
	self.NextPart = CurTime()
	self.Size = 5
	self.EndSize = 6.5
	self.Multiplier = 1
end

function ENT:Next(amount)
	if !isnumber(amount) then return false end

	self.NextPart = CurTime() + ((amount / 1000) / self.Multiplier)
	self.Speed = VectorRand(self.Owner:GetVelocity().y, self.Owner:GetVelocity().x)
	self.Pos = self.Pos + self.Bone

	return true
end

function ENT:ParticleSize(number1, number2)
	if !isnumber(number1) || !isnumber(number2) then return false end

	self.Size = number1
	self.EndSize = number2
	return true
end

function ENT:ChangeMultiplier(amount)
	if !isnumber(amount) then return false end

	self.Multiplier = (amount / self.Speed)
	return true
end

function ENT:Draw()
	self:DrawModel()
end

function ENT:Think()
	if self.NextPart < CurTime() then
		self:Next(2)

		self.Emitter:SetPos(self.Pos)

		local vec = VectorRand() * 3
		local pos = self:LocalToWorld(vec)
		local particle = self.Emitter:Add(self.Material, self.Pos)

		particle:SetVelocity( self.Speed )
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