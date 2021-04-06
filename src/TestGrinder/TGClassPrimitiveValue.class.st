Class {
	#name : #TGClassPrimitiveValue,
	#superclass : #TGPrimitiveValue,
	#category : #'TestGrinder-Model'
}

{ #category : #'instance creation' }
TGClassPrimitiveValue class >> with: anObject [
	| obj |
	obj := super with: anObject .
	obj theValue: anObject.
	^ obj
]

{ #category : #'as yet unclassified' }
TGClassPrimitiveValue >> synthesisBy: aSynthesizer [
	^ aSynthesizer synthesisClassPrimitiveValue: self
]
