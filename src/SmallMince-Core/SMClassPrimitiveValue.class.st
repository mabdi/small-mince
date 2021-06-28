Class {
	#name : #SMClassPrimitiveValue,
	#superclass : #SMPrimitiveValue,
	#category : #'SmallMince-Core-Model'
}

{ #category : #'instance creation' }
SMClassPrimitiveValue class >> with: anObject [
	| obj |
	obj := super with: anObject .
	obj theValue: anObject.
	^ obj
]

{ #category : #'as yet unclassified' }
SMClassPrimitiveValue >> synthesisBy: aSynthesizer [
	^ aSynthesizer synthesisClassPrimitiveValue: self
]
