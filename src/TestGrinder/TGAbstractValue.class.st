Class {
	#name : #TGAbstractValue,
	#superclass : #Object,
	#instVars : [
		'theClass'
	],
	#category : #'TestGrinder-Model'
}

{ #category : #'instance creation' }
TGAbstractValue class >> with: anObject [
	^ self new
		theClass: anObject class;
		yourself
]

{ #category : #copying }
TGAbstractValue >> clone [
	^ self class new
		theClass: self theClass;
		yourself
]

{ #category : #copying }
TGAbstractValue >> synthesisNodeBy: aSynthesizer [
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
