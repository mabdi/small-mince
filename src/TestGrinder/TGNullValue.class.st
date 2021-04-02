Class {
	#name : #TGNullValue,
	#superclass : #TGAbstractValue,
	#category : #'TestGrinder-Model'
}

{ #category : #copying }
TGNullValue >> synthesisNodeBy: aSynthesizer [
	^ aSynthesizer genLiteralArgNodeFrom: self
]
