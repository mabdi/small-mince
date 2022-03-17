Class {
	#name : #SMEXObjects,
	#superclass : #Object,
	#instVars : [
		'location'
	],
	#category : #'SmallMince-ToyExample'
}

{ #category : #testing }
SMEXObjects class >> acceptsId: aString [

	self subclassResponsibility 
]

{ #category : #'as yet unclassified' }
SMEXObjects class >> getById: aString [


	| theClass |
	aString = '0' ifTrue: [ ^ nil ].
	theClass := self allSubclasses detect: [ :cls | 
		            cls acceptsId: aString ].
	^ theClass getById: aString
]

{ #category : #comparing }
SMEXObjects >> = anObject [

	^ self class = anObject class and: [ 
		self  location = anObject location ]
]

{ #category : #'as yet unclassified' }
SMEXObjects >> drawBy: aDrawer [

	self subclassResponsibility 
]

{ #category : #comparing }
SMEXObjects >> hash [

	^ (self class hash * self location hash ) 
]

{ #category : #testing }
SMEXObjects >> isHitable [
	^ false
]

{ #category : #testing }
SMEXObjects >> isQBlock [

	^ false
]

{ #category : #accessing }
SMEXObjects >> location [

	^ location
]

{ #category : #accessing }
SMEXObjects >> location: anObject [

	location := anObject
]

{ #category : #'as yet unclassified' }
SMEXObjects >> tick [

	"we do nothing in toy example. monsters can act here"

	
]
