"
A TGListValueTest is a test class for testing the behavior of TGListValue
"
Class {
	#name : #TGListValueTest,
	#superclass : #TestCase,
	#category : #'TestGrinder-Tests-Model'
}

{ #category : #tests }
TGListValueTest >> testEqualOrderedCollection [
	| x y |
	x := { 1. 2 .3. {11}} asOrderedCollection tg_valueReference.
	y := TGListValue with: OrderedCollection new.
	y theValues add: 1 tg_valueReference.
	y theValues add: 2 tg_valueReference.
	y theValues add: 3 tg_valueReference.
	y theValues add: { 11 } tg_valueReference.
	self assert:  x equals: y.
]

{ #category : #tests }
TGListValueTest >> testEqualSet [
	| x y |
	x := { 1. 2 .3 } asSet tg_valueReference.
	y := TGListValue with: Set new.
	y theValues add: 1 tg_valueReference.
	y theValues add: 2 tg_valueReference.
	y theValues add: 3 tg_valueReference.
	self assert:  x equals: y.
]

{ #category : #tests }
TGListValueTest >> testSetIncludes [
	| x y |
	x := { 1. 2 .3 } asSet tg_valueReference.
	y := 2 tg_valueReference.
	self assert:  (x theValues includes: y).
]
