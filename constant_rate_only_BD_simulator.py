#!/usr/bin/env python 
# Adapted from Daniele Silvestro

import numpy as np
import random
import os

print("Birth-Death Sampler 18\n")

os.chdir("C:/Users/lucas/OneDrive/Bureau")

##########################################################################
###########                 SIMULATION SETTINGS                 ##########
##########################################################################

n_reps = 1 # number of simulations

# CONSTRAINTS on DATA SIZE (simulations will run until size requirements are met)
s_species=1   # number of starting species
minSP=200     # min size data set
maxSP=300     # max size data set
minEX_SP=0    # minimum number of extinct lineages allowed

# SETTINGS for BD-SHIFT SIMULATIONS
root_age = 66
death_age = 0
shift_speciation = []      # specify times of rate shifts (speciation)
shift_extinction = []       # specify times of rate shifts (extinction)
speciation_rates = [0.25] # if using rate shifts, the first rate is that closest to the root age
extinction_rates = [0.15] # 

scale=100.


#################### SIMULATION  FUNCTIONS #########################################


def simulate(L,M,timesL,timesM,root,death,scale,s_species,maxSP,gl=0,gm=0,Dtraj=[0],Tcomp_clade=[0]):
	ts=list()
	te=list()
	
	L,M,root,death=L/scale,M/scale,int(root*scale),int(death*scale)
    
	for i in range(s_species): 
		ts.append(root)
		te.append(death)
	
    #for time in our interval
	for t in np.arange(root, death):
#       Constant rate birth-death 
		l=L[0]
		m=M[0]        
            			
		TE=len(te)
		if TE>maxSP: 
			break
		for j in range(TE): # extant lineages
			if te[j]==death:
				ran=random.random()
                #Birth event
				if ran<l: 
					te.append(death) # add species
					ts.append(t) # sp time
                #Death event
				elif ran>l and ran < (l+m): # extinction
					te[j]=t
	te=np.array(te)
	return -np.array(ts)/scale, -(te)/scale

############### SIMULATION SETTINGS ########################################
def write_to_file(f, o):
	sumfile = open(f , "w") 
	sumfile.writelines(o)
	sumfile.close()


LOtrue=[0]
n_extinct=-0
timesL = np.sort(np.array([float(root_age),float(death_age)]+shift_speciation))[::-1]
timesM = np.sort(np.array([float(root_age),float(death_age)]+shift_extinction))[::-1]
L = np.array(speciation_rates)
M = np.array(extinction_rates)
root = -root_age
death = -death_age
FAtrue,LOtrue=simulate(L,M,timesL,timesM,root,death,scale,s_species, maxSP)
n_extinct = len(LOtrue[LOtrue>0])
print("L", L, "M",M, "tL",timesL,"tM",timesM)
print(len(LOtrue),len(L),len(M))
o="clade	species	ts	te\n"
for i in range(len(FAtrue)):
    o+= "%s\t%s\t%s\t%s\n" % (0,i+1,FAtrue[i],LOtrue[i])
    write_to_file("sim_%s.txt" % (0), o) 	

















