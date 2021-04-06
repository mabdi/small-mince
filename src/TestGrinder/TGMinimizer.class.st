Class {
	#name : #TGMinimizer,
	#superclass : #TGAbstractPreparation,
	#category : #'TestGrinder-3.Preparation'
}

{ #category : #'as yet unclassified' }
TGMinimizer >> doPreparation [
	self minimizeObjects.
	self removeRedundantObjects 
]

{ #category : #actions }
TGMinimizer >> minimizeObjects [
	"remove all state preserving method calls"
]

{ #category : #actions }
TGMinimizer >> removeRedundantObjects [
	"remove duplicated Object histories"
]
