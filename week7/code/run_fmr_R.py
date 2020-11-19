import subprocess
out_bytes = subprocess.check_output(["Rscript",'fmr.R'])
 
suc = b'Reading CSV\nCreating graph\nnull device \n 1 \nFinished in R!\n'
if out_bytes == suc:
    print("The run was successful.")
    print("The output is saved as ../Results/fmr_plot.pdf.")
    print("Open the output file.")
    subprocess.os.system("evince ../Results/fmr_plot.pdf")
else:
    print("The run failed.")
