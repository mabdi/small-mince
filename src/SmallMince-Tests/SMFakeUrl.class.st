Class {
	#name : #SMFakeUrl,
	#superclass : #Object,
	#instVars : [
		'url',
		'protocol'
	],
	#category : #'SmallMince-Tests-Helpers'
}

{ #category : #accessing }
SMFakeUrl >> protocol [
	^ protocol
]

{ #category : #accessing }
SMFakeUrl >> protocol: anObject [
	protocol := anObject
]

{ #category : #accessing }
SMFakeUrl >> url [
	^ url
]

{ #category : #accessing }
SMFakeUrl >> url: anObject [
	url := anObject
]
