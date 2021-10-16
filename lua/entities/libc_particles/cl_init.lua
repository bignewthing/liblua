
include('shared.lua')

function ENT:Initialize()
	self.Emitter = ParticleEmitter(self.Offset)
	self.Material = Material(self.Texture, self.Params)
	self.NextPart = CurTime()
	self.Size = 15
	self.EndSize = 2
	self.Multiplier = 1
end

function ENT:Next(amount)
	if !isnumber(amount) then return false end

	self.NextPart = CurTime() + ((amount / 1000) / self.Multiplier)
	self.Speed = VectorRand(self.Owner:GetVelocity().y, self.Owner:GetVelocity().x)
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
		self:Next(4)
		self.Emitter:SetPos(self.Offset)

		local particle = self.Emitter:Add(self.Material, self.Offset)
		particle:SetVelocity( self.Speed )
		particle:SetDieTime( 30 )
		particle:SetStartAlpha( 255 )
		particle:SetEndAlpha( 40 )
		particle:SetStartSize( self.Size )
		particle:SetEndSize( self.EndSize )   
		particle:SetRoll( math.random(30, 120) )
		particle:SetRollDelta( 0 )
	end
end

function ENT:OnRemove()
	self.Emitter:Finish()
end