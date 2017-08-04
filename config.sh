export CWD=$PWD
# where programs are
export BIN_DIR="/rsgrps/bhurwitz/hurwitzlab/bin"
# where the dataset to prepare is
export DATASET="/rsgrps/bhurwitz/alise/my_data/Machine_learning/Machine2/training_set/Vir_trainingset/vir_trainingset.fa"
export TYPE="viral"
#either "viral" or "bacterial"
export RESULT_DIR="/rsgrps/bhurwitz/alise/temp/test_features"
#place to store the scripts
export SCRIPT_DIR="$PWD/scripts"
export WORKER_DIR="$SCRIPT_DIR/workers"
# min length filtered read
export MIN_SIZE=500
# size of splited files
export SPLIT_SIZE=100
export NUM_FILES=2
# kmer size
export KM_SIZE=3
# User informations
export QUEUE="standard"
export GROUP="bhurwitz"
export MAIL_USER="aponsero@email.arizona.edu"
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
