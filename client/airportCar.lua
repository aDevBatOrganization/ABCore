local xPlayer = PlayerPedId();


Citizen.CreateThread(function()
    while true do
        -- variables local

        local markerX = -1037.91;
        local markerY = -2737.73;
        local markerZ = 19.67;

        local pedPos = GetEntityCoords(xPlayer);
        local dist = vector3(markerX, markerY, markerZ);
        local distance = GetDistanceBetweenCoords(pedPos, dist, true)


        if distance < 15 then
            -- Marker

            DrawMarker(
                20 --[[ integer ]],
                markerX --[[ posx ]],
                markerY --[[ posy ]],
                markerZ --[[ posz ]],
                0.0 --[[ dirx ]],
                0.0 --[[ diry ]],
                0.0 --[[ dirz ]],
                0.0 --[[ rotx ]],
                0.0 --[[ roty ]],
                0.0 --[[ rotz ]],
                0.4 --[[ scalex ]],
                0.4 --[[ scaley ]],
                0.4 --[[ scalez ]],
                113 --[[ red ]],
                14 --[[ green ]],
                14 --[[ blue ]],
                170 --[[ alpha ]],
                1 --[[ bibupanddowm ]],
                1 --[[ facecamera ]],
                2 --[[ p19 ]],
                0 --[[ rotate ]],
                nil --[[ texturedir ]],
                nil --[[ texturename ]],
                0 --[[ drawonevents ]]
            );
            if distance < 1 then
                AddTextEntry("HELP", "Appuyez sur ~INPUT_CONTEXT~ pour demander un Kalahari.");
                DisplayHelpTextThisFrame("HELP", false)
                if IsControlJustPressed(1, 51) then
                    spawnCar("kalahari")
                end
            end
        end

        -- ----
        Citizen.Wait(10)
    end
end)

function spawnCar(car)
    local car = GetHashKey(car);
    local posVehicleX = -1032.04;
    local posVehicleY = -2729.18;
    local posVehicleZ = 20.16;
    local posVehicleH = 245.43;

    RequestModel(car);
    while not HasModelLoaded(car) do
        RequestModel(car);
        Citizen.Wait(50);
    end
    local x, y, z = table.unpack(GetEntityCoords(PlayerPedId(), false))
    local vehicle = CreateVehicle(car, posVehicleX, posVehicleY, posVehicleZ, posVehicleH, true, false);
    SetPedIntoVehicle(xPlayer, vehicle, -1);

    SetEntityAsNoLongerNeeded(vehicle);
end
