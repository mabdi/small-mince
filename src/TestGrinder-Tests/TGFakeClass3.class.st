Class {
	#name : #TGFakeClass3,
	#superclass : #Object,
	#category : #'TestGrinder-Tests-Helpers'
}

{ #category : #enumerating }
TGFakeClass3 >> do: aBlock [
	^ aBlock value * 2
]

{ #category : #enumerating }
TGFakeClass3 >> example [ 
	^ self do: [ TGFakeClass2 new run ]
]
