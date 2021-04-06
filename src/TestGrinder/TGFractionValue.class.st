Class {
	#name : #TGFractionValue,
	#superclass : #TGPrimitiveValue,
	#category : #'TestGrinder-Model'
}

{ #category : #'as yet unclassified' }
TGFractionValue >> synthesisBy: aSynthesizer [ 
	^ aSynthesizer synthesisFractionValue: self
]
