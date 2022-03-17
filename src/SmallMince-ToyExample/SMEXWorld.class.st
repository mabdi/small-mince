Class {
	#name : #SMEXWorld,
	#superclass : #Object,
	#instVars : [
		'objects',
		'width',
		'height'
	],
	#category : #'SmallMince-ToyExample'
}

{ #category : #'as yet unclassified' }
SMEXWorld class >> defaultPlayerLocation [

	^ 9 @ 2
]

{ #category : #'as yet unclassified' }
SMEXWorld class >> level [
	
	self subclassResponsibility.
]

{ #category : #adding }
SMEXWorld >> add: anItem [

	"Since it's just a toy example, we add items in a list,"

	objects add: anItem
]

{ #category : #accessing }
SMEXWorld >> height [

	^ height
]

{ #category : #initialization }
SMEXWorld >> initialize [

	objects := OrderedCollection new
]

{ #category : #'as yet unclassified' }
SMEXWorld >> objectAtLocation: aPoint [

	objects
		detect: [ :item | item location = aPoint ]
		ifFound: [ :item | ^ item ]
		ifNone: [ ^ nil ]
]

{ #category : #accessing }
SMEXWorld >> objects [

	^ objects
]

{ #category : #initialization }
SMEXWorld >> setUp [
	self subclassResponsibility 
]

{ #category : #'as yet unclassified' }
SMEXWorld >> tick [
	objects do: [ :obj | obj tick ]
]

{ #category : #accessing }
SMEXWorld >> width [

	^ width
]
