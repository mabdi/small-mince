Class {
	#name : #SMEXMarioGameTest,
	#superclass : #TestCase,
	#category : #'SmallMince-ToyExample'
}

{ #category : #tests }
SMEXMarioGameTest >> testRuns [

	| game |
	game := SMEXMarioGame level: 1.
	game player: #mario.
	game start.
	[self deny: game stop.
	game acceptAction: #Right.
	game acceptAction: #Right.
	game acceptAction: #Right.
	game acceptAction: #Jump.
	game acceptAction: #Right.
	game acceptAction: #Jump.
	(Delay forSeconds: 1) wait.
	game acceptAction: #Right.
	game acceptAction: #Jump.]ensure: [ game stop: true ].
	
	self assert: game stop
]
