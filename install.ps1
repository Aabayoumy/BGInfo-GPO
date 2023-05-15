#Import Required Module to create and import GPO
Import-Module grouppolicy
#Update Domain Name in GPO
((Get-Content -path '.\{AB41A6CC-D880-4B3F-9D48-BA1DFAF73860}\DomainSysvol\GPO\Machine\Preferences\Files\Files.xml' -Raw) -replace "CONTOSO.COM", $Env:USERDNSDOMAIN) | Set-Content -Path '.\{8402A0FB-3416-47E2-82EB-6CE835FCA127}\DomainSysvol\GPO\Machine\Preferences\Files\Files.xml'
#Create & import New GPO
New-GPO BGInfo -Comment "https://github.com/Aabayoumy/BGInfo-GPO"
Import-gpo -BackupGpoName BGInfo -TargetName BGInfo -Path "$((Get-Item .).FullName)"
# Copy requred files to sysvol
Copy-Item Bginfo \\$Env:USERDNSDOMAIN\sysvol\$Env:USERDNSDOMAIN\scripts\ -force -Recurse
