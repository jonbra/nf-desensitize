process pe_Fastqscreen {

  input:
  tuple val(sampleName), path(read1), path(read2)

  output:
  tuple val(sampleName), path ("${read1.getSimpleName()}.tagged_filter.fastq.gz"), path ("${read2.getSimpleName()}.tagged_filter.fastq.gz"), emit: pe_Fastqscreen_reads
  path "*.{txt,html}", emit: pe_Fastqscreen_out

  publishDir "${params.outdir}/fastqscreen", mode: 'copy', pattern: '*.{txt,html}'

  shell:
  '''
  fastq_screen --aligner bowtie2 \
    --nohits !{read1} !{read2} \
    --threads !{params.cpu} \
    --conf /resources/fastq_screen.conf
  '''
}
