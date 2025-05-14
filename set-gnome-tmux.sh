# Set Tmux as default in Gnome Terminal
set -o errexit
dconf read /org/gnome/terminal/legacy/profiles:/"$(dconf list /org/gnome/terminal/legacy/profiles:/)"use-custom-command
dconf read /org/gnome/terminal/legacy/profiles:/"$(dconf list /org/gnome/terminal/legacy/profiles:/)"custom-command
dconf write /org/gnome/terminal/legacy/profiles:/"$(dconf list /org/gnome/terminal/legacy/profiles:/)"use-custom-command true
dconf write /org/gnome/terminal/legacy/profiles:/"$(dconf list /org/gnome/terminal/legacy/profiles:/)"custom-command \'"$(which tmux)"\'
#sudo dconf update
