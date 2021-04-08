Class {
	#name : #TGFakeClass3,
	#superclass : #Object,
	#instVars : [
		'scale'
	],
	#category : #'SmalltalkTestGrinder-Tests-Helpers'
}

{ #category : #enumerating }
TGFakeClass3 >> do: aBlock [
	^ aBlock value * scale
]

{ #category : #enumerating }
TGFakeClass3 >> example [ 
	| tmp |
	tmp := 10.
	scale := 3 * tmp.
	^ self do: [ TGFakeClass2 new run ]
]
