LibC = LibC or {}
LibC.Spectate = LibC.Spectate or {}

function LibC.Spectate:SpectatePlayer(Player, Spectatee)
    if (!IsValid(Player) or !Player:IsPlayer()) then return false end

    Player.Spectating = true
    Player.Spectatee = Spectatee
    Player.SpectateMode = OBS_MODE_CHASE

    return true
end

function LibC.Spectate:StartSpectate(Player)
    if (!IsValid(Player) or !Player:IsPlayer()) then return false end

    for k, v in pairs(Player:GetWeapons()) do
        Player.SpectateWeapons[k] = v:GetClass()
    end

    Player:StripWeapons();
    Player:GodEnable();
    Player:Spectate(Player.SpectateMode)
    Player:SpectateEntity(Player.Spectatee);

    return true
end

function LibC.Spectate:UnSpectate(Player)
    if (!IsValid(Player) or !Player:IsPlayer()) then return false end

    LibC.Promise:Init(function()
        if (!istable(Player.SpectateWeapons)) then return false end

        for k, v in pairs(Player.SpectateWeapons) do
            Player:Give(v);
        end

        return true
    end):Do(Player):Then(function()
        Player:GodDisable();
        Player:SpectateEntity(NULL);
        Player:UnSpectate()
    end, Player):Catch();

    return true 
end