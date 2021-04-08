Class {
	#name : #TGObjectHistory,
	#superclass : #Object,
	#traits : 'TGInternalClassesTrait',
	#classTraits : 'TGInternalClassesTrait classTrait',
	#instVars : [
		'objectReference',
		'events',
		'isInitialized',
		'fromEvent',
		'toEvent'
	],
	#category : #'SmalltalkTestGrinder-Model'
}

{ #category : #comparing }
TGObjectHistory >> = anObject [
	anObject class = self class ifFalse: [ ^ false ].
	^ objectReference = anObject objectReference
]

{ #category : #adding }
TGObjectHistory >> addEvent: anEvent [ 
	anEvent parent: self.
	events add: anEvent
]

{ #category : #accessing }
TGObjectHistory >> dependsOn [
	^ events flatCollect: #dependsOn
]

{ #category : #accessing }
TGObjectHistory >> events [
	^ events
]

{ #category : #accessing }
TGObjectHistory >> fromEvent [
	^ fromEvent
]

{ #category : #accessing }
TGObjectHistory >> fromEvent: anObject [
	fromEvent := anObject
]

{ #category : #comparing }
TGObjectHistory >> hash [ 
	^ objectReference hash
]

{ #category : #initialization }
TGObjectHistory >> initialize [ 
	events := OrderedCollection new.
	isInitialized := false
]

{ #category : #accessing }
TGObjectHistory >> isInitialized [
	^ isInitialized
]

{ #category : #accessing }
TGObjectHistory >> objectReference [
	^ objectReference
]

{ #category : #accessing }
TGObjectHistory >> objectReference: anObject [
	objectReference := anObject
]

{ #category : #'as yet unclassified' }
TGObjectHistory >> selectedEvents [
	| from to |
	to := toEvent ifNil: [ events size ] ifNotNil: [ toEvent ].
	from := fromEvent ifNil: [ 1 ] ifNotNil: [ fromEvent ].
	^ events copyFrom: from to: to 
]

{ #category : #initialization }
TGObjectHistory >> setInitializeDone [
	isInitialized := true
]

{ #category : #'as yet unclassified' }
TGObjectHistory >> synthesisBy: aSynthesizer [
	^ aSynthesizer synthesisObjectHistory: self
]

{ #category : #accessing }
TGObjectHistory >> toEvent [
	^ toEvent
]

{ #category : #accessing }
TGObjectHistory >> toEvent: anObject [
	toEvent := anObject
]
