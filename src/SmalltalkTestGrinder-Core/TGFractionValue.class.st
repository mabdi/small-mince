Class {
	#name : #TGFractionValue,
	#superclass : #TGPrimitiveValue,
	#category : #'SmalltalkTestGrinder-Core-Model'
}

{ #category : #'as yet unclassified' }
TGFractionValue >> synthesisBy: aSynthesizer [ 
	^ aSynthesizer synthesisFractionValue: self
]
