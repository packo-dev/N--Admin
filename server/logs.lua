-- Système de logs
-- Créé par discord : nano.pasa

-- Envoyer un log vers Discord
function SendDiscordLog(title, description, color, fields)
    if Config.Webhook == "" or Config.Webhook == "VOTRE_WEBHOOK_DISCORD_ICI" then
        return
    end
    
    local embed = {
        {
            ["title"] = title,
            ["description"] = description,
            ["type"] = "rich",
            ["color"] = color or 3447003,
            ["fields"] = fields or {},
            ["footer"] = {
                ["text"] = os.date("%d/%m/%Y %H:%M:%S"),
            },
        }
    }
    
    PerformHttpRequest(Config.Webhook, function(err, text, headers) end, 'POST', json.encode({
        username = "Menu Admin - Logs",
        embeds = embed
    }), { ['Content-Type'] = 'application/json' })
end

-- Log générique
function SendLog(action, adminSource, details, targetSource)
    local adminName = GetPlayerName(adminSource) or "Console"
    local adminId = adminSource or "N/A"
    local targetName = targetSource and GetPlayerName(targetSource) or "N/A"
    local targetId = targetSource or "N/A"
    
    -- Log console
    if Config.ConsoleLogs then
        print(string.format("[ADMIN LOG] %s (%s) - Action: %s - Details: %s - Target: %s (%s)", 
            adminName, adminId, action, details, targetName, targetId))
    end
    
    -- Log Discord
    local color = 3447003 -- Bleu par défaut
    
    if action == "ban" or action == "kick" then
        color = 15158332 -- Rouge
    elseif action == "warn" then
        color = 16776960 -- Jaune
    elseif action == "give_money" or action == "give_item" then
        color = 3066993 -- Vert
    end
    
    local fields = {
        {
            ["name"] = "👤 Administrateur",
            ["value"] = string.format("%s (ID: %s)", adminName, adminId),
            ["inline"] = true
        },
        {
            ["name"] = "🎯 Action",
            ["value"] = action,
            ["inline"] = true
        },
    }
    
    if targetSource then
        table.insert(fields, {
            ["name"] = "👥 Cible",
            ["value"] = string.format("%s (ID: %s)", targetName, targetId),
            ["inline"] = true
        })
    end
    
    table.insert(fields, {
        ["name"] = "📝 Détails",
        ["value"] = details,
        ["inline"] = false
    })
    
    SendDiscordLog("🛡️ Action Administrateur", "", color, fields)
end

-- Log de connexion admin
RegisterNetEvent('playerConnecting')
AddEventHandler('playerConnecting', function()
    local source = source
    
    Citizen.Wait(5000) -- Attendre que le joueur soit complètement connecté
    
    if IsPlayerAdmin(source) then
        local rank = GetPlayerAdminRank(source)
        SendLog('admin_connect', source, string.format("Connexion avec le grade: %s", rank))
    end
end)

-- Export de la fonction SendLog
exports('SendLog', SendLog)

