Class {
	#name : #SMEXFlower,
	#superclass : #SMEXItems,
	#category : #'SmallMince-ToyExample'
}

{ #category : #testing }
SMEXFlower class >> acceptsId: aString [

	^ aString = 'F'
]

{ #category : #'as yet unclassified' }
SMEXFlower class >> getById: aString [
	^ self new
]

{ #category : #'as yet unclassified' }
SMEXFlower >> drawBy: aDrawer [

	aDrawer drawFlower: self
]
