# 1. Online image ka link aur local save path define karein
$ImageUrl = "YAHAN_APNA_DIRECT_IMAGE_LINK_DALEIN"
$LocalPath = "$env:TEMP\desktop_wallpaper.jpg"

# 2. Image ko download karein
Invoke-WebRequest -Uri $ImageUrl -OutFile $LocalPath

# 3. Windows API ko call karne ke liye code
$definition = @'
using System;
using System.Runtime.InteropServices;

public class Wallpaper {
    [DllImport("user32.dll", CharSet = CharSet.Auto)]
    public static extern int SystemParametersInfo(int uAction, int uParam, string lpvParam, int fuWinIni);
}
'@

Add-Type -TypeDefinition $definition -ErrorAction SilentlyContinue

# 4. Wallpaper apply karein
$SPI_SETDESKWALLPAPER = 0x0014
$SPIF_UPDATEINIFILE = 0x01
$SPIF_SENDCHANGE = 0x02

[Wallpaper]::SystemParametersInfo($SPI_SETDESKWALLPAPER, 0, $LocalPath, $SPIF_UPDATEINIFILE -bor $SPIF_SENDCHANGE)

Write-Host "Wallpaper successfully update ho gaya hai!"