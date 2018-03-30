#!/bin/sh
set -u
#
# Checking args
#

source scripts/config.sh

if [[ ! -f "$DATASET" ]]; then
    echo "$DATASET does not exist. Please provide a training set file to process Job terminated."
    exit 1
fi

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
    echo "$RESULT_DIR does not exist. Directory created for pipeline output."
    mkdir -p "$RESULT_DIR"
fi

#
# Job submission
#

PREV_JOB_ID=""
ARGS="-q $QUEUE -W group_list=$GROUP -M $MAIL_USER -m $MAIL_TYPE"

#
## 01-run randomizer
#

PROG="01-run-randomizer"
export STDERR_DIR="$SCRIPT_DIR/err/$PROG"
export STDOUT_DIR="$SCRIPT_DIR/out/$PROG"

init_dir "$STDERR_DIR" "$STDOUT_DIR"

echo "Sequences smaller than $MIN_SIZE will be removed"
echo "$NUM_FILES training files containing $SPLIT_SIZE training examples with k=$KM_SIZE requested"

echo "launching $SCRIPT_DIR/run_analysis_array.sh "
           
JOB_ID=`qsub $ARGS -v WORKER_DIR,MIN_SIZE,NUM_FILES,SPLIT_SIZE,DATASET,RESULT_DIR,STDERR_DIR,STDOUT_DIR -N run_randomizer -e "$STDERR_DIR" -o "$STDOUT_DIR" $SCRIPT_DIR/run_analysis.sh`

if [ "${JOB_ID}x" != "x" ]; then
     echo Job: \"$JOB_ID\"
     PREV_JOB_ID=$JOB_ID  
else
     echo Problem submitting job. Job terminated
fi

echo "job successfully submited"
