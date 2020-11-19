import os
import time 
import timeit
import cProfile
import pstats
from LV1 import main as mainlv1
from LV2 import main as mainlv2

pr = cProfile.Profile()
'''LV1.py profiling'''
pr.enable()
mainlv1([])
pr.disable()
ps = pstats.Stats(pr)
ps.sort_stats('cumulative').print_stats(10)   

pr.enable()
'''LV2.py profiling'''
mainlv2([])
pr.disable()
ps = pstats.Stats(pr)
ps.sort_stats('cumulative').print_stats(20)   


# start1 = time.time()
# os.system("python -m cProfile LV1.py")
# end1 = time.time()
# start2 = time.time()
# os.system("python -m cProfile LV2.py")
# end2 = time.time()
# print("LV1 Running time: %s Second"%(end1-start1))
# print("LV2 Running time: %s Second"%(end2-start2))

