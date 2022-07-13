Class {
	#name : #SMBlockValue,
	#superclass : #SMAbstractValue,
	#instVars : [
		'theASTNode'
	],
	#category : #'SmallMince-Core-Model'
}

{ #category : #'instance creation' }
SMBlockValue class >> with: anObject [
	| obj |
	obj := super with: anObject.
	obj theASTNode: anObject sourceNode clone.
	^ obj
]

{ #category : #comparing }
SMBlockValue >> = anObject [
	super = anObject ifFalse: [ ^ false ].
	^ theASTNode = anObject theASTNode 
]

{ #category : #comparing }
SMBlockValue >> hash [
	^ theASTNode hash
]

{ #category : #'as yet unclassified' }
SMBlockValue >> synthesisBy: aSynthesizer [
	^ aSynthesizer synthesisBlockValue: self
]

{ #category : #copying }
SMBlockValue >> theASTNode [
	^ theASTNode
]

{ #category : #copying }
SMBlockValue >> theASTNode: anObject [
	theASTNode := anObject
]
