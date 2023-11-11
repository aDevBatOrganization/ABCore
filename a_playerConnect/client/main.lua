-- ######################################################################
--  verification du steam id du joeur et ajout dans la bdd si pas present
-- ######################################################################

Citizen.CreateThread(function()
    TriggerServerEvent("onJoin")
end)

-- #######################
-- notification de synchro
-- #######################

function SynchroNotification(text)
    SendNUIMessage({
        type = "showNotification",
        text = text,
        duration = 4000
    })
end

RegisterNetEvent('notif-synchro')
AddEventHandler('notif-synchro', function(text)
    SynchroNotification(text)
end)

-- ###############################
-- recuperer la position du joueur
-- ###############################

RegisterNetEvent("playerPos")
AddEventHandler("playerPos", function()
    local xPlayer = PlayerPedId()

    local x, y, z = table.unpack(GetEntityCoords(xPlayer, true))
    print(x .. " | " .. y .. " | " .. z)
    TriggerServerEvent("finishPlayerPos", x, y, z)
    return x, y, z
end)
