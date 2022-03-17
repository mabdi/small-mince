Class {
	#name : #SMEXMarioView,
	#superclass : #Object,
	#instVars : [
		'world'
	],
	#category : #'SmallMince-ToyExample'
}

{ #category : #drawing }
SMEXMarioView >> draw [

	1 to: world height do: [ :row | 
		1 to: world width do: [ :column | 
			(world objectAtLocation: row @ column) ifNotNil: [ :obj | 
				obj drawBy: self ] ifNil: [ ' ' trace ] ].
		'' traceCr ]
]

{ #category : #'as yet unclassified' }
SMEXMarioView >> draw1up: anObject [

	'+' trace	
]

{ #category : #'as yet unclassified' }
SMEXMarioView >> drawBeetle: anObject [

	'X' trace
]

{ #category : #'as yet unclassified' }
SMEXMarioView >> drawBlock: anObject [

	'?' trace
]

{ #category : #'as yet unclassified' }
SMEXMarioView >> drawBrick: anObject [

	'=' trace
]

{ #category : #'as yet unclassified' }
SMEXMarioView >> drawCoin: anObject [

	'$' trace
]

{ #category : #'as yet unclassified' }
SMEXMarioView >> drawFlower: anObject [

	'&' trace
]

{ #category : #'as yet unclassified' }
SMEXMarioView >> drawGoomba: anObject [

	'X' trace
]

{ #category : #'as yet unclassified' }
SMEXMarioView >> drawGround: anObject [

	'_' trace
]

{ #category : #'as yet unclassified' }
SMEXMarioView >> drawLuigi: anObject [

	'*' trace
]

{ #category : #'as yet unclassified' }
SMEXMarioView >> drawMario: anObject [

	'*' trace
]

{ #category : #'as yet unclassified' }
SMEXMarioView >> drawMushroom: anObject [

	'@' trace
]

{ #category : #'as yet unclassified' }
SMEXMarioView >> drawPipe: anObject [

	'|' trace
]

{ #category : #'as yet unclassified' }
SMEXMarioView >> drawTurtle: anObject [

	'X' trace
]

{ #category : #accessing }
SMEXMarioView >> world [

	^ world
]

{ #category : #accessing }
SMEXMarioView >> world: anObject [

	world := anObject
]
