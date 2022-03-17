Class {
	#name : #SMEXTurtle,
	#superclass : #SMEXMonster,
	#category : #'SmallMince-ToyExample'
}

{ #category : #testing }
SMEXTurtle class >> acceptsId: aString [

	^ aString = 'T'
]

{ #category : #'as yet unclassified' }
SMEXTurtle class >> getById: aString [
	^ self new
]

{ #category : #'as yet unclassified' }
SMEXTurtle >> drawBy: aDrawer [

	aDrawer drawTurtle: self
]
