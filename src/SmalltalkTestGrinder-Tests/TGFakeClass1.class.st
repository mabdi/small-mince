Class {
	#name : #TGFakeClass1,
	#superclass : #Object,
	#instVars : [
		'balance'
	],
	#category : #'SmalltalkTestGrinder-Tests-Helpers'
}

{ #category : #accessing }
TGFakeClass1 >> balance [ 
	^ balance 
]

{ #category : #'math functions' }
TGFakeClass1 >> initialize [ 
	balance := 0
]

{ #category : #'math functions' }
TGFakeClass1 >> sum: anInt [ 
	balance := balance + anInt 
]
