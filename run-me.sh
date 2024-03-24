# !/bin/bash
# Backup original config.toml
cp config.toml config_backup.toml

# Extract the values for CLAUDE and OPENAI from .env
CLAUDE_VALUE=$(grep CLAUDE .env | cut -d'=' -f2)
OPENAI_VALUE=$(grep OPENAI .env | cut -d'=' -f2)
BING_VALUE=$(grep BING .env | cut -d'=' -f2)

# Update config.toml with the extracted values
awk -v claude="$CLAUDE_VALUE" -v openai="$OPENAI_VALUE" -v bing="$BING_VALUE" '
BEGIN {FS=OFS=" = "}
$1 == "CLAUDE" {$2="\"<YOUR_CLAUDE_API_KEY>\""; sub(/<YOUR_CLAUDE_API_KEY>/, claude, $2)}
$1 == "OPENAI" {$2="\"<YOUR_OPENAI_API_KEY>\""; sub(/<YOUR_OPENAI_API_KEY>/, openai, $2)}
$1 == "BING" {$2="\"<YOUR_BING_API_KEY>\""; sub(/<YOUR_BING_API_KEY>/, bing, $2)}
{print}
' config.toml > tmp.toml && mv tmp.toml config.toml

cat config.toml

# Use trap to ensure config.toml is reverted back to its original state after the script finishes or is interrupted
trap 'mv config_backup.toml config.toml; echo "config.toml reverted to original state."' EXIT

# Inform the user
echo "config.toml has been updated."

python3.10 devika.py



