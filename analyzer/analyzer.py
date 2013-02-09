from numpy.fft import rfft
from SoundIO import SoundData
import math,cmath
import sys

def analyze(filename):
	sound=SoundData()
	sound.readFile(filename)
	
	bassArr=[]
	midArr=[]
	trebleArr=[]
	centArr=[]
	for idx in xrange(0,len(sound.samples)-1024,256):
		samp=sound.samples[idx:idx+1024:4]
		fqs=list(abs(rfft(samp)))
		bassArr.append(sum(fqs[1:5]))
		midArr.append(sum(fqs[5:40]))
		trebleArr.append(sum(fqs[40:]))
		centArr.append(sum(i*j for i,j in enumerate(fqs)) / float(sum(fqs)) )
	return [bassArr,midArr,trebleArr,centArr]

def findTempo(arr):
	mint=int(256*len(arr)*60/(44100.0*60.0))
	maxt=int(256*len(arr)*480/(44100.0*60.0))+1
	a2=rfft(hwtrate(arr))
	a3=list(abs(a2))[mint:maxt]
	a3[0]=0
	a4=a3.index(max(a3))
	phase=cmath.phase(a4)/(2.0*math.pi)
	idxdiff=len(arr)/float(a4)
	idxstart=idxdiff*phase
	out=[0]*len(arr)
	for i in xrange(a4+1):
		idx=int(round(idxdiff*i+idxstart))
		if idx>=0 and idx<len(arr): out[idx]=1
	return out

def tempoFFT(arr,tempo,hopsize=256.0,samplesize=44100.0):
	step=(44100.0*60.0)/(256.0*tempo)
	sinsum=sum(math.sin(2*math.pi/step*i)*j for i,j in enumerate(arr))
	cossum=sum(math.cos(2*math.pi/step*i)*j for i,j in enumerate(arr))
	x=complex(cossum,sinsum)
	return [abs(x),cmath.phase(x)/2*math.pi]

def graphTempo(arr,tempo,phase):
	step=(44100.0*60.0)/(256.0*tempo)
	idxstart=step*phase
	n=int(len(arr)/step)+1
	out=[0]*len(arr)
	for i in xrange(n):
		idx=int(round(step*i+idxstart))
		if idx>=0 and idx<len(arr): out[idx]=1
	plt.plot(normalize(arr))
	plt.plot(out)
	plt.show()
	

def hwtrate(arr):
	return [0]+[max(0,arr[i]-arr[i-1]) for i in xrange(1,len(arr))]
	
def normalize(arr):
	maxval=float(max(max(arr),-min(arr)))
	return([i/maxval for i in arr])

def findPeaks(arr):
	a2=rfft(hwtrate(arr))
	
def removeradius(arr,maxrad=30):
	a2=list(enumerate(arr))
	a2.sort(key=lambda x:-x[1])
	a3=[False]*len(arr)
	a4=[0]*len(arr)
	for idx,val in a2:
		if not a3[idx]:
			a4[idx]=val
			for i in xrange(max(0,idx-maxrad),min(idx+maxrad,len(arr))):
				a3[i]=True
	return a4

def removelow(arr,minval):
	return [0 if i<minval else i for i in arr]

def getTimeValArr(arr,type):
	timevals=[]
	for idx,val in enumerate(arr):
		if val==0: continue
		time_ms=int(round((idx*256+512)/44.1))
		val_perc=int(round(val*100))
		timevals.append((time_ms,val_perc,type))
	return timevals

def main(infile,outfile,rad=45,minperc=0.6):
	a=analyze(infile)[:3]
	a=[removeradius(i,rad) for i in a]
	a=[normalize(i) for i in a]
	a=[removelow(i,minperc) for i in a]
	timevals=[]
	for arr,type in zip(a,('b','m','t')):
		timevals.extend(getTimeValArr(arr,type))
	timevals.sort(key=lambda x:x[0])
	s='\n'.join([','.join([str(j) for j in i]) for i in timevals])
	f=open(outfile,'w')
	f.write(s)
	f.close()

	
def removeradius2(arr,maxrad=30):
	#works with multiple arrays
	n=len(arr[0])
	a2=[]
	for aidx,i in enumerate(arr):
		a2.extend([(idx,val,aidx) for idx,val in enumerate(i)])
	a2.sort(key=lambda x:-x[1])
	a3=[False]*n
	a4=[]
	for obj in a2:
		idx=obj[0]
		if not a3[idx]:
			a4.append(obj)
			for i in xrange(max(0,idx-maxrad),min(idx+maxrad,n)):
				a3[i]=True
	types="bmt"
	return [[int(round((i[0]*256+512)/44.1)),int(round(i[1]*100)),types[i[2]]] for i in a4]

def main2(infile,outfile,rad=45,minperc=0.6):
	a=analyze(infile)[:3]
	a=[normalize(i) for i in a]
	timevals=removeradius2(a,rad)
	timevals=[i for i in timevals if i[1]>minperc*100]
	timevals.sort(key=lambda x:x[0])
	s='\n'.join([','.join([str(j) for j in i]) for i in timevals])
	f=open(outfile,'w')
	f.write(s)
	f.close()


if __name__ == "__main__":
    main2(sys.argv[1],sys.argv[2])