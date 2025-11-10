# 🤝 Guide de Contribution

Merci de votre intérêt pour contribuer au Menu Admin Pro !

## 🌟 Comment Contribuer

### Signaler un Bug 🐛

1. Vérifiez qu'il n'existe pas déjà dans [Issues](https://github.com/votre-repo/issues)
2. Créez une nouvelle issue avec le template "Bug Report"
3. Incluez:
   - Description détaillée
   - Étapes pour reproduire
   - Comportement attendu vs actuel
   - Screenshots si possible
   - Version FiveM
   - Logs d'erreur

### Suggérer une Fonctionnalité 💡

1. Vérifiez dans [Issues](https://github.com/votre-repo/issues) si elle n'a pas déjà été suggérée
2. Créez une issue avec le template "Feature Request"
3. Décrivez:
   - La fonctionnalité souhaitée
   - Pourquoi elle serait utile
   - Comment elle pourrait fonctionner

### Soumettre du Code 💻

#### 1. Fork le Projet

```bash
git clone https://github.com/votre-username/fivem-admin-menu.git
cd fivem-admin-menu
```

#### 2. Créer une Branche

```bash
git checkout -b feature/MaSuperFonctionnalite
```

Nommage des branches:
- `feature/` - Nouvelles fonctionnalités
- `fix/` - Corrections de bugs
- `docs/` - Documentation
- `style/` - Améliorations UI/UX
- `refactor/` - Refactoring de code

#### 3. Coder

- Suivez le style de code existant
- Commentez les parties complexes
- Testez sur un serveur de développement

#### 4. Commit

```bash
git add .
git commit -m "feat: ajout de la fonctionnalité X"
```

Format des commits:
- `feat:` - Nouvelle fonctionnalité
- `fix:` - Correction de bug
- `docs:` - Documentation
- `style:` - Formatage, UI
- `refactor:` - Refactoring
- `test:` - Tests
- `chore:` - Tâches de maintenance

#### 5. Push

```bash
git push origin feature/MaSuperFonctionnalite
```

#### 6. Pull Request

1. Allez sur GitHub
2. Créez une Pull Request
3. Décrivez vos changements
4. Attendez la review

## 📝 Standards de Code

### Lua

```lua
-- Bonnes pratiques
local function myFunction(param1, param2)
    -- Commentaire explicatif
    local result = param1 + param2
    return result
end

-- Nommage
local myVariable = "valeur"  -- camelCase
MY_CONSTANT = 100            -- UPPERCASE

-- Indentation: 4 espaces
```

### JavaScript

```javascript
// Bonnes pratiques
function myFunction(param1, param2) {
    // Commentaire explicatif
    const result = param1 + param2;
    return result;
}

// Nommage
const myVariable = 'valeur';  // camelCase
const MY_CONSTANT = 100;      // UPPERCASE

// Indentation: 4 espaces
```

### HTML/CSS

```html
<!-- HTML bien structuré -->
<div class="container">
    <h1 class="title">Titre</h1>
    <p class="description">Description</p>
</div>
```

```css
/* CSS organisé */
.container {
    display: flex;
    flex-direction: column;
    gap: 10px;
}

.title {
    font-size: 24px;
    font-weight: 700;
}
```

## 🧪 Tests

Avant de soumettre:

1. **Testez sur un serveur de développement**
   - Vérifiez toutes les fonctionnalités modifiées
   - Testez avec différents grades (superadmin, admin, moderator)
   - Vérifiez les logs console et Discord

2. **Vérifiez la compatibilité**
   - FiveM dernière version
   - ESX (si applicable)
   - QBCore (si applicable)

3. **Testez l'UI**
   - Différentes résolutions
   - Tous les navigateurs NUI
   - Responsive

## 📚 Documentation

Si vous modifiez des fonctionnalités:

1. Mettez à jour `README.md`
2. Ajoutez des commentaires dans le code
3. Mettez à jour `INSTALLATION.md` si nécessaire

## 🎨 Idées de Contribution

### Facile 🟢
- Corriger des fautes de frappe
- Améliorer la documentation
- Ajouter des véhicules dans la config
- Traduire en d'autres langues

### Moyen 🟡
- Ajouter de nouveaux outils personnels
- Améliorer l'UI
- Optimiser les performances
- Ajouter des animations

### Difficile 🔴
- Système de base de données pour les bans
- Système de warnings avec compteur
- Historique détaillé des actions
- Intégration avec d'autres frameworks

## 🚫 Ce Qu'il Ne Faut PAS Faire

- ❌ Copier du code sans attribution
- ❌ Ajouter des backdoors ou code malveillant
- ❌ Casser la compatibilité existante
- ❌ Ignorer les standards de code
- ❌ Soumettre du code non testé

## 📋 Checklist Pull Request

Avant de soumettre, vérifiez que:

- [ ] Le code suit les standards
- [ ] Tout est testé et fonctionne
- [ ] La documentation est à jour
- [ ] Les commits sont bien nommés
- [ ] Aucun fichier inutile n'est inclus
- [ ] Les logs/console sont propres
- [ ] L'UI est responsive (si modifiée)

## 💬 Questions ?

- 💬 Discord: [Rejoindre](https://discord.gg/votre-serveur)
- 📧 Email: dev@votreserveur.com

## 🏆 Contributeurs

Un grand merci à tous les contributeurs !

<!-- ALL-CONTRIBUTORS-LIST:START -->
<!-- Sera rempli automatiquement -->
<!-- ALL-CONTRIBUTORS-LIST:END -->

## 📜 Code de Conduite

- Soyez respectueux et constructif
- Accueillez les nouveaux contributeurs
- Restez professionnel dans les discussions
- Pas de spam, trolling, ou comportement toxique

---

**Merci de contribuer à rendre ce menu encore meilleur ! 🚀**

