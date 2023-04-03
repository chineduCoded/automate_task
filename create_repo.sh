#!/bin/bash

# set your GitHub username
USERNAME="chineduCoded"
README_FILE="README.md"

# read the personal access token from the .github-token file in the user's home directory
TOKEN=$(cat "${HOME}/.github-token")

# ask the user to enter the repository name
read -p "Enter the name of the repository: " REPO_NAME

# check if the repository name was entered
if [ -z "$REPO_NAME" ]; then
	  echo "No repository name entered. Exiting script."
	    exit 1
fi

# check if the repository already exists
RESPONSE=$(curl -s -o /dev/null -w "%{http_code}" https://api.github.com/repos/${USERNAME}/${REPO_NAME})

if [ $RESPONSE -eq 404 ]; then
	    # create the repository
	        curl -H "Authorization: token $TOKEN" https://api.github.com/user/repos -d "{\"name\":\"${REPO_NAME}\"}"
fi

# clone the repository
#git clone https://TOKEN@github.com/${USERNAME}/${REPO_NAME}.git
git clone ssh://git@ssh.github.com:443/${USERNAME}/${REPO_NAME}.git
cd ${REPO_NAME}

# create the README file
echo "# ${REPO_NAME}" > ${README_FILE}

# commit and push the changes
git add .
git commit -m "Initial commit"
git branch -M main
git push -u origin main
