Class {
	#name : #SMMinimizer,
	#superclass : #Object,
	#traits : 'SMInternalClassesTrait',
	#classTraits : 'SMInternalClassesTrait classTrait',
	#instVars : [
		'objectHistories'
	],
	#category : #'SmallMince-Core-3.Preparation'
}

{ #category : #actions }
SMMinimizer >> minimizeObjects [
	"remove all state preserving method calls"
]

{ #category : #actions }
SMMinimizer >> removeRedundantObjects [
	"remove duplicated Object histories"
]

{ #category : #'as yet unclassified' }
SMMinimizer >> run [
	self minimizeObjects.
	self removeRedundantObjects 
]
