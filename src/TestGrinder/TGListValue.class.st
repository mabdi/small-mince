Class {
	#name : #TGListValue,
	#superclass : #TGAbstractValue,
	#instVars : [
		'theValues'
	],
	#category : #'TestGrinder-Model'
}

{ #category : #accessing }
TGListValue >> clone [
	| clone |
	clone := super clone.
	^ clone
		theValues: (self theValues collect: #clone);
		yourself
]

{ #category : #accessing }
TGListValue >> synthesisNodeBy: aSynthesizer [
	^ aSynthesizer genVariableArgNodeFrom: self
]

{ #category : #accessing }
TGListValue >> theValues [
	^ theValues
]

{ #category : #accessing }
TGListValue >> theValues: anObject [
	theValues := anObject
]
