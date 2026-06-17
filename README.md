# CDM 2026 — Coupe du Monde FIFA 2026

PWA autonome : calendrier, scores, grilles TV France et pronostics entre amis.

- **Repo :** `chapiber/cdm2026`
- **URL prod :** https://diveapps.serveblog.net/portailClub/apps/cdm2026/
- **API :** `/portailClub/api/cdm2026/`
- **BDD :** MariaDB `DiveKit`, tables `PORTAIL_CLUB_cdm_*`

## Structure

```
site/public/   → déployé vers NAS .../apps/cdm2026/
site/api/      → déployé vers NAS .../api/cdm2026/
sql/           → migrations (copiées dans site/public/sql au deploy)
tools/         → migrate.php, generate_cdm2026_seed.js, gen_cdm_icons.ps1
```

## Déploiement

```bat
deployer.bat
```

Destination NAS : `\\NasChapron\web\portailClub\apps\cdm2026` + `api\cdm2026`

Post-deploy migrations (SSH NAS) :

```bash
/usr/local/bin/php82 /volume1/web/portailClub/apps/cdm2026/tools/migrate.php
```

## MAJ données tournoi

- Automatique : job NAS `cdm2026-daily` (CursorAutomation)
- Manuelle : skill `.cursor/skills/cdm2026-update/`

Fichier cible : `site/public/data/cdm2026.json`

## Développement local

Secrets DB : copier `config.local.php` dans `site/public/` (non versionné) ou utiliser les secrets NAS en prod.
