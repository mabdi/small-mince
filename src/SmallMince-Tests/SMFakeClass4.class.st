Class {
	#name : #SMFakeClass4,
	#superclass : #Object,
	#instVars : [
		'flag',
		'result'
	],
	#category : #'SmallMince-Tests-Helpers'
}

{ #category : #'as yet unclassified' }
SMFakeClass4 >> brances [
	flag 
		ifTrue: [ self setZero ]
		ifFalse: [ self setTen ].
	result timesRepeat: [ self doSomething. 1 + 2 ]
]

{ #category : #'as yet unclassified' }
SMFakeClass4 >> doSomething [ 
	^ 2 + result
]

{ #category : #'as yet unclassified' }
SMFakeClass4 >> flagOff [
	flag := false
]

{ #category : #'as yet unclassified' }
SMFakeClass4 >> flagOn [
	flag := true
]

{ #category : #'as yet unclassified' }
SMFakeClass4 >> setTen [
	result := 10
]

{ #category : #'as yet unclassified' }
SMFakeClass4 >> setZero [
	result := 0
]
