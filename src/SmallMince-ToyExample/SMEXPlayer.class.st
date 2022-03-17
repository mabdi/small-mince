Class {
	#name : #SMEXPlayer,
	#superclass : #SMEXObjects,
	#instVars : [
		'small',
		'score',
		'nextMove'
	],
	#category : #'SmallMince-ToyExample'
}

{ #category : #testing }
SMEXPlayer class >> acceptsId: aString [

	^ false
]

{ #category : #'as yet unclassified' }
SMEXPlayer class >> playerName [
	^ self subclassResponsibility 
]

{ #category : #visiting }
SMEXPlayer >> acceptAction: aSymbol [

	
]

{ #category : #initialization }
SMEXPlayer >> initialize [

	
]

{ #category : #accessing }
SMEXPlayer >> location: aPoint [
	location := aPoint 
]

{ #category : #initialization }
SMEXPlayer >> setUp [

	small := true.
	score := 0
]
