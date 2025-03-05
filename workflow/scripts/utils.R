# R script to extract most recent sample time from a tree

library(tidyverse)
library(treedataverse)

tree <- read.beast(file = snakemake@input[["tree"]])[1 + snakemake@params[["tree_index"]]]
mrs <- max(tree[[1]]@data$time)

write(mrs, file = snakemake@output[["mrs"]])


# tree = read.beast("/Users/ceciliav/Projects/2105-cov-armee/11.published-simulations/results/sim_asymp_symp_rho/inference/2types_sim3p_rho.2types_inf3p_rho.1.1.trees")[[1]]
tree = read.beast("//Users/ceciliav/Projects/2105-cov-armee/11.published-simulations/results/sim_asymp_symp_rho/sim/2types_sim3p_rho.trees")
as_tibble(tree) %>% filter(grepl("leaf", label)) %>% 
  count(type)


# 
# seq_ratio = 1
# pop_ratio=(1/0.7 -1)
# sampling_type2= 0.4
# deathRate_type1=36.5
# deathRate_type2=36.5
# seq_ratio*pop_ratio*sampling_type2*deathRate_type1/(sampling_type2+deathRate_type2-seq_ratio*pop_ratio*sampling_type2)

# parameterization

seq_ratio = 0.95
p_type1 = 0.8
pop_ratio = (1 - p_type1) / p_type1
sampling_type2 = 0.4
deathRate_type1 = 36.5
deathRate_type2 = 36.5


seq_ratio*pop_ratio*sampling_type2*deathRate_type1/(sampling_type2+deathRate_type2-seq_ratio*pop_ratio*sampling_type2)
3.758667263308


birth_type1 = 15
f_type2= 5.0
p_type1= 0.7
pop_ratio = (1 - p_type1) / p_type1

b_11 = birth_type1
b12 = birth_type1 * pop_ratio 
b22 = birth_type1 * pop_ratio * f_type2
b21= birth_type1  * f_type2


trace = read.table("/Users/ceciliav/Projects/2105-cov-armee/11.published-simulations/results/sim_asymp_symp/inference/2types_sim3p.2types_inf3p.1.1.log",
                   header = TRUE)

pop_ratio = (1 - trace$p_type1) / trace$p_type1
b22 = trace$birthRateSVtype1 * trace$f_type2 * pop_ratio
b12 = trace$birthRateSVtype1 * pop_ratio
b21 = trace$birthRateSVtype1 * trace$f_type2 

seq_ratio = 0.6423841059602649
sampling_type2 = trace$samplingRateSVi1_type2
deathRate_type1 = trace$deathRateSVtype1
deathRate_type2 = trace$deathRateSVtype2
s1 = seq_ratio*pop_ratio*sampling_type2*deathRate_type1/(sampling_type2+deathRate_type2-seq_ratio*pop_ratio*sampling_type2)
s1


r21 = (1-p2)/p2
r21*p2 +p2 = 1
p2(r21+1) = 1
p2 = 1/(r21+1)

