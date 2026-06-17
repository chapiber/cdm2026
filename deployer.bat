@echo off
setlocal EnableExtensions EnableDelayedExpansion

set "ROOT=%~dp0"
set "PUBLIC=%ROOT%site\public"
set "API=%ROOT%site\api"
set "DEST_BASE=\\NasChapron\web\portailClub"
set "DEST_APP=%DEST_BASE%\apps\cdm2026"
set "DEST_API=%DEST_BASE%\api\cdm2026"
set "LOGDIR=%ROOT%deploy_logs"
if not exist "%LOGDIR%" mkdir "%LOGDIR%"
for /f "usebackq delims=" %%T in (`powershell -NoProfile -Command "Get-Date -Format 'yyyyMMdd_HHmmss'"`) do set "LOGTS=%%T"
set "LOGFILE=%LOGDIR%\deploy_cdm2026_!LOGTS!.log"

echo ============================================
echo Deploiement CDM 2026 vers %DEST_BASE%
echo Journal : %LOGFILE%
echo ============================================

if not exist "%PUBLIC%\index.html" (
  echo [ERREUR] Source introuvable : %PUBLIC%
  exit /b 1
)

if not exist "%DEST_BASE%" (
  echo [INFO] Creation destination...
  mkdir "%DEST_BASE%" 2>nul
)

(
  echo [INFO] Deploy front apps/cdm2026...
  robocopy "%PUBLIC%" "%DEST_APP%" /MIR /R:2 /W:3 /XD ".git" "deploy_logs" /XF "config.local.php" /NFL /NDL /NJH /NJS /NC /NS /NP
  set "RC1=!ERRORLEVEL!"

  echo [INFO] Deploy API api/cdm2026...
  robocopy "%API%" "%DEST_API%" /MIR /R:2 /W:3 /XD ".git" /NFL /NDL /NJH /NJS /NC /NS /NP
  set "RC2=!ERRORLEVEL!"
) >>"%LOGFILE%" 2>&1

if !RC1! GEQ 8 (
  echo [ERREUR] Robocopy front code !RC1! — voir %LOGFILE%
  exit /b !RC1!
)
if !RC2! GEQ 8 (
  echo [ERREUR] Robocopy API code !RC2! — voir %LOGFILE%
  exit /b !RC2!
)

echo [INFO] Cache-bust __BUILD_VERSION__ = %LOGTS%...
powershell -NoProfile -Command "$bv='%LOGTS%'; $f='%DEST_APP%\index.html'; if(Test-Path $f){ $c=[IO.File]::ReadAllText($f,[Text.UTF8Encoding]::new($false)) -replace '__BUILD_VERSION__',$bv; [IO.File]::WriteAllText($f,$c,[Text.UTF8Encoding]::new($false)) }"

echo [OK] Deploiement termine — https://diveapps.serveblog.net/portailClub/apps/cdm2026/
exit /b 0
