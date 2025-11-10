-- Système de gestion des permissions
-- Créé par discord : nano.pasa

-- Récupérer le grade d'un joueur
function GetPlayerAdminRank(source)
    local identifiers = GetPlayerIdentifiers(source)
    
    for _, identifier in pairs(identifiers) do
        if Config.Admins[identifier] then
            return Config.Admins[identifier]
        end
    end
    
    return nil
end

-- Vérifier si un joueur a une permission spécifique
function HasPermission(source, permission)
    local rank = GetPlayerAdminRank(source)
    
    if not rank then
        return false
    end
    
    if Config.Permissions[rank] then
        for _, perm in pairs(Config.Permissions[rank]) do
            if perm == permission then
                return true
            end
        end
    end
    
    return false
end

-- Vérifier si un joueur est admin (n'importe quel grade)
function IsPlayerAdmin(source)
    return GetPlayerAdminRank(source) ~= nil
end

-- Event pour vérifier les permissions depuis le client
RegisterNetEvent('admin:checkPermission')
AddEventHandler('admin:checkPermission', function(permission)
    local source = source
    local hasPerm = HasPermission(source, permission)
    TriggerClientEvent('admin:permissionResult', source, permission, hasPerm)
end)

-- Event pour obtenir le grade du joueur
RegisterNetEvent('admin:getRank')
AddEventHandler('admin:getRank', function()
    local source = source
    local rank = GetPlayerAdminRank(source)
    TriggerClientEvent('admin:rankResult', source, rank)
end)

-- Event pour obtenir toutes les permissions du joueur
RegisterNetEvent('admin:getPermissions')
AddEventHandler('admin:getPermissions', function()
    local source = source
    local rank = GetPlayerAdminRank(source)
    local permissions = {}
    
    if rank and Config.Permissions[rank] then
        permissions = Config.Permissions[rank]
    end
    
    TriggerClientEvent('admin:permissionsResult', source, permissions, rank)
end)

-- Commande pour ajouter un admin (superadmin uniquement)
RegisterCommand('addadmin', function(source, args)
    if not HasPermission(source, 'manage_permissions') then
        TriggerClientEvent('chat:addMessage', source, {
            color = {255, 0, 0},
            multiline = true,
            args = {"Système", "Vous n'avez pas la permission"}
        })
        return
    end
    
    if #args < 2 then
        TriggerClientEvent('chat:addMessage', source, {
            color = {255, 165, 0},
            multiline = true,
            args = {"Système", "Usage: /addadmin [ID] [rank]"}
        })
        return
    end
    
    local targetId = tonumber(args[1])
    local rank = args[2]
    
    if not Config.Permissions[rank] then
        TriggerClientEvent('chat:addMessage', source, {
            color = {255, 0, 0},
            multiline = true,
            args = {"Système", "Grade invalide: superadmin, admin, moderator, support"}
        })
        return
    end
    
    if GetPlayerName(targetId) then
        local identifiers = GetPlayerIdentifiers(targetId)
        local identifier = identifiers[1] -- Premier identifiant (généralement steam)
        
        Config.Admins[identifier] = rank
        
        TriggerClientEvent('chat:addMessage', source, {
            color = {0, 255, 0},
            multiline = true,
            args = {"Système", string.format("Admin ajouté: %s (%s)", GetPlayerName(targetId), rank)}
        })
        
        TriggerClientEvent('chat:addMessage', targetId, {
            color = {0, 255, 0},
            multiline = true,
            args = {"Système", string.format("Vous avez été promu %s", rank)}
        })
        
        SendLog('addadmin', source, string.format("A ajouté %s (%s) comme %s", GetPlayerName(targetId), targetId, rank))
    else
        TriggerClientEvent('chat:addMessage', source, {
            color = {255, 0, 0},
            multiline = true,
            args = {"Système", "Joueur introuvable"}
        })
    end
end)

-- Exporter les fonctions pour les autres scripts
exports('GetPlayerAdminRank', GetPlayerAdminRank)
exports('HasPermission', HasPermission)
exports('IsPlayerAdmin', IsPlayerAdmin)

