"
A TGListValueTest is a test class for testing the behavior of TGListValue
"
Class {
	#name : #SMListValueTest,
	#superclass : #TestCase,
	#category : #'SmallMince-Tests-Model'
}

{ #category : #tests }
SMListValueTest >> testEqualOrderedCollection [
	| x y |
	x := { 1. 2 .3. {11}} asOrderedCollection sm_valueReference.
	y := SMListValue with: OrderedCollection new.
	y theValues add: 1 sm_valueReference.
	y theValues add: 2 sm_valueReference.
	y theValues add: 3 sm_valueReference.
	y theValues add: { 11 } sm_valueReference.
	self assert:  x equals: y.
]

{ #category : #tests }
SMListValueTest >> testEqualSet [
	| x y |
	x := { 1. 2 .3 } asSet sm_valueReference.
	y := SMListValue with: Set new.
	y theValues add: 1 sm_valueReference.
	y theValues add: 2 sm_valueReference.
	y theValues add: 3 sm_valueReference.
	self assert:  x equals: y.
]

{ #category : #tests }
SMListValueTest >> testSetIncludes [
	| x y |
	x := { 1. 2 .3 } asSet sm_valueReference.
	y := 2 sm_valueReference.
	self assert:  (x theValues includes: y).
]
