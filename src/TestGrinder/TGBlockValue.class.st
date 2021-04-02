Class {
	#name : #TGBlockValue,
	#superclass : #TGAbstractValue,
	#instVars : [
		'theASTNode'
	],
	#category : #'TestGrinder-Model'
}

{ #category : #'instance creation' }
TGBlockValue class >> with: anObject [
	| obj |
	obj := super with: anObject.
	obj theASTNode: anObject sourceNode clone.
	^ obj
]

{ #category : #copying }
TGBlockValue >> clone [
	| clone |
	clone := super clone.
	^ clone
		theASTNode: self theASTNode;
		yourself
]

{ #category : #copying }
TGBlockValue >> theASTNode [
	^ theASTNode
]

{ #category : #copying }
TGBlockValue >> theASTNode: anObject [
	theASTNode := anObject
]
