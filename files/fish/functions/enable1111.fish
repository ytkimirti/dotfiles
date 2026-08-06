function enable1111 --description 'Set Wi-Fi DNS to Cloudflare 1.1.1.1 (DNS censorship bypass / privacy)'
    sudo networksetup -setdnsservers Wi-Fi 1.1.1.1 1.0.0.1
    echo "Wi-Fi DNS → 1.1.1.1 / 1.0.0.1 (Cloudflare)."
    networksetup -getdnsservers Wi-Fi
end
