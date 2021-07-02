Class {
	#name : #SMFakeHttpAgent,
	#superclass : #Object,
	#instVars : [
		'method',
		'url'
	],
	#category : #'SmallMince-Tests-Helpers'
}

{ #category : #'as yet unclassified' }
SMFakeHttpAgent class >> runExample [
	SMFakeHttpAgent new url: (SMFakeUrl new url: 'google.com'; protocol: (SMFakeProtocol new protocol: 'https')); method: (SMFakeMethod new method: #GET); execute
]

{ #category : #execution }
SMFakeHttpAgent >> execute [ 
	^ true
]

{ #category : #accessing }
SMFakeHttpAgent >> method [
	^ method
]

{ #category : #accessing }
SMFakeHttpAgent >> method: anObject [
	method := anObject
]

{ #category : #accessing }
SMFakeHttpAgent >> url [
	^ url
]

{ #category : #accessing }
SMFakeHttpAgent >> url: anObject [
	url := anObject
]
