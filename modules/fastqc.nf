process pe_First_Fastqc {

  echo true

  input:
  tuple val(sampleName), path(read1), path(read2)

  publishDir "${params.outdir}/fastqc", mode: 'link', pattern:'*.{zip,html}'

  output:
  tuple val(sampleName), path ("*.{zip,html}"), emit: FASTQC_out

  shell:
  '''
  fastqc -t !{params.cpu} !{read1} !{read2}
  '''
}
