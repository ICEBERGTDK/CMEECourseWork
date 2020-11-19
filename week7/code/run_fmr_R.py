import subprocess
''''''
try:
    subprocess.call(["Rscript",'fmr.R'])
except:
    print("The run failed.")
