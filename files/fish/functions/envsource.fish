function envsource
  set -f envfile "$argv"
  if not test -f "$envfile"
    echo "Unable to load $envfile"
    return 1
  end
  set -l lines (cat "$envfile")
  for line in $lines
    set -l key (echo $line | cut -d= -f1)
    # Take after the first =
    set -l value (echo $line | cut -d= -f2-)
    
    # Remove quotes value's start and end
    set -l value (echo $value | sed -e 's/^"//' -e 's/"$//')
    
    set -xg $key $value

    echo "$key=$value"
  end
end
