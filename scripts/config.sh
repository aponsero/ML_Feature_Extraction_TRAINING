export CWD=$PWD
# where the dataset to prepare is
export DATASET="YOUR/FILE"
export TYPE="viral"
#either "viral" or "bacterial"
export RESULT_DIR="YOUR/DIR"
#place to store the scripts
export SCRIPT_DIR="$PWD/scripts"
export WORKER_DIR="$SCRIPT_DIR/workers"
# min length filtered read
export MIN_SIZE=500
# size of splited files
export SPLIT_SIZE=100
export NUM_FILES=2
# kmer size
export KM_SIZE=8
# User informations
export QUEUE="standard"
export GROUP="yourgroup"
export MAIL_USER="yourmail@email.arizona.edu"
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
