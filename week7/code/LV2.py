import sys
import scipy as sc
import scipy.stats
import scipy.integrate as integrate
import matplotlib.pylab as p
from matplotlib.backends.backend_pdf import PdfPages

'''LV2'''
def LV2_model(t,pops): 
    with PdfPages('../results/LV2.pdf') as pdf:
        f1 = p.figure()
        p.plot(t, pops[:,0], 'g-', label='Resource density') # Plot
        p.plot(t, pops[:,1]  , 'b-', label='Consumer density')
        p.grid()
        p.legend(loc='best')
        p.xlabel('Time')
        p.ylabel('Population density')
        p.title('Consumer-Resource population dynamics')
        # p.show()# To display the figure
        pdf.savefig(f1)
        p.close()

        f2 = p.figure()
        p.plot(pops[:,0], pops[:,1]  , 'r-')
        p.grid()
        p.xlabel('Resource density')
        p.ylabel('Consumer density')
        p.title('Consumer-Resource population dynamics')
        # p.show()# To display the figure
        pdf.savefig(f2)
        p.close()
    return None
'''LV2_model''' 

def main(argv): 
    def dCR_dt(pops, t=0):
        R = pops[0]
        C = pops[1]
        dRdt = r * R * (1 - R / K) - a * R * C 
        dCdt = -z * C + e * a * R * C
        # print(dRdt)
        # print(dCdt)
        return sc.array([dRdt, dCdt])
    
    try:
        r = float(sys.argv[1])
        a = float(sys.argv[2])
        z = float(sys.argv[3])
        e = float(sys.argv[4])
        print("valid input")
    except:
        r = 1
        a = 0.5
        z = 1.5
        e = 0.75
        print("invalid input, auto set(r=1,a=0.5,z=1.5,e=0.75).")
    
    K = 30000
    t = sc.linspace(0, 15, 1000)
    R0 = 10
    C0 = 5 
    RC0 = sc.array([R0, C0])
    pops, infodict = integrate.odeint(dCR_dt, RC0, t, full_output=True)
    #print(pops)
    LV2_model(t,pops)
    return 0
''' the main function'''

if (__name__ == "__main__"):
    status = main(sys.argv)
    sys.exit(status)

