#!/usr/bin/env bash

# Usage: plate_reader_long_parser.sh $infile $outfile


infile=$1
outfile=$2

echo "Converting "${infile}" to long format"

Rscript convert_xlsx_to_csv.R ${infile} tmp_file.csv

grep "Value" tmp_file.csv -A8 | grep -v "^--$" > tmp_file_matrices.csv

Rscript convert_matrices_to_long_df.R tmp_file_matrices.csv ${outfile}