Class {
	#name : #TGMinimizer,
	#superclass : #Object,
	#traits : 'TGInternalClassesTrait',
	#classTraits : 'TGInternalClassesTrait classTrait',
	#instVars : [
		'objectHistories'
	],
	#category : #'TestGrinder-3.Preparation'
}

{ #category : #actions }
TGMinimizer >> minimizeObjects [
	"remove all state preserving method calls"
]

{ #category : #actions }
TGMinimizer >> removeRedundantObjects [
	"remove duplicated Object histories"
]

{ #category : #'as yet unclassified' }
TGMinimizer >> run [
	self minimizeObjects.
	self removeRedundantObjects 
]
