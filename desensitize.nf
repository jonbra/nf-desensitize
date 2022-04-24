nextflow.enable.dsl=2

params.cpu=4
pipeline_version = "v1"

nf_mod_path = "$baseDir/modules"

params.outdir = params.outpath + "/results/"

// **********************************************************************************


File pipeline_tool_file = new File("$params.outpath/pipeline_info.txt")
pipeline_tool_file.write '\n' +
                         'Pipeline:\t' + pipeline_version + '\n' +
                         '\n' +
                         'RunFolder:\t' + params.outpath + '\n' +
                         'SampleSheet:\t' + params.samplelist + '\n' +
                         '\n'


log.info """\
         D E S E N S I T I Z E - N F   P I P E L I N E
         ===================================
         nf_mod_path: ${nf_mod_path}
         outpath: ${params.outpath}
         """
         .stripIndent()


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
