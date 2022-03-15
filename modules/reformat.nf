process pe_Reformat {

  echo true

  input:
  tuple val(sampleName), path(read1), path(read2)

  output:
  tuple val(sampleName), path ("${sampleName}_reformat_raw_R1.fq.gz"), path ("${sampleName}_reformat_raw_R2.fq.gz"), emit: pe_Reformat_raw_out

  publishDir "${params.outdir}/reformat_raw", mode: 'link', pattern: '*.{gz}'

  shell:
  '''
  reformat.sh out=!{sampleName}_reformat_raw_R1.fq.gz out2=!{sampleName}_reformat_raw_R2.fq.gz in=!{read1} in2=!{read2} vpair
  '''
}
