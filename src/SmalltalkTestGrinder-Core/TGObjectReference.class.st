Class {
	#name : #TGObjectReference,
	#superclass : #TGAbstractValue,
	#instVars : [
		'uniqueId',
		'lastRecordId'
	],
	#category : #'SmalltalkTestGrinder-Core-Model'
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

{ #category : #comparing }
TGObjectReference >> = anObject [ 
	super = anObject ifFalse: [ ^ false ].
	^ uniqueId = anObject uniqueId
]

{ #category : #accessing }
TGObjectReference >> copy [
	| clone |
	clone := super copy.
	^ clone
		lastRecordId: self lastRecordId;
		uniqueId: self uniqueId;
		yourself
]

{ #category : #testing }
TGObjectReference >> isObjectValue [
	^ true
]

{ #category : #accessing }
TGObjectReference >> lastRecordId [
	^ lastRecordId
]

{ #category : #accessing }
TGObjectReference >> lastRecordId: anObject [
	lastRecordId := anObject
]

{ #category : #'as yet unclassified' }
TGObjectReference >> synthesisBy: aSynthesizer [
	^ aSynthesizer synthesisObjectReference: self
]

{ #category : #accessing }
TGObjectReference >> uniqueId [
	^ uniqueId
]

{ #category : #accessing }
TGObjectReference >> uniqueId: anObject [
	uniqueId := anObject
]
