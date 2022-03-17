Class {
	#name : #SMEXMushroom,
	#superclass : #SMEXItems,
	#category : #'SmallMince-ToyExample'
}

{ #category : #testing }
SMEXMushroom class >> acceptsId: aString [

	^ aString = 'M'
]

{ #category : #'as yet unclassified' }
SMEXMushroom class >> getById: aString [
	^ self new
]

{ #category : #'as yet unclassified' }
SMEXMushroom >> drawBy: aDrawer [

	aDrawer drawMushroom: self
]
