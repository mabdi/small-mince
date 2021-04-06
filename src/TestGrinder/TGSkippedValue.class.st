Class {
	#name : #TGSkippedValue,
	#superclass : #TGAbstractValue,
	#category : #'TestGrinder-Model'
}

{ #category : #'as yet unclassified' }
TGSkippedValue >> synthesisBy: aSynthesizer [
	^ aSynthesizer synthesisSkippedValue: self
]
