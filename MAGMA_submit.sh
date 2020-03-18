#!/bin/bash

<<<<<<< HEAD
## Perform MAGMA on all trait folder in directory using summary statistics
=======
## Perform MAGMA on all trait folder in directory
>>>>>>> b12e541c3256d548ed6080b2cd2a3e86a7518fab
#######

# Number of cores
ncores=20

<<<<<<< HEAD
# Experimental info. workDir is folder containing subfolders with summary stats for each trait
=======
# Experimental info (update for single or paired reads, and readlength). Set paired to "yes" if appropriate. NOTE: reads are assumed to be stranded.
>>>>>>> b12e541c3256d548ed6080b2cd2a3e86a7518fab
workDir="/share/ScratchGeneral/scoyou/projects/dysplasia_traits/skeletal_traits"
geneLoc="/share/ScratchGeneral/scoyou/projects/dysplasia_GWAS/MAGMA_files/NCBI37/NCBI37.3.gene.loc"
genome="/share/ScratchGeneral/scoyou/projects/dysplasia_GWAS/MAGMA_files/g1000_eur/g1000_eur"
geneList="/share/ScratchGeneral/scoyou/projects/dysplasia_GWAS/gene_sets/Dysplasia_ENTREZ.txt"

# Path to folder containing sample folders
sample_Path=$workDir
echo "sample_Path "$sample_Path

# Make an array containing names of directories containing samples
sample_arr=( $(ls $workDir) )
echo "# in samples array ${#sample_arr[@]}"
echo "names in samples array ${sample_arr[@]}"

# Submit command for each sample in array
for sample in ${sample_arr[@]}; do

# Runs loop for only the first sample in array (used for development)
# for sample in ${sample_arr[0]}; do

# Define input directory, define and make output and log directories
inPath=$sample_Path/$sample
echo "inPath $inPath"

# Path for log files
logDir=$sample_Path/$sample
mkdir -p $logDir
echo "logDir $logDir"

# Define input files
<<<<<<< HEAD
inFile=$inPath/$sample/*"_MAGMA.input.txt"
=======
inFile1=$inPath/$sample/*"_MAGMA.input.txt"
>>>>>>> b12e541c3256d548ed6080b2cd2a3e86a7518fab
echo "inFile1 $inFile1"

# Command to be executed
Command="/home/scoyou/projects/dysplasia_traits/dysplasia_traits_scripts/MAGMA_each.sh $inPath $inFile $geneLoc $sample $genome $geneList"

# Submit to queue
echo "Command "$Command
# $CommandPE
# qsub -P OsteoporosisandTranslationalResearch -N 'MAGMA'$sample -b y -wd $logDir -j y -R y -l mem_requested=8G -pe smp $ncores -V -m bea -M s.youlten@garvan.org.au $Command
done
