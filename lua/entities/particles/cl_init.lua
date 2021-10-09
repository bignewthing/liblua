
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

function ENT:Next(amount)
	if !isnumber(amount) then return false end

	self.NextPart = CurTime() + (amount / self.Multiplier)
	print(self.NextPart)
	self.Speed = VectorRand(self.Owner:GetVelocity().y, self.Owner:GetVelocity().x)
	print(self.Speed)

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
	self:Next(0.02)

	if self.NextPart < CurTime() then
		self.Emitter:SetPos(self.Owner:GetPos())

		local vec = VectorRand() * 3
		local pos = self:LocalToWorld(vec)
		local particle = self.Emitter:Add(self.Material, self.Owner:GetPos())

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