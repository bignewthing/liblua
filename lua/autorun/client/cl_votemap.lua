local on_prompt = false;

net.Receive("VoteMap_Open", function()
    local tbl = net.ReadTable();

    PrintTable(tbl)

    local frame = vgui.Create("GCore:DFrame")
    :SetSize(ScrW(), ScrH())
    :SetHeader("ChaCha Vote", 50, { marginRight = 10 })
    :Center()
    :SetDraggable(true)
    :MakePopup()

    local panel = vgui.Create("GCore:DScrollPanel", frame)
    :SetSize(frame:GetWide(), frame:GetTall())
    :SetPos(20, 70)
    :AddIconLayout(10,10)

    for k, v in pairs(tbl) do   
        if (!v) then continue end

        local but = vgui.Create("GCore:DButton", panel:GetIconLayout())
        :SetSize(512, 64)
        :SetFont(GCore.Lib:GetFont(18, "Roboto"))
        :SetDefaultText('Voter pour: ' .. k,{type="fas",size=18,unicode="f00c"}) 

        function but:DoClick()
            if (on_prompt) then return end

            GCore.Lib:Confirm("Confirmation", "Confirmer la sélection?", { blur=true }, function()
                net.Start("VoteMap_Select");
                net.WriteString(k); 
                net.SendToServer();
            end)
        end
    end

    for i = 1, #team.GetPlayers(2) do   
        local but = vgui.Create("GCore:DButton", panel:GetIconLayout())
        :SetSize(512, 64)
        :SetFont(GCore.Lib:GetFont(18, "Roboto"))
        :SetDefaultText('A Voté: ' .. team.GetPlayers(2)[i]:GetNWString("PlayerDidVote", "N'a pas voté..."),{type="fas",size=18,unicode=""}) 
    
        local avatar = vgui.Create( "AvatarImage", but )
        avatar:SetSize( 64, 64 )
        avatar:SetPlayer( team.GetPlayers(2)[i], 64 )

        function but:DoClick()

        end
    end
end)

local frame = vgui.Create("GCore:DFrame")
local lock = false

local function ScoreBoard(close)
    if (!close && !lock) then
        if (!IsValid(frame)) then
            frame = vgui.Create("GCore:DFrame")
        end

        frame:SetSize(ScrW(), ScrH())
        :SetHeader("ChaCha - Scoreboard", 50, { marginRight = 10 })
        :Center()
        :SetVisible(true)
    
        local panel = vgui.Create("GCore:DScrollPanel", frame)
        :SetSize(frame:GetWide(), frame:GetTall())
        :SetPos(20, 70)
        :AddIconLayout(10, 10)
    
        for i = 1, #player.GetAll() do   
            local v = player.GetAll()[i]
            local team_name = "Observer!"
            if (v:Team() != 2) then
                team_name = "Jouer!"
            end

            local but = vgui.Create("GCore:DButton", panel:GetIconLayout())
            :SetSize(512, 64)
            :SetFont(GCore.Lib:GetFont(18, "Roboto"))
            :SetDefaultText(v:Nick() .. " " .. v:SteamID(),{type="fas",size=18,unicode=""}) 
        
            local avatar = vgui.Create("AvatarImage", but)
            avatar:SetSize(64, 64)
            avatar:SetPlayer(v, 64)
        end

        local team_name = GCore.Lib:Ternary(LocalPlayer():Team() == 2, "Spectateurs", "Joueurs");

        local but = vgui.Create("GCore:DButton", panel:GetIconLayout())
        :SetSize(512, 64)
        :SetFont(GCore.Lib:GetFont(18, "Roboto"))
        :SetDefaultText("Changer vers " .. team_name,{type="fas",size=18,unicode=""})
        :SetBackgroundColor(Color(14,76,175,130),Color(255,0,0,160));
    
        function but:DoClick() 
            if (LocalPlayer():Team() != 2) then
                RunConsoleCommand("mu_jointeam", 2)
            else
                RunConsoleCommand("mu_jointeam", 1)
            end

            frame:Close()
        end
    else
        if (IsValid(frame) && !lock) then
            frame:Remove()
        end
    end
end

hook.Add("Think", "ChaCha-KeyPress", function()
    if (input.IsMouseDown(MOUSE_RIGHT)) then
        lock = true
    elseif (input.IsMouseDown(MOUSE_LEFT)) then
        lock = false
    end
end)

hook.Add("ScoreboardShow", "ChaCha-Scoreboard-Show", function()
    ScoreBoard(false)
end)

hook.Add("ScoreboardHide", "ChaCha-Scoreboard-Hide", function()
    ScoreBoard(true)
end)