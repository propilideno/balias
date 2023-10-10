#!/bin/bash
#################### IMPORT ####################
source lib/colors.sh
source lib/error_handling.sh
source lib/utils.sh
source lib/decorators.sh
#################### SETUP ####################

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
			executeSetup "$option"
            break
        else
            echo "<ERROR> Please, select a valid option."
        fi
    done
else
	echo "<ERROR> Could not retrieve the list of folders from GitHub."
fi
