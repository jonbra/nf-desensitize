process Multiqc {

  publishDir "${params.outdir}/multiqc", mode: 'copy'

  input:
  path 'data/*'

  output:
  path 'multiqc_report.html'

  shell:
  '''
  multiqc data
  '''
}
