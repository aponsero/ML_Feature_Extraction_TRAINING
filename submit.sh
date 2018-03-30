#!/bin/sh
set -u
#
# Checking args
#

source scripts/config.sh

if [[ ${#TYPE} -lt 1 ]]; then
  echo "Incorrect training set type value. Please correct specified parameter in config file. Job terminated."
  exit 1
fi

if [[ $MIN_SIZE -lt 1 ]]; then
  echo "Incorrect length sequence value. Please correct specified parameter in config file. Job terminated."
  exit 1
fi

if [[ $SPLIT_SIZE -lt 1 ]]; then
  echo "Incorrect training set size value. Please correct specified parameter in config file. Job terminated."
  exit 1
fi

if [[ $NUM_FILES -lt 1 ]]; then
  echo "Incorrect number of expected training set value. Please correct specified parameter in config file. Job terminated."
  exit 1
fi

if [[ $KM_SIZE -lt 1 ]]; then
  echo "Incorrect kmer size value. Please correct specified parameter in config file. Job terminated."
  exit 1
fi

if [[ ! -d "$RESULT_DIR" ]]; then
    echo "$RESULT_DIR does not exist. Run ./split.sh to create the directory and the split files."
    exit 1
fi

#
# Job submission
#

PREV_JOB_ID=""
ARGS="-q $QUEUE -W group_list=$GROUP -M $MAIL_USER -m $MAIL_TYPE"

#
## 02- run kmerFrequency calculation
#

PROG2="02-kmerCount"

export STDERR_DIR2="$SCRIPT_DIR/err/$PROG2"
export STDOUT_DIR2="$SCRIPT_DIR/out/$PROG2"

init_dir "$STDERR_DIR2" "$STDOUT_DIR2"

if [ "$TYPE" == "viral" ]; then
        export READTYPE=1
else
        export READTYPE=0
fi

cd $RESULT_DIR
export FILES_LIST="Split_list"
touch $FILES_LIST
find . -type f -name "file*.fasta" > $FILES_LIST


echo "launching $SCRIPT_DIR/run_kmercounter.sh in queue"

if [ $NUM_FILES -gt 1 ]; then

        echo "launching as an array job"        

        JOB_ID=`qsub $ARGS -v WORKER_DIR,KM_SIZE,RESULT_DIR,FILES_LIST,STDERR_DIR2,STDOUT_DIR2,READTYPE -N get-kmercount -e "$STDERR_DIR2" -o "$STDOUT_DIR2" -J 1-$NUM_FILES $SCRIPT_DIR/run_kmercouter_array.sh`

        if [ "${JOB_ID}x" != "x" ]; then
             echo Job: \"$JOB_ID\"
        else
             echo Problem submitting job. Job terminated.
             exit 1
        fi
else
        echo "launching as an unique job"
        export MYFILE="file1.fasta"

        JOB_ID=`qsub $ARGS -v WORKER_DIR,KM_SIZE,RESULT_DIR,MYFILE,STDERR_DIR2,STDOUT_DIR2,READTYPE -N get-kmercount -e "$STDERR_DIR2" -o "$STDOUT_DIR2" $SCRIPT_DIR/run_kmercouter.sh`

        if [ "${JOB_ID}x" != "x" ]; then
             echo Job: \"$JOB_ID\"
        else
             echo Problem submitting job. Job terminated.
             exit 1
        fi
fi


echo "job successfully submited"
