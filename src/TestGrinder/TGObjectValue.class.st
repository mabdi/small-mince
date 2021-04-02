Class {
	#name : #TGObjectValue,
	#superclass : #TGAbstractValue,
	#instVars : [
		'uniqueId',
		'lastRecordId'
	],
	#category : #'TestGrinder-Model'
}

{ #category : #accessing }
TGObjectValue >> clone [
	| clone |
	clone := super clone.
	^ clone
		lastRecordId: self lastRecordId;
		uniqueId: self uniqueId;
		yourself
]

{ #category : #accessing }
TGObjectValue >> lastRecordId [
	^ lastRecordId
]

{ #category : #accessing }
TGObjectValue >> lastRecordId: anObject [
	lastRecordId := anObject
]

{ #category : #accessing }
TGObjectValue >> synthesisNodeBy: aSynthesizer [
	^ aSynthesizer genVariableArgNodeFrom: self
]

{ #category : #accessing }
TGObjectValue >> uniqueId [
	^ uniqueId
]

{ #category : #accessing }
TGObjectValue >> uniqueId: anObject [
	uniqueId := anObject
]
