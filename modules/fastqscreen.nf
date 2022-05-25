process pe_Fastqscreen {

  input:
  tuple val(sampleName), path(read1), path(read2)

  output:
  tuple val(sampleName), path ("${read1.getSimpleName()}.tagged_filter.fastq.gz"), path ("${read2.getSimpleName()}.tagged_filter.fastq.gz"), emit: pe_Fastqscreen_reads
  path "*.{txt,html}"
  path "*.{sh,out}"

  publishDir "${params.outdir}/fastqscreen", mode: 'copy', pattern: '*.{txt,html,tagged_filter.fastq.gz}'
  publishDir "${params.outdir}/fastqscreen/log", mode: 'copy', pattern: '*.{out,sh}'

  script:
  """
  fastq_screen --aligner bowtie2 \
    --nohits ${read1} ${read2} \
    --threads ${params.cpu} \
    --conf /resources/fastq_screen.conf

  cp .command.sh ${sampleName}.fastqscreen.sh
  cp .command.out ${sampleName}.fastqscreen.out
  """
}
