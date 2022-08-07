Class {
	#name : #SMTestMethod,
	#superclass : #Object,
	#traits : 'SMInternalClassesTrait',
	#classTraits : 'SMInternalClassesTrait classTrait',
	#instVars : [
		'methodName',
		'events'
	],
	#category : #'SmallMince-Core-Model'
}

{ #category : #'instance creation' }
SMTestMethod class >> from: anOrderedCollection [

	^ self new
		  events: anOrderedCollection reverse;
		  yourself
]

{ #category : #accessing }
SMTestMethod >> events [

	^ events
]

{ #category : #accessing }
SMTestMethod >> events: anObject [

	events := anObject
]

{ #category : #accessing }
SMTestMethod >> methodName [
	^ methodName
]

{ #category : #accessing }
SMTestMethod >> methodName: anObject [
	methodName := anObject
]

{ #category : #'as yet unclassified' }
SMTestMethod >> synthesisBy: aSynthesizer [
	^ aSynthesizer synthesisTestMethod: self
]
