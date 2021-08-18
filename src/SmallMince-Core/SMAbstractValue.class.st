Class {
	#name : #SMAbstractValue,
	#superclass : #Object,
	#traits : 'SMInternalClassesTrait',
	#classTraits : 'SMInternalClassesTrait classTrait',
	#instVars : [
		'theClass'
	],
	#category : #'SmallMince-Core-Model'
}

{ #category : #'instance creation' }
SMAbstractValue class >> with: anObject [
	^ self new
		theClass: anObject class;
		yourself
]

{ #category : #comparing }
SMAbstractValue >> = anObject [
	self class = anObject class ifFalse: [ ^ false ].
	^ theClass = anObject theClass
]

{ #category : #copying }
SMAbstractValue >> copy [
	^ self class new
		theClass: self theClass;
		yourself
]

{ #category : #comparing }
SMAbstractValue >> hash [ 
	^ theClass hash
]

{ #category : #testing }
SMAbstractValue >> isObjectValue [
	^ false
]

{ #category : #'as yet unclassified' }
SMAbstractValue >> synthesisBy: aSynthesizer [
	^ self subclassResponsibility 
]

{ #category : #copying }
SMAbstractValue >> theClass [
	^ theClass
]

{ #category : #copying }
SMAbstractValue >> theClass: anObject [
	theClass := anObject
]
