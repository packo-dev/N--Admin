-- Gestion du serveur
-- Créé par discord : nano.pasa

-- Annonce globale
RegisterNetEvent('admin:announce')
AddEventHandler('admin:announce', function(message)
    local source = source
    
    if not HasPermission(source, 'announce') then
        TriggerClientEvent('admin:notify', source, Config.Messages.no_permission)
        return
    end
    
    TriggerClientEvent('chat:addMessage', -1, {
        color = {255, 0, 0},
        multiline = true,
        args = {"📢 ANNONCE", message}
    })
    
    SendLog('announce', source, message)
    TriggerClientEvent('admin:notify', source, "~g~Annonce envoyée")
end)

-- Changer la météo
RegisterNetEvent('admin:setWeather')
AddEventHandler('admin:setWeather', function(weather)
    local source = source
    
    if not HasPermission(source, 'weather') then
        TriggerClientEvent('admin:notify', source, Config.Messages.no_permission)
        return
    end
    
    TriggerClientEvent('admin:syncWeather', -1, weather)
    SendLog('weather', source, string.format("Météo changée: %s", weather))
    TriggerClientEvent('admin:notify', source, string.format("~g~Météo changée: %s", weather))
end)

-- Changer l'heure
RegisterNetEvent('admin:setTime')
AddEventHandler('admin:setTime', function(hour, minute)
    local source = source
    
    if not HasPermission(source, 'time') then
        TriggerClientEvent('admin:notify', source, Config.Messages.no_permission)
        return
    end
    
    TriggerClientEvent('admin:syncTime', -1, hour, minute)
    SendLog('time', source, string.format("Heure changée: %02d:%02d", hour, minute))
    TriggerClientEvent('admin:notify', source, string.format("~g~Heure changée: %02d:%02d", hour, minute))
end)

-- Clear area (nettoyer la zone)
RegisterNetEvent('admin:clearArea')
AddEventHandler('admin:clearArea', function(radius)
    local source = source
    
    if not HasPermission(source, 'clear_area') then
        TriggerClientEvent('admin:notify', source, Config.Messages.no_permission)
        return
    end
    
    TriggerClientEvent('admin:clearAreaClient', source, radius)
    SendLog('clear_area', source, string.format("Zone nettoyée (rayon: %sm)", radius))
    TriggerClientEvent('admin:notify', source, "~g~Zone nettoyée")
end)

-- Clear tous les véhicules
RegisterNetEvent('admin:clearAllVehicles')
AddEventHandler('admin:clearAllVehicles', function()
    local source = source
    
    if not HasPermission(source, 'clear_cars') then
        TriggerClientEvent('admin:notify', source, Config.Messages.no_permission)
        return
    end
    
    TriggerClientEvent('admin:clearAllVehiclesClient', -1)
    SendLog('clear_cars', source, "Tous les véhicules supprimés")
    TriggerClientEvent('admin:notify', source, "~g~Tous les véhicules ont été supprimés")
end)

-- Clear tous les peds
RegisterNetEvent('admin:clearAllPeds')
AddEventHandler('admin:clearAllPeds', function()
    local source = source
    
    if not HasPermission(source, 'clear_peds') then
        TriggerClientEvent('admin:notify', source, Config.Messages.no_permission)
        return
    end
    
    TriggerClientEvent('admin:clearAllPedsClient', -1)
    SendLog('clear_peds', source, "Tous les PNJ supprimés")
    TriggerClientEvent('admin:notify', source, "~g~Tous les PNJ ont été supprimés")
end)

-- Restart une ressource
RegisterNetEvent('admin:restartResource')
AddEventHandler('admin:restartResource', function(resourceName)
    local source = source
    
    if not HasPermission(source, 'restart_resource') then
        TriggerClientEvent('admin:notify', source, Config.Messages.no_permission)
        return
    end
    
    if GetResourceState(resourceName) ~= "missing" then
        StopResource(resourceName)
        Citizen.Wait(1000)
        StartResource(resourceName)
        
        SendLog('restart_resource', source, string.format("Ressource redémarrée: %s", resourceName))
        TriggerClientEvent('admin:notify', source, string.format("~g~Ressource redémarrée: %s", resourceName))
    else
        TriggerClientEvent('admin:notify', source, string.format("~r~Ressource introuvable: %s", resourceName))
    end
end)

-- Stop une ressource
RegisterNetEvent('admin:stopResource')
AddEventHandler('admin:stopResource', function(resourceName)
    local source = source
    
    if not HasPermission(source, 'stop_resource') then
        TriggerClientEvent('admin:notify', source, Config.Messages.no_permission)
        return
    end
    
    if GetResourceState(resourceName) ~= "missing" then
        StopResource(resourceName)
        
        SendLog('stop_resource', source, string.format("Ressource arrêtée: %s", resourceName))
        TriggerClientEvent('admin:notify', source, string.format("~g~Ressource arrêtée: %s", resourceName))
    else
        TriggerClientEvent('admin:notify', source, string.format("~r~Ressource introuvable: %s", resourceName))
    end
end)

-- Start une ressource
RegisterNetEvent('admin:startResource')
AddEventHandler('admin:startResource', function(resourceName)
    local source = source
    
    if not HasPermission(source, 'start_resource') then
        TriggerClientEvent('admin:notify', source, Config.Messages.no_permission)
        return
    end
    
    if GetResourceState(resourceName) ~= "missing" then
        StartResource(resourceName)
        
        SendLog('start_resource', source, string.format("Ressource démarrée: %s", resourceName))
        TriggerClientEvent('admin:notify', source, string.format("~g~Ressource démarrée: %s", resourceName))
    else
        TriggerClientEvent('admin:notify', source, string.format("~r~Ressource introuvable: %s", resourceName))
    end
end)

-- Obtenir la liste des ressources
RegisterNetEvent('admin:getResources')
AddEventHandler('admin:getResources', function()
    local source = source
    
    if not HasPermission(source, 'manage_server') then
        return
    end
    
    local resources = {}
    local resourceCount = GetNumResources()
    
    for i = 0, resourceCount - 1 do
        local resourceName = GetResourceByFindIndex(i)
        local resourceState = GetResourceState(resourceName)
        
        table.insert(resources, {
            name = resourceName,
            state = resourceState
        })
    end
    
    TriggerClientEvent('admin:receiveResources', source, resources)
end)

-- Obtenir les infos du serveur
RegisterNetEvent('admin:getServerInfo')
AddEventHandler('admin:getServerInfo', function()
    local source = source
    
    if not IsPlayerAdmin(source) then
        return
    end
    
    local players = GetNumPlayerIndices()
    local maxPlayers = GetConvarInt('sv_maxclients', 32)
    local serverName = GetConvar('sv_hostname', 'Unknown')
    
    TriggerClientEvent('admin:receiveServerInfo', source, {
        players = players,
        maxPlayers = maxPlayers,
        serverName = serverName
    })
end)

