Class {
	#name : #SMAbstractStrategy,
	#superclass : #Object,
	#traits : 'SMInternalClassesTrait',
	#classTraits : 'SMInternalClassesTrait classTrait',
	#instVars : [
		'traces',
		'links',
		'results',
		'slicingCriteria'
	],
	#category : #'SmallMince-Core-2.Strategies'
}

{ #category : #initialization }
SMAbstractStrategy >> initialize [ 
	results := Dictionary new
]

{ #category : #accessing }
SMAbstractStrategy >> links [

	^ links
]

{ #category : #accessing }
SMAbstractStrategy >> links: anObject [

	links := anObject
]

{ #category : #'as yet unclassified' }
SMAbstractStrategy >> run [
	^ self subclassResponsibility 
]

{ #category : #accessing }
SMAbstractStrategy >> slicingCriteria [

	^ slicingCriteria
]

{ #category : #accessing }
SMAbstractStrategy >> slicingCriteria: anObject [

	slicingCriteria := anObject
]

{ #category : #accessing }
SMAbstractStrategy >> traces [
	^ traces
]

{ #category : #accessing }
SMAbstractStrategy >> traces: anObject [
	traces := anObject
]
