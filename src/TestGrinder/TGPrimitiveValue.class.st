Class {
	#name : #TGPrimitiveValue,
	#superclass : #TGAbstractValue,
	#instVars : [
		'theValue'
	],
	#category : #'TestGrinder-Model'
}

{ #category : #'instance creation' }
TGPrimitiveValue class >> with: anObject [
	| obj |
	obj := super with: anObject.
	obj theValue: anObject clone.
	^ obj
]

{ #category : #comparing }
TGPrimitiveValue >> = anObject [
	^ anObject theValue = self theValue
]

{ #category : #accessing }
TGPrimitiveValue >> clone [
	| clone |
	clone := super clone.
	^ clone
		theValue: self theValue clone;
		yourself
]

{ #category : #accessing }
TGPrimitiveValue >> synthesisNodeBy: aSynthesizer [
	^ aSynthesizer genLiteralArgNodeFrom: self
]

{ #category : #accessing }
TGPrimitiveValue >> theValue [
	^ theValue
]

{ #category : #accessing }
TGPrimitiveValue >> theValue: anObject [
	theValue := anObject
]
