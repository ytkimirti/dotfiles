function gbetter
	set -l str (string replace 'https://' '' $argv[1])

	set -l ssh_link (string replace --regex '([^/]+)/([^/]+)/([^/]+)' 'git@$1:$2/$3.git' $str)

	git clone --depth 1 --recursive $ssh_link $argv[2]
end
