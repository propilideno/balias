balias_dir="$HOME/.local/share/balias" # UBUNTU

show_version(){
	echo "Do you want show version of $1? (y/n): "
	read -r choice
	case "$choice" in
		'y'|'Y')
			$1 --version
		;;
	esac
}

alreadyInstalled(){
	if [[ -x "$(command -v $1)" ]]; then
		echo 1
	else
		echo 0
	fi
}

installPackage(){
	mkdir -p "$balias_dir/$1"
}
