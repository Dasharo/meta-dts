#!/bin/bash

# Function to print usage
usage() {
    echo "Usage: $0 info"
    exit 1
}

# Check if the first argument is 'info'
if [[ "$1" != "info" ]]; then
    usage
fi

# Mock info command output
echo "Dasharo EC Tool Mock - Info Command"
echo "-----------------------------------"
echo "board: novacustom/nv4x_adl"
echo "version: 2023-03-10_c0fe220"
echo "-----------------------------------"

exit 0
