Class {
	#name : #TGObjectReference,
	#superclass : #TGAbstractValue,
	#instVars : [
		'uniqueId',
		'lastRecordId'
	],
	#category : #'TestGrinder-Model'
}

{ #category : #'as yet unclassified' }
TGObjectReference class >> uniqueIdFor: anObject [
	^ anObject basicIdentityHash
]

{ #category : #'instance creation' }
TGObjectReference class >> with: anObject [
	| obj |
	obj := super with: anObject.
	obj lastRecordId: -1.
	obj uniqueId: (self uniqueIdFor: anObject).
	^ obj
]

{ #category : #accessing }
TGObjectReference >> clone [
	| clone |
	clone := super clone.
	^ clone
		lastRecordId: self lastRecordId;
		uniqueId: self uniqueId;
		yourself
]

{ #category : #accessing }
TGObjectReference >> lastRecordId [
	^ lastRecordId
]

{ #category : #accessing }
TGObjectReference >> lastRecordId: anObject [
	lastRecordId := anObject
]

{ #category : #accessing }
TGObjectReference >> uniqueId [
	^ uniqueId
]

{ #category : #accessing }
TGObjectReference >> uniqueId: anObject [
	uniqueId := anObject
]
