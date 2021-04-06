Class {
	#name : #TGListValue,
	#superclass : #TGAbstractValue,
	#instVars : [
		'theValues'
	],
	#category : #'TestGrinder-Model'
}

{ #category : #'instance creation' }
TGListValue class >> with: anObject [
	| obj |
	obj := super with: anObject.
	obj theValues: (anObject collect: [ :x | x tg_valueReference ]).
	^ obj
]

{ #category : #comparing }
TGListValue >> = anObject [
	super = anObject ifFalse: [ ^ false ].
	^ theValues = anObject theValues
]

{ #category : #'as yet unclassified' }
TGListValue >> areAllPrimitive [
	^ theValues allSatisfy: #isTGPrimitive
]

{ #category : #accessing }
TGListValue >> copy [
	| clone |
	clone := super copy.
	^ clone
		theValues: (self theValues collect: #copy);
		yourself
]

{ #category : #comparing }
TGListValue >> hash [
	^ theValues hash
]

{ #category : #'as yet unclassified' }
TGListValue >> synthesisBy: aSynthesizer [
	^ aSynthesizer synthesisListValue: self
]

{ #category : #accessing }
TGListValue >> theValues [
	^ theValues
]

{ #category : #accessing }
TGListValue >> theValues: anObject [
	theValues := anObject
]

{ #category : #accessing }
TGListValue >> valueAt: key [ 
	^ theValues at: key
]
