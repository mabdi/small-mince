Class {
	#name : #SMObjectReturnEvent,
	#superclass : #SMObjectAbstractEvent,
	#traits : 'SMInternalClassesTrait',
	#classTraits : 'SMInternalClassesTrait classTrait',
	#instVars : [
		'returnValue'
	],
	#category : #'SmallMince-Core-Model'
}

{ #category : #'as yet unclassified' }
SMObjectReturnEvent class >> forCall: callRecord return: returnRecord [
	^ self new forCall: callRecord return: returnRecord
]

{ #category : #accessing }
SMObjectReturnEvent >> isReturn [
	^ true
]

{ #category : #accessing }
SMObjectReturnEvent >> returnValue [
	^ returnValue
]

{ #category : #accessing }
SMObjectReturnEvent >> returnValue: anObject [
	returnValue := anObject
]

{ #category : #'as yet unclassified' }
SMObjectReturnEvent >> synthesisBy: aSynthesizer [
	^ aSynthesizer synthesisObjectReturnEvent: self
]
