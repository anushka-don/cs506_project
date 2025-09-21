if (!require("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

BiocManager::install("curatedMetagenomicData")

# Load Libraries
library(dplyr)
library(DT)
library(curatedMetagenomicData)

# accessing data
relative_abundance <- curatedMetagenomicData("MetaCardis_2020_a.relative_abundance", 
                                             dryrun = FALSE,rownames = "short")

x <- relative_abundance[[1]]

abundance <- assay(x, "relative_abundance")

abundance_df <- as.data.frame(abundance)

# Add taxa names as a column
abundance_df$taxa <- rownames(abundance_df)

# Move taxa to the first column
abundance_df <- abundance_df %>% relocate(taxa)

write.csv(abundance_df, "MetaCardis2020_relative_abundance.csv", row.names = FALSE)

# Sample metadata
sample_meta <- as.data.frame(colData(x))

# Taxa metadata (taxonomy info)
taxa_meta <- as.data.frame(rowData(x))

# Save sample metadata
write.csv(sample_meta, "MetaCardis2020_sample_metadata.csv", row.names = TRUE)

# Save taxa metadata
write.csv(taxa_meta, "MetaCardis2020_taxa_metadata.csv", row.names = TRUE)
