#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=4
#SBATCH --cpus-per-task=1
#SBATCH	--mem=5GB
#SBATCH --time=5:00:00
#SBATCH --job-name=equil_WK9
#SBATCH --output=slurm_%j.out

# Modules
module purge
module load openmpi/intel/4.1.1

# Create system
mpirun lmp -var configfile ../Inputs/n360/kalj_n360_create.lmp -var id 1 -in ../Inputs/create_3d_binary.lmp
mpirun lmp -var configfile ../Inputs/n360/kalj_n360_T1.5.lmp -var id 1 -in ../Inputs/anneal_3d_binary.lmp

values="1.0 0.9 0.8 0.7 0.65 0.6 0.55 0.5 0.475"
for value in $values; do
	mpirun lmp -var configfile ../Inputs/n360/kalj_n360_T$value.lmp -var id 1 -in ../Inputs/anneal_3d_binary.lmp
done
