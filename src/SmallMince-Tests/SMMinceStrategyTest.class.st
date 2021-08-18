Class {
	#name : #SMMinceStrategyTest,
	#superclass : #TestCase,
	#category : #'SmallMince-Tests-2.Strategies'
}

{ #category : #'as yet unclassified' }
SMMinceStrategyTest >> getTrace [
	^ SMTracer new
		captureTargets:
			{SMFakeClass1.
			SMFakeClass2.
			SMFakeClass3};
		executableCode: [ SMFakeClass3 new example ];
		run; 
	 	records
]

{ #category : #tests }
SMMinceStrategyTest >> testComposeClasses [
	| traces s |
	traces := self getTrace.
	s := SMMinceStrategy new
		traces: traces;
		classesUnderTest:
			{SMFakeClass1.
			SMFakeClass3}.
	s composeClasses.
	self assert: s results size equals: 2.
	self assert: (s results includesKey: #SMFakeClass1).
	self assert: (s results includesKey: #SMFakeClass3).
	self deny: (s results includesKey: #SMFakeClass2).
	self assert: (s results at: #SMFakeClass1) size equals: 2.
	self
		assert: ((s results at: #SMFakeClass1) at: 1) class
		equals: OrderedCollection.
	self
		assert: ((s results at: #SMFakeClass1) at: 1) first class
		equals: SMTestMethod
]

{ #category : #test }
SMMinceStrategyTest >> testPackageTests [
	| traces s |
	traces := self getTrace.
	s := SMMinceStrategy new
		traces: traces;
		classesUnderTest:
			{SMFakeClass1.
			SMFakeClass3}.
	s
		composeClasses;
		packageTests.
	self assert: s results size equals: 2.
	self assert: (s results includesKey: #SMFakeClass1).
	self assert: (s results includesKey: #SMFakeClass3).
	self deny: (s results includesKey: #SMFakeClass2).
	self assert: (s results at: #SMFakeClass1) class equals: Array.
	self assert: (s results at: #SMFakeClass1) size equals: 2.
	self
		assert: (s results at: #SMFakeClass1) first class
		equals: SMTestMethod
]

{ #category : #test }
SMMinceStrategyTest >> testSetNameForTheTests [
	| s m |
	s := SMMinceStrategy new.
	m := {(#method1
		->
			{SMTestMethod new.
			SMTestMethod new}).
	(#method2:arg:
		->
			{SMTestMethod new.
			SMTestMethod new}).
	(#method3 -> {SMTestMethod new})} asDictionary.
	s setNameForTheTests: m.
	self
		assert: ((m at: #method1) collect: #methodName) asArray
		equals: {'testN_2_1' . 'testN_2_2'}.
	self
		assert: ((m at: #method2:arg:) collect: #methodName) asArray
		equals: {'testN_1_1' . 'testN_1_2'}.
	self
		assert: ((m at: #method3) collect: #methodName) asArray
		equals: {'testN_3'}
]
