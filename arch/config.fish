if status is-interactive
    # Commands to run in interactive sessions can go here
end

alias vim="nvim"
alias g14="g++ -std=c++14 -Wall -g"
alias g17="g++ -std=c++17 -Wall -g"
alias gst="gst ~/.config/floatfix.st"
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

# opam configuration
source /home/austin/.opam/opam-init/init.fish > /dev/null 2> /dev/null; or true
