# ------------------------------------------------------------------------------
#          ---        
#        / o o \    Project:  cov-armee Simulation
#        V\ Y /V    Split trees in one file per tree
#    (\   / - \     
#     )) /    |     
#     ((/__) ||     Code by Ceci VA 
# ------------------------------------------------------------------------------

# Load libraries ---------------------------------------------------------------
library(treeio)
library(stringr)
library(dplyr)
library(readr)

# Read, split, write -----------------------------------------------------------
trees <- read.beast(file = snakemake@input[["trees"]])

if (length(trees) == 1) trees <- list(trees)

lapply(1:length(trees), function(i) {
    tree <- trees[[i]]
    tree_t <- as_tibble(tree) %>% mutate(label2 = ifelse(!is.na(label), paste0("leaf_", label, "|", type, "|", time), label))
    tree_renamed <- rename_taxa(tree, tree_t, label, label2)
    
    tryCatch({
      #write.tree(as.phylo(tree_renamed), file = paste0(snakemake@params[["out_file"]], i, ".tree"))
      write.beast.newick(tree_renamed, file = paste0(snakemake@params[["out_file"]], i, ".tree")) # For some reason, this write functions is mixing the types so we save them in a separate file
      write_tsv(as_tibble(tree_renamed), file = paste0(snakemake@params[["out_file"]], i, ".tsv"))
      }, error = function(x) message(paste("Error writting tree ", i, " continue")))
})
