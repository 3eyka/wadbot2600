Invoke-WebRequest -Uri "https://raw.githubusercontent.com/3eyka/wadbot2600/main/wadbot.ps1" -OutFile "wadbot"; Set-ItemProperty -Path "wadbot" -Name "IsReadOnly" -Value $false; .\wadbot sentinel
