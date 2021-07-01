Class {
	#name : #SMObjectEvent,
	#superclass : #Object,
	#traits : 'SMInternalClassesTrait',
	#classTraits : 'SMInternalClassesTrait classTrait',
	#instVars : [
		'parent',
		'selector',
		'stateBefore',
		'stateAfter',
		'argsBefore',
		'argsAfter',
		'returnValue',
		'dependsOn',
		'isReturn',
		'isException'
	],
	#category : #'SmallMince-Core-Model'
}

{ #category : #'as yet unclassified' }
SMObjectEvent class >> forCall: callRecord exception: exceptionRecord [
	^ self new forCall: callRecord exception: exceptionRecord
]

{ #category : #'as yet unclassified' }
SMObjectEvent class >> forCall: callRecord return: returnRecord [
	^ self new forCall: callRecord return: returnRecord
]

{ #category : #accessing }
SMObjectEvent >> argsAfter [
	^ argsAfter
]

{ #category : #accessing }
SMObjectEvent >> argsAfter: anObject [
	argsAfter := anObject
]

{ #category : #accessing }
SMObjectEvent >> argsBefore [
	^ argsBefore
]

{ #category : #accessing }
SMObjectEvent >> argsBefore: anObject [
	argsBefore := anObject
]

{ #category : #accessing }
SMObjectEvent >> dependsOn [
	^ dependsOn
]

{ #category : #'as yet unclassified' }
SMObjectEvent >> forCall: callRecord exception: exceptionRecord [
	self isException: true.
	self selector: callRecord selector.
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
	self exceptionValue: exceptionRecord returnValue copy
]

{ #category : #'as yet unclassified' }
SMObjectEvent >> forCall: callRecord return: returnRecord [
	self isReturn: true.
	self selector: callRecord selector.
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

{ #category : #initialization }
SMObjectEvent >> initialize [
	dependsOn := OrderedCollection new.
	self isReturn: false.
	self isException: false.
]

{ #category : #accessing }
SMObjectEvent >> isException [
	^ isException
]

{ #category : #accessing }
SMObjectEvent >> isException: anObject [
	isException := anObject
]

{ #category : #accessing }
SMObjectEvent >> isReturn [
	^ isReturn
]

{ #category : #accessing }
SMObjectEvent >> isReturn: anObject [
	isReturn := anObject
]

{ #category : #testing }
SMObjectEvent >> isStatePreserving [
	^ stateBefore = stateAfter 
]

{ #category : #accessing }
SMObjectEvent >> parent [
	^ parent
]

{ #category : #accessing }
SMObjectEvent >> parent: anObject [
	parent := anObject
]

{ #category : #accessing }
SMObjectEvent >> returnValue [
	^ returnValue
]

{ #category : #accessing }
SMObjectEvent >> returnValue: anObject [
	returnValue := anObject
]

{ #category : #accessing }
SMObjectEvent >> selector [
	^ selector
]

{ #category : #accessing }
SMObjectEvent >> selector: anObject [
	selector := anObject
]

{ #category : #accessing }
SMObjectEvent >> stateAfter [
	^ stateAfter
]

{ #category : #accessing }
SMObjectEvent >> stateAfter: anObject [
	stateAfter := anObject
]

{ #category : #accessing }
SMObjectEvent >> stateBefore [
	^ stateBefore
]

{ #category : #accessing }
SMObjectEvent >> stateBefore: anObject [
	stateBefore := anObject
]

{ #category : #'as yet unclassified' }
SMObjectEvent >> synthesisBy: aSynthesizer [
	^ aSynthesizer synthesisObjectEvent: self
]
