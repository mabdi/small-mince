Class {
	#name : #TGBlockValue,
	#superclass : #TGAbstractValue,
	#instVars : [
		'theASTNode'
	],
	#category : #'SmalltalkTestGrinder-Model'
}

{ #category : #'instance creation' }
TGBlockValue class >> with: anObject [
	| obj |
	obj := super with: anObject.
	obj theASTNode: anObject sourceNode clone.
	^ obj
]

{ #category : #comparing }
TGBlockValue >> = anObject [
	super = anObject ifFalse: [ ^ false ].
	^ theASTNode = anObject theASTNode 
]

{ #category : #copying }
TGBlockValue >> copy [
	| clone |
	clone := super copy.
	^ clone
		theASTNode: self theASTNode;
		yourself
]

{ #category : #comparing }
TGBlockValue >> hash [
	^ theASTNode hash
]

{ #category : #'as yet unclassified' }
TGBlockValue >> synthesisBy: aSynthesizer [
	^ aSynthesizer synthesisBlockValue: self
]

{ #category : #copying }
TGBlockValue >> theASTNode [
	^ theASTNode
]

{ #category : #copying }
TGBlockValue >> theASTNode: anObject [
	theASTNode := anObject
]
