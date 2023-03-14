# Generates a random number for committing, with a smaller range on weekends (1-4)
# and a larger range on weekdays (1-10), which presents a 20% chance of committing
# on weekends and a 80% chance of committing on weekdays.
if [ $(date +%u) -gt 5 ]; then
    # Generate a random number between 1 and 4
    random_num=$(( RANDOM % 5 + 1 ))
else
    # Generate a random number between 1 and 10
    # 
    random_num=$(( RANDOM % 20 + 1 ))
fi

if [ $random_num -gt 4 ]; then
    num_commits=$(( RANDOM % 10 + 1 ))
    echo "$num_commits commits today"
    # Loop through the commits
    for i in $(seq 1 $num_commits); do
    # Delete previous files and commit
    rm -rf src/*
    git add -A
    git commit -m "Deleted previous files"
    echo "files in src deleted"

        # Create new files with random names and commit for each file
        for j in $(seq 1 $(( ${num_commits} - 1 ))); do
            # Generate a random filename with .txt extension
            filename=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 10 | head -n 1).txt

            # Create the file and add its content
            touch "src/$filename"
            echo "This is a sample text for $filename" >> "src/$filename"

            # Commit the file
            git add "src/$filename"
            git commit -m "Added $filename"
        done
    done

else
    echo "No commits today"
fi