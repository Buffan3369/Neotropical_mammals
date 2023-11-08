#!/usr/bin/env python 
# Adapted from Daniele Silvestro, 2017

import numpy as np
import random
import os

print("Birth-Death Sampler 18\n")

os.chdir("E:/Internship_ISEM/Neotropical_Mammals/REPO/Neotropical_mammals/")

##########################################################################
###########                 SIMULATION SETTINGS                 ##########
##########################################################################
n_reps = 1 # number of simulations

# CONSTRAINTS on DATA SIZE (simulations will run until size requirements are met)
s_species=1   # number of starting species
minSP=1200     # min size data set
maxSP=2200     # max size data set
minEX_SP=0    # minimum number of extinct lineages allowed

# SETTINGS for BD-SHIFT SIMULATIONS
root_age = 66
death_age = 5.33
shift_speciation = []      # specify times of rate shifts (speciation)
shift_extinction = []       # specify times of rate shifts (extinction)
speciation_rates = [0.25] # if using rate shifts, the first rate is that closest to the root age
extinction_rates = [0.2] # 

scale=100. #determines time step of simulation => 10e-2 My here


############################ SIMULATION  FUNCTION #############################
def simulate(L,M,timesL,timesM,root,death,scale,s_species,maxSP,gl=0,gm=0,Dtraj=[0],Tcomp_clade=[0]):
	ts=list()
	te=list()
	
	L,M,root,death=L/scale,M/scale,int(root*scale),int(death*scale)
    #Birth-death rates
	l=L[0]
	m=M[0]
    #Initialise ts
	for i in range(s_species): 
		ts.append(root)
    #Simulate birth events
	for t in np.arange(root, death):
		TS=len(ts)
        #breaking condition => we simulated enough species (threshold fixed by maxSP)
		if TS>maxSP: 
			break
		for j in range(TS): # extant lineages
			ran=random.random()
			if ran<l:
				ts.append(t) # sp time
	#Now that we simulated birth events, let's move on to death events
	for sp_t in ts:
		t = sp_t
		te.append(death) #initialisation of the extinction times vector
		while t < death: #goes negatively
			ran = random.random()
			if ran < m:
				te[-1] = t
				break
			else:
				t += 1
    #Convert to arrays and return unscaled            
	ts=np.array(ts)
	te=np.array(te)
	return -(ts)/scale, -(te)/scale

############################ SIMULATION SETTINGS ##############################
def write_to_file(f, o):
	sumfile = open(f , "w") 
	sumfile.writelines(o)
	sumfile.close()

################################# EXECUTION ###################################
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
    write_to_file("./data_2023/simulated_data/sim_%s.txt" % (0), o) 	

















