Class {
	#name : #SMPrimitiveValue,
	#superclass : #SMAbstractValue,
	#instVars : [
		'theValue'
	],
	#category : #'SmallMince-Core-Model'
}

{ #category : #'instance creation' }
SMPrimitiveValue class >> with: anObject [
	| obj |
	obj := super with: anObject .
	obj theValue: anObject copy.
	^ obj
]

{ #category : #comparing }
SMPrimitiveValue >> = anObject [
	super = anObject ifFalse: [ ^ false ].
	^ anObject theValue = self theValue
]

{ #category : #accessing }
SMPrimitiveValue >> copy [
	| clone |
	clone := super copy.
	^ clone
		theValue: self theValue copy;
		yourself
]

{ #category : #comparing }
SMPrimitiveValue >> hash [
	^ theValue hash
]

{ #category : #'as yet unclassified' }
SMPrimitiveValue >> synthesisBy: aSynthesizer [
	^ aSynthesizer synthesisPrimitiveValue: self
]

{ #category : #accessing }
SMPrimitiveValue >> theValue [
	^ theValue
]

{ #category : #accessing }
SMPrimitiveValue >> theValue: anObject [
	theValue := anObject
]
