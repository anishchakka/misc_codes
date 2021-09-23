
## function to add gene names
# input: file location, mapping id's, output dir
# output: new file with gene names
add_gene_names <- function(fname, map.ids, out_dir) {
  file.df <- read.delim2(fname)
  df.map <- merge.data.frame(file.df , map.ids, 
                               by.x = 'gene', by.y = 'ensembl_gene_id_decimals',
                               all.x = TRUE)
  df.map <- df.map[, c(length(df.map), 1:length(df.map)-1)]
  df.map <- df.map[order(df.map$p_val_adj),]
  
  new.fname = paste("geneID", basename(fname), sep = "_")
  dir.create(file.path(out_dir), showWarnings = FALSE)
  
  new.fname.path <- paste(out_dir, new.fname, sep = "/")
  write.table(df.map, file= new.fname.path,
              quote = FALSE, row.names = FALSE, sep = "\t")
}

## read ensembl mapping
map.ids <- read.delim2("ensembl_mapping.txt")
map.ids$description <- NULL

## get list of file names
# uniq gene list
file.list <- list.files("../Spladder/01-DiffTest/testing_KO_vs_PBS_4",
                             pattern = "*.gene_unique.tsv", full.names = TRUE)
# output directory
out_dir = "../Spladder/01-DiffTest/testing_KO_vs_PBS_4/01-GeneID/"

# call function on the list of files
for (file_name in file.list) {
  add_gene_names(file_name, map.ids, out_dir)
}
