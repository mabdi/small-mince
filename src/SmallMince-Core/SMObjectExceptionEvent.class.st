Class {
	#name : #SMObjectExceptionEvent,
	#superclass : #SMObjectAbstractEvent,
	#traits : 'SMInternalClassesTrait',
	#classTraits : 'SMInternalClassesTrait classTrait',
	#instVars : [
		'exceptionValue'
	],
	#category : #'SmallMince-Core-Model'
}

{ #category : #'as yet unclassified' }
SMObjectExceptionEvent class >> forCall: callRecord exception: exceptionRecord [
	^ self new forCall: callRecord exception: exceptionRecord
]

{ #category : #accessing }
SMObjectExceptionEvent >> exceptionValue [
	^ exceptionValue
]

{ #category : #accessing }
SMObjectExceptionEvent >> exceptionValue: anObject [
	exceptionValue := anObject
]

{ #category : #'as yet unclassified' }
SMObjectExceptionEvent >> forCall: callRecord exception: exceptionRecord [
	self selector: callRecord selector.
	self eventId: exceptionRecord id.
	self stateBefore: (callRecord state collect: #copy).
	self stateAfter: (exceptionRecord state collect: #copy).
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
	self exceptionValue: exceptionRecord exception copy
]

{ #category : #accessing }
SMObjectExceptionEvent >> isException [
	^ true
]

{ #category : #'as yet unclassified' }
SMObjectExceptionEvent >> synthesisBy: aSynthesizer [
	^ aSynthesizer synthesisObjectErrorEvent: self
]
