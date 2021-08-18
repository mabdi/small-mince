"
A SMDictionaryValueTest is a test class for testing the behavior of SMDictionaryValue
"
Class {
	#name : #SMDictionaryValueTest,
	#superclass : #TestCase,
	#category : #'SmallMince-Tests-Model'
}

{ #category : #test }
SMDictionaryValueTest >> testHash [
	| val1 val2 m1 m2 val3 m3 |
	val1 := {(#test -> 1)} asDictionary.
	val2 := {(#test -> 1)} asDictionary.
	val3 := {(#test -> 2)} asDictionary.
	m1 := val1 sm_valueReference.
	m2 := val2 sm_valueReference.
	m3 := val3 sm_valueReference.
	self assert: m1 hash equals: m2 hash.
	self deny: m1 hash equals: m3 hash.
	self assert: (Set with: m1 with: m2 with: m3) size equals: 2
]
