Class {
	#name : #SMAbstractStrategy,
	#superclass : #Object,
	#traits : 'SMInternalClassesTrait',
	#classTraits : 'SMInternalClassesTrait classTrait',
	#instVars : [
		'traces',
		'classesUnderTest',
		'results',
		'synthesizer'
	],
	#category : #'SmallMince-Core-2.Strategies'
}

{ #category : #accessing }
SMAbstractStrategy >> classesUnderTest [
	^ classesUnderTest
]

{ #category : #accessing }
SMAbstractStrategy >> classesUnderTest: anObject [
	classesUnderTest := anObject
]

{ #category : #initialization }
SMAbstractStrategy >> initialize [ 
	results := Dictionary new
]

{ #category : #'as yet unclassified' }
SMAbstractStrategy >> run [
	^ self subclassResponsibility 
]

{ #category : #'as yet unclassified' }
SMAbstractStrategy >> synthesizer [
	^ synthesizer
]

{ #category : #accessing }
SMAbstractStrategy >> traces [
	^ traces
]

{ #category : #accessing }
SMAbstractStrategy >> traces: anObject [
	traces := anObject
]
