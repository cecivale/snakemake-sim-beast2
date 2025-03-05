# Run snakemake workflow in Euler

# old
#bsub -W 120:00 snakemake --cores 100 --profile euler --use-conda

# slurm
sbatch --time=120:00:00 --wrap="snakemake --cores 100 --profile slurm --use-conda --keep-going"

