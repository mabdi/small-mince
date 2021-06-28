"
A TGPrimitiveValueTest is a test class for testing the behavior of TGPrimitiveValue
"
Class {
	#name : #SMPrimitiveValueTest,
	#superclass : #TestCase,
	#category : #'SmallMince-Tests-Model'
}

{ #category : #tests }
SMPrimitiveValueTest >> testEqual [
	self assert: 10 sm_valueReference equals: (9+1) sm_valueReference 
]
