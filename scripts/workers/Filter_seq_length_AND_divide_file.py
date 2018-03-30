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

  parser.add_argument('-s', '--split', help='split size', default=5000,
    type=int, metavar='SPLIT', required=False)

  return parser.parse_args()


def main():
   args = get_args()
   inputfile = args.fasta
   mini = args.mini
   size_file= args.split
   output= args.output

   cpt=0
   liste=[]
   for record in SeqIO.parse(inputfile, "fasta"):
    seq    = record.seq
    if (len(seq) > mini):
        liste.append(record)

    if(len(liste)==size_file) :
        name=output+"/file"+str(cpt)+".fasta"
        with open(name, "w") as output_handle:
            for seq in liste:
                SeqIO.write(seq, output_handle, "fasta")

        liste=[]
        cpt=cpt+1


if __name__ == "__main__":
   main()
