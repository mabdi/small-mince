Class {
	#name : #SMFakeClass1,
	#superclass : #Object,
	#instVars : [
		'balance'
	],
	#category : #'SmallMince-Tests-Helpers'
}

{ #category : #accessing }
SMFakeClass1 >> balance [ 
	^ balance 
]

{ #category : #'math functions' }
SMFakeClass1 >> initialize [ 
	balance := 0
]

{ #category : #'math functions' }
SMFakeClass1 >> sum: anInt [ 
	balance := balance + anInt 
]
