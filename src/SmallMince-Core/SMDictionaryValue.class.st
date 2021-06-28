Class {
	#name : #SMDictionaryValue,
	#superclass : #SMListValue,
	#category : #'SmallMince-Core-Model'
}

{ #category : #accessing }
SMDictionaryValue >> = anObject [
	| val |
	self class = anObject class ifFalse: [ ^ false ].
	theClass = anObject theClass  ifFalse: [ ^ false ].
	val := true.
	theValues keysAndValuesDo: [ :k :v | val := val and: [(anObject valueAt: k) = v] ].
	^ val
]

{ #category : #accessing }
SMDictionaryValue >> hash [
	^ theValues hash
]

{ #category : #'as yet unclassified' }
SMDictionaryValue >> synthesisBy: aSynthesizer [
	^ aSynthesizer synthesisDictionaryValue: self
]

{ #category : #accessing }
SMDictionaryValue >> valueAt: key [ 
	^ theValues at: key
]
