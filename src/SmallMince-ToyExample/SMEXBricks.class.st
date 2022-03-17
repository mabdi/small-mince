Class {
	#name : #SMEXBricks,
	#superclass : #SMEXObjects,
	#category : #'SmallMince-ToyExample'
}

{ #category : #testing }
SMEXBricks class >> acceptsId: aString [
	^ aString = 'B'
]

{ #category : #'as yet unclassified' }
SMEXBricks class >> getById: aString [
	^ self new
]

{ #category : #'as yet unclassified' }
SMEXBricks >> drawBy: aDrawer [
	aDrawer drawBrick: self
]
