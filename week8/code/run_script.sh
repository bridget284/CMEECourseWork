#!/bin/bash
#PBS -l walltime=12:00:00
#PBS -l select=1:ncpus=1:mem=1gb

module load anaconda3/personal

echo "R is about to run"

cp $HOME/bs2324_HPC_2024_demographic_cluster.R $TMPDIR

cp $HOME/bs2324_HPC_2024_main.R $TMPDIR

cp $HOME/Demographic.R $TMPDIR

R --vanilla < $HOME/bs2324_HPC_2024_demographic_cluster.R

mv output_* $HOME/output_files/

echo "R has finished running"
