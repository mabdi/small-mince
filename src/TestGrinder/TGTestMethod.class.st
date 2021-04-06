Class {
	#name : #TGTestMethod,
	#superclass : #Object,
	#instVars : [
		'objectUnderTest',
		'dependencies'
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
