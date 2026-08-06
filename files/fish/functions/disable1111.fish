function disable1111 --description 'Revert Wi-Fi DNS to automatic (DHCP) so captive portals open'
    sudo networksetup -setdnsservers Wi-Fi empty
    echo "Wi-Fi DNS → automatic (DHCP). Captive portal popups will work now."
    networksetup -getdnsservers Wi-Fi
end
