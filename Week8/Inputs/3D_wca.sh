#!/bin/bash

# Set the command and input file path
command="mpirun lmp -var density"
input_file="3dWCA.in"

# Loop to iterate over the range from 0.8 to 1.5 with 0.1 increments
for ((i=8; i<=15; i++)); do
    # Calculate the density value
    density=$(echo "scale=1; $i/10" | bc)

    # Run the command with the current density value
    $command $density -in $input_file -log logfile_$density.log
    sleep 1
done
