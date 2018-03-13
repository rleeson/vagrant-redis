param (
    [string]$GuestIPAddress = $(throw "-GuestIPAddress is required. ")
 )

 $guestAddress = $GuestIPAddress

# validate guest ip address
try { 
    $ip = [System.Net.IPAddress]::parse($guestAddress)
} 
catch { 
    "`"{0}`" is not a valid IP address" -f $guestAddress
    exit 1
} 

# clean up portproxy forward rules
Write-Host *** Cleanup local port forwarding from localhost to guest virtual machine ***`n

netsh interface portproxy delete v4tov4 protocol=tcp `
    listenport=6379 listenaddress=localhost | Out-Null

# add new portproxy forward rules
Write-Host *** Add local port forwarding from localhost to guest virtual machine ***`n

netsh interface portproxy add v4tov4 protocol=tcp `
    listenport=6379 listenaddress=localhost `
    connectport=6379 connectaddress=$guestAddress | Out-Null

# print out result
Write-Host *** Port forwarding has been set as following ***
netsh interface portproxy dump | findstr $guestAddress

exit 0