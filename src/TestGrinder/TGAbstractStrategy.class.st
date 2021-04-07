Class {
	#name : #TGAbstractStrategy,
	#superclass : #Object,
	#traits : 'TGInternalClassesTrait',
	#classTraits : 'TGInternalClassesTrait classTrait',
	#instVars : [
		'traces',
		'classesUnderTest',
		'results'
	],
	#category : #'TestGrinder-2.Strategies'
}

{ #category : #accessing }
TGAbstractStrategy >> classesUnderTest [
	^ classesUnderTest
]

{ #category : #accessing }
TGAbstractStrategy >> classesUnderTest: anObject [
	classesUnderTest := anObject
]

{ #category : #initialization }
TGAbstractStrategy >> initialize [ 
	results := Dictionary new
]

{ #category : #'as yet unclassified' }
TGAbstractStrategy >> run [
	^ self subclassResponsibility 
]

{ #category : #'as yet unclassified' }
TGAbstractStrategy >> synthesizer [
	^ self subclassResponsibility 
]

{ #category : #accessing }
TGAbstractStrategy >> traces [
	^ traces
]

{ #category : #accessing }
TGAbstractStrategy >> traces: anObject [
	traces := anObject
]
