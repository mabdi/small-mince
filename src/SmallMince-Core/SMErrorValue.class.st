Class {
	#name : #SMErrorValue,
	#superclass : #SMAbstractValue,
	#instVars : [
		'errorMessage'
	],
	#category : #'SmallMince-Core-Model'
}

{ #category : #'instance creation' }
SMErrorValue class >> with: anObject [
	| obj |
	obj := super with: anObject.
	obj errorMessage: anObject messageText.
	^ obj
]

{ #category : #accessing }
SMErrorValue >> errorMessage [
	^ errorMessage
]

{ #category : #accessing }
SMErrorValue >> errorMessage: anObject [
	errorMessage := anObject
]
