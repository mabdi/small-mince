Class {
	#name : #TGSkippedValue,
	#superclass : #TGAbstractValue,
	#category : #'SmalltalkTestGrinder-Core-Model'
}

{ #category : #'as yet unclassified' }
TGSkippedValue >> synthesisBy: aSynthesizer [
	^ aSynthesizer synthesisSkippedValue: self
]
