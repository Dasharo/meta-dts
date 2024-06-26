#!/bin/bash

# Initialize variables
PROGRAMMER=""
READ_FLAG=""
OUTPUT_FILE=""
EXTRA_OPTIONS=""

# Function to print usage
usage() {
    echo "Usage: $0 -p PROGRAMMER -r OUTPUT_FILE [EXTRA_OPTIONS]"
    exit 1
}

# Parse command-line arguments
while [[ "$#" -gt 0 ]]; do
    case $1 in
        -p)
            PROGRAMMER="$2"
            shift 2
            ;;
        -r)
            READ_FLAG="-r"
            OUTPUT_FILE="$2"
            shift 2
            ;;
        *)
            EXTRA_OPTIONS+="$1 "
            shift
            ;;
    esac
done

# Check if required arguments are provided
if [[ -z "$PROGRAMMER" ]]; then
    usage
fi

# Create the directory for the output file if it doesn't exist
OUTPUT_DIR=$(dirname "$OUTPUT_FILE")
mkdir -p "$OUTPUT_DIR"

# Mock flashrom functionality
echo "Mock flashrom: Programmer = $PROGRAMMER"
echo "Mock flashrom: Extra options = $EXTRA_OPTIONS"

if [[ -n "$READ_FLAG" ]]; then
    if [[ -z "$OUTPUT_FILE" ]]; then
        usage
    fi
    echo "Mock flashrom: Reading BIOS into $OUTPUT_FILE"

    # Create a mock rom.bin file with some dummy data
    echo "This is a mock rom.bin file for testing purposes." > "$OUTPUT_FILE"
    
    # Verify if the file is created
    if [ -f "$OUTPUT_FILE" ]; then
        echo "Mock flashrom: Successfully created $OUTPUT_FILE"
    else
        echo "Mock flashrom: Failed to create $OUTPUT_FILE"
        exit 1
    fi
fi
