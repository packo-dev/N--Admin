# 🚀 Guide d'Installation Rapide

## Installation en 5 minutes

### Étape 1: Télécharger
```bash
cd resources
git clone https://github.com/votre-repo/fivem-admin-menu.git
```

Ou téléchargez le ZIP et extrayez dans `resources/`

### Étape 2: Configuration Minimale

Ouvrez `config.lua` et modifiez:

```lua
-- Votre identifiant Steam/Discord
Config.Admins = {
    ["steam:VOTRE_STEAM_ID"] = "superadmin",
}

-- (Optionnel) Webhook Discord pour les logs
Config.Webhook = "https://discord.com/api/webhooks/..."
```

### Étape 3: Trouver votre Steam ID

1. Connectez-vous à votre serveur
2. Ouvrez la console F8
3. Tapez: `cl_debug`
4. Votre Steam ID s'affichera (format: `steam:110000XXXXXXXX`)

Ou utilisez ce site: https://steamid.io/

### Étape 4: Ajouter au server.cfg

```cfg
ensure fivem-admin-menu
```

### Étape 5: Redémarrer

```bash
restart fivem-admin-menu
```

## ✅ Vérification

1. Connectez-vous au serveur
2. Appuyez sur **F10** (ou tapez `/admin`)
3. Le menu devrait s'ouvrir !

---

## 🔧 Configuration Avancée

### Changer la touche d'ouverture

Dans `config.lua`:
```lua
Config.OpenMenuKey = 121 -- F10
```

Liste des touches: https://docs.fivem.net/docs/game-references/controls/

**Touches populaires:**
- `121` = F10
- `166` = F5
- `167` = F6
- `168` = F7
- `170` = F9

### Ajouter plusieurs admins

```lua
Config.Admins = {
    -- Superadmin
    ["steam:110000XXXXXXXX"] = "superadmin",
    ["discord:123456789012345678"] = "superadmin",
    
    -- Admin
    ["steam:110000YYYYYYYY"] = "admin",
    
    -- Moderateur
    ["steam:110000ZZZZZZZZ"] = "moderator",
}
```

### Configurer le Webhook Discord

1. Sur votre serveur Discord:
   - Paramètres du serveur → Intégrations → Webhooks
   - Créer un webhook
   - Copier l'URL

2. Dans `config.lua`:
```lua
Config.Webhook = "https://discord.com/api/webhooks/123456789/ABCdef..."
```

### Personnaliser les véhicules

Ajoutez vos propres véhicules dans `config.lua`:

```lua
{
    label = "🏎️ Mes Véhicules Custom",
    vehicles = {
        {name = "Ma Super Car", model = "nom_du_modele"},
        {name = "Mon SUV", model = "nom_du_modele"},
    }
}
```

### Ajouter des lieux de téléportation

```lua
{label = "🏢 Mon Lieu", coords = vector3(x, y, z)},
```

Pour obtenir les coordonnées:
- Allez à l'endroit souhaité en jeu
- Ouvrez F8
- Tapez: `getcoords`

---

## 🐛 Problèmes Courants

### Le menu ne s'ouvre pas

**Solution 1:** Vérifiez votre identifiant
```bash
# Dans F8
cl_debug
```

**Solution 2:** Utilisez la commande
```bash
/admin
```

**Solution 3:** Vérifiez les logs
```bash
# Dans la console serveur
resmon
```

### "Vous n'avez pas la permission"

1. Vérifiez que votre Steam ID est correct dans `Config.Admins`
2. Tapez `/myrank` pour voir votre grade actuel
3. Redémarrez la ressource: `restart fivem-admin-menu`

### Logs Discord ne fonctionnent pas

1. Testez le webhook sur Discord
2. Vérifiez que l'URL est complète
3. Vérifiez `Config.Webhook` dans config.lua

### Erreurs de console

**Erreur:** `attempt to call nil value`
- **Solution:** Redémarrez le serveur complètement

**Erreur:** `resource not found`
- **Solution:** Vérifiez le nom du dossier (doit être `fivem-admin-menu`)

---

## 📞 Besoin d'aide ?

- 💬 Discord: [Rejoindre](https://discord.gg/votre-serveur)
- 📧 Email: support@votreserveur.com
- 🐛 Issues: [GitHub](https://github.com/votre-repo/issues)

---

## ✅ Checklist Installation

- [ ] Menu téléchargé et extrait dans `resources/`
- [ ] Steam ID ajouté dans `config.lua`
- [ ] Ressource ajoutée dans `server.cfg`
- [ ] Serveur redémarré
- [ ] Menu testé (F10 ou `/admin`)
- [ ] Webhook Discord configuré (optionnel)
- [ ] Permissions configurées
- [ ] Véhicules personnalisés ajoutés (optionnel)

---

**🎉 Félicitations ! Votre menu admin est maintenant opérationnel !**

