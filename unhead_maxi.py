# -*- coding: utf-8 -*-
"""
Created on Tue Mar 7 2023
@author: Lucas Buffan
@email: lucas.l.buffan@gmail.com
"""

import os
os.chdir("E:/Internship_ISEM/Neotropical_Mammals/Neotrop_repo/Neotropical_mammals")

## Open raw pbdb dataset and split it by skipped lines "\n" -----------------------------------
a = open("data_2023/Neotropical_Mammals_raw_maxi_2023.tsv", "r", encoding = 'utf8')
raw = a.read()
a.close()
raw = raw.split("\n")

## Store lines of length 64 only (i.e. not "notes" or stuff) in the unheaded_maxi dataset -----
with open("data_2023/Neotropical_Mammals_unheaded_maxi_2023.tsv", "w", encoding = 'utf8') as file:
    for line in raw:
        if len(line.split("\t")) == 64:
            file.write(line)
            file.write("\n")

## Delete remaining objects -------------------------------------------------------------------
del a, raw, file, line