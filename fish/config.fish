
function fish_prompt
    set -l tmpstatus $status
    set -l col yellow

    # Print time
    printf "%s " (set_color $col)(date +%H:%M:%S)

    # Print username
    printf "%s" (set_color white)"$USER"(set_color $col)"@"

    # Print hostname, and strip from the first dot onwards
    printf "%s " (set_color white)(hostname | sed 's/\..*$//')

    # Print return value of last command
    if [ "$tmpstatus" = 0 ]
        #printf "%s " (set_color green)"$tmpstatus"
    else
        printf "%s " (set_color red)"$tmpstatus"
    end

    # Print path
    printf "%s" (set_color yellow)(pwd | string replace $HOME "~")
    printf "\n"

    # Print prompt line
    set_color normal
    printf "~"
    set_color green
    if [ (id -u) = 0 ]
        # Root
        printf "# "
    else
        printf "> "
    end
end

if type -q conda
    source (conda info --root)/etc/fish/conf.d/conda.fish
end

