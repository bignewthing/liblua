surface.CreateFont("CCS", {
	font = "Helvetica",
	size = 50,
})

surface.CreateFont("CCSPlayer", {
	font = "Helvetica",
	size = 30,
})

local smoothHealth = 1000
local blur = Material("pp/blurscreen")
local isTrading = false

function render.BlurBox(x, y, w, h, heavyness, amount)
	surface.SetDrawColor(32, 32, 32, 155)
	surface.SetMaterial(blur)

	for i = 1, heavyness do
		blur:SetFloat("$blur", (i / 3) * (amount or 6))
		blur:Recompute()

		render.UpdateScreenEffectTexture()

		render.SetScissorRect(x, y, x + w, y + h, true)
			surface.DrawTexturedRect(0 * -1, 0 * -1, ScrW(), ScrH())
		render.SetScissorRect(0, 0, 0, 0, false)
	end
end

local col

local t1, t2 = name or "debug " , choosenName or "debug "

function draw.cdnHud(ply)
	if (engine.ActiveGamemode() == "murder") then return end
	ply = ply or LocalPlayer()

	local col = ply:GetPlayerColor()
	col = Color(col.x * 255, col.y * 255, col.z * 255)

	smoothHealth = Lerp(0.1, smoothHealth, ply:Health())

	draw.DrawText(GAMEMODE.LootCollected.." | 5" or ply:Nick(), "CCS", 50, ScrH()-180, col)
	draw.DrawText(ply:GetNWString("bystanderName", "Innocent"), "CCSPlayer", 50, ScrH()-120, col)
	draw.RoundedBox(30, 20, ScrH()-65, smoothHealth * 5, 15, col)
end 

hook.Add("HUDPaint", "cdn.paint.hud", function()
	if LocalPlayer():Alive() then
		draw.cdnHud()
	end
end)

