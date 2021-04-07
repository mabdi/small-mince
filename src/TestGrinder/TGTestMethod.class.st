Class {
	#name : #TGTestMethod,
	#superclass : #Object,
	#traits : 'TGInternalClassesTrait',
	#classTraits : 'TGInternalClassesTrait classTrait',
	#instVars : [
		'objectUnderTest',
		'dependencies',
		'methodName'
	],
	#category : #'TestGrinder-Model'
}

{ #category : #accessing }
TGTestMethod >> dependencies [
	^ dependencies
]

{ #category : #accessing }
TGTestMethod >> dependencies: anObject [
	dependencies := anObject
]

{ #category : #accessing }
TGTestMethod >> methodName [
	^ methodName
]

{ #category : #accessing }
TGTestMethod >> methodName: anObject [
	methodName := anObject
]

{ #category : #accessing }
TGTestMethod >> objectUnderTest [
	^ objectUnderTest
]

{ #category : #accessing }
TGTestMethod >> objectUnderTest: anObject [
	objectUnderTest := anObject
]

{ #category : #'as yet unclassified' }
TGTestMethod >> synthesisBy: aSynthesizer [
	^ aSynthesizer synthesisTestMethod: self
]
