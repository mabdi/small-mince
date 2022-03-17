Class {
	#name : #SMEXGoomba,
	#superclass : #SMEXMonster,
	#category : #'SmallMince-ToyExample'
}

{ #category : #testing }
SMEXGoomba class >> acceptsId: aString [

	^ aString = 'O'
]

{ #category : #'as yet unclassified' }
SMEXGoomba class >> getById: aString [
	^ self new
]

{ #category : #'as yet unclassified' }
SMEXGoomba >> drawBy: aDrawer [

	aDrawer drawGoomba: self
]
