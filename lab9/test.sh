#!/bin/bash

# Required to rerun the server
killall main

# Define the PORT number
PORT=1337

# Compile the C code
cd build
make

# Run the compiled executable in the background
./main &

# Test the server using nc command
echo "Testing..."
echo "Hello, server!" | nc -u localhost "$PORT"

