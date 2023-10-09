error_input(){
	echo "<WRONG INPUT> $1 is not a valid input!"
}

error_install(){
	echo "<INSTALL ERROR> $1 could not be installed!"
}

error_exit(){
	echo "<ERROR> $1"
	exit 1
}
