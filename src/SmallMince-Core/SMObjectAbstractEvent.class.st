Class {
	#name : #SMObjectAbstractEvent,
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
		'dependsOn'
	],
	#category : #'SmallMince-Core-Model'
}

{ #category : #accessing }
SMObjectAbstractEvent >> argsAfter [
	^ argsAfter
]

{ #category : #accessing }
SMObjectAbstractEvent >> argsAfter: anObject [
	argsAfter := anObject
]

{ #category : #accessing }
SMObjectAbstractEvent >> argsBefore [
	^ argsBefore
]

{ #category : #accessing }
SMObjectAbstractEvent >> argsBefore: anObject [
	argsBefore := anObject
]

{ #category : #accessing }
SMObjectAbstractEvent >> dependsOn [
	^ dependsOn
]

{ #category : #'as yet unclassified' }
SMObjectAbstractEvent >> forCall: callRecord exception: exceptionRecord [
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
	self exceptionValue: exceptionRecord exception copy
]

{ #category : #'as yet unclassified' }
SMObjectAbstractEvent >> forCall: callRecord return: returnRecord [
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
SMObjectAbstractEvent >> initialize [
	dependsOn := OrderedCollection new.

]

{ #category : #testing }
SMObjectAbstractEvent >> isException [
	^ false
]

{ #category : #testing }
SMObjectAbstractEvent >> isReturn [
	^ false
]

{ #category : #testing }
SMObjectAbstractEvent >> isStatePreserving [
	^ stateBefore = stateAfter 
]

{ #category : #accessing }
SMObjectAbstractEvent >> parent [
	^ parent
]

{ #category : #accessing }
SMObjectAbstractEvent >> parent: anObject [
	parent := anObject
]

{ #category : #accessing }
SMObjectAbstractEvent >> selector [
	^ selector
]

{ #category : #accessing }
SMObjectAbstractEvent >> selector: anObject [
	selector := anObject
]

{ #category : #accessing }
SMObjectAbstractEvent >> stateAfter [
	^ stateAfter
]

{ #category : #accessing }
SMObjectAbstractEvent >> stateAfter: anObject [
	stateAfter := anObject
]

{ #category : #accessing }
SMObjectAbstractEvent >> stateBefore [
	^ stateBefore
]

{ #category : #accessing }
SMObjectAbstractEvent >> stateBefore: anObject [
	stateBefore := anObject
]

{ #category : #'as yet unclassified' }
SMObjectAbstractEvent >> synthesisBy: aSynthesizer [
	^ self subclassResponsibility 
]
