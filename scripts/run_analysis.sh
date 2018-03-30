#!/bin/bash

#PBS -l select=1:ncpus=1:mem=5gb
#PBS -l walltime=24:00:00
#PBS -l cput=24:00:00

LOG="$STDOUT_DIR/filter.log"
ERRORLOG="$STDERR_DIR/filter.log"

if [ ! -f "$LOG" ] ; then
	touch "$LOG"
fi

echo "Started `date`">>"$LOG"

echo "Host `hostname`">>"$LOG"

#
# load tools
#

module load python/3/3.5.2


#
# remove too short sequences
#
export RUN="$WORKER_DIR/Filter.py"
echo "$RUN -f $DATASET -o $RESULT_DIR -m $MIN_SIZE" >> $LOG
python3 $RUN -f $DATASET -o $RESULT_DIR -m $MIN_SIZE 2> "ERRORLOG"

#
# get number of sequences after filter
#
export DATA_FILTER="$RESULT_DIR/filtered_dataset.fasta"
export NUM=$(grep -c '>' $DATA_FILTER)
echo "number found in file : $NUM" >> $LOG 

# Check if number of remaining sequences are enough for the SPlit_size

if [ $SPLIT_SIZE -gt $NUM ]; then
    echo "$NUM sequences are available for training after filtering (min size of $MIN_SIZE pb). Please provide a $SPLIT_SIZE inferior to $NUM in config file or consider modifying the minimum sequence size. Job aborted."
    exit 1
fi

#
# randomize the dataset and generates randomlists
#

export RUN="$WORKER_DIR/randomize.py"
echo "$RUN -f $DATA_FILTER -o $RESULT_DIR -s $SPLIT_SIZE -m $NUM -n $NUM_FILES" >> $LOG
python3 $RUN -f $DATA_FILTER -o $RESULT_DIR -s $SPLIT_SIZE -m $NUM -n $NUM_FILES


echo "Finished `date`">>"$LOG"
