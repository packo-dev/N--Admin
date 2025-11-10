-- Actions sur le serveur côté client
-- Créé par discord : nano.pasa

-- Sync météo
RegisterNetEvent('admin:syncWeather')
AddEventHandler('admin:syncWeather', function(weather)
    SetWeatherTypeNowPersist(weather)
    SetWeatherTypePersist(weather)
    SetWeatherTypeNow(weather)
    SetWeatherTypeOverTime(weather, 1.0)
    
    ShowNotification(string.format("~g~Météo: %s", weather))
end)

-- Sync time
RegisterNetEvent('admin:syncTime')
AddEventHandler('admin:syncTime', function(hour, minute)
    NetworkOverrideClockTime(hour, minute, 0)
    
    ShowNotification(string.format("~g~Heure: %02d:%02d", hour, minute))
end)

-- Clear area
RegisterNetEvent('admin:clearAreaClient')
AddEventHandler('admin:clearAreaClient', function(radius)
    local playerPed = PlayerPedId()
    local coords = GetEntityCoords(playerPed)
    
    -- Clear véhicules
    local vehicles = GetGamePool('CVehicle')
    for _, vehicle in pairs(vehicles) do
        local vehicleCoords = GetEntityCoords(vehicle)
        local distance = #(coords - vehicleCoords)
        
        if distance <= radius then
            DeleteVehicle(vehicle)
        end
    end
    
    -- Clear peds
    local peds = GetGamePool('CPed')
    for _, ped in pairs(peds) do
        if not IsPedAPlayer(ped) then
            local pedCoords = GetEntityCoords(ped)
            local distance = #(coords - pedCoords)
            
            if distance <= radius then
                DeletePed(ped)
            end
        end
    end
    
    -- Clear objets
    local objects = GetGamePool('CObject')
    for _, object in pairs(objects) do
        local objectCoords = GetEntityCoords(object)
        local distance = #(coords - objectCoords)
        
        if distance <= radius then
            DeleteObject(object)
        end
    end
    
    ShowNotification(string.format("~g~Zone nettoyée (rayon: %sm)", radius))
end)

-- Clear tous les PNJ
RegisterNetEvent('admin:clearAllPedsClient')
AddEventHandler('admin:clearAllPedsClient', function()
    local peds = GetGamePool('CPed')
    
    for _, ped in pairs(peds) do
        if not IsPedAPlayer(ped) then
            DeletePed(ped)
        end
    end
    
    ShowNotification("~g~Tous les PNJ ont été supprimés")
end)

