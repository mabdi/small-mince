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
SMEXQBlock >> freeItem [

	is1Up := false.
	isCoin := false.
	isFlower := false.
	isMushroom := false
]

{ #category : #'as yet unclassified' }
SMEXQBlock >> hitBy: aPlayer in: world [

	self isCoin ifTrue: [ aPlayer score: aPlayer score + 1 ].
	self isMushroom ifTrue: [ 
		| item |
		item := aPlayer small
			        ifTrue: [ SMEXMushroom new ]
			        ifFalse: [ SMEXFlower new ].
		item location: self location + (-1 @ 0).
		world add: item ].
	self isFlower ifTrue: [ 
		| item |
		item := SMEXFlower new.
		item location: self location + (-1 @ 0).
		world add: item ].
	self is1Up ifTrue: [ aPlayer lifes: aPlayer lifes + 1 ].
	self freeItem
]

{ #category : #initialization }
SMEXQBlock >> initialize [

	self freeItem.
	isCoin := true.
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

{ #category : #testing }
SMEXQBlock >> isQBlock [

	^ true
]
