# Définit le nom de la machine virtuelle, le nom du commutateur et le chemin du support d'installation.
$VMName = 'TESTVM'
$Switch = 'Default Switch'
$InstallMedia = 'C:\mondossier\de\travail\SERVER_EVAL_x64FRE_fr-fr.iso'

# Crée une nouvelle machine virtuelle
New-VM -Name $VMName -MemoryStartupBytes 1GB -Generation 2 -NewVHDPath "C:\mondossier\de\travail\$VMName.vhdx" -NewVHDSizeBytes 40GB -Path "C:\mondossier\de\travail\$VMName" -SwitchName $Switch

# Ajoute un lecteur DVD à la machine virtuelle
Add-VMScsiController -VMName $VMName
Add-VMDvdDrive -VMName $VMName -ControllerNumber 1 -ControllerLocation 0 -Path $InstallMedia

# Monte le support d'installation
$DVDDrive = Get-VMDvdDrive -VMName $VMName

# Configure la machine virtuelle pour démarrer à partir du DVD
Set-VMFirmware -VMName $VMName -FirstBootDevice $DVDDrive
