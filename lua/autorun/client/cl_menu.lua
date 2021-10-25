include("cl_utils.lua")

surface.CreateFont("menuFont", {
	font = "coolvetica",
	size = 20,
	weight = 100,
})

local clientMenu = {}

function CMenu()
	return clientMenu
end

clientMenu.baseColor = Color(88, 24, 69, 255)
clientMenu.frameColor = Color(234, 234, 234)

function clientMenu.OpenMenu(isVote, args)
	local scrw, scrh = ScrW(), ScrH()
	if IsValid(clientMenu.Menu) then
		clientMenu.Menu:Remove()
	end

	clientMenu.x, clientMenu.y = scrw * .5, scrh * .5

	local time, delay, ease = 1.8, 0, .1

	clientMenu.Menu = vgui.Create("DFrame")
	clientMenu.Menu:SetTitle("")
	clientMenu.Menu:ShowCloseButton(false)
	clientMenu.Menu:MakePopup(true)
	clientMenu.Menu:SetSize(0, 0)

	local isAnimating = true

	clientMenu.Menu:SizeTo(clientMenu.x, clientMenu.y, time, delay, ease, function()
		isAnimating = false
	end)

	clientMenu.Menu.Paint = function(me, w, h)
		surface.SetDrawColor(clientMenu.frameColor)
		surface.DrawRect(0, 0, w, h)
	end
	
	clientMenu.Menu.OnSizeChanged = function(me, w, h)
		if isAnimating then
			me:Center()
		end
	end
end