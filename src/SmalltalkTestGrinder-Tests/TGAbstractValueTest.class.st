"
A TGAbstractValueTest is a test class for testing the behavior of TGAbstractValue
"
Class {
	#name : #TGAbstractValueTest,
	#superclass : #TestCase,
	#category : #'SmalltalkTestGrinder-Tests-Model'
}

{ #category : #test }
TGAbstractValueTest >> testCloneBoolean [
	| m m2 val oldVal |
	val := true.
	m := val tg_valueReference.
	self assert: m theValue equals: val.
	self deny: m clone == m.
	oldVal := val.
	val := false.
	m2 := val tg_valueReference.
	self assert: m2 theValue equals: val.
	self deny: m2 theValue equals: oldVal.

	
	
]

{ #category : #test }
TGAbstractValueTest >> testCloneClass [
	| m val |
	val := self class.
	m := val tg_valueReference.
	self assert: m theValue equals: val.
	self assert: m theClass equals: val class.
	self deny: m clone == m.
	
]

{ #category : #test }
TGAbstractValueTest >> testCloneDictionary [
	| m val |
	val := { (#int -> 10). (#bool -> false). (#str -> 'jjj'). (#obj -> (2@3)) } asDictionary.
	m := val tg_valueReference.
	val keysAndValuesDo: [:k :v | 
		self assert: (m valueAt: k) equals: (val at: k) tg_valueReference ].
	self deny: m copy identicalTo: m.
	self assert: val tg_valueReference equals: m.
	self deny: val tg_valueReference identicalTo: m.
]

{ #category : #test }
TGAbstractValueTest >> testCloneInteger [
	| m m2 val oldVal |
	val := 10.
	m := val tg_valueReference.
	self assert: m theValue equals: val.
	self deny: m clone == m.
	oldVal := val.
	val := 11.
	m2 := val tg_valueReference.
	self assert: m2 theValue equals: val.
	self deny: m2 theValue equals: oldVal.

	
	
]

{ #category : #test }
TGAbstractValueTest >> testCloneList [
	| m val |
	val := { 10. false. 'jjj'. (2@3) } asOrderedCollection.
	m := val tg_valueReference.
	val keysAndValuesDo: [:k :v | 
		self assert: (m valueAt: k) equals: (val at: k) tg_valueReference ].
	self deny: m copy identicalTo: m.
	self assert: val tg_valueReference equals: m.
	self deny: val tg_valueReference identicalTo: m.
]

{ #category : #test }
TGAbstractValueTest >> testCloneSet [
	| m val |
	val := { 10. false. 'jjj'. (2@3) } asSet.
	m := val tg_valueReference.
	self assert: (m theValues includes: 10 tg_valueReference).
	self assert: (m theValues includes: false tg_valueReference).
	self assert: (m theValues includes: 'jjj' tg_valueReference).
	self assert: (m theValues includes: (2@3) tg_valueReference).
	self deny: m copy identicalTo: m.
	self assert: val tg_valueReference equals: m.
	self deny: val tg_valueReference identicalTo: m.
]

{ #category : #test }
TGAbstractValueTest >> testCloneString [
	| m m2 val oldVal |
	val := 'abcd'.
	m := val tg_valueReference.
	self assert: m theValue equals: val.
	self deny: m clone == m.
	oldVal := val.
	val := 'abcde'.
	m2 := val tg_valueReference.
	self assert: m2 theValue equals: val.
	self deny: m2 theValue equals: oldVal.

	
	
]
