Class {
	#name : #SMEXQBlock,
	#superclass : #SMEXObjects,
	#instVars : [
		'isCoin',
		'isMushroom',
		'isFlower',
		'is1Up'
	],
	#category : #'SmallMince-ToyExample'
}

{ #category : #testing }
SMEXQBlock class >> acceptsId: aString [

	^ #( c m f u ) includes: aString
]

{ #category : #'as yet unclassified' }
SMEXQBlock class >> getById: aString [

	| block |
	block := self new.
	({ 
		 ('c' -> [ :b | b isCoin: true ]).
		 ('m' -> [ :b | b isMushroom: true ]).
		 ('f' -> [ :b | b isFlower: true ]).
		 ('u' -> [ :b | b is1Up: true ]) } asDictionary at: aString) value: block.
	^ block
]

{ #category : #'as yet unclassified' }
SMEXQBlock >> drawBy: aDrawer [

	aDrawer drawBlock: self
]

{ #category : #'as yet unclassified' }
SMEXQBlock >> hitBy: aPlayer in: world [

	self halt.
]

{ #category : #initialization }
SMEXQBlock >> initialize [
	is1Up := false.
	isCoin := true.
	isFlower := false.
	isMushroom := false
]

{ #category : #accessing }
SMEXQBlock >> is1Up [

	^ is1Up
]

{ #category : #accessing }
SMEXQBlock >> is1Up: anObject [

	is1Up := anObject
]

{ #category : #accessing }
SMEXQBlock >> isCoin [

	^ isCoin
]

{ #category : #accessing }
SMEXQBlock >> isCoin: anObject [

	isCoin := anObject
]

{ #category : #accessing }
SMEXQBlock >> isFlower [

	^ isFlower
]

{ #category : #accessing }
SMEXQBlock >> isFlower: anObject [

	isFlower := anObject
]

{ #category : #accessing }
SMEXQBlock >> isMushroom [

	^ isMushroom
]

{ #category : #accessing }
SMEXQBlock >> isMushroom: anObject [

	isMushroom := anObject
]

{ #category : #accessing }
SMEXQBlock >> isOpened [

	^ (self is1Up | self isCoin | self isFlower | self isMushroom ) not
]
