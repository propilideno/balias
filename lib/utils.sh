balias_dir="$HOME/.local/share/balias" # DEBIAN

# Usage: show_version <package_name>
show_version(){
	echo "Do you want show version of $1? (y/n): "
	read -r choice
	case "$choice" in
		'y'|'Y')
			$1 --version
		;;
	esac
}

# Usage: alreadyInstalled <package_name>
alreadyInstalled(){
	if [[ -x "$(command -v $1)" ]]; then
		echo 1
	else
		echo 0
	fi
}

# Usage: status <package_name>
status(){
	if [[ $(alreadyInstalled $1) ]]; then
		echo " - Status: Installed"
		echo " - Version: $($1 --version)"
	else
		echo " - Status: Not Installed"
	fi
}

# Usage: executeRawFile <package_name>
executeSetup(){
	local rawPath="https://raw.githubusercontent.com/propilideno/balias/main/services/$1/setup.sh"
	bash <(curl -sL $rawPath)
}

# Usage: getPackage <package_name>
getPackage(){
	local package_url="https://raw.githubusercontent.com/propilideno/balias/main/services/$1/main.sh"
	echo "Downloading $1..."
	mkdir -p "$balias_dir"
	curl $package_url -o "$balias_dir/$1.sh"
	chmod +x "$balias_dir/$1.sh"
	echo "Done!"
}

# Usage: proceedInstallation <package_name>
install(){
	while true; do
		echo "Do you want to proceed with the $1 installation? (y/n): "
		read -r choice
		case "$choice" in
			'y'|'Y')
				getPackage $1
				break
			;;
			'n'|'N')
				echo "Installation aborted!"
				exit 1
			;;
			*)
				echo "Invalid input!"
			;;
		esac
	done
}

# Usage: question <string>
question(){
	echo "$1 (y/n): "
	read -r choice
	while true; do
		case "$choice" in
			'y'|'Y')
				break
			;;
			'n'|'N')
				echo "Aborted!"
				exit 1
			;;
			*)
				echo "Invalid input!"
			;;
		esac
	done
}

installBalias(){
	local source_balias="source $HOME/.local/share/balias/*.sh"
	# Shell configs to install balias
	configs=(
		".bashrc"
		".zshrc"
	)

	# Detect if balias is already installed
	local flag=1
	for config in "${configs[@]}"; do
		path="$HOME/${config}"
		local isInstalled=$(! grep -Fxq "$source_balias" "$path")
		if [[ isInstalled && flag ]] ; then
			question "Do you want to install balias?"
			flag=0
		fi
	done

	# Install in all shell configs
	for config in "${configs[@]}"; do
		path="$HOME/${config}"

		# Grep to verify if the source is already installed
		if ! grep -Fxq "$source_balias" "$path"; then
			echo "Installed in:  $path..."
			echo "# ======== Added by balias ========" >> "$path"
			echo "$source_balias" >> "$path"
			echo "# ==================================" >> "$path"
		fi
	done
	
	echo "Balias installed!"
}
