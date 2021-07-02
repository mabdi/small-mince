Class {
	#name : #SMFakeMethod,
	#superclass : #Object,
	#instVars : [
		'method'
	],
	#category : #'SmallMince-Tests-Helpers'
}

{ #category : #accessing }
SMFakeMethod >> method [
	^ method
]

{ #category : #accessing }
SMFakeMethod >> method: anObject [
	method := anObject
]
