param(
    [string]$argument
)

if (-not $argument) {
    Write-Host "USAGE : ./wadbot.ps1 [push | sentinel]"
    exit 0
}

if ($argument -eq "push") {
    Write-Host "wadbot na blyat ski pushi zjinya"
}
elseif ($argument -eq "sentinel") {
    Write-Host "wadbot na blyat ya ore no [S A N T I N E R U]-sama"
}
else {
    Write-Host "USAGE : ./wadbot.ps1 [push | sentinel]"
    exit 0
}

# demande de nom...
$prenom = Read-Host "Prenom (don't forget les majuscules) :"
$nom = Read-Host "Nom (don't forget les majuscules) :"
# numéro de l'exercice ASR
$asr_nbr = Read-Host "ASR [2, 3, 4, 5, 11, 12] :"
# message de commit
$cummit = Read-Host "commit message :"
# configurer l'utilisateur, l'email et la persistance Git (pour le repo, les identifiants sont stockés dans gitconfig, supprimer à la fin du script)
git config --global user.name "${prenom} ${nom}"
git config --global user.email "${prenom}.${nom}@ecole2600.com"
git config --global credential.helper store
# construire le lien gitea
$fullpath = "https://git.ecole2600.com/promo2026_RNCP35612/${prenom}.${nom}_asr-exos-${asr_nbr}-2025.git"
# cloner l'exercice ASR, à ton nom (oui, il y a toujours des majuscules dans le nom/prénom, mais cela ne change absolument rien)
git clone $fullpath
# accéder au seul dossier pouvant contenir "2025"
cd "${prenom}.${nom}_asr-exos-${asr_nbr}-2025/"
# accéder au seul dossier du projet, donc pas de risque de saisir un *
#cd *
# obtenir Sentinel
Invoke-WebRequest -Uri "https://sentinel.ecole2600.com/download/latest" -OutFile "sentinel"
# chmod de Sentinel
Set-ItemProperty -Path "sentinel" -Name "IsReadOnly" -Value $false
# git add
git add .
# git commit -m
git commit -m "$cummit"

if ($argument -eq "push") {
    git push
}
elseif ($argument -eq "sentinel") {
    py sentinel
}

# nettoyage final, suppression du repo ainsi que de gitconfig
cd ../
Remove-Item -Path "${prenom}.${nom}_asr-exos-${asr_nbr}-2025/" -Recurse -Force
Remove-Item -Path ".gitconfig" -Force

Write-Host "WADBOT COMPLETE."
