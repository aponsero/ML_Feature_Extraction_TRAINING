# ML_Feature_Extraction_TRAINING
pipeline for features extraction (kmer frequency count) to train a linear classifier using HPC cluster.

## Quick start

### Edit scripts/config.sh file

please modify the

  - DATASET = indicate here the dataset to use as input
  - RESULT_DIR = indicates the directory for output
  - MIN_SIZE = minimum sequence size taken into account (remove short sequences from the dataset)
  - SPLIT_SIZE = Number of training examples per output files
  - NUM_FILE = Number of training files
  - KM_SIZE = kmer size for frequency calculation (if > 8pb, consider modifying the jobs running walltime )
  - MAIL_USER = indicate here your arizona.edu email
  - GROUP = indicate here your group affiliation

You can also modify

  - MAIL_TYPE = change the mail type option. By default set to "bea".
  - QUEUE = change the submission queue. By default set to "standard".

### Filter and create subsets

Run

  ```bash
  ./split.sh
  ```

This command will remove short contigs from the dataset (< MIN_SIZE) and create NUM_FILE files containing SPLIT_SIZE sequences randomly selected from the DATASET. The split files are stored in RESULT_DIR/.

Once the job is completed successfully, the analysis can be run.

### Calculate kmer frequencies

Run

  ```bash
  ./submit.sh
  ```
Will place in queue an array job for the analysis. The final output is located in SAMPLE_DIR/kmers.
