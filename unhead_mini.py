# -*- coding: utf-8 -*-
"""
Created on Tue Mar 7 2023
@author: Lucas Buffan
@email: lucas.l.buffan@gmail.com
"""

import os
os.chdir("E:/Internship_ISEM/Neotropical_Mammals/Neotrop_repo/Neotropical_mammals")

## Open raw pbdb dataset and split it by skipped lines "\n" -----------------------------------
a = open("data_2023/Neotropical_Mammals_raw_2023.tsv", "r")
raw = a.read()
a.close()
raw = raw.split("\n")
raw = raw[18:] #erase metadata at the beginning

## Store lines in the unheaded_mini dataset ---------------------------------------------------
with open("data_2023/Neotropical_Mammals_unheaded_2023.tsv", "w") as file:
    for line in raw:
        if len(line.split("\t")) == 17:
            file.write(line)
            file.write("\n")

## Delete remaining objects -------------------------------------------------------------------
del a, raw, file, line