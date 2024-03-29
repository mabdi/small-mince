Class {
	#name : #SMEXMarioGame,
	#superclass : #Object,
	#instVars : [
		'world',
		'player',
		'thread',
		'stop',
		'view',
		'actionsBuffer',
		'clockSpeed'
	],
	#category : #'SmallMince-ToyExample'
}

{ #category : #examples }
SMEXMarioGame class >> example [

	| game |
	game := SMEXMarioGame level: 1.
	game clockSpeed: 300.
	game player: #mario.
	[ 
	game start.
	game acceptAction: #Right.
	game acceptAction: #Right.
	game acceptAction: #Right.
	game acceptAction: #Jump.
	game acceptAction: #Right.
	game acceptAction: #Jump.
	(Delay forSeconds: 1) wait.
	game acceptAction: #Right.
	game acceptAction: #Jump ] ensure: [ game stop: true ]
]

{ #category : #accessing }
SMEXMarioGame class >> level: anInt [
	^ self new level: anInt
]

{ #category : #visiting }
SMEXMarioGame >> acceptAction: aSymbol [

	actionsBuffer nextPut: aSymbol
]

{ #category : #'as yet unclassified' }
SMEXMarioGame >> actionsBufferIsEmpty [

	^ actionsBuffer isEmpty
]

{ #category : #accessing }
SMEXMarioGame >> clockSpeed [
	^ clockSpeed
]

{ #category : #accessing }
SMEXMarioGame >> clockSpeed: speed [

	clockSpeed := speed
]

{ #category : #drawing }
SMEXMarioGame >> draw [

	view draw
]

{ #category : #'as yet unclassified' }
SMEXMarioGame >> enforceAction: aSymbol [

	aSymbol asString traceCr.
	[ 
	aSymbol = #Right ifTrue: [ self movePlayer: 0 @ 1 ].
	aSymbol = #Left ifTrue: [ self movePlayer: 0 @ -1 ].
	aSymbol = #Jump ifTrue: [ self jumpPlayer ].
	aSymbol = #Fire ifTrue: [ self flag: #todo ] ]
		on: Error
		do: [ :x | x traceCr ]
]

{ #category : #'as yet unclassified' }
SMEXMarioGame >> gameTick [

	self processActions .
	world tick.
	self draw
]

{ #category : #'as yet unclassified' }
SMEXMarioGame >> gravityPlayer [

	| height newLocation objectInDestination |
	height := 10.
	newLocation := player location + (1 @ 0).
	objectInDestination := world objectAtLocation: newLocation.
	[ objectInDestination isNil and: [ height > 0 ] ] whileTrue: [ 
		height := height - 1.
		newLocation := newLocation + (1 @ 0).
		objectInDestination := world objectAtLocation: newLocation ].
	player location: newLocation + (-1 @ 0)
]

{ #category : #initialization }
SMEXMarioGame >> initialize [

	view := SMEXMarioView new.
	
	actionsBuffer := WaitfreeQueue new
]

{ #category : #'as yet unclassified' }
SMEXMarioGame >> jumpPlayer [

	| newLocation objectInDestination height |
	height := 1.
	newLocation := player location + (-1 @ 0).
	objectInDestination := world objectAtLocation: newLocation.
	[ objectInDestination isNil and: [ height < 6 ] ] whileTrue: [ 
		height := height + 1.
		newLocation := newLocation + (-1 @ 0).
		objectInDestination := world objectAtLocation: newLocation ].
	objectInDestination ifNil: [ 
		player location: newLocation.
		^ self ].
	objectInDestination isHitable ifTrue: [ 
		objectInDestination hitBy: player in: world ].
	
	newLocation := newLocation + (1 @ 0).
	player location: newLocation
]

{ #category : #visiting }
SMEXMarioGame >> level: anInt [

	| worldClass |
	worldClass := SMEXWorld subclasses detect: [ :cls | 
		              cls level = anInt ].
	world := worldClass new.
	world setUp.
	view world: world 
]

{ #category : #'as yet unclassified' }
SMEXMarioGame >> movePlayer: speed [

	| newLocation objectTo |
	newLocation := player location + speed.
	"TODO. check the out of border positions"
	objectTo := world objectAtLocation: newLocation.
	objectTo ifNil: [ player location: newLocation ]
]

{ #category : #accessing }
SMEXMarioGame >> player [

	^ player
]

{ #category : #initialization }
SMEXMarioGame >> player: aSymbol [
	| playerClass |
	playerClass := SMEXPlayer subclasses detect: [ :cls | cls playerName = aSymbol ].
	player := playerClass new.
	player setUp.
	player location: world class defaultPlayerLocation.
	world add: player.
]

{ #category : #'as yet unclassified' }
SMEXMarioGame >> processActions [

	| action |
	
	self gravityPlayer.
	action := actionsBuffer nextOrNil.
	action ifNotNil: [ self enforceAction: action ]
]

{ #category : #modes }
SMEXMarioGame >> screen [

	^ view screen
]

{ #category : #accessing }
SMEXMarioGame >> start [

	stop := false.
	self draw.
	thread := [ 
	          [ self stop ] whileFalse: [ 
		          self gameTick.
		          (Delay forMilliseconds: self clockSpeed) wait ] ] fork
]

{ #category : #accessing }
SMEXMarioGame >> stop [

	^ stop
]

{ #category : #accessing }
SMEXMarioGame >> stop: anObject [

	stop := anObject
]
