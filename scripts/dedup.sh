#!/bin/bash

# Use the variable for the job name and log/error files
#$ -N pythia-dedup
#$ -o /exports/eddie/scratch/s2605274/job_runs/EDDIE-pythia-dedup_$JOB_ID.log
#$ -e /exports/eddie/scratch/s2605274/job_runs/EDDIE-pythia-dedup_$JOB_ID.err
#$ -cwd
#$ -P lel_hcrc_cstr_students
#$ -q gpu
#$ -pe gpu-a100 1
#$ -l h_vmem=500G
#$ -l h_rt=24:00:00
#$ -m bea -M s2605274@ed.ac.uk 

export HF_HOME="/exports/eddie/scratch/s2605274/.cache/huggingface_cache"
export TRANSFORMERS_CACHE="/exports/eddie/scratch/s2605274/.cache/huggingface_cache/transformers"
export HF_DATASETS_CACHE="/exports/eddie/scratch/s2605274/.cache/huggingface_cache/datasets"
export PIP_CACHE_DIR="/exports/eddie/scratch/s2605274/.cache/pip"
export CONDA_PKGS_DIRS="/exports/eddie/scratch/s2605274/.cache/conda_pkgs"

source /exports/eddie/scratch/s2605274/miniconda3/etc/profile.d/conda.sh

cd /exports/eddie/scratch/s2605274/deduplicate-text-datasets/
#conda remove --name extract --all
conda activate myenv

# conda create -n pythia python=3.9 
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
# sudo apt-get install gcc


pip3 install numpy scipy sentencepiece
pip3 install -r requirements-tf.txt


cargo build
bash /scripts/deduplicate_single_file.sh /exports/eddie/scratch/s2605274/base_extraction_implementaion/swa_sample.txt dedup_swa.txt 50 2

# Run the main script


conda deactivate 
