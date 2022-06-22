function fish_greeting
    return
	set -l message \
        'Hoşgeldiniz efendim' \
        'Çay veriyim mi abim' \
        Welcome \
        sa
    magical $message[(random 1 (count $message))]
end
