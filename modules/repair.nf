process pe_Repair {

  input:
  tuple val(sampleName), path(read1), path(read2)

  output:
  tuple val(sampleName), path ("${sampleName}_R1.desensitized.fastq.gz"), path ("${sampleName}_R2.desensitized.fastq.gz"), emit: repair_reads

  publishDir "${params.outdir}/repair_filtered", mode: 'copy', pattern: '*.{gz}'

  shell:
  '''
  repair.sh in=!{read1} in2=!{read2} out1=!{sampleName}_R1.desensitized.fastq.gz  out2=!{sampleName}_R2.desensitized.fastq.gz
  '''
}
