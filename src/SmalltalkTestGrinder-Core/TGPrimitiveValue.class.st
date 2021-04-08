Class {
	#name : #TGPrimitiveValue,
	#superclass : #TGAbstractValue,
	#instVars : [
		'theValue'
	],
	#category : #'SmalltalkTestGrinder-Core-Model'
}

{ #category : #'instance creation' }
TGPrimitiveValue class >> with: anObject [
	| obj |
	obj := super with: anObject .
	obj theValue: anObject copy.
	^ obj
]

{ #category : #comparing }
TGPrimitiveValue >> = anObject [
	super = anObject ifFalse: [ ^ false ].
	^ anObject theValue = self theValue
]

{ #category : #accessing }
TGPrimitiveValue >> copy [
	| clone |
	clone := super copy.
	^ clone
		theValue: self theValue copy;
		yourself
]

{ #category : #comparing }
TGPrimitiveValue >> hash [
	^ theValue hash
]

{ #category : #testing }
TGPrimitiveValue >> isTGPrimitive [ 
	^ true
]

{ #category : #'as yet unclassified' }
TGPrimitiveValue >> synthesisBy: aSynthesizer [
	^ aSynthesizer synthesisPrimitiveValue: self
]

{ #category : #accessing }
TGPrimitiveValue >> theValue [
	^ theValue
]

{ #category : #accessing }
TGPrimitiveValue >> theValue: anObject [
	theValue := anObject
]
