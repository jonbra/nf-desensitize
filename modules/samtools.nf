process Bam2fq {

  publishDir "output/converted"
  conda '/opt/conda/envs/env'

  input:
  path bam

  output:
  path "${bam.getSimpleName()}_R1.fastq", emit: fastq_r1
  path "${bam.getSimpleName()}_R2.fastq", emit: fastq_r2

  shell:
  '''
  samtools bam2fq !{bam} -1 !{bam.getSimpleName()}_R1.fastq -2 !{bam.getSimpleName()}_R2.fastq
  '''
}
