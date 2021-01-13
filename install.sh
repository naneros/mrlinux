#! /bin/bash

##################################################################################################################
# .zshrc -> Cambiar zsh theme por simple y descomentar path bin
# .profile -> crear y añadir linea path de .zshrc

# apparmor
# GRUB_CMDLINE_LINUX_DEFAULT="apparmor=1 lsm=lockdown,yama,apparmor" -> /etc/default/grub
# sudo systemctl enable apparmor
# sudo aa-enforce firejail-default
##################################################################################################################

# small template for my bash shell scripts.

#set -o errexit  # the script ends if a command fails
#set -o pipefail # the script ends if a command fails in a pipe
#set -o nounset  # the script ends if it uses an undeclared variable
# set -o xtrace # if you want to debug

base() {
	sudo pacman -S xorg xorg-xinit
	sudo pacman -S lightdm lightdm-gtk-greeter
	sudo pacman -S openbox lxappearance-obconf lxsession
	sudo pacman -S tint2 rofi nitrogen picom
	sudo pacman -S awesome awesome-terminal-fonts ttf-dejavu noto-fonts
	sudo pacman -S papirus-icon-theme arc-gtk-theme

	sudo pacman -S alsa-utils pulseaudio pavucontrol

	sudo pacman -S base-devel
	sudo pacman -S terminator mc htop rsync xclip

	sudo pacman -S firejail apparmor ufw
	sudo systemctl enable ufw
	sudo ufw enable

	sudo pacman -S thunar thunar-archive-plugin thunar-volman xarchiver
	
	sudo pacman -S chromium

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

protonvpn() {
	sudo pacman -S openvpn dialog python-pip python-setuptools
	sudo pip3 install protonvpn-cli
}

vbox-guest() {
	sudo pacman -S virtualbox-guest-utils 
	sudo systemctl enable vboxservice.service
}

end() {
	sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"	
}

# Main function
main() {
  base
  protonvpn
  vbox-guest
  end
}

main "$@"
