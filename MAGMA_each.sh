#!/bin/bash

# Run MAGMA on all folders in inPath
# usage: writes to sample input directory
# ./MAGMA_each.sh (inPath) (inFile) (geneLoc) (trait) (genome) (geneList)
# eg ./MAGMA_each.sh /share/ScratchGeneral/scoyou/projects/dysplasia_GWAS/skeletal_traits Biobank2-British-Bmd-As-C-Gwas-SumStats_MAGMA.input.txt /share/ScratchGeneral/scoyou/projects/dysplasia_GWAS/MAGMA_files/NCBI37/NCBI37.3.gene.loc UKBB_eBMD /share/ScratchGeneral/scoyou/projects/dysplasia_GWAS/MAGMA_files/g1000_eur/g1000_eur /share/ScratchGeneral/scoyou/projects/dysplasia_GWAS/gene_sets/Dysplasia_ENTREZ.txt

# input: gzipped fastq file read1 [read2 for paired-end] 
#        STAR genome directory, RSEM reference directory - prepared with STAR_RSEM_prep.sh script
inPath=$1 # directory containing summary stats for GWAS and output with following white space seperated columns: RSID CHR BP P N
inFile=$2 # summary stats for GWAS with following white space seperated columns: RSID CHR BP P N
geneLoc=$3 # gene locus file such as that provided with magma (/share/ScratchGeneral/scoyou/projects/dysplasia_GWAS/MAGMA_files/NCBI37/NCBI37.3.gene.loc)
trait=$4 # trait being examined (default to input folder name)
genome=$5 # genome LD files such as those provided with magma, note ancestry specific (/share/ScratchGeneral/scoyou/projects/dysplasia_GWAS/MAGMA_files/g1000_eur/g1000_eur)
geneList=$6 # a file containing lists of ENTREZ gene IDs for gene set testing (ie SET1 1546 90122 386 6001 23019)

# Creates gene annotation
/share/ScratchGeneral/scoyou/local/bin/MAGMA/magma --annotate window=1 --snp-loc $inFile --gene-loc $geneLoc --out $inPath/

# Calculates genewise enrichment using mean method
/share/ScratchGeneral/scoyou/local/bin/MAGMA/magma --bfile $genome --gene-annot $inPath/*.genes.annot --gene-model snp-wise=mean --seed 1 --pval $inFile use=1,4 ncol=5 --out $inPath/$trait'.mean'

# Calculates genewise enrichment using multi method
/share/ScratchGeneral/scoyou/local/bin/MAGMA/magma --bfile $genome --gene-annot $inPath/*.genes.annot --gene-model snp-wise=multi --seed 1 --pval $inFile use=1,4 ncol=5 --out $inPath/$trait'.multi'

# Calculates geneset enrichment using mean method
/share/ScratchGeneral/scoyou/local/bin/MAGMA/magma --gene-results $inPath/$trait/*_mean.genes.raw --set-annot $geneList --out $inPath/$trait'.mean'

# Calculates geneset enrichment using multi method
/share/ScratchGeneral/scoyou/local/bin/MAGMA/magma --gene-results $inPath/$trait/*_multi.genes.raw --set-annot $geneList --out $inPath/$trait'.multi'
