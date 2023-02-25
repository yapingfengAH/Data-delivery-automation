import csv
import sys

################################################################################################################
#  Author     : Wei Chun (John) Chen
#  E-mail     : weichun.chen@admerahealth.com
#  Date       : 2/24/2023
#  Description: Check for barcode conflict

#### version 1.0
################################################################################################################ script for checking barcode conflict
###################################################################### open file
mismatch0=csv.writer(open("mismatch0.csv",'w'))
mismatch1=csv.writer(open("mismatch1.csv",'w'))

###################################################################### function
def exact_match(samplename, barcode, index1, index2, single_barcode):
	a=[]
	b=[]
	if 'GGGGGG' in index2 or 'GGGGGGGG' in index2 or 'GGGGGGGGGG' in index2: #### if there is single index...

		######################################################################
		print("Single indexing is used among samples:")
		#print("Single indexing is used among samples (it is advised to separate single index from duel indexes in the samplesheet or re-demultiplex single indexing samples even if it does not contribute to barcode conflict):")
		dict_combine={}
		for count, index in enumerate(barcode):
			temp=[]
			if index not in dict_combine:
				temp.append(samplename[count])
				dict_combine[index] = temp
			else:
				dict_combine[index].append(samplename[count])
		#print(dict_combine)

		s1=[]
		for key, value in dict_combine.items():
			if len(value) > 1:
				s1.append(value)
				#print("Samples:", value, "; Barcode: ", key)

		sp1=[]
		for i in range(len(s1)):
			for j in range(len(s1[i])):
				sp1.append(s1[i][j])

		######################################################################
		dict_index1={}
		for count, index in enumerate(index1):
			temp=[]
			if index not in dict_index1:
				temp.append(samplename[count])
				dict_index1[index] = temp
			else:
				dict_index1[index].append(samplename[count])
		#print(dict_index1)

		s2=[]
		for key, value in dict_index1.items():
			if key in single_barcode:
				if len(value) > 1:
					s2.append(value)
					#print("Samples:", value, "; Barcode: ", key)

		sp2=[]
		for i in range(len(s2)):
			for j in range(len(s2[i])):
				sp2.append(s2[i][j])

		sp3 = sp1 + sp2
		sp3 = set(sp3)
		sp3 = list(sp3)
		print()
		print("Exact match:")
		counter=0
		if len(sp3) != 0:
			if counter == 0:
				print("List of samples having conflicting barcodes:")
			counter+=1

			for i in range(len(sp3)): #### print a list of samples
				print(sp3[i])
				a.append(sp3[i])

			print("Barcode conflict information:")

			for key, value in dict_combine.items():
				if len(value) > 1:
					s1.append(value)
					print("Samples:", value, "; Barcode: ", key) #### print barcode conflict information

			for key, value in dict_index1.items():
				if key in single_barcode:
					if len(value) > 1:
						print("Samples:", value, "; Barcode: ", key) #### print barcode conflict information

		else:
			print("There is no barcode conflict!")
		print()

		a.sort()
		return a

		######################################################################
	else:	#### if there is no single index...
		print("Only duel indexing is used:")
		barcode_conflict=[]
		dict_combine={}
		for count, index in enumerate(combine):
			temp=[]
			if index not in dict_combine:
				temp.append(sample[count])
				dict_combine[index] = temp
			else:
				dict_combine[index].append(sample[count])
		#print(dict_combine)
		print()

		s=[]
		for key, value in dict_combine.items():
			if len(value) > 1:
				s.append(value)
				#print("Samples:", value, "; Barcode: ", key)

		sp=[]
		for i in range(len(s)):
			for j in range(len(s[i])):
				sp.append(s[i][j])

		sp=set(sp)
		sp=list(sp)
		counter=0
		if len(sp) != 0:
			if counter == 0:
				print("List of samples having conflicting barcodes:")
			counter+=1

			for i in range(len(sp)): #### print a list of samples
				print(sp[i])
				b.append(sp[i])

		counter=0
		for key, value in dict_combine.items():
			if len(value) > 1:
				counter+=1
				if counter == 1:
					print("Barcode conflict information:")
				print("Samples:", value, "; Barcode: ", key) #### print barcode conflict information

		if counter == 0:
			print("There is no barcode conflict!")
		print()

		b.sort()
		return b

