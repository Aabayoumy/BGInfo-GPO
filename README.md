# GPO Backup to implement BGInfo

Run this command on Administrative "Active Directory PowerShell" (On DC or computer with RSAT installed & Domain Admin user).

```powershell
#Import Required Module to create and import GPO
Import-Module grouppolicy
#Create New GPO
New-GPO BGInfo -Comment "https://github.com/Aabayoumy/BGInfo-GPO"
#Download Master files from GitHub
Invoke-WebRequest https://github.com/Aabayoumy/BGInfo-GPO/archive/refs/heads/master.zip -OutFile "$env:TEMP\BGInfo-GPO.zip"
Expand-Archive -LiteralPath "$env:TEMP\BGInfo-GPO.zip" -DestinationPath $env:TEMP
cd "$env:TEMP\BGInfo-GPO-master"
#Update Domain Name in GPO
((Get-Content -path '.\{8402A0FB-3416-47E2-82EB-6CE835FCA127}\DomainSysvol\GPO\Machine\Preferences\Files\Files.xml' -Raw) -replace "CONTOSO.COM", $Env:USERDNSDOMAIN) | Set-Content -Path '.\{8402A0FB-3416-47E2-82EB-6CE835FCA127}\DomainSysvol\GPO\Machine\Preferences\Files\Files.xml'
#Import GPO
Import-gpo -BackupGpoName BGInfo -TargetName BGInfo -Path "$((Get-Item .).FullName)"
#Download BGInfo.exe & Copy Bginfo folder to Domain script folder
Invoke-WebRequest https://live.sysinternals.com/Bginfo.exe -OutFile .\BGinfo\bginfo.exe
Copy-Item Bginfo \\$Env:USERDNSDOMAIN\sysvol\$Env:USERDNSDOMAIN\scripts\ -force -Recurse

```

This commands will restore the GPO copy files to Sysvol Script Path and show you this path, Replace the Path in GPO with current domain name.
If you replace the wallpaper.jpg file in folder \\$Env:USERDNSDOMAIN\sysvol\$Env:USERDNSDOMAIN\scripts\BGinfo it's will effect client computers after next group policy apply.

Link "BGInfo" to Required OU 😊

Also BGinfo.html is report of GPO you can read it and create the GPO form scratch.

![Result](Result.png)

IP VBS script source : https://social.technet.microsoft.com/Forums/scriptcenter/en-US/bb74c2eb-eca2-455d-a270-8dd0f3d195e6/wmi-query-to-retrieve-only-active-ipv4-address
