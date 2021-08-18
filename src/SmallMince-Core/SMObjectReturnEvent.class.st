Class {
	#name : #SMObjectReturnEvent,
	#superclass : #SMObjectAbstractEvent,
	#traits : 'SMInternalClassesTrait',
	#classTraits : 'SMInternalClassesTrait classTrait',
	#instVars : [
		'returnValue'
	],
	#category : #'SmallMince-Core-Model'
}

{ #category : #'as yet unclassified' }
SMObjectReturnEvent class >> forCall: callRecord return: returnRecord [
	^ self new forCall: callRecord return: returnRecord
]

{ #category : #'as yet unclassified' }
SMObjectReturnEvent >> forCall: callRecord return: returnRecord [
	self selector: callRecord selector.
	self eventId: returnRecord id.
	self stateBefore: (callRecord state collect: #copy).
	self stateAfter: (returnRecord state collect: #copy).
	self argsBefore: (callRecord arguments collect: #copy).
	self argsAfter: (callRecord arguments collect: #copy).
	dependsOn
		addAll:
			(self stateBefore select: #isObjectValue) values asOrderedCollection
				removeDuplicates.
	dependsOn
		addAll:
			(self stateAfter select: #isObjectValue) values asOrderedCollection
				removeDuplicates.
	dependsOn
		addAll:
			(self argsBefore select: #isObjectValue) asOrderedCollection
				removeDuplicates.
	dependsOn
		addAll:
			(self argsAfter select: #isObjectValue) asOrderedCollection
				removeDuplicates.
	self returnValue: returnRecord returnValue copy
]

{ #category : #accessing }
SMObjectReturnEvent >> isReturn [
	^ true
]

{ #category : #accessing }
SMObjectReturnEvent >> returnValue [
	^ returnValue
]

{ #category : #accessing }
SMObjectReturnEvent >> returnValue: anObject [
	returnValue := anObject
]

{ #category : #'as yet unclassified' }
SMObjectReturnEvent >> synthesisBy: aSynthesizer [
	^ aSynthesizer synthesisObjectReturnEvent: self
]
