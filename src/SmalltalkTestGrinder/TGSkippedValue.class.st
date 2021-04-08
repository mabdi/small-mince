Class {
	#name : #TGSkippedValue,
	#superclass : #TGAbstractValue,
	#category : #'SmalltalkTestGrinder-Model'
}

{ #category : #'as yet unclassified' }
TGSkippedValue >> synthesisBy: aSynthesizer [
	^ aSynthesizer synthesisSkippedValue: self
]
