#!/bin/bash
# IMPORT
source ../../lib/colors.sh
source ../../lib/error_handling.sh
source ../../lib/utils.sh

# CODE

install(){
	read -r -p "Select your favorite installer: " choice
 	case "$choice" in
		1)
			pip install yt-dlp
		;;
		2)
			sudo add-apt-repository ppa:tomtomtom/yt-dlp    # Add ppa repo to apt
			sudo apt update                                 # Update package list
			sudo apt install yt-dlp                         # Install yt-dlp
		;;
		3)
			brew install yt-dlp
		;;
		*)
			error_input "$choice"
		;;
	esac
}

menu(){
	balias 95
	echo "=========== Youtube Video Downloader ==========="
	echo "| Installer          | Operating System  |"
	echo "| 1) pip             | Multiplatform     |"
	echo "| 2) apt             | Ubuntu            |"
	echo "| 3) brew            | MacOS             |"
	echo "================================================"
}

main(){
	menu
	install
}

main
