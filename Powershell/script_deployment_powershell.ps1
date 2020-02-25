Import-Module Az
Connect-x

New-AzResourceGroup -Name TutorialResources -Location eastus

$cred = Get-Credential -Message "Enter a username and password for the virtual machine."

$vmParams = @{
  ResourceGroupName = 'TutorialResources'
  Name = 'TutorialVM1'
  Location = 'eastus'
  ImageName = 'Win2016Datacenter'
  PublicIpAddressName = 'tutorialPublicIp'
  Credential = $cred
  OpenPorts = 3389
}

$newVM1 = New-AzVM @vmParams

$newVM1

$newVM1.OSProfile | Select-Object ComputerName,AdminUserName

$newVM1 | Get-AzNetworkInterface |
  Select-Object -ExpandProperty IpConfigurations |
    Select-Object Name,PrivateIpAddress

    $publicIp = Get-AzPublicIpAddress -Name tutorialPublicIp -ResourceGroupName TutorialResources

$publicIp | Select-Object Name,IpAddress,@{label='FQDN';expression={$_.DnsSettings.Fqdn}}