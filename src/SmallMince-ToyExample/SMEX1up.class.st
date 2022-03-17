Class {
	#name : #SMEX1up,
	#superclass : #SMEXItems,
	#category : #'SmallMince-ToyExample'
}

{ #category : #testing }
SMEX1up class >> acceptsId: aString [

	^ aString = 'U'
]

{ #category : #'as yet unclassified' }
SMEX1up class >> getById: aString [
	^ self new
]

{ #category : #'as yet unclassified' }
SMEX1up >> drawBy: aDrawer [

	aDrawer draw1up: self
]
