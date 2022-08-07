Class {
	#name : #SMObjectIndex,
	#superclass : #Object,
	#traits : 'SMInternalClassesTrait',
	#classTraits : 'SMInternalClassesTrait classTrait',
	#instVars : [
		'uniqueId',
		'theClass'
	],
	#category : #'SmallMince-Core-Model'
}

{ #category : #'as yet unclassified' }
SMObjectIndex class >> forClass: aClass anId: uuid [
	^ self new theClass: aClass; uniqueId: uuid; yourself
]

{ #category : #comparing }
SMObjectIndex >> = anObjectIndex [

	anObjectIndex class = self class ifFalse: [ ^ false ].
	^ (anObjectIndex theClass = self theClass) & (anObjectIndex uniqueId
	  = self uniqueId)
]

{ #category : #'reflective operations' }
SMObjectIndex >> gtDisplayString [

	^ theClass name , ':' , uniqueId asString
]

{ #category : #comparing }
SMObjectIndex >> hash [

	^ (uniqueId hash * theClass hash)
]

{ #category : #printing }
SMObjectIndex >> printOn: aStream [

	aStream nextPutAll: self gtDisplayString
]

{ #category : #accessing }
SMObjectIndex >> theClass [

	^ theClass
]

{ #category : #accessing }
SMObjectIndex >> theClass: anObject [

	theClass := anObject
]

{ #category : #accessing }
SMObjectIndex >> uniqueId [

	^ uniqueId
]

{ #category : #accessing }
SMObjectIndex >> uniqueId: anObject [

	uniqueId := anObject
]
