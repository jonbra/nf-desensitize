# nf-desensitize
See here: https://gitlab.com/uit-sfb/fhi-desensitize

Example run command:
```
docker build -t nf-desensitize .
docker run -v $(pwd):/workflow/output -v /path/to/input/files/:/input nf-desensitize nextflow desensitize.nf --threads 8 --outpath output --samplelist /workflow/output/sample_sheet.csv -profile conda
docker run -v $(pwd):/workflow/output -v /media/jonr/SDD2TB/Test_Corona_desensitize_data/:/workflow/input nf-desensitize nextflow desensitize.nf --threads 8 --outpath output --samplelist input/test-samplesheet.csv -profile conda
```
