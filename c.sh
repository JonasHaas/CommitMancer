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
    rm -rf src/*
    git add -A
    git commit -m "Deleted previous files"
    filename=$(date +%s | shuf | head -c 10).txt
    echo $filename



else
    echo "No commits today"
fi