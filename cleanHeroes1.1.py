import pandas as pd

# Read the CSV file into a DataFrame - Change the file name to the one you want to process 
df = pd.read_csv("outputFinal.csv")

# Initialize variables
structured_data = []
player_data = {}
winner = False

# Iterate over each row in the DataFrame
for index, row in df.iterrows():
    line = row["Success"]

    # Check for team header
    if line.startswith("Team"):
        # Set winner flag based on the order of the teams
        winner = not winner
        continue

    # Check for player header
    if line.startswith("[") and "Player:" in line:
        # Add previous player data to structured_data if exists
        if player_data:
            player_data["Winner"] = "Winner" if winner else "Loser"
            structured_data.append(player_data)
            player_data = {}

        # Extract player name
        player_data["Player"] = line.split(": ")[1]

    # Process key-value pairs
    elif ":" in line:
        parts = line.split(": ")
        if len(parts) == 2:
            key, value = parts
            player_data[key.strip()] = value.strip()
        else:
            print(f"Linea no procesada: {line}")

# Add the last player if exists
if player_data:
    player_data["Winner"] = "Winner" if winner else "Loser"
    structured_data.append(player_data)

# Convert the list of dictionaries into a DataFrame
df = pd.DataFrame(structured_data)

# Export to CSV
df.to_csv("structured_data3.csv", index=False)
