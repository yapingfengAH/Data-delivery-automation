import csv
import sys

################################################################################################################
#  Author     : Wei Chun (John) Chen
#  E-mail     : weichun.chen@admerahealth.com
#  Date       : 2/13/2023
#  Description: Split undetermined reads by index header

#### version 1.1
###################################################################### extract information from samplesheet
file=sys.argv[1]
file=open(file, "r")
data=csv.reader(file)

samplesheet=[]
for row in data:
	samplesheet.append(row)
#print(samplesheet)

dat=[]
for i in range(18, len(samplesheet), 1):
	d=[]
	samplesheet[i][6] = ':' + samplesheet[i][6]
	samplesheet[i][8] = '+' + samplesheet[i][8]
	d.append(samplesheet[i][1])
	d.append(samplesheet[i][6])
	d.append(samplesheet[i][8])
	dat.append(d)
#print(dat)

mm1=[]
mm2=[]
for i in range(len(dat)):
	x1=[]
	x2=[]
	for k in range(1,len(dat[0][1])):
		index1=dat[i][1][:k] + '.' + dat[i][1][k+1:]
		index2=dat[i][2][:k] + '.' + dat[i][2][k+1:]
		x1.append(index1)
		x2.append(index2)
	mm1.append(x1)
	mm2.append(x2)
#print(mm1)
#print(mm2)

with open("temp.csv", "w", newline="") as f:
	writer = csv.writer(f)
	writer.writerows(dat)

with open('mm1.txt', 'w') as m1:
	for i in range(len(mm1)):
		for j in range(len(mm1[0])):
			if(j != len(mm1[0])-1):
                        	m1.write(str(mm1[i][j]) + " ")
			if(j == len(mm1[0])-1):
				m1.write(str(mm1[i][j]) + '\n')

with open('mm2.txt', 'w') as m2:
        for i in range(len(mm2)):
                for j in range(len(mm2[0])):
                        if(j != len(mm2[0])-1):
                                m2.write(str(mm2[i][j]) + " ")
                        if(j == len(mm2[0])-1):
                                m2.write(str(mm2[i][j]) + '\n')

m1.close()
m2.close()
dat=[]
mm1=[]
wmm2=[]

######################################################################
text=open("temp.csv", "r")
lines = text.readlines()
a=[]
for line in lines:
        line = line.strip('\n')
        line = line.replace(',',' ')
        a.append(line)
#print(a)

#####################################################################
with open('samplelist.txt', 'w') as s:
	for i in range(0, len(a)):
		s.write(str(a[i]) + '\n')
s.close()

