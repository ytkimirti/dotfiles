if status is-interactive
    # Commands to run in interactive sessions can go here
end

if type -q thefuck
	thefuck --alias | source
end
