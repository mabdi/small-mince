Class {
	#name : #TGObjectEvent,
	#superclass : #Object,
	#instVars : [
		'selector',
		'stateBefore',
		'stateAfter',
		'argsBefore',
		'argsAfter',
		'dependsOn'
	],
	#category : #'TestGrinder-Model'
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
	self stateBefore: callRecord state.
	self stateAfter: returnRecord state.
	self argsBefore: callRecord arguments.
	self argsAfter: callRecord arguments.
	dependsOn addAll: (callRecord state select: #isObjectValue) removeDuplicates.
	dependsOn addAll: (returnRecord state select: #isObjectValue) removeDuplicates.
	dependsOn addAll: (callRecord argument select: #isObjectValue) removeDuplicates.
	dependsOn addAll: (returnRecord argument select: #isObjectValue) removeDuplicates.
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
TGObjectEvent >> tg_internal_class [
	^ true
]
