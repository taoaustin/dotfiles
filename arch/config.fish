if status is-interactive
    # Commands to run in interactive sessions can go here
end

alias vim="nvim"

alias monitor-left="xrandr --output LVDS1 --auto --left-of HDMI1"
alias monitor-right="xrandr --output LVDS1 --auto --right-of HDMI1"
alias spot="LD_PRELOAD=/usr/lib/spotify-adblock.so spotify &"
set -Ux EDITOR nvim
set -U fish_user_paths (ruby -e 'puts Gem.user_dir')/bin
zoxide init fish | source
starship init fish | source
#Start X at login
if status is-login
	if test -z "$DISPLAY" -a "$XDG_VTNR" = 1
		exec startx -- -keeptty
	end
end
