# nf-desensitize
See here: https://gitlab.com/uit-sfb/fhi-desensitize

Example run command:
```
docker build -t nf-desensitize .
docker run -v $(pwd):/workflow/output -v /path/to/input/files/:/input nf-desensitize nextflow desensitize.nf --outpath output --samplelist /workflow/output/sample_sheet.csv
```
