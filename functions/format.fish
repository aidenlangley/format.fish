function format --description 'Echo a styled string then reset'
    set __name (string split '.' (basename (status -f)))[1]
    set __version '0.1.0'
    set __description 'Print a styled string then reset'

    set opts (fish_opt --short D --long debug)
    set opts $opts (fish_opt --short h --long help)

    # Color options.
    set opts $opts (fish_opt --short c --long color --required-val)
    set opts $opts (fish_opt --short f --long foreground --required-val)
    set opts $opts (fish_opt --short b --long background --required-val)

    # Flags.
    set opts $opts (fish_opt --short d --long dim)
    set opts $opts (fish_opt --short i --long italic)
    set opts $opts (fish_opt --short o --long bold)
    set opts $opts (fish_opt --short u --long underline)

    argparse $opts -- $argv

    if set --query _flag_h || not argparse --min-args=1 -- $argv &>/dev/null
        set TAB '  '
        set FLAG_DELIM ', '

        set name (set_color --bold green)$__name(set_color --reset)
        set desc (set_color --italic)$__description(set_color --reset)
        echo (printf '%s %s - %s.' $name $__version $desc)

        function _usage --inherit-variable __name --argument-names args
            echo (set_color --bold cyan)$__name(set_color --reset) $args
        end

        function _desc --argument-names desc
            echo (set_color --dim brwhite)$desc(set_color --reset)
        end

        function _option --argument-names args
            echo (set_color --bold cyan)$args(set_color --reset)
        end

        echo
        echo (set_color --bold green)'Usage:'(set_color --reset)
        echo $TAB(_usage '[OPTIONS] [COLOR] ...')
        echo $TAB(_usage '-c red ...') (_desc 'Print red text.')
        echo $TAB(_usage '-d/--dim brwhite ...') (_desc 'Print dim white text.')
        echo $TAB(_usage '-i/--italic ...') (_desc 'Print italic text.')
        echo $TAB(_usage '-o/--bold cyan ...') (_desc 'Print bold cyan text.')
        echo $TAB(_usage '-u/--underline red ...') (_desc 'Print underlined red text.')
        echo $TAB(_usage '-b/--background white -f/--foreground black ...') (_desc 'Print black text on white background.')
        echo $TAB(_usage '-oi ...') (_desc 'Print bold, dim text.')

        echo
        echo (set_color --bold green)'Options:'(set_color --reset)
        echo $TAB(_option (string join -- $FLAG_DELIM -f --foreground) '<COLOR>')
        echo $TAB$TAB'Foreground color - for example: white, brwhite, black etc.'
        echo $TAB(_option (string join -- $FLAG_DELIM -b --background) '<COLOR>')
        echo $TAB$TAB'Background color - for example: red, yellow, bryellow, etc.'
        echo $TAB(_option (string join -- $FLAG_DELIM -d --dim))
        echo $TAB$TAB'Dim text.'
        echo $TAB(_option (string join -- $FLAG_DELIM -i --italic))
        echo $TAB$TAB'Italic text.'
        echo $TAB(_option (string join -- $FLAG_DELIM -o --bold))
        echo $TAB$TAB'Bold text.'
        echo $TAB(_option (string join -- $FLAG_DELIM -u --underline))
        echo $TAB$TAB'Underline text.'

        return
    end

    set args
    if set --query _flag_c
        # If we have c/color, store it.
        set args $_flag_c
    else if set --query _flag_f
        # If we have f/foreground...
        if set --query _flag_b
            # And b/background, set both.
            set args --foreground $_flag_f --background $_flag_b
        else
            # Without background, set c/color.
            set args $_flag_f
        end
    end

    set flags
    set --query _flag_u && set flags $flags u
    set --query _flag_o && set flags $flags o
    set --query _flag_d && set flags $flags d
    set --query _flag_i && set flags $flags i

    if test (count $flags) -gt 0
        set args (string join '' - $flags) $args
    end

    set --query _flag_D && echo $args

    set_color $args
    echo $argv
    set_color --reset
end
