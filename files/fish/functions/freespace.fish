function freespace
	df -h | grep -e "/Users/$USER\$" | xargs | cut -d " " -f 3
end
