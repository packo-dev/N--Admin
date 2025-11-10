-- Système de Reports - Client
-- Créé par discord : nano.pasa

-- Commande /report pour les joueurs
RegisterCommand('report', function(source, args)
    if #args < 1 then
        -- Message d'aide
        TriggerEvent('chat:addMessage', {
            color = {255, 165, 0},
            multiline = true,
            args = {"N-Admin", "Usage: /report [votre message]"}
        })
        
        TriggerEvent('chat:addMessage', {
            color = {255, 255, 255},
            multiline = true,
            args = {"", "Exemple: /report J'ai besoin d'aide"}
        })
        return
    end
    
    -- Assembler le message
    local message = table.concat(args, " ")
    
    if #message < 5 then
        TriggerEvent('chat:addMessage', {
            color = {255, 0, 0},
            multiline = true,
            args = {"N-Admin", "Le message doit contenir au moins 5 caractères"}
        })
        return
    end
    
    -- Envoyer le report au serveur
    TriggerServerEvent('admin:createReport', message)
    
    -- Confirmation visuelle
    TriggerEvent('chat:addMessage', {
        color = {0, 255, 0},
        multiline = true,
        args = {"N-Admin", "✅ Report envoyé ! Un admin va vous répondre."}
    })
    
    ShowNotification("~g~Report envoyé avec succès")
end)

-- Suggestion : Commande /reporthelp
RegisterCommand('reporthelp', function()
    TriggerEvent('chat:addMessage', {
        color = {102, 126, 234},
        multiline = true,
        args = {"N-Admin - Aide Report", "━━━━━━━━━━━━━━━━━━━━━━━━"}
    })
    
    TriggerEvent('chat:addMessage', {
        color = {255, 255, 255},
        multiline = true,
        args = {"", "📢 Comment contacter un admin ?"}
    })
    
    TriggerEvent('chat:addMessage', {
        color = {255, 255, 255},
        multiline = true,
        args = {"", "  Usage: /report [votre message]"}
    })
    
    TriggerEvent('chat:addMessage', {
        color = {255, 255, 255},
        multiline = true,
        args = {"", "  Exemples:"}
    })
    
    TriggerEvent('chat:addMessage', {
        color = {255, 255, 255},
        multiline = true,
        args = {"", "    • /report J'ai besoin d'aide"}
    })
    
    TriggerEvent('chat:addMessage', {
        color = {255, 255, 255},
        multiline = true,
        args = {"", "    • /report Un joueur me tue en spawn"}
    })
    
    TriggerEvent('chat:addMessage', {
        color = {255, 255, 255},
        multiline = true,
        args = {"", "    • /report Question sur le serveur"}
    })
    
    TriggerEvent('chat:addMessage', {
        color = {102, 126, 234},
        multiline = true,
        args = {"", "💜 Créé par discord : nano.pasa"}
    })
end)

