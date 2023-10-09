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
			echo "Selected 1"
		;;
		2)
			echo "Selected 2"
		;;
		3)
			echo "Selected 3"
		;;
		*)
			error_input "$choice"
		;;
	esac
}

menu(){
	balias 32
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
