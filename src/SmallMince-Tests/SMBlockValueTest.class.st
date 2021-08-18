"
A SMBlockValueTest is a test class for testing the behavior of SMBlockValue
"
Class {
	#name : #SMBlockValueTest,
	#superclass : #TestCase,
	#category : #'SmallMince-Tests-Model'
}

{ #category : #tests }
SMBlockValueTest >> testHashEqualsSign [
	| val1 val2 m1 m2 val3 m3 |
	val1 := [ :x | x + 1 ].
	val2 := [ :x | x + 1 ].
	val3 := [ :x | x + 2 ].
	m1 := val1 sm_valueReference.
	m2 := val2 sm_valueReference.
	m3 := val3 sm_valueReference.
	self assert: m1 hash equals: m2 hash.
	self deny: m1 hash equals: m3 hash.
	self assert: m1 equals: m2.
	self deny: m1 equals: m3.
	self assert: (Set with: m1 with: m2 with: m3) size equals: 2
]
