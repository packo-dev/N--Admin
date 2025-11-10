-- Script principal serveur
-- Créé par discord : nano.pasa

-- Event quand un joueur se connecte
AddEventHandler('playerConnecting', function(name, setKickReason, deferrals)
    local source = source
    local identifiers = GetPlayerIdentifiers(source)
    
    -- Vérifier si le joueur est banni (vous devez implémenter la base de données)
    -- Exemple:
    -- if IsPlayerBanned(identifiers) then
    --     deferrals.done("Vous êtes banni de ce serveur")
    -- end
end)

-- Commande pour ouvrir le menu
RegisterCommand('admin', function(source)
    if IsPlayerAdmin(source) then
        TriggerClientEvent('admin:openMenu', source)
    else
        TriggerClientEvent('admin:notify', source, Config.Messages.no_permission)
    end
end)

-- Commande pour obtenir son grade
RegisterCommand('myrank', function(source)
    local rank = GetPlayerAdminRank(source)
    if rank then
        TriggerClientEvent('chat:addMessage', source, {
            color = {0, 255, 0},
            multiline = true,
            args = {"Système", string.format("Votre grade: %s", rank)}
        })
    else
        TriggerClientEvent('chat:addMessage', source, {
            color = {255, 0, 0},
            multiline = true,
            args = {"Système", "Vous n'êtes pas admin"}
        })
    end
end)

-- Commande pour voir les admins en ligne
RegisterCommand('admins', function(source)
    local adminsOnline = {}
    local maxPlayers = GetNumPlayerIndices()
    
    for i = 0, maxPlayers - 1 do
        local playerId = GetPlayerFromIndex(i)
        if playerId ~= -1 then
            local rank = GetPlayerAdminRank(playerId)
            if rank then
                table.insert(adminsOnline, {
                    name = GetPlayerName(playerId),
                    rank = rank,
                    id = playerId
                })
            end
        end
    end
    
    if #adminsOnline > 0 then
        TriggerClientEvent('chat:addMessage', source, {
            color = {0, 255, 0},
            multiline = true,
            args = {"Système", string.format("Admins en ligne (%d):", #adminsOnline)}
        })
        
        for _, admin in pairs(adminsOnline) do
            TriggerClientEvent('chat:addMessage', source, {
                color = {255, 255, 255},
                multiline = true,
                args = {"", string.format("  • %s [%s] (ID: %d)", admin.name, admin.rank, admin.id)}
            })
        end
    else
        TriggerClientEvent('chat:addMessage', source, {
            color = {255, 165, 0},
            multiline = true,
            args = {"Système", "Aucun admin en ligne"}
        })
    end
end)

-- Commande d'aide
RegisterCommand('adminhelp', function(source)
    if not IsPlayerAdmin(source) then
        TriggerClientEvent('admin:notify', source, Config.Messages.no_permission)
        return
    end
    
    TriggerClientEvent('chat:addMessage', source, {
        color = {0, 255, 255},
        multiline = true,
        args = {"Menu Admin", "Commandes disponibles:"}
    })
    
    local commands = {
        "/admin - Ouvrir le menu admin",
        "/myrank - Voir votre grade",
        "/admins - Voir les admins en ligne",
        "/adminhelp - Afficher cette aide",
        "/addadmin [ID] [grade] - Ajouter un admin",
    }
    
    for _, cmd in pairs(commands) do
        TriggerClientEvent('chat:addMessage', source, {
            color = {255, 255, 255},
            multiline = true,
            args = {"", "  • " .. cmd}
        })
    end
end)

-- Message de démarrage
Citizen.CreateThread(function()
    print("^2=======================================^7")
    print("^2  N-Admin - Version 1.0.0^7")
    print("^6  Créé par discord : nano.pasa^7")
    print("^2  Chargement réussi!^7")
    print("^2=======================================^7")
end)

