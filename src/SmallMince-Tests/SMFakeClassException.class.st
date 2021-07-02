Class {
	#name : #SMFakeClassException,
	#superclass : #Object,
	#instVars : [
		'flag',
		'result'
	],
	#category : #'SmallMince-Tests-Helpers'
}

{ #category : #'as yet unclassified' }
SMFakeClassException class >> runExample [
	| o |
	o := self new.
	o notRaiseAnError.
	[ o raiseAnError ]
		on: Error
		do: [ :x | ^ 1 ].
	
]

{ #category : #'as yet unclassified' }
SMFakeClassException >> notRaiseAnError [
	^ 1
]

{ #category : #'as yet unclassified' }
SMFakeClassException >> raiseAnError [
	self error: 'something bad'
]
