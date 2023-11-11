-- ########################################
-- Regarder le steam id de tous les joueurs
-- ########################################

function getSteamId(playerId)
    local steamIdentifier = GetPlayerIdentifiers(playerId)
    for key, value in pairs(steamIdentifier) do
        if string.match(value, "steam:") then
            return value
        end
    end
    return nil
end

-- ######################################################################
--  verification du steam id du joeur et ajout dans la bdd si pas present
-- ######################################################################

RegisterNetEvent("onJoin")
AddEventHandler("onJoin", function()
    local _src = source
    local steamIdentifier = nil
    -- recuperer l'id steam du joueur qui se connecte

    for k, v in ipairs(GetPlayerIdentifiers(_src)) do
        if string.sub(v, 1, 5) == "steam" then
            steamIdentifier = v
            break
        end
    end

    if steamIdentifier then
        -- Vous avez le SteamID dans la variable steamIdentifier
        -- print("^2[JOIN]^7 : Le SteamID du joueur est : ^5" .. steamIdentifier)
        -- recuperer les joueur de la table user_fivem par leur steam id
        MySQL.Async.fetchAll("SELECT * FROM user_fivem WHERE steam_id = @a", { ["a"] = steamIdentifier },
            function(result)
                -- iteration de la table result
                local count = 0
                for i, v in ipairs(result) do
                    count = count + 1
                end
                -- verification de la presence du joueur dans la table
                if count > 0 then
                    -- le joueur est dans la table
                    -- print("^3[DB]^7 : Le joueur est dans la base de donner")
                else
                    -- le joueur n'est pas dans la table
                    -- print("^3[DB]^7 : Le joueur n'existe pas")
                    -- ajout du joueur dans la table user_fivem
                    MySQL.Async.execute("INSERT INTO user_fivem (player_name, money, steam_id) VALUES (@a, @b, @c)",
                        { ["a"] = GetPlayerName(_src), ["b"] = Config.MoneyStart, ["c"] = steamIdentifier }, function()
                            -- print("^3[DB] ^7 : Le joueur ^5" ..
                            --     GetPlayerName(_src) .. " ^7vient d'etre ajouter dans la bdd")
                        end)
                end
            end)
    else
        -- Le joueur n'a pas Steam d'ouvert ou n'est pas connecté avec Steam
        setKickReason('Vous devez avoir Steam ouvert pour jouer sur ce serveur.')
        CancelEvent()
    end

    -- print("^2[JOIN] ^7 : Le joueur ^5" ..
    --     GetPlayerName(_src) .. "^7 avec le steam id : ^5" .. steamIdentifier .. " ^7vient de se connecter !")
end)

-- ########################################
-- demander la position du joueur au client
-- ########################################

function storePlayerPositions()
    local players = GetPlayers() -- Récupère tous les joueurs actuellement connectés
    for _, playerId in pairs(players) do
        MySQL.Async.fetchAll("SELECT * FROM user_fivem WHERE steam_id = @a", { ["a"] = steamId },
            function(result)
                local count = 0
                for i, v in ipairs(result) do
                    count = count + 1
                end
                TriggerClientEvent("playerPos", playerId)
            end)
    end
end

-- ###################################
-- sauvegarde de la position du joueur
-- ###################################

RegisterNetEvent("finishPlayerPos")
AddEventHandler("finishPlayerPos", function(x, y, z)
    local players = GetPlayers()
    for k, playerId in pairs(players) do
        local steamId = getSteamId(playerId)
        MySQL.Async.execute("UPDATE user_fivem SET position = @position WHERE steam_id = @steamId", {
            ['@position'] = "{ x = " .. x .. " , y = " .. y .. ", z = " .. z .. "}",
            ['@steamId'] = steamId,
            print("Le joueur " ..
                steamId ..
                " est a la position x = " ..
                x .. " y = " .. y .. " z = " .. z .. " et sa position vien d'etre synchorniser en bddd")
        })
    end
end)

-- ###########################
-- synchronisation des joueurs
-- ###########################

Citizen.CreateThread(function()
    while true do
        storePlayerPositions()
        TriggerClientEvent('notif-synchro', -1, "Synchronisation du personnage")
        print("^1[SYNCHRO]^7 : Synchronisation des joueur")
        Citizen.Wait(60000)
    end
end)
