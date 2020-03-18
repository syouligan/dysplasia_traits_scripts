#!/bin/bash

# Run MAGMA on 
# usage: writes to sample input directory
# ./MAGMA_each.sh (workDir) (inFile) (geneLoc) (trait) (genome) (geneList)
# eg ./MAGMA_each.sh /share/ScratchGeneral/scoyou/projects/dysplasia_GWAS/skeletal_traits Biobank2-British-Bmd-As-C-Gwas-SumStats_MAGMA.input.txt /share/ScratchGeneral/scoyou/projects/dysplasia_GWAS/MAGMA_files/NCBI37/NCBI37.3.gene.loc UKBB_eBMD /share/ScratchGeneral/scoyou/projects/dysplasia_GWAS/MAGMA_files/g1000_eur/g1000_eur /share/ScratchGeneral/scoyou/projects/dysplasia_GWAS/gene_sets/Dysplasia_ENTREZ.txt

# input: gzipped fastq file read1 [read2 for paired-end] 
#        STAR genome directory, RSEM reference directory - prepared with STAR_RSEM_prep.sh script
workDir=$1 # directory containing summary stats for GWAS and output with following white space seperated columns: RSID CHR BP P N
inFile=$2 # summary stats for GWAS with following white space seperated columns: RSID CHR BP P N
geneLoc=$3 # gene locus file such as that provided with magma (/share/ScratchGeneral/scoyou/projects/dysplasia_GWAS/MAGMA_files/NCBI37/NCBI37.3.gene.loc)
trait=$4 # trait being examined (default to input folder name)
genome=$5 # genome LD files such as those provided with magma, note ancestry specific (/share/ScratchGeneral/scoyou/projects/dysplasia_GWAS/MAGMA_files/g1000_eur/g1000_eur)
geneList=$6 # a file containing lists of ENTREZ gene IDs for gene set testing (ie SET1 1546 90122 386 6001 23019)

# Creates gene annotation
/share/ScratchGeneral/scoyou/local/bin/MAGMA/magma --annotate window=1 --snp-loc $workDir/$trait/$inFile --gene-loc $geneLoc --out $workDir/$trait

# Calculates genewise enrichment using mean method
/share/ScratchGeneral/scoyou/local/bin/MAGMA/magma --bfile $genome --gene-annot $workDir/*.genes.annot --gene-model snp-wise=mean --seed 1 --pval $workDir/$trait/$inFile use=1,4 ncol=5 --out $workDir/$trait/$trait'.mean'

# Calculates genewise enrichment using multi method
/share/ScratchGeneral/scoyou/local/bin/MAGMA/magma --bfile $genome --gene-annot $workDir/*.genes.annot --gene-model snp-wise=multi --seed 1 --pval $workDir/$trait/$inFile use=1,4 ncol=5 --out $workDir/$trait/$trait'.multi'

# Calculates geneset enrichment using mean method
/share/ScratchGeneral/scoyou/local/bin/MAGMA/magma --gene-results $workDir/*_mean.genes.raw --set-annot $geneList --out $workDir/$trait'.mean'

# Calculates geneset enrichment using multi method
/share/ScratchGeneral/scoyou/local/bin/MAGMA/magma --gene-results $workDir/*_multi.genes.raw --set-annot $geneList --out $workDir/$trait'.multi'
