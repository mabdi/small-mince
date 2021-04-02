Class {
	#name : #TGPrimitiveValue,
	#superclass : #TGAbstractValue,
	#instVars : [
		'theValue'
	],
	#category : #'TestGrinder-Model'
}

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
