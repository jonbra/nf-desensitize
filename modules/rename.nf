process se_Rename {

  publishDir "output/fastq"
  conda '/opt/conda/envs/env'

  input:
  path r1

  output:
  path "${r1.getSimpleName()}.desensitized.fastq.gz", emit: renamed_r1

  shell:
  '''
  mv !{r1} !{r1.getSimpleName()}.desensitized.fastq.gz
  '''
}
