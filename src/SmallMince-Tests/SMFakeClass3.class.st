Class {
	#name : #SMFakeClass3,
	#superclass : #Object,
	#instVars : [
		'scale'
	],
	#category : #'SmallMince-Tests-Helpers'
}

{ #category : #enumerating }
SMFakeClass3 >> do: aBlock [
	^ aBlock value * scale
]

{ #category : #enumerating }
SMFakeClass3 >> example [ 
	| tmp |
	tmp := 10.
	scale := 3 * tmp.
	^ self do: [ SMFakeClass2 new run ]
]
