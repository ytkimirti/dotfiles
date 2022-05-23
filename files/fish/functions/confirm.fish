function confirm
  while true
    read -l -P "$(set_color cyan)\
$argv[1] \
$(set_color reset)\
[\
$(set_color green)\
y\
$(set_color reset)\
/\
$(set_color red)\
N\
$(set_color reset)\
] " confirm

    switch $confirm
      case Y y
        return 0
      case '' N n
        return 1
    end
  end
end
