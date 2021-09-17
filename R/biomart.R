# if (!requireNamespace("BiocManager", quietly = TRUE))
#   install.packages("BiocManager")
# BiocManager::install("biomaRt")

library(biomaRt)

# # 1. Identify the data base you need (we select 'genes')
# listEnsembl()
# ensembl <- useEnsembl(biomart = "genes")
# 
# # 2. Choose a dataset 
# datasets <- listDatasets(ensembl)
# head(datasets)
# searchDatasets(mart = ensembl, pattern = "hsapiens") #human
# searchDatasets(mart = ensembl, pattern = "mmusculus") #mouse

### function to get ensembl genes using HT-seq counts
get_ensembl_genes <- function(genes = "genes", dataset = "hsapiens_gene_ensembl",
                              fname) {
  ensembl <- useEnsembl(biomart = genes, dataset = dataset)
  
  # ensembl to gene mapping
  ensembl_ids <- read.delim2(fname, header = FALSE)
  ensembl_ids$V2 <- NULL
  ensembl_ids$V2 <- gsub("\\.\\d+$", "", ensembl_ids$V1)
  
  ensembl_gn <- getBM(attributes = c("ensembl_gene_id", "external_gene_name", 
                                     "description"), 
                      filter = "ensembl_gene_id", 
                      values = ensembl_ids$V2, 
                      mart = ensembl)
  ensembl_gn <- merge.data.frame(ensembl_gn, ensembl_ids, 
                                 by.x = 'ensembl_gene_id', by.y = 'V2')
  colnames(ensembl_gn)[4] <- "ensembl_gene_id_decimals"
  ensembl_gn <- ensembl_gn[, c(1,4,2,3)]
  
  return(ensembl_gn)
}

### obtain the ensembl genes
ensembl_gn <- get_ensembl_genes(dataset = "mmusculus_gene_ensembl", 
                                fname = "../HT-Seq/1w_KO11_S2.counts.txt")
write.table(ensembl_gn, file= "ensembl_mapping.txt",
            quote = FALSE, row.names = FALSE, sep = "\t")
