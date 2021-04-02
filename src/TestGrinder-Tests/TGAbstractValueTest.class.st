"
A TGAbstractValueTest is a test class for testing the behavior of TGAbstractValue
"
Class {
	#name : #TGAbstractValueTest,
	#superclass : #TestCase,
	#category : #'TestGrinder-Tests-Model'
}

{ #category : #test }
TGAbstractValueTest >> testClone [
	| m m2 val oldVal |
	val := 1.
	m := val tg_valueReference.
	self assert: m theValue equals: val.
	self deny: m clone == m.
	oldVal := val.
	val := 100.
	m2 := val tg_valueReference.
	self assert: m2 theValue equals: val.
	self deny: m2 theValue equals: oldVal.

	
	
]
