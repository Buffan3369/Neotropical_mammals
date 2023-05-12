# -*- coding: utf-8 -*-
"""
Process extant South American species list available on Wikipedia:
https://en.wikipedia.org/wiki/List_of_mammals_of_South_America

@author: Lucas Buffan

"""
import pandas as pd
import os
os.chdir("E:/Internship_ISEM/Neotropical_Mammals/DATA")

# Genera seeker
genera_nosep = []
genera_sep = []
with open("wikipedia_extant_South_american_mammals.txt") as file:
    for line in file:
        line = line.split(" ")
        if "Genus:" in line:
            genera_sep.append(line[1])
            no_sep = line[1].split("\n")
            genera_nosep.append(no_sep[0])
        
# Corresponding order and family seeker
order = []
family = []
for genus in genera_sep:
#    print(genus)
    with open("wikipedia_extant_South_american_mammals.txt", "r") as file:
        for line in file:
            line = line.split(" ")
            if "Order:" in line:
                no_sep = line[1].split("\n")
                tmp_ord = no_sep[0]
            elif "Family:" in line:
                no_sep = line[1].split("\n")
                tmp_fam = no_sep[0]
            elif genus in line:
                order.append(tmp_ord)
                family.append(tmp_fam)
                break

# Assemble in one dataset and save
Extant_Mammals = pd.DataFrame({"Order":order, "Family": family, "Genus": genera_nosep})
Extant_Mammals.to_csv("../REPO/Neotropical_mammals/data_2023/extant_mammals.csv",
                      index = False)
