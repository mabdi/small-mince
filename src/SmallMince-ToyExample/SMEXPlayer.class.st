Class {
	#name : #SMEXPlayer,
	#superclass : #SMEXObjects,
	#instVars : [
		'small',
		'score',
		'nextMove',
		'lifes'
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

{ #category : #accessing }
SMEXPlayer >> lifes [

	^ lifes
]

{ #category : #accessing }
SMEXPlayer >> lifes: anObject [

	lifes := anObject
]

{ #category : #accessing }
SMEXPlayer >> location: aPoint [
	location := aPoint 
]

{ #category : #accessing }
SMEXPlayer >> score [

	^ score
]

{ #category : #accessing }
SMEXPlayer >> score: anObject [

	score := anObject
]

{ #category : #initialization }
SMEXPlayer >> setUp [

	lifes := 3.
	small := true.
	score := 0
]

{ #category : #accessing }
SMEXPlayer >> small [

	^ small
]

{ #category : #accessing }
SMEXPlayer >> small: anObject [

	small := anObject
]
