Class {
	#name : #SMObjectHistory,
	#superclass : #Object,
	#traits : 'SMInternalClassesTrait',
	#classTraits : 'SMInternalClassesTrait classTrait',
	#instVars : [
		'objectReference',
		'events',
		'isInitialized',
		'fromEvent',
		'toEvent'
	],
	#category : #'SmallMince-Core-Model'
}

{ #category : #comparing }
SMObjectHistory >> = anObject [
	anObject class = self class ifFalse: [ ^ false ].
	^ objectReference = anObject objectReference
]

{ #category : #adding }
SMObjectHistory >> addEvent: anEvent [ 
	anEvent parent: self.
	events add: anEvent
]

{ #category : #accessing }
SMObjectHistory >> dependsOn [
	^ events flatCollect: #dependsOn
]

{ #category : #accessing }
SMObjectHistory >> events [
	^ events
]

{ #category : #accessing }
SMObjectHistory >> fromEvent [
	^ fromEvent
]

{ #category : #accessing }
SMObjectHistory >> fromEvent: anObject [
	fromEvent := anObject
]

{ #category : #comparing }
SMObjectHistory >> hash [ 
	^ objectReference hash
]

{ #category : #initialization }
SMObjectHistory >> initialize [ 
	events := OrderedCollection new.
	isInitialized := false
]

{ #category : #accessing }
SMObjectHistory >> isInitialized [
	^ isInitialized
]

{ #category : #accessing }
SMObjectHistory >> objectReference [
	^ objectReference
]

{ #category : #accessing }
SMObjectHistory >> objectReference: anObject [
	objectReference := anObject
]

{ #category : #'as yet unclassified' }
SMObjectHistory >> selectedEvents [
	| from to |
	to := toEvent ifNil: [ events size ] ifNotNil: [ toEvent ].
	from := fromEvent ifNil: [ 1 ] ifNotNil: [ fromEvent ].
	^ events copyFrom: from to: to 
]

{ #category : #initialization }
SMObjectHistory >> setInitializeDone [
	isInitialized := true
]

{ #category : #'as yet unclassified' }
SMObjectHistory >> synthesisBy: aSynthesizer [
	^ aSynthesizer synthesisObjectHistory: self
]

{ #category : #accessing }
SMObjectHistory >> toEvent [
	^ toEvent
]

{ #category : #accessing }
SMObjectHistory >> toEvent: anObject [
	toEvent := anObject
]
