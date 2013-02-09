#!/usr/bin/env python

'''
Created on Mar 24, 2009

@author: smyer
'''

import wave
import aifc
import struct
import math, cmath
import numpy
from numpy import fft
import os

class SoundData:
	def __init__(self):
		self.snd=None
		self.samples=None
	
	def readFile(self,fileName,startTime=0,endTime=-1,timeInSeconds=False):
		#if timeInSeconds is true, starttime and endtime will be in seconds, otherwise they will be in samples
		extension=os.path.splitext(fileName)[1].lower()
		if extension=="": return
		if extension.startswith(".wav"):
			try:
				infile=wave.open(fileName, "r")
			except:
				print "Could not open file '"+fileName+"'"
				return False
		elif extension.startswith(".aif"):
			try:
				infile=aifc.open(fileName, "r")
			except:
				print "Could not open file '"+fileName+"'"
				return False
		else:
			raise Exception("File must have .wav or .aif extension")
			return False
		self.bps=infile.getsampwidth()
		self.isStereo=(infile.getnchannels()==2)
		self.frameRate=infile.getframerate()
		
		self.samples=list()
		totalSamples=infile.getnframes()-1
		startSample=startTime*self.frameRate if timeInSeconds else startTime
		if endTime<=0: endSample=totalSamples
		elif timeInSeconds: endSample=endTime*self.frameRate
		else: endSample=endTime
		
		#ensure proper range
		endSample=int(min(totalSamples,max(0,endSample)))
		startSample=int(min(totalSamples,max(0,startSample)))
		
		numSamples=endSample-startSample+1
		
		infile.readframes(startSample)
		bufferSize=65536
		for i in xrange(0,numSamples,bufferSize):
			framesToRead=min(bufferSize,numSamples-i)
			frames=infile.readframes(framesToRead)
			bytesPerFrame=int(len(frames)/framesToRead)
			for j in xrange(0,len(frames),bytesPerFrame):
				self.samples.append(self.translateFrame(frames[j:j+bytesPerFrame]))
		
		infile.close()
		return True
		
	def translateFrame(self,s):		
		if self.isStereo:
			if self.bps==1:
				samples=struct.unpack("bb", s)
			elif self.bps==2:
				samples=struct.unpack("hh",s)
			else:
				samples=[0,0]
			smp=(samples[0]+samples[1])/2
		else:
			if self.bps==1:
				samples=struct.unpack("b", s)
			elif self.bps==2:
				samples=struct.unpack("h",s)
			else:
				samples=[0]
			smp=samples[0]
		return(smp)
