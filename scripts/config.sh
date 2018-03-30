export CWD=$PWD
# where programs are
export BIN_DIR="/rsgrps/bhurwitz/hurwitzlab/bin"
# where the dataset to prepare is
export DATASET="/rsgrps/bhurwitz/alise/my_data/Riveal_exp/Datasets/Tara_broad_subsample/bact_set/cent_Map_cleaned/bact_map_cent-cleaned.fasta"
export TYPE="bacterial"
#either "viral" or "bacterial"
export RESULT_DIR="/rsgrps/bhurwitz/alise/my_data/Riveal_exp/Datasets/Tara_broad_subsample/bact_set/cent_Map_cleaned/extract_kmers"
#place to store the scripts
export SCRIPT_DIR="$PWD/scripts"
export WORKER_DIR="$SCRIPT_DIR/workers"
# min length filtered read
export MIN_SIZE=500
# size of splited files
export SPLIT_SIZE=10000
export NUM_FILES=10
# kmer size
export KM_SIZE=8
# User informations
export QUEUE="standard"
export GROUP="group"
export MAIL_USER="myemail@email.arizona.edu"
export MAIL_TYPE="bea"

#
# --------------------------------------------------
function init_dir {
    for dir in $*; do
        if [ -d "$dir" ]; then
            rm -rf $dir/*
        else
            mkdir -p "$dir"
        fi
    done
}

# --------------------------------------------------
function lc() {
    wc -l $1 | cut -d ' ' -f 1
}
