Class {
	#name : #SMEXCoin,
	#superclass : #SMEXItems,
	#category : #'SmallMince-ToyExample'
}

{ #category : #testing }
SMEXCoin class >> acceptsId: aString [

	^ aString = 'C'
]

{ #category : #'as yet unclassified' }
SMEXCoin class >> getById: aString [
	^ self new
]

{ #category : #'as yet unclassified' }
SMEXCoin >> drawBy: aDrawer [

	aDrawer drawCoin: self
]