def mismatch_eq_1(samplename, barcode, index2, mm1, mm2, single_samplename, mms):
	c=[]
	d=[]
	if 'GGGGGG' in index2 or 'GGGGGGGG' in index2 or 'GGGGGGGGGG' in index2: #### if there is single index...
		print("Single indexing is used among samples:")
		#print("Single indexing is used among samples (it is advised to separate single index from duel indexes in the samplesheet or re-demultiplex single indexing samples even if it does not contribute to barcode conflict):")
		######################################################################
		print()
		mismatch1=[]
		pattern1=[]
		for i in range(len(barcode)-1):
			for k in range(i+1, len(barcode)):
				s=[]
				for j in range(len(barcode[i])):
					if barcode[i][j] in barcode[k]:
						s.append(samplename[i])
						s.append(samplename[k])
						pattern1.append(barcode[i][j])
						break
				if len(s) != 0:
					mismatch1.append(s)
		#print("Barcode conflict information (for samples that are exactly the same, only shows only the first pattern that violates):")
		#print("mismatch:", mismatch1)
		#print("pattern:", pattern1)

		sp=[]
		for i in range(len(mismatch1)):
			for j in range(len(mismatch1[i])):
				sp.append(mismatch1[i][j])

		######################################################################
		mismatch1_single=[]
		pattern1_single=[]
		p=[]
		for i in range(len(mm1)-1):
			for k in range(i+1, len(mm1)):
				s=[]
				pa=[]
				for j in range(len(mm1[i])):
					if mm1[i][j] in mm1[k]:
						s.append(samplename[i])
						s.append(samplename[k])
						pattern1_single.append(mm1[i][j]+"+"+mm2[i][j])
						pa.append(mm1[i])
						pa.append(mm1[k])
						break
				if len(pa) !=0:
					p.append(pa)
				if len(s) != 0:
					mismatch1_single.append(s)
		#print("Barcode conflict information (for samples that are exactly the same, only shows only the first pattern that violates):")
		#print("mismatch for single index (mismatch1_single):", mismatch1_single)
		#print("pattern for single index (pattern1_single):", pattern1_single)
		#print("pattern (p):", p)

		sp_single=[]
		for i in range(len(mismatch1_single)):
			for j in range(len(mismatch1_single[i])):
				sp_single.append(mismatch1_single[i][j])

		sp3 = sp + sp_single
		sp3 = set(sp3)
		sp3 = list(sp3)
		counter = 0
		if len(sp3) != 0:
			if counter == 0:
				print("List of samples having conflicting barcodes:")
			counter+=1

			for i in range(len(sp3)): #### print a list of samples
				print(sp3[i])
				c.append(sp3[i])


		if len(mismatch1_single) != 0:
			print("Barcode conflict information (for samples that are exactly the same, only shows only the first pattern that violates):")
			for i in range(len(mismatch1_single)):
				if mismatch1_single[i][0] not in single_samplename and  mismatch1_single[i][1] not in single_samplename:
					print("Samples:", mismatch1_single[i], "; Barcodes:", pattern1_single[i]) #### print barcode conflict information

			for i in range(len(mismatch1_single)):
				for k in range(len(single_samplename)):
					if single_samplename[k] in mismatch1_single[i]:
						for l in range(len(p[i][0])):
							if  p[i][0][l] in p[i][1]:
								print("Samples:", mismatch1_single[i], "Barcodes:", p[i][0][l])
						break
		else:
			print("There is no barcode conflict!")
		print()

		c.sort()
		return c

		######################################################################
	else:
		print("Only duel indexing is used:")
		print()
		mismatch1=[]
		pattern1=[]
		for i in range(len(barcode)-1):
			for k in range(i+1, len(barcode)):
				s=[]
				for j in range(len(barcode[i])):
					if barcode[i][j] in barcode[k]:
						s.append(samplename[i])
						s.append(samplename[k])
						pattern1.append(barcode[i][j])
						break
				if len(s) != 0:
					mismatch1.append(s)
		#print("Barcode conflict information (for samples that are exactly the same, only shows only the first pattern that violates):")
		#print("mismatch:", mismatch1)
		#print("pattern:", pattern1)

		sp=[]
		for i in range(len(mismatch1)):
			for j in range(len(mismatch1[i])):
				sp.append(mismatch1[i][j])

		sp=set(sp)
		sp=list(sp)
		counter=0
		if len(sp) != 0:
			if counter == 0:
				print("List of samples having conflicting barcodes:")
			counter+=1

			for i in range(len(sp)): #### print a list of samples
				print(sp[i])
				d.append(sp[i])

		if len(mismatch1) != 0:
			print("Barcode conflict information (for samples that are exactly the same, only shows only the first pattern that violates):")
			for i in range(len(mismatch1)):
				print("Samples:", mismatch1[i], "; Barcodes:", pattern1[i]) #### print barcode conflict information
		else:
			print("There is no barcode conflict!")
		print()

		d.sort()
		return d

