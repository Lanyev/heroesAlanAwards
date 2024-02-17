#!/bin/bash

# Define the directory where your replay files are located
script_dir="$(dirname "$BASH_SOURCE")"
replay_dir="$script_dir"

# Create an empty output CSV file
output_csv="combined_output.csv"
touch "$output_csv"

# Initialize a counter for processed replays
replay_counter=0

# Loop through all .StormReplay files in the directory
for replay_file in "$replay_dir"/*.StormReplay; do
    # Execute the dotnet heroes-decode command and append the output to the CSV file
    dotnet heroes-decode --replay-path "$replay_file" --show-player-stats >> "$output_csv"
    
    # Increment the counter
    ((replay_counter++))
    
    # Print the number of processed replays
    echo "Replays procesados: $replay_counter"
done

# Remove the strange characters using sed
sed -i 's/\x1b\[[0-9;]*m//g' "$output_csv"