

# Check if exiftool is installed
if ! command -v exiftool &> /dev/null; then
    echo "Error: exiftool is not installed. Please install it before running this script."
    exit 1
fi

# Function to display metadata for a given file
display_metadata() {
    local file="$1"
    echo "Metadata for $file:"
    exiftool "$file"
    echo "----------------------------------------"
}

# Check if a directory is provided as an argument
if [ $# -eq 0 ]; then
    echo "Usage: $0 <directory>"
    echo "inter the directory path"
	 exit 1
fi

# Get the directory path from the command line argument
directory="$1"

# Check if the specified directory exists
if [ ! -d "$directory" ]; then
    echo "Error: Directory '$directory' not found."
    exit 1
fi

# Loop through each file in the directory and display metadata
for file in "$directory"/*; do
    if [ -f "$file" ]; then
        display_metadata "$file"
    fi
done

echo "Metadata extraction completed for files in '$directory'."
