#!/bin/bash

# Slurm job options (job-name, compute nodes, job time)
#SBATCH --job-name=gyre-test
#SBATCH --time=0:20:0
#SBATCH --nodes=2 
#SBATCH --ntasks=112
#SBATCH --cpus-per-task=1

# Replace [budget code] below with your project code (e.g. n01-SOWISE)
#SBATCH --account=n01-SOWISE 
#SBATCH --partition=standard
#SBATCH --reservation=shortqos
#SBATCH --qos=short

# Setup the job environment (this module needs to be loaded before any other modules)
module load epcc-job-env

# Set the number of threads to 1
#   This prevents any threaded system libraries from automatically
#   using threading.
export OMP_NUM_THREADS=1

# Launch the parallel job
#   Using 126 MPI processes and up to 64 MPI processes per node
#   srun picks up the distribution from the sbatch options
srun --distribution=block:block --hint=nomultithread ./mitgcmuv
