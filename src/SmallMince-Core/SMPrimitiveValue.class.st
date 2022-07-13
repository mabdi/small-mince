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
