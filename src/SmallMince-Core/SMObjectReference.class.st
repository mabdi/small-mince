Class {
	#name : #SMObjectReference,
	#superclass : #Object,
	#traits : 'SMInternalClassesTrait',
	#classTraits : 'SMInternalClassesTrait classTrait',
	#instVars : [
		'uniqueId',
		'version',
		'theClass'
	],
	#category : #'SmallMince-Core-Model'
}

{ #category : #'instance creation' }
SMObjectReference class >> from: anObject [

^ self new uniqueId: anObject uniqueId ; version: anObject version ; theClass: anObject theClass; yourself
]

{ #category : #accessing }
SMObjectReference >> theClass [

	^ theClass
]

{ #category : #accessing }
SMObjectReference >> theClass: anObject [

	theClass := anObject
]

{ #category : #accessing }
SMObjectReference >> uniqueId [

	^ uniqueId
]

{ #category : #accessing }
SMObjectReference >> uniqueId: anObject [

	uniqueId := anObject
]

{ #category : #accessing }
SMObjectReference >> version [

	^ version
]

{ #category : #accessing }
SMObjectReference >> version: anObject [

	version := anObject
]
