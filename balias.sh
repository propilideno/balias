#!/bin/bash
#################### SETUP ####################
# Usage: importRaw <package_name>
importRaw(){
	local rawPath="https://raw.githubusercontent.com/propilideno/balias/main/lib/$1.sh"
	source <(curl -sSL $1)
}
################### IMPORT ####################
importRaw "colors"
importRaw "error_handling"
importRaw "utils"
importRaw "decorators"
#################### MAIN ####################

# API endpoint to list the content of the directory
api_endpoint="https://api.github.com/repos/propilideno/balias/contents/services"

# Request to the GitHub API to list the content of the directory
answer=$(curl -s "$api_endpoint")

PS3="Select the service: "
# Verify if the request was successful
if [ $? -eq 0 ]; then
	# Extract the names of the folders from the response JSON
    options=()
    while IFS= read -r line; do
        folder_name=$(echo "$line" | grep -o '"name": "[^"]*' | cut -d'"' -f4)
        if [ -n "$folder_name" ]; then
            options+=("$folder_name")
        fi
    done <<< "$answer"

	# Show an interactive menu for the user to select the folder
    select option in "${options[@]}"; do
        if [ "$option" ]; then
			echo "Selected: $option"
			executeSetup "$option"
            break
        else
            echo "<ERROR> Please, select a valid option."
        fi
    done
else
	echo "<ERROR> Could not retrieve the list of folders from GitHub."
fi
