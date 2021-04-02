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

{ #category : #comparing }
TGAbstractValue >> = anObject [
	^ false
]

{ #category : #copying }
TGAbstractValue >> clone [
	^ self class new
		theClass: self theClass;
		yourself
]

{ #category : #'as yet unclassified' }
TGAbstractValue >> tg_internal_class [
	^ true
]

{ #category : #copying }
TGAbstractValue >> theClass [
	^ theClass
]

{ #category : #copying }
TGAbstractValue >> theClass: anObject [
	theClass := anObject
]
