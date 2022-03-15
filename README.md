# nf-desensitize
See here: https://gitlab.com/uit-sfb/fhi-desensitize

Run with:
`sudo nextflow run desensitize.nf --outpath . --samplelist sample_sheet.csv`  

NB: Change the path to the fastq_screen references on Line 67 in `util/fastq_screen.conf`


ToDo:  
[ ] Am I getting everything I need into the Multiqc report? Check from UiT.  
[ ] Drop some of the publishing of files to outdir, even though they are only links. Like the output of reformat and the fastqc reports.  
[ ] Fixing the path to the bowtie indexes in fastq_screen.conf
