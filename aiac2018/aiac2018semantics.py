import numpy
#import scipy.stats as stats    
import matplotlib.pyplot as plt
import csv
import random
from collections import Counter
import json

nodes = dict()
signodes = dict()
catdates = dict()
edges = numpy.zeros((0,2))

#import all nodes
with open('nodes.csv', 'r') as csv_file:
    reader = csv.reader(csv_file)
    next(reader, None) #skip header
    for row in reader:
        nodes[int(row[0])] = row[1]
        
#create list of significant nodes
with open('nodes.csv', 'r') as csv_file:
    reader = csv.reader(csv_file)
    next(reader, None) #skip header
    for row in reader:
        if row[3] == 'true':
            signodes[int(row[0])] = row[1]
            
#import dates of time-sensitive nodes
with open('nodes.csv', 'r') as csv_file:
    reader = csv.reader(csv_file)
    next(reader, None) #skip header
    for row in reader:
        if row[4] != '' and row[5] != '':
            daterange = [row[4],row[5]]
            catdates[int(row[0])] = daterange


#import all edges
with open('edges.csv', 'r') as csv_file:
    reader = csv.reader(csv_file)
    next(reader, None) #skip header
    for row in reader:
        edges = numpy.vstack((edges,(int(row[0]),int(row[1]))))

numberofnodes = int(max(edges.flatten()))

steps = dict()
for node in range(numberofnodes + 1):
    nextstep = []
    for row in range(edges.shape[0]):
        if edges[row][0] == node:
            nextstep = nextstep + [edges[row][1]]
    steps[node] = nextstep



#make dict of categorical variables at each site
dataset = numpy.zeros((0,2))

dataset = dict()
with open('dataset.csv', 'r') as csv_file:
    reader = csv.reader(csv_file)
    #next(reader, none) #skip header
    for row in reader:
        rawelements = [x for x in row[1:] if x != '']
        elements = []
        for i in rawelements:
            for j in range(len(nodes)):
                if nodes.get(j) == i:
                    elements = elements + [j]   
        dataset[row[0]] = elements
      
    
#import sitedates
sitedates = dict()
with open('datasetdates.csv', 'r') as csv_file:
    reader = csv.reader(csv_file)
#    next(reader, None) #skip header
    for row in reader:
        daterange = []
        dates1 = [row[1],row[2]]
        daterange = daterange + [dates1]
        if 3 < len(row):
            if row[3] != '':
                dates2 = [row[3],row[4]]
                daterange = daterange + [dates2]
            if 5 < len(row):
                if row[5] != '':
                    dates3 = [row[5],row[6]]
                    daterange = daterange + [dates3]
        sitedates[row[0]] = daterange

def pathtrace(start, depth=10):
    """ negative depths means unlimited recursion """
    kats1 = []

    # recursive function that collects all the ids in `acc`
    def recurse(current, depth):
        kats1.append(current)
        if depth != 0:
            if current != '':
                for step in steps.get(current):
                # recursive call for each subfolder
                    recurse(step, depth-1)

    recurse(start, depth) # starts the recursion
    return kats1

simulations = 1000

year = 50

subsamples2 = dict()

for b in range(simulations):
    subsamplesize = random.randint(1,len(dataset))
    subsample = random.sample(list(dataset), subsamplesize)

    knodes = dict()
    for site in subsample: 
        #check the date of the site
        datecheck = 0
        if site in sitedates.keys():
            for daterange in sitedates.get(site):
                if year in range(int(daterange[0]),int(daterange[1])):
                    datecheck = 1
        if datecheck == 1:
            cats = dataset.get(site)
            kats = []
            for i in cats:
                if i in catdates:
                    if year in range(int(catdates.get(i)[0]),int(catdates.get(i)[1])):
                        kats = kats + [i]
                        kats = kats + pathtrace(i)
                if i not in catdates:
                    kats = kats + [i]
                    kats = kats + pathtrace(i)
            kats = set(kats)
            kats2 = []
            for j in signodes.keys():
                if j in kats:
                    kats2 = kats2 + [j]
            knodes[site] = set(kats2)
    subsamples2[b] = knodes

#simulations = 1000


def removekey(d, key):
    r = dict(d)
    del r[key]
    return r


subsamples = dict(subsamples2)
for b in subsamples2:
    if subsamples2.get(b) == {}:
        del subsamples[b]


#reorganize by signode - quant in "subse"

subse = dict()
for i in signodes.keys():
    kest = list()
    for b in subsamples.keys():
        kcount = 0
        subsample = subsamples.get(b)
        for j in subsample:
            if i in subsample.get(j):
                kcount = kcount + 1
        kcount = kcount / float(len(subsample))
        kest = kest + [kcount]
    subse[i] = kest


#klist = list(signodes.keys())
#
#for k in kquants:
#    for j in sites:
#        result[sites.index(j) , klist.index(k)] = kquants.get(k).get(j)
#        
#result = numpy.vstack((numpy.array(list(signodes.keys())),result))
colheader = ''
for i in list(signodes.values()):
    colheader = colheader + str(i) + ','

#for s in sites:
result = numpy.zeros((simulations,len(signodes)))
colcount = 0
for k in subse.keys():
    #result[0,colcount] = k
#    for s in subsampling.get(k).keys():
    q = subse.get(k)
    result[0:,colcount] = q   + [0] * (simulations - len(q))
    colcount = colcount + 1
numpy.savetxt("result-sab{0}.csv".format(year), result, delimiter=",", header = colheader,  comments='')
       
