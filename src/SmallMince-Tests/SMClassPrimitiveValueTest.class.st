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

	self
		assert: (SMFakeUrl new url: '123') sm_valueReference
		equals: (SMSkippedValue with: ((SMFakeUrl new url: '111')))
]
