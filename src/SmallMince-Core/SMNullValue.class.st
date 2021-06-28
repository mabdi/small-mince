Class {
	#name : #SMNullValue,
	#superclass : #SMAbstractValue,
	#category : #'SmallMince-Core-Model'
}

{ #category : #testing }
SMNullValue >> isTGPrimitive [
	^ true
]

{ #category : #'as yet unclassified' }
SMNullValue >> synthesisBy: aSynthesizer [
	^ aSynthesizer synthesisNullValue: self
]
