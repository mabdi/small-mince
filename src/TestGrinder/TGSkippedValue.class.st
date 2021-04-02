Class {
	#name : #TGSkippedValue,
	#superclass : #TGAbstractValue,
	#category : #'TestGrinder-Model'
}

{ #category : #copying }
TGSkippedValue >> synthesisNodeBy: aSynthesizer [
	^ aSynthesizer genSkippedNodeFrom: self
]
