Class {
	#name : #SMEXGround,
	#superclass : #SMEXObjects,
	#category : #'SmallMince-ToyExample'
}

{ #category : #testing }
SMEXGround class >> acceptsId: aString [

	^ aString = 'G'
]

{ #category : #'as yet unclassified' }
SMEXGround class >> getById: aString [
	^ self new
]

{ #category : #'as yet unclassified' }
SMEXGround >> drawBy: aDrawer [

	aDrawer drawGround: self
]
