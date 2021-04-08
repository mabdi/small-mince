Class {
	#name : #TGNullValue,
	#superclass : #TGAbstractValue,
	#category : #'SmalltalkTestGrinder-Core-Model'
}

{ #category : #testing }
TGNullValue >> isTGPrimitive [
	^ true
]

{ #category : #'as yet unclassified' }
TGNullValue >> synthesisBy: aSynthesizer [
	^ aSynthesizer synthesisNullValue: self
]
