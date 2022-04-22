library(tidyverse)

# TODO
# sample should contain the whole filename except .fastq.gz
# Then only add desensitized 
files <- list.files("/mnt/N/Virologi/NGS/1-NGS-Analyser/1-Rutine/2-Resultater/SARS-CoV-2/1-Illumina_NSC_FHI/2022/rawfastq/220413_A00943.A.Project_20220413-S1-FHI411/",
           recursive = TRUE,
           pattern = "gz$",
           full.names = TRUE)

files <- files[-grep("ktr", files)]

sample_id <- sort(unique(gsub("_.*", "", basename(files))))

R1 <- sort(files[grep("R1", files)])
R2 <- sort(files[grep("R2", files)])

df <- as_tibble(cbind(R1, R2))

df <- df %>%
  mutate(sample_id = gsub("_.*", "", basename(R1))) %>%
  select("sample" = sample_id,
         "fastq_1" = R1,
         "fastq_2" = R2)

write_csv(df, "/home/jonr/Prosjekter/nf-desensitize/FHI411.csv")
