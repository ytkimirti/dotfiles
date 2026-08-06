function fish_user_key_bindings
  fzf --fish | source
  for mode in insert default visual
  	bind -M $mode \cf forward-char
  end
end
