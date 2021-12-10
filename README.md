# GPO-BGInfo

### Group policy Backup to implement BGInfo to automate update wallpaper on user logon

Download zip file to DC and extract https://github.com/Aabayoumy/GPO-BGInfo/archive/refs/heads/master.zip .
Download https://download.sysinternals.com/files/BGInfo.zip and copy Bginfo.exe or Bginfo64.exe to main folder (according to target machines architect 32 or 64 bit).
Cd to extracted folder and run this command on Administrative "Active Directory PowerShell"

```powershell
Restore-GPO -Path "$((Get-Item .).FullName)"
```
