# Total height
setwd("/share/ScratchGeneral/scoyou/projects/dysplasia_GWAS/skeletal_traits")

library('biomaRt')

summaryStats <- read.table("GIANT_height_total/GIANT_HEIGHT_Wood_et_al_2014_publicrelease_HapMapCeuFreq.txt", header = TRUE)
SNP_ids <- unique(as.character(summaryStats$MarkerName))
SNPsMart <- useMart(biomart="ENSEMBL_MART_SNP", dataset="hsapiens_snp", host = "grch37.ensembl.org")
rsMap <- getBM(attributes = c("refsnp_id", "chr_name", "chrom_start"),
               filters    = "snp_filter",
               values = SNP_ids,
               mart = SNPsMart)

idx <- match(summaryStats$MarkerName, rsMap$refsnp_id)
summaryStats$Chromosome <- rsMap$chr_name [idx]
summaryStats$BP <- rsMap$chrom_start [idx]
summaryStats$N <- round(summaryStats$N)
write.table(summaryStats, "GIANT_height_total/GIANT_HEIGHT_Wood_et_al_2014_publicrelease_HapMapCeuFreq_wCHR.txt", quote = FALSE, sep="\t", row.names = FALSE)

# Male height
setwd("/share/ScratchGeneral/scoyou/projects/dysplasia_GWAS/skeletal_traits")

library('biomaRt')

summaryStats <- read.table("GIANT_height_male/GIANT_Randall2013PlosGenet_stage1_publicrelease_HapMapCeuFreq_HEIGHT_MEN_N.txt", header = TRUE)
SNP_ids <- unique(as.character(summaryStats$MarkerName))
SNPsMart <- useMart(biomart="ENSEMBL_MART_SNP", dataset="hsapiens_snp", host = "grch37.ensembl.org")
rsMap <- getBM(attributes = c("refsnp_id", "chr_name", "chrom_start"),
               filters    = "snp_filter",
               values = SNP_ids,
               mart = SNPsMart)

idx <- match(summaryStats$MarkerName, rsMap$refsnp_id)
summaryStats$Chromosome <- rsMap$chr_name [idx]
summaryStats$BP <- rsMap$chrom_start [idx]
summaryStats$N <- round(summaryStats$N)
write.table(summaryStats, "GIANT_height_male/GIANT_Randall2013PlosGenet_stage1_publicrelease_HapMapCeuFreq_HEIGHT_MEN_N_wCHR.txt", quote = FALSE, sep="\t", row.names = FALSE)

# Female height
setwd("/share/ScratchGeneral/scoyou/projects/dysplasia_GWAS/skeletal_traits")

library('biomaRt')

summaryStats <- read.table("GIANT_height_female/GIANT_Randall2013PlosGenet_stage1_publicrelease_HapMapCeuFreq_HEIGHT_WOMEN_N.txt", header = TRUE)
SNP_ids <- unique(as.character(summaryStats$MarkerName))
SNPsMart <- useMart(biomart="ENSEMBL_MART_SNP", dataset="hsapiens_snp", host = "grch37.ensembl.org")
rsMap <- getBM(attributes = c("refsnp_id", "chr_name", "chrom_start"),
               filters    = "snp_filter",
               values = SNP_ids,
               mart = SNPsMart)

idx <- match(summaryStats$MarkerName, rsMap$refsnp_id)
summaryStats$Chromosome <- rsMap$chr_name [idx]
summaryStats$BP <- rsMap$chrom_start [idx]
summaryStats$N <- round(summaryStats$N)
write.table(summaryStats, "GIANT_height_female/GIANT_Randall2013PlosGenet_stage1_publicrelease_HapMapCeuFreq_HEIGHT_WOMEN_N_wCHR.txt", quote = FALSE, sep="\t", row.names = FALSE)

# Extreme height
setwd("/share/ScratchGeneral/scoyou/projects/dysplasia_GWAS/skeletal_traits")

library('biomaRt')

summaryStats <- read.table("GIANT_extreme_height/GIANT_EXTREME_HEIGHT_Stage1_Berndt2013_publicrelease_HapMapCeuFreq.txt", header = TRUE)
SNP_ids <- unique(as.character(summaryStats$MarkerName))
SNPsMart <- useMart(biomart="ENSEMBL_MART_SNP", dataset="hsapiens_snp", host = "grch37.ensembl.org")
rsMap <- getBM(attributes = c("refsnp_id", "chr_name", "chrom_start"),
               filters    = "snp_filter",
               values = SNP_ids,
               mart = SNPsMart)

idx <- match(summaryStats$MarkerName, rsMap$refsnp_id)
summaryStats$Chromosome <- rsMap$chr_name [idx]
summaryStats$BP <- rsMap$chrom_start [idx]
summaryStats$N <- summaryStats$N_cases + summaryStats$N_controls
summaryStats$N <- round(summaryStats$N)
write.table(summaryStats, "GIANT_extreme_height/GIANT_EXTREME_HEIGHT_Stage1_Berndt2013_publicrelease_HapMapCeuFreq_wCHR.txt", quote = FALSE, sep="\t", row.names = FALSE)




