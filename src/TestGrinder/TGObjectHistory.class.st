Class {
	#name : #TGObjectHistory,
	#superclass : #Object,
	#instVars : [
		'theClass',
		'uId',
		'events',
		'isInitialized'
	],
	#category : #'TestGrinder-Model'
}

{ #category : #comparing }
TGObjectHistory >> = anObject [
	anObject class = self class ifFalse: [ ^ false ].
	^ uId = anObject uId
]

{ #category : #adding }
TGObjectHistory >> addEvent: anEvent [ 
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
TGObjectHistory >> events: anObject [
	events := anObject
]

{ #category : #comparing }
TGObjectHistory >> hash [ 
	^ uId hash
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

{ #category : #initialization }
TGObjectHistory >> setInitIfNil: aRecord [
	
	theClass ifNil: [ theClass := aRecord receiver theClass ]
	
]

{ #category : #initialization }
TGObjectHistory >> setInitializeDone [
	isInitialized := true
]

{ #category : #'as yet unclassified' }
TGObjectHistory >> tg_internal_class [
	^ true
]

{ #category : #accessing }
TGObjectHistory >> theClass [
	^ theClass
]

{ #category : #accessing }
TGObjectHistory >> theClass: anObject [
	theClass := anObject
]

{ #category : #accessing }
TGObjectHistory >> uId [
	^ uId
]

{ #category : #accessing }
TGObjectHistory >> uId: anObject [
	uId := anObject
]
