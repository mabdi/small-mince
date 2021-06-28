Class {
	#name : #SMFractionValue,
	#superclass : #SMPrimitiveValue,
	#category : #'SmallMince-Core-Model'
}

{ #category : #'as yet unclassified' }
SMFractionValue >> synthesisBy: aSynthesizer [ 
	^ aSynthesizer synthesisFractionValue: self
]
