#!/bin/bash
python process_data.py
Rscript pop.R
xdg-open ../results/PopBio.pdf 
