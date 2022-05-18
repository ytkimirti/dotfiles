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
		   'sa' \

	magical $message[(random 1 (count $message))]
end
