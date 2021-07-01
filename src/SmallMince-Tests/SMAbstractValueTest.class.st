"
A TGAbstractValueTest is a test class for testing the behavior of TGAbstractValue
"
Class {
	#name : #SMAbstractValueTest,
	#superclass : #TestCase,
	#category : #'SmallMince-Tests-Model'
}

{ #category : #test }
SMAbstractValueTest >> testBlock [
	| m m2 val oldVal |
	val := [ :x | x + 1 ].
	m := val sm_valueReference.
	self assert: m theASTNode equals: [ :x | x + 1 ] sourceNode.
	self deny: m copy identicalTo: m.
	oldVal := val.
	val := [ :y | y + 2 ].
	m2 := val sm_valueReference.
	self assert: m2 theASTNode equals: val sourceNode.
	self deny: m2 theASTNode equals: oldVal sourceNode
]

{ #category : #test }
SMAbstractValueTest >> testCloneBoolean [
	| m m2 val oldVal |
	val := true.
	m := val sm_valueReference.
	self assert: m theValue equals: val.
	self deny: m copy identicalTo: m.
	oldVal := val.
	val := false.
	m2 := val sm_valueReference.
	self assert: m2 theValue equals: val.
	self deny: m2 theValue equals: oldVal
]

{ #category : #test }
SMAbstractValueTest >> testCloneClass [
	| m val |
	val := self class.
	m := val sm_valueReference.
	self assert: m theValue equals: val.
	self assert: m theClass equals: val class.
	self deny: m copy identicalTo: m
]

{ #category : #test }
SMAbstractValueTest >> testCloneDictionary [
	| m val |
	val := { (#int -> 10). (#bool -> false). (#str -> 'jjj'). (#obj -> (2@3)) } asDictionary.
	m := val sm_valueReference.
	val keysAndValuesDo: [:k :v | 
		self assert: (m valueAt: k) equals: (val at: k) sm_valueReference ].
	self deny: m copy identicalTo: m.
	self assert: val sm_valueReference equals: m.
	self deny: val sm_valueReference identicalTo: m.
]

{ #category : #test }
SMAbstractValueTest >> testCloneInteger [
	| m m2 val oldVal |
	val := 10.
	m := val sm_valueReference.
	self assert: m theValue equals: val.
	self deny: m copy identicalTo: m.
	oldVal := val.
	val := 11.
	m2 := val sm_valueReference.
	self assert: m2 theValue equals: val.
	self deny: m2 theValue equals: oldVal
]

{ #category : #test }
SMAbstractValueTest >> testCloneList [
	| m val |
	val := { 10. false. 'jjj'. (2@3) } asOrderedCollection.
	m := val sm_valueReference.
	val keysAndValuesDo: [:k :v | 
		self assert: (m valueAt: k) equals: (val at: k) sm_valueReference ].
	self deny: m copy identicalTo: m.
	self assert: val sm_valueReference equals: m.
	self deny: val sm_valueReference identicalTo: m.
]

{ #category : #test }
SMAbstractValueTest >> testCloneSet [
	| m val |
	val := { 10. false. 'jjj'. (2@3) } asSet.
	m := val sm_valueReference.
	self assert: (m theValues includes: 10 sm_valueReference).
	self assert: (m theValues includes: false sm_valueReference).
	self assert: (m theValues includes: 'jjj' sm_valueReference).
	self assert: (m theValues includes: (2@3) sm_valueReference).
	self deny: m copy identicalTo: m.
	self assert: val sm_valueReference equals: m.
	self deny: val sm_valueReference identicalTo: m.
]

{ #category : #test }
SMAbstractValueTest >> testCloneString [
	| m m2 val oldVal |
	val := 'abcd'.
	m := val sm_valueReference.
	self assert: m theValue equals: val.
	self deny: m copy identicalTo: m.
	oldVal := val.
	val := 'abcde'.
	m2 := val sm_valueReference.
	self assert: m2 theValue equals: val.
	self deny: m2 theValue equals: oldVal
]
