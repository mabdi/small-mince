"
A TGPrimitiveValueTest is a test class for testing the behavior of TGPrimitiveValue
"
Class {
	#name : #TGPrimitiveValueTest,
	#superclass : #TestCase,
	#category : #'TestGrinder-Tests-Model'
}

{ #category : #tests }
TGPrimitiveValueTest >> testEqual [
	self assert: 10 tg_valueReference equals: (9+1) tg_valueReference 
]
