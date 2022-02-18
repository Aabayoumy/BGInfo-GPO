# GPO Backup to implement BGInfo

Download zip file to DC and extract https://github.com/Aabayoumy/BGInfo-GPO/archive/refs/heads/master.zip .
Cd to extracted folder and run this command on Administrative "Active Directory PowerShell"

```powershell
#Update Domain Name in GPO
((Get-Content -path '.\{8402A0FB-3416-47E2-82EB-6CE835FCA127}\DomainSysvol\GPO\Machine\Preferences\Files\Files.xml' -Raw) -replace "CONTOSO.COM", $Env:USERDNSDOMAIN) | Set-Content -Path '.\{8402A0FB-3416-47E2-82EB-6CE835FCA127}\DomainSysvol\GPO\Machine\Preferences\Files\Files.xml'
Import-Module grouppolicy
New-GPO BGInfo
Import-gpo -BackupGpoName BGInfo -TargetName BGInfo -Path "$((Get-Item .).FullName)"
Invoke-WebRequest https://live.sysinternals.com/Bginfo.exe -OutFile .\bginfo\bginfo.exe
Copy-Item Bginfo \\$Env:USERDNSDOMAIN\sysvol\$Env:USERDNSDOMAIN\scripts\ -force -Recurse

```

This commands will restore the GPO copy files to Sysvol Script Path and show you this path, Replace the Path in GPO with current domain name.
If you replace the wallpaper.jpg file in folder \\$Env:USERDNSDOMAIN\sysvol\$Env:USERDNSDOMAIN\scripts\BGinfo it's will effect client computers after next group policy apply.

Link "BGInfo" to Required OU 😊

Also BGinfo.html is report of GPO you can read it and create the GPO form scratch.

![Result](Result.png)
