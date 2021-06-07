library(ggplot2)
library(dplyr)
library(tidyr)   # replace_na
library(tibble)  # column_to_rownames

###

DATA_DIR <- 'data/'
OUT_DIR <- 'images/'

###

 if (!requireNamespace("BiocManager", quietly = TRUE))
   install.packages("BiocManager")
# BiocManager::install("TxDb.Hsapiens.UCSC.hg19.knownGene")
 BiocManager::install("TxDb.Mmusculus.UCSC.mm10.knownGene")
 BiocManager::install("ChIPseeker")
 BiocManager::install("clusterProfiler")
 BiocManager::install("org.Mm.eg.db")
 
 
library(ChIPseeker)
#library(TxDb.Hsapiens.UCSC.hg19.knownGene)
library(TxDb.Mmusculus.UCSC.mm10.knownGene)
library(clusterProfiler)

###

#NAME <- 'H3K9me3_MEL.ENCFF175TIH.mm10.filtered'
#NAME <- 'H3K9me3_MEL.ENCFF725BPX.mm10.filtered'
NAME <- 'mouseZ-DNA1'
BED_FN <- paste0(DATA_DIR, NAME, '.bed')


###

txdb <- TxDb.Mmusculus.UCSC.mm10.knownGene

peakAnno <- annotatePeak(BED_FN, tssRegion=c(-3000, 3000), TxDb=txdb, annoDb="org.Mm.eg.db")

#pdf(paste0(OUT_DIR, 'chip_seeker.', NAME, '.plotAnnoPie.pdf'))
png(paste0(OUT_DIR, 'chip_seeker.', NAME, '.plotAnnoPie.png'))
plotAnnoPie(peakAnno)
dev.off()

# peak <- readPeakFile(BED_FN)
# pdf(paste0(OUT_DIR, 'chip_seeker.', NAME, '.covplot.pdf'))
# covplot(peak, weightCol="V5")
# dev.off()
# 