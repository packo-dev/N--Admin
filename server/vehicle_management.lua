-- Gestion des véhicules côté serveur
-- Créé par discord : nano.pasa

-- Spawn un véhicule
RegisterNetEvent('admin:spawnVehicle')
AddEventHandler('admin:spawnVehicle', function(model)
    local source = source
    
    if not HasPermission(source, 'spawn_vehicle') then
        TriggerClientEvent('admin:notify', source, Config.Messages.no_permission)
        return
    end
    
    TriggerClientEvent('admin:spawnVehicleClient', source, model)
    SendLog('spawn_vehicle', source, string.format("Véhicule spawn: %s", model))
end)

-- Supprimer le véhicule actuel
RegisterNetEvent('admin:deleteVehicle')
AddEventHandler('admin:deleteVehicle', function()
    local source = source
    
    if not HasPermission(source, 'delete_vehicle') then
        TriggerClientEvent('admin:notify', source, Config.Messages.no_permission)
        return
    end
    
    TriggerClientEvent('admin:deleteVehicleClient', source)
    SendLog('delete_vehicle', source, "Véhicule supprimé")
end)

-- Réparer le véhicule
RegisterNetEvent('admin:repairVehicle')
AddEventHandler('admin:repairVehicle', function()
    local source = source
    
    if not HasPermission(source, 'repair_vehicle') then
        TriggerClientEvent('admin:notify', source, Config.Messages.no_permission)
        return
    end
    
    TriggerClientEvent('admin:repairVehicleClient', source)
    SendLog('repair_vehicle', source, "Véhicule réparé")
end)

-- Nettoyer le véhicule
RegisterNetEvent('admin:cleanVehicle')
AddEventHandler('admin:cleanVehicle', function()
    local source = source
    
    if not HasPermission(source, 'clean_vehicle') then
        TriggerClientEvent('admin:notify', source, Config.Messages.no_permission)
        return
    end
    
    TriggerClientEvent('admin:cleanVehicleClient', source)
    SendLog('clean_vehicle', source, "Véhicule nettoyé")
end)

-- Retourner le véhicule
RegisterNetEvent('admin:flipVehicle')
AddEventHandler('admin:flipVehicle', function()
    local source = source
    
    if not HasPermission(source, 'flip_vehicle') then
        TriggerClientEvent('admin:notify', source, Config.Messages.no_permission)
        return
    end
    
    TriggerClientEvent('admin:flipVehicleClient', source)
    SendLog('flip_vehicle', source, "Véhicule retourné")
end)

-- Booster le véhicule
RegisterNetEvent('admin:boostVehicle')
AddEventHandler('admin:boostVehicle', function(multiplier)
    local source = source
    
    if not HasPermission(source, 'boost_vehicle') then
        TriggerClientEvent('admin:notify', source, Config.Messages.no_permission)
        return
    end
    
    TriggerClientEvent('admin:boostVehicleClient', source, multiplier)
    SendLog('boost_vehicle', source, string.format("Boost véhicule: x%s", multiplier))
end)

-- Mode God véhicule
RegisterNetEvent('admin:godVehicle')
AddEventHandler('admin:godVehicle', function(toggle)
    local source = source
    
    if not HasPermission(source, 'god_vehicle') then
        TriggerClientEvent('admin:notify', source, Config.Messages.no_permission)
        return
    end
    
    TriggerClientEvent('admin:godVehicleClient', source, toggle)
    local status = toggle and "activé" or "désactivé"
    SendLog('god_vehicle', source, string.format("Mode God véhicule %s", status))
end)

-- Changer la couleur du véhicule
RegisterNetEvent('admin:changeVehicleColor')
AddEventHandler('admin:changeVehicleColor', function(primary, secondary)
    local source = source
    
    if not HasPermission(source, 'spawn_vehicle') then
        TriggerClientEvent('admin:notify', source, Config.Messages.no_permission)
        return
    end
    
    TriggerClientEvent('admin:changeVehicleColorClient', source, primary, secondary)
    SendLog('vehicle_color', source, string.format("Couleur changée: %s/%s", primary, secondary))
end)

-- Tune max le véhicule
RegisterNetEvent('admin:maxTuneVehicle')
AddEventHandler('admin:maxTuneVehicle', function()
    local source = source
    
    if not HasPermission(source, 'spawn_vehicle') then
        TriggerClientEvent('admin:notify', source, Config.Messages.no_permission)
        return
    end
    
    TriggerClientEvent('admin:maxTuneVehicleClient', source)
    SendLog('max_tune', source, "Véhicule tune max")
end)

