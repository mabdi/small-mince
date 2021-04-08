Class {
	#name : #TGObjectEvent,
	#superclass : #Object,
	#traits : 'TGInternalClassesTrait',
	#classTraits : 'TGInternalClassesTrait classTrait',
	#instVars : [
		'parent',
		'selector',
		'stateBefore',
		'stateAfter',
		'argsBefore',
		'argsAfter',
		'returnValue',
		'dependsOn'
	],
	#category : #'SmalltalkTestGrinder-Model'
}

{ #category : #'as yet unclassified' }
TGObjectEvent class >> forCall: callRecord return: returnRecord [
	^ self new forCall: callRecord return: returnRecord
]

{ #category : #accessing }
TGObjectEvent >> argsAfter [
	^ argsAfter
]

{ #category : #accessing }
TGObjectEvent >> argsAfter: anObject [
	argsAfter := anObject
]

{ #category : #accessing }
TGObjectEvent >> argsBefore [
	^ argsBefore
]

{ #category : #accessing }
TGObjectEvent >> argsBefore: anObject [
	argsBefore := anObject
]

{ #category : #accessing }
TGObjectEvent >> dependsOn [
	^ dependsOn
]

{ #category : #'as yet unclassified' }
TGObjectEvent >> forCall: callRecord return: returnRecord [
	self selector: callRecord selector.
	self stateBefore: (callRecord state collect: #copy).
	self stateAfter: (returnRecord state collect: #copy).
	self argsBefore: (callRecord arguments collect: #copy).
	self argsAfter: (callRecord arguments collect: #copy).
	dependsOn addAll: (self stateBefore select: #isObjectValue) values asOrderedCollection removeDuplicates.
	dependsOn addAll: (self stateAfter select: #isObjectValue) values asOrderedCollection removeDuplicates.
	dependsOn addAll: (self argsBefore select: #isObjectValue) asOrderedCollection removeDuplicates.
	dependsOn addAll: (self argsAfter select: #isObjectValue) asOrderedCollection removeDuplicates.
	self returnValue: returnRecord returnValue copy
]

{ #category : #initialization }
TGObjectEvent >> initialize [ 
	dependsOn := OrderedCollection new.
	
]

{ #category : #testing }
TGObjectEvent >> isStatePreserving [
	^ stateBefore = stateAfter 
]

{ #category : #accessing }
TGObjectEvent >> parent [
	^ parent
]

{ #category : #accessing }
TGObjectEvent >> parent: anObject [
	parent := anObject
]

{ #category : #accessing }
TGObjectEvent >> returnValue [
	^ returnValue
]

{ #category : #accessing }
TGObjectEvent >> returnValue: anObject [
	returnValue := anObject
]

{ #category : #accessing }
TGObjectEvent >> selector [
	^ selector
]

{ #category : #accessing }
TGObjectEvent >> selector: anObject [
	selector := anObject
]

{ #category : #accessing }
TGObjectEvent >> stateAfter [
	^ stateAfter
]

{ #category : #accessing }
TGObjectEvent >> stateAfter: anObject [
	stateAfter := anObject
]

{ #category : #accessing }
TGObjectEvent >> stateBefore [
	^ stateBefore
]

{ #category : #accessing }
TGObjectEvent >> stateBefore: anObject [
	stateBefore := anObject
]

{ #category : #'as yet unclassified' }
TGObjectEvent >> synthesisBy: aSynthesizer [
	^ aSynthesizer synthesisObjectEvent: self
]
