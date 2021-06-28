"
A TGClassPrimitiveValueTest is a test class for testing the behavior of TGClassPrimitiveValue
"
Class {
	#name : #SMClassPrimitiveValueTest,
	#superclass : #TestCase,
	#category : #'SmallMince-Tests-Model'
}

{ #category : #tests }
SMClassPrimitiveValueTest >> testEqual [ 
	self assert: (1@1) sm_valueReference equals: (SMSkippedValue with: (0@0))
]
