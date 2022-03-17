Class {
	#name : #SMEXLuigiPlayer,
	#superclass : #SMEXPlayer,
	#category : #'SmallMince-ToyExample'
}

{ #category : #'as yet unclassified' }
SMEXLuigiPlayer class >> playerName [
	^ #luigi
]

{ #category : #'as yet unclassified' }
SMEXLuigiPlayer >> drawBy: aDrawer [

	aDrawer drawLuigi: self
]
