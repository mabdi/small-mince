"
A TGClassPrimitiveValueTest is a test class for testing the behavior of TGClassPrimitiveValue
"
Class {
	#name : #TGClassPrimitiveValueTest,
	#superclass : #TestCase,
	#category : #'TestGrinder-Tests-Model'
}

{ #category : #tests }
TGClassPrimitiveValueTest >> testEqual [ 
	self assert: (1@1) tg_valueReference equals: (TGSkippedValue with: (0@0))
]
