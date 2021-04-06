Class {
	#name : #TGPipedPreparation,
	#superclass : #TGAbstractPreparation,
	#instVars : [
		'preprations'
	],
	#category : #'TestGrinder-3.Preparation'
}

{ #category : #copying }
TGPipedPreparation >> , anObject [
	anObject isTGPreparation ifFalse: [ self error: 'invalid argument' ].
	anObject class = self class 
	ifTrue: [ self addAll: anObject ]
	ifFalse: [ self add: anObject ].
	
]

{ #category : #copying }
TGPipedPreparation >> add: anObj [
	preprations add: anObj 
]

{ #category : #copying }
TGPipedPreparation >> addAll: anObj [
	preprations addAll: anObj preprations
]

{ #category : #'as yet unclassified' }
TGPipedPreparation >> doPreparation [
	preprations do: [ :p | p doPreparation ]
]

{ #category : #initialization }
TGPipedPreparation >> initialize [ 
	preprations := OrderedCollection new
]

{ #category : #accessing }
TGPipedPreparation >> preprations [
	^ preprations
]
