# -*- coding: utf-8 -*-
"""
Process extant South American species list available on Wikipedia:
https://en.wikipedia.org/wiki/List_of_mammals_of_South_America#Lists_of_Western_Hemisphere_mammals_from_north_to_south

@author: Lucas Buffan

"""
import pandas as pd
import os
os.chdir("E:/Internship_ISEM/Neotropical_Mammals/DATA")

# Genera seeker
genera = []
with open("wikipedia_extant_South_american_mammals.txt") as file:
    for line in file:
        line = line.split(" ")
        if "Genus:" in line:
            genera.append(line[1])
        
# Corresponding order and family seeker
order = []
family = []
for genus in genera:
    print(genus)
    with open("wikipedia_extant_South_american_mammals.txt", "r") as file:
        for line in file:
            line = line.split(" ")
            if "Order:" in line:
                tmp_ord = line[1]
            elif "Family:" in line:
                tmp_fam = line[1]
            elif genus in line:
                order.append(tmp_ord)
                family.append(tmp_fam)
                break

# Assemble in one dataset and save
Extant_Mammals = pd.DataFrame({"Order":order, "Family": family, "Genus": genera})
Extant_Mammals.to_csv("../REPO/Neotropical_mammals/data_2023/extant_mammals.csv",
                      index = False)
