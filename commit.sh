#!/bin/bash 

# List of possible commit messages
commit_messages=(
    "Fix bug"
    "Add new feature"
    "Update documentation"
    "Refactor code"
    "Improve performance"
    "Fix typo"
    "Add tests"
)

# Generates a random number for committing, with a smaller range on weekends (1-4)
# and a larger range on weekdays (1-10), which presents a 20% chance of committing
# on weekends and a 80% chance of committing on weekdays.
if [ $(date +%u) -gt 5 ]; then
    # Generate a random number between 1 and 5
    random_num=$(( RANDOM % 5 + 1 ))
else
    # Generate a random number between 1 and 20
    random_num=$(( RANDOM % 20 + 1 ))
fi

if [ $random_num -gt 4 ]; then
    num_commits=$(( RANDOM % 10 + 1 ))
    #echo "$num_commits commits today"

    rm -rf /home/whalesay/repositories/GitHub-Activity-Generator/src/*
    git add /home/whalesay/repositories/GitHub-Activity-Generator/src
    git commit -m "daily cleanup"

    for (( i=1; i<=$num_commits; i++ )); do
        # Create a random filename
        filename=$(openssl rand -hex 8 | base64 | tr -dc 'a-zA-Z0-9' | head -c 10).txt
        #echo $filename

        # Choose a random commit message
        commit_message=${commit_messages[$RANDOM % ${#commit_messages[@]}]}
        #echo $commit_message

        # Generate the file content
        file_contents="This is a random file generated by the script for commit $i."
        #echo $file_contents

        # Set the file path relative to the src folder
        file_path="/home/whalesay/repositories/GitHub-Activity-Generator/src/${filename}"

        # Write the file to disk
        echo "$file_contents" > "$file_path"

        # Stage the file for commit
        git add $file_path

        # Commit the changes with the random commit message
        git commit -m "$commit_message"
    done
    git push
else
    echo "No commits today"
fi