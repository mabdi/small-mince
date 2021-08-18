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
		'dependsOn',
		'eventId'
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

{ #category : #accessing }
SMObjectAbstractEvent >> eventId [
	^ eventId
]

{ #category : #accessing }
SMObjectAbstractEvent >> eventId: anObject [
	eventId := anObject
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
