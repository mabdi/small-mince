Class {
	#name : #SMEXBeetle,
	#superclass : #SMEXMonster,
	#category : #'SmallMince-ToyExample'
}

{ #category : #testing }
SMEXBeetle class >> acceptsId: aString [

	^ aString = 'E'
]

{ #category : #'as yet unclassified' }
SMEXBeetle class >> getById: aString [
	^ self new
]

{ #category : #'as yet unclassified' }
SMEXBeetle >> drawBy: aDrawer [

	aDrawer drawBeetle: self
]
