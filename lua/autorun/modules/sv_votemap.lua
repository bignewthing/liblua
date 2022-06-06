util.AddNetworkString("VoteMap_Open")
util.AddNetworkString("VoteMap_Select")

LibC = LibC or {}

LibC.Votes = {};
LibC.Count = 0;
LibC.Enabled = false;
LibC.RoundLeft = 20;

LibC.MapList = {
    ["mu_greenwood"] = true,
    ["hns_poolparty"] = true,
    ["mu_nightmare_church"] = true,
    ["museum"] = true,
    ["hns_lazytown_advanced"] = true,
    ["gm_poolday"] = true,
    ["ph_abandoned_office"] = true,
    ["sz_castle_keep_snowy"] = true,
    ["cs_office_night"] = true,
    ["mcdonalds-mds-v2-beta"] = true,
};

local function activate_votemap()
    LibC.Enabled = true;

    LibC.Count = 0;
    LibC.Votes = {}

    local pool = {};

    for k, v in pairs(LibC.MapList) do
        if (k == game.GetMap()) then continue end
        pool[k] = v;
    end

    net.Start("VoteMap_Open")
    net.WriteTable(pool)
    net.Broadcast()
end

LibC.RTVMinPlayers = 6
LibC.DelayChange = 2
LibC.Delay = 15

function LibC:AddVote(player, map)
    if (!LibC.Enabled) then return false end
    if (!IsValid(player)) then return false end
    if (!LibC.MapList[map]) then return false end
    if (LibC.Votes[player]) then return false end

    LibC.Votes[player] = map;

    player:SetNWString("PlayerDidVote", map);

    PrintMessage(HUD_PRINTTALK, player:Nick() .. " a voté " .. map);

    print("------------------------------------");
    print("Steam-ID: " .. player:SteamID());
    print("Nick: " .. player:Nick());
    print("------------------------------------");

    return true;
end

function LibC:StartTick()
    if (timer.Exists("ChaCha:VoteTick")) then return false end

    timer.Create("ChaCha:VoteTick", LibC.Delay, 1, function()
        local occurences = {}
        local highest, highest_map

        for k, v in pairs(LibC.Votes) do
            occurences[v] = occurences[v] or 0 + 1;

            print(occurences[v])
        end

        for k, v in pairs(occurences) do
            if highest == nil || highest < v then
                highest = v
                highest_map = k
            end

            if v >= highest then
                highest = v;
            end
        end

        PrintMessage(HUD_PRINTCENTER, highest_map .. " a été choisi comme étant la prochaine map!");
        
        timer.Simple(LibC.DelayChange, function()
            LibC:ChangeMap(highest_map)
        end)
    end)

    return true
end

function LibC:ChangeMap(map)
    if (game.GetMap() == map) then return false end // vérifie, si la map demandé n'est pas celle qu'on a déjà.

    RunConsoleCommand("changelevel", map);
    
    LibC.Count = 0;
    LibC.Votes = {}
    LibC.RoundLeft = 20;
    LibC.Enabled = false;
    player:SetNWString("PlayerDidVote", "N'a pas voté...");

    return true;
end

net.Receive("VoteMap_Select", function(len, ply)
    local str = net.ReadString();
    LibC:AddVote(ply, str);
    
    if (LibC.Enabled) then
        if (LibC:StartTick()) then print("Started timer!") end
    end
end)

hook.Add("PlayerSay", "ChaCha-RTV", function(player, text)
    if (text == "!rtv" && !player:GetNWBool("HasRTV", false)) then 
        if (LibC.RTVMinPlayers > #team.GetPlayers(2)) then 
            player:PrintMessage(HUD_PRINTCENTER, "Le RTV est desactivé a moins de " .. LibC.RTVMinPlayers .. " joueurs.");
            return "" 
        end
        
        player:SetNWBool("HasRTV", true);

        LibC.Count = LibC.Count + 1;

        if (LibC.Count >= #team.GetPlayers(2) / 1.5) then 
            activate_votemap()
        else 
            PrintMessage(HUD_PRINTCENTER, player:Nick() .. " veut RockTheVote! " .. LibC.Count .. "/4");
        end
    end

    if (player:IsSuperAdmin()) then
        if text == "!force_vote" then
            activate_votemap();
        end
    end
end)

hook.Add("OnEndRound", "ChaCha-RoundCounter", function()
    if (LibC.RoundLeft < 1) then
        activate_votemap()
    else
        LibC.RoundLeft = LibC.RoundLeft - 1;
    end
end)