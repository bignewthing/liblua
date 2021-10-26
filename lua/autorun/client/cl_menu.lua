surface.CreateFont("menuFont", {
	font = "coolvetica",
	size = 20,
	weight = 100,
})

local clientMenu = {}

function CMenu()
	return clientMenu
end

clientMenu.baseColor = Color(51, 13, 40)
clientMenu.frameColor = Color(88, 24, 69, 255)

function clientMenu.OpenMenu()
	local scrw, scrh = ScrW(), ScrH()
	if IsValid(clientMenu.Menu) then
		clientMenu.Menu:Remove()
	end

	clientMenu.x, clientMenu.y = scrw * .5, scrh * .5

	local time, delay, ease = 1.8, 0, .1

	clientMenu.Menu = vgui.Create("DFrame")
	clientMenu.Menu:SetTitle("LaSecteRose - Options")
	clientMenu.Menu:ShowCloseButton(true)
	clientMenu.Menu:MakePopup(true)
	clientMenu.Menu:SetSize(0, 0)

	local isAnimating = true

	clientMenu.Menu:SizeTo(clientMenu.x, clientMenu.y, time, delay, ease, function()
		isAnimating = false
	end)

	clientMenu.Menu.Paint = function(me, w, h)
		draw.RoundedBox(10, 0, 0, w, h, clientMenu.baseColor )
	end

	clientMenu.Menu.OnSizeChanged = function(me, w, h)
		if isAnimating then
			me:Center()
		end
	end
end

CMenu().OpenMenu() 