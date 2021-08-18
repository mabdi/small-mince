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
	^ ((events flatCollect: #dependsOn) collect: #uniqueId) asSet
]

{ #category : #accessing }
SMObjectHistory >> events [
	^ events
]

{ #category : #accessing }
SMObjectHistory >> fromEvent [
	^ fromEvent
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
	events ifEmpty: [ ^ {  } ].
	to := toEvent ifNil: [ events last eventId ] ifNotNil: [ toEvent ].
	from := fromEvent ifNil: [ -1 ] ifNotNil: [ fromEvent ].
	fromEvent := to.
	^ events select: [ :ev | ev eventId > from and: [ ev eventId <= to ] ]
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
SMObjectHistory >> toEvent: anObject [
	toEvent := anObject
]
