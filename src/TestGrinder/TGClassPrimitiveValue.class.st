Class {
	#name : #TGClassPrimitiveValue,
	#superclass : #TGAbstractValue,
	#category : #'TestGrinder-Model'
}

{ #category : #copying }
TGClassPrimitiveValue >> synthesisNodeBy: aSynthesizer [
	^ aSynthesizer genClassNameNodeFrom: self
]