###################################################################### main
###################################################################### extract information from samplesheet
file=sys.argv[1]
file=open(file, "r")
data=csv.reader(file)

samplesheet=[]
for row in data:
	samplesheet.append(row)
#print(samplesheet)

print("Sample input:")
sample=[]
index1=[]
index2=[]
for i in range(18, len(samplesheet), 1):
	sample.append(samplesheet[i][1])
	index1.append(samplesheet[i][6])
	index2.append(samplesheet[i][8])
	print(samplesheet[i][1], samplesheet[i][6], samplesheet[i][8])
#print("sample:", sample)
#print("index 1:", index1)
#print("index 2:", index2)
print()

###################################################################### find samples with single index
single_sample=[]
single_barcode=[]
for i in range (len(index2)):
	if index2[i] == 'GGGGGG' or  index2[i] == 'GGGGGGGG' or index2[i] == 'GGGGGGGGGG':
		single_sample.append(sample[i])
		single_barcode.append(index1[i])
#print("single-index sample:", single_sample)
#print("single index:", single_barcode)

###################################################################### combine patterns
combine=[]
for i in range(len(index1)):
	combine.append(index1[i]+"+"+index2[i])
#print("combined pattern:", combine)

###################################################################### Mismatch = 1
dat=[]
for i in range(18, len(samplesheet), 1):
	d=[]
	samplesheet[i][6] = samplesheet[i][6]
	samplesheet[i][8] = samplesheet[i][8]
	d.append(samplesheet[i][1])
	d.append(samplesheet[i][6])
	d.append(samplesheet[i][8])
	dat.append(d)
#print("sample:", dat)

mm1=[]
mm2=[]
for i in range(len(dat)):
	x1=[]
	x2=[]
	for k in range(0,len(dat[0][1])):
		ind1=dat[i][1][:k] + '.' + dat[i][1][k+1:]
		ind2=dat[i][2][:k] + '.' + dat[i][2][k+1:]
		x1.append(ind1)
		x2.append(ind2)
	mm1.append(x1)
	mm2.append(x2)
#print("Variation of index 1 (mm1):",mm1)
#print("Variation of index 2 (mm2):", mm2)

###################################################################### single index patterns
mms=[]
for i in range(len(single_barcode)):
	x1=[]
	for k in range(0,len(single_barcode[0])):
		ind1=single_barcode[i][:k] + '.' + single_barcode[i][k+1:]
		x1.append(ind1)
	mms.append(x1)
#print("Variation of index 1 of single barcode (mms):",mms)

###################################################################### combine patterns
combine2=[]
for i in range(len(mm1)):
	temp=[]
	for j in range(len(mm1[i])):
		for k in range(len(mm2[i])):
			temp.append(mm1[i][j]+"+"+mm2[i][k])
	combine2.append(temp)
#print("combined pattern:", combine2)


###################################################################### check for barcode conflict
print("----------------------------------------------------------------------------------")
print("Exact match: checking for barcode conflict...")
m0=exact_match(sample, combine, index1, index2, single_barcode)
#print(m0)
for item in m0:
	mismatch0.writerow([item])

print("-----------------------------------------------------------------------------------")
print("Mismatch = 1: checking for barcode conflict...")
m1=mismatch_eq_1(sample, combine2, index2, mm1, mm2, single_sample, mms)
#print(m1)
for item in m1:
	mismatch1.writerow([item])


