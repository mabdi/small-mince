Class {
	#name : #SMFakeProtocol,
	#superclass : #Object,
	#instVars : [
		'protocol'
	],
	#category : #'SmallMince-Tests-Helpers'
}

{ #category : #accessing }
SMFakeProtocol >> protocol [
	^ protocol
]

{ #category : #accessing }
SMFakeProtocol >> protocol: anObject [
	protocol := anObject
]
