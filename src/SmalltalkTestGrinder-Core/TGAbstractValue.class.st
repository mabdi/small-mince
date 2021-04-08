Class {
	#name : #TGAbstractValue,
	#superclass : #Object,
	#traits : 'TGInternalClassesTrait',
	#classTraits : 'TGInternalClassesTrait classTrait',
	#instVars : [
		'theClass'
	],
	#category : #'SmalltalkTestGrinder-Core-Model'
}

{ #category : #'instance creation' }
TGAbstractValue class >> with: anObject [
	^ self new
		theClass: anObject class;
		yourself
]

{ #category : #comparing }
TGAbstractValue >> = anObject [
	self class = anObject class ifFalse: [ ^ false ].
	^ theClass = anObject theClass
]

{ #category : #copying }
TGAbstractValue >> copy [
	^ self class new
		theClass: self theClass;
		yourself
]

{ #category : #comparing }
TGAbstractValue >> hash [ 
	^ theClass hash
]

{ #category : #testing }
TGAbstractValue >> isObjectValue [
	^ false
]

{ #category : #testing }
TGAbstractValue >> isTGPrimitive [ 
	^ false
]

{ #category : #'as yet unclassified' }
TGAbstractValue >> synthesisBy: aSynthesizer [
	^ self subclassResponsibility 
]

{ #category : #copying }
TGAbstractValue >> theClass [
	^ theClass
]

{ #category : #copying }
TGAbstractValue >> theClass: anObject [
	theClass := anObject
]
