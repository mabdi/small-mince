Class {
	#name : #SMTestMethod,
	#superclass : #Object,
	#traits : 'SMInternalClassesTrait',
	#classTraits : 'SMInternalClassesTrait classTrait',
	#instVars : [
		'objectUnderTest',
		'dependencies',
		'methodName'
	],
	#category : #'SmallMince-Core-Model'
}

{ #category : #accessing }
SMTestMethod >> dependencies [
	^ dependencies
]

{ #category : #accessing }
SMTestMethod >> dependencies: anObject [
	dependencies := anObject
]

{ #category : #accessing }
SMTestMethod >> methodName [
	^ methodName
]

{ #category : #accessing }
SMTestMethod >> methodName: anObject [
	methodName := anObject
]

{ #category : #accessing }
SMTestMethod >> objectUnderTest [
	^ objectUnderTest
]

{ #category : #accessing }
SMTestMethod >> objectUnderTest: anObject [
	objectUnderTest := anObject
]

{ #category : #'as yet unclassified' }
SMTestMethod >> synthesisBy: aSynthesizer [
	^ aSynthesizer synthesisTestMethod: self
]
