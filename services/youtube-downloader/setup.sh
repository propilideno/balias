#!/bin/bash
#################### IMPORT ####################
# source ../../lib/colors.sh
# source ../../lib/error_handling.sh
# source ../../lib/utils.sh
# source ../../lib/decorators.sh
#################### SETUP ####################


menuInstallation(){
	echo "================================================"
	echo "| Installer          | Operating System  |"
	echo "| 1) pip             | Multiplatform     |"
	echo "| 2) apt             | Ubuntu            |"
	echo "| 3) brew            | MacOS             |"
	echo "================================================"
}

installDeps(){
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
	echo " - Package Required: $1"
	echo " - Description: $1 is a youtube-dl fork based on the now inactive youtube-dlc."
	status $1
}

#################### MAIN ####################

main(){
	menu "yt-dlp"

	if [[ ! $(alreadyInstalled "yt-dlp") ]] ; then
		menuInstallation
		installDeps
	else
		echo "================================================"
	fi
	install "youtube-downloader"
}

main
