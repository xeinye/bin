#!/bin/sh
#
# Simple script to manage dotfiles

case $1 in
    "s")
        mkdir -p $HOME/git/dotfiles
        cp -r $HOME/.config/mpv $HOME/git/dotfiles/
        mkdir -p $HOME/git/dotfiles/misc
        cp $HOME/.profile $HOME/git/dotfiles/misc/profile
        cp $HOME/rules/rc $HOME/git/dotfiles/misc/
        cp $HOME/rules/xsession $HOME/git/dotfiles/misc
        cp $HOME/.config/sxhkd/sxhkdrc $HOME/git/dotfiles/misc/
        mkdir -p $HOME/git/dotfiles/vim
        cp $HOME/.vim/vimrc $HOME/git/dotfiles/vim/
	    mkdir -p $HOME/git/dotfiles/X11/xenodm/pixmaps
	    cp -r /etc/X11/xenodm/pixmaps/zeppelin.xpm $HOME/git/dotfiles/X11/xenodm/pixmaps/
	    doas cp -r /etc/X11/xenodm/Xresources /etc/X11/xenodm/Xsession /etc/X11/xenodm/Xsetup_0 $HOME/git/dotfiles/X11/xenodm/
        printf '%s\n' "-> ok"


        ;;
    "d")
        printf '%s\n' "-> Do you want do deploy? (y/n): "
        read -r conf
        case "$conf" in
            [yY])
                ;;
            *)
            printf '%s\n' "Operation canceled by the user."
            exit 0
                ;;
        esac
   
    	mkdir -p $HOME/git
    	git clone git://git.zepp.club/dotfiles.git $HOME/git/dotfiles
    	mkdir -p $HOME/.config
    	mkdir -p $HOME/.config/sxhkd
    	mkdir -p $HOME/.config/git
   	    mkdir -p $HOME/rules
    	cp -r $HOME/git/dotfiles/mpv $HOME/.config/mpv
    	cp -r $HOME/git/dotfiles/vim $HOME/.vim
    	cp -r $HOME/git/dotfiles/misc/sxhkdrc $HOME/.config/sxhkd/
    	cp -r $HOME/git/dotfiles/misc/profile $HOME/.profile
    	cp -r $HOME/git/dotfiles/misc/rc $HOME/rules/
    	cp -r $HOME/git/dotfiles/misc/xsession $HOME/rules/

   	    doas cp -r $HOME/git/dotfiles/X11 /etc/

    	git clone git://git.zepp.club/core.git $HOME/git/core
    	git clone git://git.zepp.club/fonts.git $HOME/git/fonts
    	git clone git://git.zepp.club/glazier.git $HOME/git/glazier
    	git clone git://git.zepp.club/libwm.git $HOME/git/libwm
    	git clone git://git.zepp.club/ports.git $HOME/git/ports
    	git clone git://git.zepp.club/st.git $HOME/git/st
    	git clone git://git.zepp.club/wall.git $HOME/git/wall
        ;;
    *)
        echo "Usage: sail {s|u}"
        printf "s: sync files to dots\nd: deploy files to system\n"
        exit 1
        ;;
esac
