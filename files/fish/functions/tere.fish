function tere
	if not type -q tere
		echo (set_color -o) "tere not installed." (set_color reset)
	end
    set --local result (command tere $argv)
    [ -n "$result" ] && cd -- "$result"
end
