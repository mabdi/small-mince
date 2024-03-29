Class {
	#name : #SMAbstractValue,
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
SMAbstractValue class >> uniqueIdFor: anObject [
	^ anObject basicIdentityHash
]

{ #category : #'instance creation' }
SMAbstractValue class >> with: anObject [

	^ self new
		  theClass: anObject class;
		uniqueId: (self uniqueIdFor: anObject);
	
		  yourself
]

{ #category : #comparing }
SMAbstractValue >> = anObject [

	self class = anObject class ifFalse: [ ^ false ].
	theClass = anObject theClass ifFalse: [ ^ false ].
	^ true
]

{ #category : #comparing }
SMAbstractValue >> == anObject [

	self = anObject ifFalse: [ ^ false ].
	uniqueId = anObject uniqueId ifFalse: [ ^ false ].
	^ true
]

{ #category : #comparing }
SMAbstractValue >> hash [ 
	^ theClass hash
]

{ #category : #testing }
SMAbstractValue >> isObjectReference [
	^ false
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

{ #category : #accessing }
SMAbstractValue >> uniqueId [
	^ uniqueId
]

{ #category : #accessing }
SMAbstractValue >> uniqueId: anObject [
	uniqueId := anObject
]
