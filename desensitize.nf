nextflow.enable.dsl=2

params.cpu=4
pipeline_version = "v1"

nf_mod_path = "$baseDir/modules"

// **********************************************************************************

//human_genome = "$baseDir/util/hg38.fa"
//fastq_screen_conf = "$baseDir/util/fastq_screen.conf"

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

// Include modules for each tool
//include { pe_First_Fastqc } from "$nf_mod_path/fastqc.nf"
//include { pe_Reformat } from "$nf_mod_path/reformat.nf"
include { pe_Fastqscreen } from "$nf_mod_path/fastqscreen.nf"
include { pe_Repair } from "$nf_mod_path/repair.nf"
//include { pe_First_Fastqc as pe_Second_Fastqc } from "$nf_mod_path/fastqc.nf"
//include { Multiqc } from "$nf_mod_path/multiqc.nf"

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

    //pe_First_Fastqc(reads)
    //pe_Reformat(reads)
    pe_Fastqscreen(reads)
    pe_Repair(pe_Fastqscreen.out.pe_Fastqscreen_reads)
    //pe_Second_Fastqc(pe_Repair.out.repair_reads)

    // MultiQC -- Needs input from all FastQC and fastp reports
    /*FILES_FOR_MULTIQC = pe_First_Fastqc.out.FASTQC_out.collect { it[1] }.mix(
        pe_Fastqscreen.out.pe_Fastqscreen_out.collect { it[1] }.mix(
            pe_Second_Fastqc.out.FASTQC_out.collect { it[1] }
        )
    ).collect()
    Multiqc(FILES_FOR_MULTIQC)
    */
}
