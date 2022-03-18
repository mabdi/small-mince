Class {
	#name : #SMPointValue,
	#superclass : #SMPrimitiveValue,
	#category : #'SmallMince-Core-Model'
}

{ #category : #'as yet unclassified' }
SMPointValue >> synthesisBy: aSynthesizer [

	^ aSynthesizer synthesisPointValue: self
]
