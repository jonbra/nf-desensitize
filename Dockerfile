FROM continuumio/miniconda3
# Dockerfile based on this: https://gitlab.com/uit-sfb/fhi-desensitize/-/blob/master/Dockerfile

# NOTE: /resources will contain files available locally to the container.
# (Configuration file for fastqscreen and downloadable references for fastqscreen.)
WORKDIR /resources
COPY fastq_screen.conf .
COPY references.txt .
RUN wget -i references.txt
# NOTE: /workflow will be mounted and "overwritten" by NF on runtime

ENV HOME /workflow
WORKDIR ${HOME}

# Install and configure Conda
COPY conda-environment.yaml .
RUN apt-get update
RUN conda config --add channels conda-forge
RUN conda config --add channels bioconda
RUN conda env create --name desensitize --file conda-environment.yaml
RUN echo "source activate desensitize" > ~/.bashrc
ENV PATH /opt/conda/envs/desensitize/bin:$PATH

# Copy over Nextflow related files
COPY modules/ ./modules/
COPY desensitize.nf .
RUN mkdir output
VOLUME /workdir/output
#ENTRYPOINT ["nextflow"]
