#!/usr/bin/env python3

import argparse
import itertools
from Bio import SeqIO
import sys, getopt


def get_args():
  parser = argparse.ArgumentParser(description='Filter sequences and divide file')
  parser.add_argument('-f', '--fasta', help='FASTA input file',
    type=str, metavar='FILE', required=True)

  parser.add_argument('-o', '--output', help='output directory',
    type=str, metavar='OUTPUT', required=True)

  parser.add_argument('-m', '--mini', help='minimum filter size', default=500,
    type=int, metavar='MINI', required=False)

  return parser.parse_args()


def main():
   args = get_args()
   inputfile = args.fasta
   mini = args.mini
   output= args.output
   name = output+"/filtered_dataset.fasta"
   
   with open(name, "w") as output_handle:
        print("working into "+name+"\n")
        for record in SeqIO.parse(inputfile, "fasta"):
            seq    = record.seq
            if (len(seq) > mini):
                SeqIO.write(record, output_handle, "fasta")

if __name__ == "__main__":
   main()
