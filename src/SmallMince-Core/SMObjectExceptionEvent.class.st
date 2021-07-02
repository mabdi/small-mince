Class {
	#name : #SMObjectExceptionEvent,
	#superclass : #SMObjectAbstractEvent,
	#traits : 'SMInternalClassesTrait',
	#classTraits : 'SMInternalClassesTrait classTrait',
	#instVars : [
		'exceptionValue'
	],
	#category : #'SmallMince-Core-Model'
}

{ #category : #'as yet unclassified' }
SMObjectExceptionEvent class >> forCall: callRecord exception: exceptionRecord [
	^ self new forCall: callRecord exception: exceptionRecord
]

{ #category : #accessing }
SMObjectExceptionEvent >> exceptionValue [
	^ exceptionValue
]

{ #category : #accessing }
SMObjectExceptionEvent >> exceptionValue: anObject [
	exceptionValue := anObject
]

{ #category : #accessing }
SMObjectExceptionEvent >> isException [
	^ true
]

{ #category : #'as yet unclassified' }
SMObjectExceptionEvent >> synthesisBy: aSynthesizer [
	^ aSynthesizer synthesisObjectErrorEvent: self
]
