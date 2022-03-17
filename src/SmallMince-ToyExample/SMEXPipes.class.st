Class {
	#name : #SMEXPipes,
	#superclass : #SMEXObjects,
	#category : #'SmallMince-ToyExample'
}

{ #category : #testing }
SMEXPipes class >> acceptsId: aString [

	^ aString = 'P'
]

{ #category : #'as yet unclassified' }
SMEXPipes class >> getById: aString [
	^ self new
]

{ #category : #'as yet unclassified' }
SMEXPipes >> drawBy: aDrawer [

	aDrawer drawPipe: self
]
