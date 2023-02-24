# Criado com base no video:
# https://www.youtube.com/watch?v=_3F2nhRAMHY

# Modificado o SMC para 0 devido aos erros apontados nele
param (
        $nomeVM
    )

# Add a pasta do VmBox para o path
[Environment]::SetEnvironmentVariable("Path", $env:Path + ";C:\Program Files\Oracle\VirtualBox\")

# Verifica se o processador é Intel
$marcaCPU = (Get-WmiObject Win32_Processor).manufacturer
$validadorIntel = $marcaCPU.contains("Intel")
if ($validadorIntel) {
    Write-Host "Configurando para Intel"
    VBoxManage.exe modifyvm "$nomeVM" --cpuidset 00000001 000106e5 00100800 0098e3fd bfebfbff
    VBoxManage.exe setextradata "$nomeVM" "VBoxInternal/Devices/efi/0/Config/DmiSystemProduct" “MacBookPro15,1”
    VBoxManage.exe setextradata "$nomeVM" "VBoxInternal/Devices/efi/0/Config/DmiBoardProduct" "Mac-551B86E5744E2388"
    VBoxManage.exe setextradata "$nomeVM" "VBoxInternal/Devices/smc/0/Config/DeviceKey" "ourhardworkbythesewordsguardedpleasedontsteal(c)AppleComputerInc"
    VBoxManage.exe setextradata "$nomeVM" "VBoxInternal/Devices/smc/0/Config/GetKeyFromRealSMC" 0
} else {
    Write-Host "Configurando para AMD"
    VBoxManage.exe modifyvm "macos" --cpuidset 00000001 000106e5 00100800 0098e3fd bfebfbff 
    VBoxManage.exe setextradata "macos" "VBoxInternal/Devices/efi/0/Config/DmiSystemProduct" "iMac11,3" 
    VBoxManage.exe setextradata "macos" "VBoxInternal/Devices/efi/0/Config/DmiSystemVersion" "1.0" 
    VBoxManage.exe setextradata "macos" "VBoxInternal/Devices/efi/0/Config/DmiBoardProduct" "Iloveapple" 
    VBoxManage.exe setextradata "macos" "VBoxInternal/Devices/smc/0/Config/DeviceKey" "ourhardworkbythesewordsguardedpleasedontsteal(c)AppleComputerInc" 
    VBoxManage.exe setextradata "macos" "VBoxInternal/Devices/smc/0/Config/GetKeyFromRealSMC" 0
    VBoxManage.exe modifyvm "macos" --cpu-profile "Intel Core i7-6700K"
}