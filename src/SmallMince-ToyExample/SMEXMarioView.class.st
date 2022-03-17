Class {
	#name : #SMEXMarioView,
	#superclass : #Object,
	#instVars : [
		'world',
		'stream'
	],
	#category : #'SmallMince-ToyExample'
}

{ #category : #drawing }
SMEXMarioView >> draw [

	self newDraw.
	1 to: world height do: [ :row | 
		1 to: world width do: [ :column | 
			(world objectAtLocation: row @ column)
				ifNotNil: [ :obj | obj drawBy: self ]
				ifNil: [ stream << ' ' ] ].
		stream cr ]
]

{ #category : #'as yet unclassified' }
SMEXMarioView >> draw1up: anObject [

	stream << '+'
]

{ #category : #'as yet unclassified' }
SMEXMarioView >> drawBeetle: anObject [

	stream <<'X'
]

{ #category : #'as yet unclassified' }
SMEXMarioView >> drawBlock: anObject [

	anObject isOpened
		ifTrue: [ stream << '!' ]
		ifFalse: [stream << '?'  ]
]

{ #category : #'as yet unclassified' }
SMEXMarioView >> drawBrick: anObject [

	stream <<'=' 
]

{ #category : #'as yet unclassified' }
SMEXMarioView >> drawCoin: anObject [

	stream <<'$' 
]

{ #category : #'as yet unclassified' }
SMEXMarioView >> drawFlower: anObject [

	stream <<'&' 
]

{ #category : #'as yet unclassified' }
SMEXMarioView >> drawGoomba: anObject [

	stream <<'X'
]

{ #category : #'as yet unclassified' }
SMEXMarioView >> drawGround: anObject [

	stream <<'_'
]

{ #category : #'as yet unclassified' }
SMEXMarioView >> drawLuigi: anObject [

	stream <<'*'
]

{ #category : #'as yet unclassified' }
SMEXMarioView >> drawMario: anObject [

	stream <<'*'
]

{ #category : #'as yet unclassified' }
SMEXMarioView >> drawMushroom: anObject [

	stream <<'@'
]

{ #category : #'as yet unclassified' }
SMEXMarioView >> drawPipe: anObject [

	stream <<'|'
]

{ #category : #'as yet unclassified' }
SMEXMarioView >> drawTurtle: anObject [

	stream <<'X'
]

{ #category : #initialization }
SMEXMarioView >> initialize [ 
	stream := ''
]

{ #category : #'instance creation' }
SMEXMarioView >> newDraw [
	
	
	stream := '' writeStream
]

{ #category : #modes }
SMEXMarioView >> screen [
	^ stream contents 
]

{ #category : #accessing }
SMEXMarioView >> world [

	^ world
]

{ #category : #accessing }
SMEXMarioView >> world: anObject [

	world := anObject
]
