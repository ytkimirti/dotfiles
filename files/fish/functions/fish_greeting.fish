function magical
	echo "$(set_color magenta)(ﾉ◕ヮ◕)ﾉ\
$(set_color yellow)*:･ﾟ✧ \
$(set_color green)\
$argv[1]\
$(set_color yellow)\
 ✧ﾟ･ *$(set_color magenta)\
ヽ(◕ヮ◕ヽ)$(set_color normal)"
end

function fish_greeting
	set -l message \
		   'Hoşgeldiniz efendim' \
		   'Çay veriyim mi abim' \
		   'Welcome' \
		   'Sa' \
		   'Çay veriyim mi abim' \
		   'Çay veriyim mi abim' \
		   'Çay veriyim mi abim' \
		   'Çay veriyim mi abim'
	set -l random_num (count $message)
	echo random

	magical $message[(random (count $message))]
end
