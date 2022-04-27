nextflow.enable.dsl=2

pipeline_version = "v1"

nf_mod_path = "$baseDir/modules"

params.outdir = params.outpath + "/desensitized/"

// **********************************************************************************

include { pe_Fastqscreen } from "$nf_mod_path/fastqscreen.nf"
include { pe_Repair } from "$nf_mod_path/repair.nf"

workflow {
    main:
    if (params.test) {
        reads = Channel
                .fromSRA(["SRR11939535", "SRR12473500"])
                .map{ tuple(it[0], it[1][0], it[1][1]) }
    }
    else {
        reads = Channel
                .fromPath(params.samplelist)
                .splitCsv(header:true, sep:",")
                .map{ row -> tuple(row.sample, file(row.fastq_1), file(row.fastq_2)) }
    }

    pe_Fastqscreen(reads)
    pe_Repair(pe_Fastqscreen.out.pe_Fastqscreen_reads)
}
