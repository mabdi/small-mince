Class {
	#name : #TGDictionaryValue,
	#superclass : #TGListValue,
	#category : #'SmalltalkTestGrinder-Model'
}

{ #category : #accessing }
TGDictionaryValue >> = anObject [
	| val |
	self class = anObject class ifFalse: [ ^ false ].
	theClass = anObject theClass  ifFalse: [ ^ false ].
	val := true.
	theValues keysAndValuesDo: [ :k :v | val := val and: [(anObject valueAt: k) = v] ].
	^ val
]

{ #category : #accessing }
TGDictionaryValue >> hash [
	^ theValues hash
]

{ #category : #'as yet unclassified' }
TGDictionaryValue >> synthesisBy: aSynthesizer [
	^ aSynthesizer synthesisDictionaryValue: self
]

{ #category : #accessing }
TGDictionaryValue >> valueAt: key [ 
	^ theValues at: key
]
