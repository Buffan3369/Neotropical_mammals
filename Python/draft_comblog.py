#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Tue Mar 12 11:05:30 2024

@author: lucas.buffan
"""
import sys
import glob
import numpy as np
import os
import pandas as pd

## Default function to combine log files from PyRate
def comb_log_files(path_to_files,burnin=0,tag="",resample=0,col_tag=[]):
    infile=path_to_files
    sys.path.append(infile)
    direct="%s/*%s*.log" % (infile,tag)
    files=glob.glob(direct)
    files=np.sort(files)
    print("found", len(files), "log files...\n")
    if len(files)==0: quit()
    j=0


    burnin = int(burnin)

    if "_sp_rates.log" in os.path.basename(files[0]) or "_ex_rates.log" in os.path.basename(files[0]):
        for f in files:
            f_temp = open(f,'r')
            x_temp = [line for line in f_temp.readlines()]
            x_temp = x_temp[max(1,int(burnin)):]
            x_temp = np.array(x_temp)
            try:
                if resample>0:
                    r_ind= np.sort(np.random.randint(0,len(x_temp),resample))
                    x_temp = x_temp[r_ind]
                if j==0:
                    comb = x_temp
                else:
                    comb = np.concatenate((comb,x_temp))
                j+=1
            except:
                print("Could not process file:",f)

        outfile = "%s/combined_%s%s.log" % (infile,len(files),tag)
        with open(outfile, 'w') as f:
            #
            for i in comb: f.write(i)
             #fmt_list=['%i']
             #if platform.system() == "Windows" or platform.system() == "Microsoft":
             #    np.savetxt(f, comb, delimiter="\t",fmt=fmt_list,newline="\r") #)
             #else:
             #    np.savetxt(f, comb, delimiter="\t",fmt=fmt_list,newline="\n") #)
               #
        sys.exit("done")


    for f in files:
        try:
            file_name =  os.path.splitext(os.path.basename(f))[0]
            print(file_name, end=' ')
            t_file=np.loadtxt(f, skiprows=max(1,int(burnin)))
            shape_f=np.shape(t_file)
            print(shape_f)
            #t_file = t[burnin:shape_f[0],:]#).astype(str)
            # only sample from cold chain

            head = np.array(next(open(f)).split()) # should be faster\
            #txt_tbl = np.genfromtxt(f, delimiter="\t")
            #print "TRY", txt_tbl[0:],np.shape(txt_tbl), head
            if j == 0:
                tbl_header = '\t'.join(head)
            if "temperature" in head or "beta" in head:
                try:
                    temp_index = np.where(head=="temperature")[0][0]
                except(IndexError):
                    temp_index = np.where(head=="beta")[0][0]

                temp_values = t_file[:,temp_index]
                t_file = t_file[temp_values==1,:]
                print("removed heated chains:",np.shape(t_file))
            shape_f=np.shape(t_file)

            if resample>0:
                r_ind= np.sort(np.random.randint(0,shape_f[0],resample))
                t_file = t_file[r_ind,:]



        except: print("ERROR in",f)
        if len(col_tag) == 0:
            if j==0:
                tbl_header = next(open(f))#.split()
                comb = t_file
            else:
                comb = np.concatenate((comb,t_file),axis=0)
        else:
            head_temp = next(open(f)).split() # should be faster
            sp_ind_list=[]
            for TAG in col_tag:
                if TAG in head_temp:
                    sp_ind_list+=[head_temp.index(s) for s in head_temp if s == TAG]

            try:
                col_tag_ind = np.array([int(tag_i) for tag_i in col_tag])
                sp_ind= np.array(col_tag_ind)
            except:
                sp_ind= np.array(sp_ind_list)

            #print "COLTAG",col_tag, sp_ind, head_temp
            #sys.exit()


            #print "INDEXES",sp_ind
            if j==0:
                head_temp= np.array(head_temp)
                head_t= ["%s\t" % (i) for i in head_temp[sp_ind]]
                tbl_header="it\t"
                for i in head_t: tbl_header+=i
                tbl_header+="\n"
                print("found", len(head_t), "columns")
                comb = t_file[:,sp_ind]
            else:
                comb = np.concatenate((comb,t_file[:,sp_ind]),axis=0)

        j+=1

    #print shape(comb)
    if len(col_tag) == 0:
        sampling_freq= comb[1,0]-comb[0,0]
        comb[:,0] = (np.arange(0,len(comb))+1)*sampling_freq
        fmt_list=['%i']
        for i in range(1,np.shape(comb)[1]): fmt_list.append('%4f')
    else:
        fmt_list=['%i']
        for i in range(1,np.shape(comb)[1]+1): fmt_list.append('%4f')
        comb = np.concatenate((np.zeros((len(comb[:,0]),1)),comb),axis=1)
    comb[:,0] = (np.arange(0,len(comb)))

    print(np.shape(comb), len(fmt_list))

    outfile = "%s/combined_%s%s.log" % (infile,len(files),tag)

    with open(outfile, 'w') as f:
        f.write(tbl_header)
        np.savetxt(f, comb, delimiter="\t",fmt=fmt_list,newline="\n") #)


## New extension allowing to combine BDS log files varying in their number of rate shifts (+/- 1)
def comb_bds_extended(path_to_files,
                      burnin=0,
                      tag="", # tag = "mcmc" or "marginal rates"
                      resample=0,
                      col_tag=[]):
    # extract the names of all the files matching the pattern imposed by `tag`
    direct="%s/*%s*.log" % (path_to_files,tag)
    files=glob.glob(direct)
    files=np.sort(files)
    file_temp = [f for f in files if tag in os.path.basename(f)]
    # headers of these files and their respective shapes
    heads = list(np.array(next(open(f)).split()) for f in file_temp)
    shapes = list(np.shape(h)[0] for h in heads)
    # if some runs inferred one more shift than others (per rate)
    if len(np.unique(shapes)) == 2:
        h = 0
        #positions of the runs with a lower number of rate shifts
        lower = np.where(shapes == np.unique(shapes)[0])[0] #np.unique() returns an ordered tuple (increasing)
        #position of the runs with a higher number of rate shifts
        higher = np.where(shapes == np.unique(shapes)[1])[0]
        #name of the colmuns missing in some runs ( "mu_i" and "lambda_i" in mcmc.logs) => reversed to facilitate insertion in the table
        missing = [i for i in heads[higher[0]] if i not in heads[lower[0]]][::-1]
        #name of the columns after which we'll add the missing ones ("mu_0" and "lambda_0" in mcmc.logs)
        missing_prev = [el.split("_")[0] + "_0" for el in missing]
        for i in range(len(file_temp)):
            tmp_df = pd.read_csv(file_temp[i], sep="\t")
            # remove burn-in
            tmp_df = tmp_df[:][int(burnin):]
            # remove undesired columns (not specified in col_tag)
            if len(col_tag) > 0:
                tmp_df = tmp_df.drop(col_tag, axis = 1)
            if i in lower: # if we have to add "missing" rates
                for j in range(len(missing)):
                    idx = tmp_df.columns.get_loc(missing_prev[j])
                    tmp_df.insert(idx+1, missing[j], tmp_df[missing_prev[j]])
            if h == 0:
                comb = tmp_df
            else:
                comb = pd.concat([comb, tmp_df], axis = 0)
            h += 1
        outfile = "%s/combined_%s_%s.log" % (path_to_files, len(file_temp), tag)
        comb.to_csv(outfile, index=False, sep="\t")
    else:
        comb_log_files(path_to_files, burnin, tag, resample, col_tag)


path_to_files="Documents/GitHub/PhD/Chapter_1/results_EXTENDED/SALMA_smoothed/genus_level/1-Full/BDS/pyrate_mcmc_logs"
burnin=10
tag="marginal_rates"

comb_bds_extended(path_to_files, burnin, tag)
