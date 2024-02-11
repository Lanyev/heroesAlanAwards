#!/bin/bash

# Define the directory where your replay files are located
replay_dir="C:\\Users\\lanye\\OneDrive\\Documentos\\Heroes of the Storm\\Accounts\\860012555\\1-Hero-1-11283694\\Replays\\Multiplayer"

# Create an empty output CSV file
output_csv="combined_output.csv"
touch "$output_csv"

# Loop through all .StormReplay files in the directory
for replay_file in "$replay_dir"/*.StormReplay; do
    # Execute the dotnet heroes-decode command and append the output to the CSV file
    dotnet heroes-decode --replay-path "$replay_file" --show-player-stats >> "$output_csv"
done

# Remove the strange characters using sed
sed -i 's/\x1b\[[0-9;]*m//g' "$output_csv"
