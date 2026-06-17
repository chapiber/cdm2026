---
name: cdm2026-update
description: >-
  Scanne le web pour mettre à jour les scores, classements et grilles TV de
  l'app Coupe du Monde 2026 (cdm2026.json). Utiliser quand
  l'utilisateur invoque @cdm2026-update ou demande d'actualiser la CDM 2026.
disable-model-invocation: true
---

# CDM 2026 ? Mise à jour données

> **Automatisation NAS** : la MAJ quotidienne (n8n ? skills-runner) est **programmatique** (`handler: cdm_update`). Cette skill reste pour les **mises à jour manuelles** depuis l'IDE.

## Fichiers cibles

| Fichier | Rôle |
|---------|------|
| `site/public/data/cdm2026.json` | Source de vérité (104 matchs, 48 équipes, 12 poules) |
| `.cursor/skills/cdm2026-update/schema.json` | Schéma de validation |
| `tools/generate_cdm2026_seed.js` | Générateur seed (référence structure / TV M6) |

## Livraison

1. Écrire `site/public/data/cdm2026.json`
2. `git commit` dans `cdm2026/` ? message : `chore: MAJ données CDM 2026`
3. `git push origin main`
4. Exécuter `deployer.bat` depuis `cdm2026/`

Pas de `migrate.php` (aucune BDD pour les scores).

## Rapport utilisateur

- Nombre de matchs mis à jour (scores / TV)
- Sources consultées
- Hash commit, branche, statut push et deploy

Pour le détail des étapes de scan web, fusion, standings et validation : voir sections complètes dans l'historique du skill ou le README du dépôt.
