Class {
	#name : #SMObjectReference,
	#superclass : #SMAbstractValue,
	#instVars : [
		'uniqueId',
		'lastRecordId'
	],
	#category : #'SmallMince-Core-Model'
}

{ #category : #'as yet unclassified' }
SMObjectReference class >> uniqueIdFor: anObject [
	^ anObject basicIdentityHash
]

{ #category : #'instance creation' }
SMObjectReference class >> with: anObject [
	| obj |
	obj := super with: anObject.
	obj lastRecordId: -1.
	obj uniqueId: (self uniqueIdFor: anObject).
	^ obj
]

{ #category : #comparing }
SMObjectReference >> = anObject [ 
	super = anObject ifFalse: [ ^ false ].
	^ uniqueId = anObject uniqueId
]

{ #category : #accessing }
SMObjectReference >> copy [
	| clone |
	clone := super copy.
	^ clone
		lastRecordId: self lastRecordId;
		uniqueId: self uniqueId;
		yourself
]

{ #category : #testing }
SMObjectReference >> isObjectValue [
	^ true
]

{ #category : #accessing }
SMObjectReference >> lastRecordId [
	^ lastRecordId
]

{ #category : #accessing }
SMObjectReference >> lastRecordId: anObject [
	lastRecordId := anObject
]

{ #category : #'as yet unclassified' }
SMObjectReference >> synthesisBy: aSynthesizer [
	^ aSynthesizer synthesisObjectReference: self
]

{ #category : #accessing }
SMObjectReference >> uniqueId [
	^ uniqueId
]

{ #category : #accessing }
SMObjectReference >> uniqueId: anObject [
	uniqueId := anObject
]
