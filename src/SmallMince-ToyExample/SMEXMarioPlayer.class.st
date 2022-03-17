Class {
	#name : #SMEXMarioPlayer,
	#superclass : #SMEXPlayer,
	#category : #'SmallMince-ToyExample'
}

{ #category : #'as yet unclassified' }
SMEXMarioPlayer class >> playerName [
	^ #mario
]

{ #category : #'as yet unclassified' }
SMEXMarioPlayer >> drawBy: aDrawer [

	aDrawer drawMario: self
]
