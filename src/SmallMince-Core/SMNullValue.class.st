Class {
	#name : #SMNullValue,
	#superclass : #SMAbstractValue,
	#category : #'SmallMince-Core-Model'
}

{ #category : #'as yet unclassified' }
SMNullValue class >> uniqueIdFor: anObject [
	^ 0
]

{ #category : #'as yet unclassified' }
SMNullValue >> synthesisBy: aSynthesizer [
	^ aSynthesizer synthesisNullValue: self
]
