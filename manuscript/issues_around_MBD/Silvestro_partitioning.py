#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Thu Nov 14 18:15:06 2024

@author: lucas.buffan
"""

import os
import numpy as np

def init_Dtraj(n_clades,n_events):
    return np.zeros(n_clades*n_events).reshape(n_events,n_clades)

def getDT(T,s,e): # returns the Diversity Trajectory of s,e at times T
    return np.array([len(s[s>t])-len(s[e>t]) for t in T])


os.chdir("/home/lucas.buffan/Documents/GitHub/PhD/Chapter_1/results_EXTENDED/MBD/SALMA_smoothed/genus_level/1-Full_conservative_partitioning")
dataset = "Full_Eocene_Oligocene_SALMA_smoothed_se_est.txt"

j = 3 # fictively, replicate 3

# load TsTe file
t_file = np.loadtxt(dataset, skiprows=1)

# split speciation and extinction times
ts = t_file[:,2+2*j] 
te = t_file[:,3+2*j]

# get clade IDs
clade_ID=t_file[:,0]
clade_ID=clade_ID.astype(int)

# concatenate ts and te and sort them by increasing order
all_events = np.sort(np.concatenate((ts,te),axis=0))[::-1] # events are speciation/extinction that change the diversity trajectory

# initialise diversity trajectory => as many change in diversity as we have speciation/extinction events
n_clades,n_events=max(clade_ID)+1,len(all_events)
Dtraj=init_Dtraj(n_clades,n_events)


s_list = []
e_list = []
s_or_e_list=[]
clade_inx_list=[]
unsorted_events = [] # will contain the times at which each birth or death event occur
print("Indexing events...")
for i in range(n_clades): # useless here, only one clade
    "used for Dtraj"
    s_list.append(ts[clade_ID==i])
    e_list.append(te[clade_ID==i])
    "used for lik calculation"
    if i==0: # diversity traj
        # adding 1s or 2s for each speciation or extinction event
        s_or_e_list += list(np.repeat(1,len(ts[clade_ID==i]))) # index 1 for s events
        s_or_e_list += list(np.repeat(2,len(te[clade_ID==i]))) # index 2 for e events
    else: # additional curves
        s_or_e_list += list(np.repeat(0,len(ts[clade_ID==i]))) # index 0 for events of continuous variable change
        s_or_e_list += list(np.repeat(0,len(te[clade_ID==i]))) # index 0 for events of continuous variable change
        
    clade_inx_list += list(np.repeat(i,2*len(te[clade_ID==i])))
    unsorted_events += list(ts[clade_ID==i])
    unsorted_events += list(te[clade_ID==i])

s_or_e_array= np.array(s_or_e_list)
unsorted_events= np.array(unsorted_events)
s_or_e_array[unsorted_events==0] = 3 # limit condition, i.e. species not extinct


""" so now: s_or_e_array = 0 (cont variable change), s_or_e_array = 1 (s events), s_or_e_array = 2 (e events), s_or_e_array = 3 (e=0 events)"""


# get an array : 
    # - 1st row => time of the event
    # - 2nd row => nature of the event (extinction : 2, speciation: 1)
    # - 3rd row => index of the clade (here always 0 as we only have one clade)
""" concatenate everything:
                          1st row: all events  2nd row index s,e     3rd row clade index """
all_events_temp = np.array([unsorted_events,    s_or_e_array,         np.array(clade_inx_list)])

# sort the array by decreasing time
idx = np.argsort(all_events_temp[0])[::-1] # get indexes of sorted events
all_events_temp2 = all_events_temp[:,idx] # sort by time of event
all_time_eve = all_events_temp2[0] # first row of the sorted array => sorted time of events
all_Times = all_events_temp2[0]
fixed_focal_clade = 0


idx_s = []
idx_e = []
i = 0 # index of the clade
## Get clade's diversit trajectory
dd_focus_clade = getDT(all_events_temp2[0],s_list[i],e_list[i]) + np.zeros(len(all_events_temp2[0])) # adding np.zeros makes DT expressed in float instead of int
# dd_focus_clade: raw diversity trajectory (not rescaled 0 to 1) is used in the likelihood calculation
Dtraj[:,i] = dd_focus_clade/np.max(dd_focus_clade) # scaling
ind_clade_i = np.arange(len(all_events_temp2[0]))[all_events_temp2[2]==i] # i.e., seq(from = 0, to = nb_events, by = 1) for the clade 0
# get the indices of the events corresponding to a speciation and an extinction separately
ind_sp = np.arange(len(all_events_temp2[0]))[all_events_temp2[1]==1] # speciation
ind_ex = np.arange(len(all_events_temp2[0]))[all_events_temp2[1]==2] # extinction
# Rank of the events in their order of occurrence
idx_s.append(np.intersect1d(ind_clade_i,ind_sp))
idx_e.append(np.intersect1d(ind_clade_i,ind_ex))

## Filter out events out of the user-specified time range ---------------------
max_T = 52
min_T = 33.9

# Indices (i.e. rank) of all events occurring after max_T
index_temp = np.arange(0,len(all_Times)) 
M_index_events_included = index_temp[all_Times <= max_T]
# All events occurring before min_T
index_temp = np.arange(0,len(all_Times))
m_index_events_included = index_temp[all_Times >= min_T]

# Times of all speciation and extinction events (for the clade 0)
sp_times = all_Times[idx_s[fixed_focal_clade]]
ex_times = all_Times[idx_e[fixed_focal_clade]]

# Get indices of all speciation events occurring after max_T
M_index_temp = np.arange(0,len(sp_times))
M_index_included_sp_times = M_index_temp[sp_times <= max_T]
# Same for extinction events
M_index_temp = np.arange(0,len(ex_times)) # why defined twice?? same thing though, as we necessarily have as many speciations as we have extinctions
M_index_included_ex_times = M_index_temp[ex_times <= max_T]

# All speciation events occurring before min_T
m_index_temp = np.arange(0,len(sp_times))
m_index_included_sp_times = m_index_temp[sp_times >= min_T]
# Same for extinction events
m_index_temp = np.arange(0,len(ex_times)) # why defined twice??
m_index_included_ex_times = m_index_temp[ex_times >= min_T]

# combined
index_temp = np.intersect1d(M_index_temp, m_index_temp) # indices of all events (again!?)
index_events_included = np.intersect1d(M_index_events_included, m_index_events_included) # only retained events

# index of the included speciation and extinction times
index_included_sp_times = np.intersect1d(m_index_included_sp_times, M_index_included_sp_times)
index_included_ex_times = np.intersect1d(m_index_included_ex_times, M_index_included_ex_times)

