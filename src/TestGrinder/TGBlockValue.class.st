Class {
	#name : #TGBlockValue,
	#superclass : #TGAbstractValue,
	#instVars : [
		'theASTNode'
	],
	#category : #'TestGrinder-Model'
}

{ #category : #copying }
TGBlockValue >> clone [
	| clone |
	clone := super clone.
	^ clone
		theASTNode: self theASTNode;
		yourself
]

{ #category : #copying }
TGBlockValue >> synthesisNodeBy: aSynthesizer [
	^ aSynthesizer genBlockClosureNodeFrom: self
]

{ #category : #copying }
TGBlockValue >> theASTNode [
	^ theASTNode
]

{ #category : #copying }
TGBlockValue >> theASTNode: anObject [
	theASTNode := anObject
]
