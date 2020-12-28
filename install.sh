#! /bin/bash

# .zshrc -> Cambiar zsh theme por simple y descomentar path bin
# .profile -> crear y añadir linea path de .zshrc

# small template for my bash shell scripts.

set -o errexit  # the script ends if a command fails
set -o pipefail # the script ends if a command fails in a pipe
set -o nounset  # the script ends if it uses an undeclared variable
# set -o xtrace # if you want to debug

base() {
	sudo pacman -S xorg xorg-xinit
	sudo pacman -S lightdm lightdm-gtk-greeter
	sudo pacman -S openbox lxappearance-obconf
	sudo pacman -S tint2 rofi nitrogen picom
	sudo pacman -S awesome awesome-terminal-fonts ttf-dejavu noto-fonts
	sudo pacman -S papiurus-icon-theme arc-gtk-theme

	sudo pacman -S alsa-utils pulseaudio pavucontrol

	sudo pacman -S base-devel
	sudo pacman -S terminator mc htop rsync xclip

	sudo pacman -S thunar thunar-archive-plugin thunar-volman xarchiver
	
	sudo pacman -S chromium

	sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

	mkdir -p ~/gitrepos/
	cd ~/gitrepos
	git clone https://aur.archlinux.org/pikaur.git
	cd pikaur
	makepkg -fsri
	cd ~/mrlinux

	mkdir -p ~/bin/
	cd ~/bin/
	curl https://getmic.ro | bash
	cd ~/mrlinux
	
	sudo systemctl enable lightdm.service
	sudo localectl set-x11-keymap es

	git config --global user.email "naneros21@gmail.com"
	git config --global user.name "naneros"	

	pikaur -S menumaker
	mmaker -vf OpenBox3

}

vbox-guest() {
	sudo pacman -S virtualbox-guest-utils 
	sudo systemctl enable vboxservice.service
}

# Main function
main() {
  base
  vbox-guest
}

main "$@"
