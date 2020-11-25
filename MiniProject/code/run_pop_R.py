import subprocess
''''''
try:
    subprocess.call(["Rscript",'pop.R'])
except:
    print("The run failed.")