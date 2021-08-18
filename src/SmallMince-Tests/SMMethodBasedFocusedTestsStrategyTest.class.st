"
A TGMethodBasedFocusedTestsStrategyTest is a test class for testing the behavior of TGMethodBasedFocusedTestsStrategy
"
Class {
	#name : #SMMethodBasedFocusedTestsStrategyTest,
	#superclass : #TestCase,
	#category : #'SmallMince-Tests-2.Strategies'
}

{ #category : #'as yet unclassified' }
SMMethodBasedFocusedTestsStrategyTest >> getTrace [
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
SMMethodBasedFocusedTestsStrategyTest >> testComposeClasses [
	| traces s |
	traces := self getTrace.
	s := SMMethodBasedFocusedTestsStrategy new 
		traces: traces;
		classesUnderTest: { SMFakeClass1. SMFakeClass3 }.
	s composeClasses.
	self assert: s results size equals: 2.
	self assert: (s results includesKey: #SMFakeClass1).
	self assert: (s results includesKey: #SMFakeClass3).
	self deny: (s results includesKey: #SMFakeClass2).
	self assert: ((s results at: #SMFakeClass1) includesKey: #sum:).
	self assert: ((s results at: #SMFakeClass1) includesKey: #balance).
	self assert: ((s results at: #SMFakeClass1) includesKey: #initialize).
	self assert: ((s results at: #SMFakeClass1) at: #sum:) class equals: SMObjectHistoryComposer.
]

{ #category : #test }
SMMethodBasedFocusedTestsStrategyTest >> testComposedObjectsToTestModel [
	| traces s |
	traces := self getTrace.
	s := SMMethodBasedFocusedTestsStrategy new 
		traces: traces;
		classesUnderTest: { SMFakeClass1. SMFakeClass3 }.
	s composeClasses; 
		composedObjectsToTestModel.	
	self assert: s results size equals: 2.
	self assert: (s results includesKey: #SMFakeClass1).
	self assert: (s results includesKey: #SMFakeClass3).
	self deny: (s results includesKey: #SMFakeClass2).
	self assert: ((s results at: #SMFakeClass1) includesKey: #sum:).
	self assert: ((s results at: #SMFakeClass1) includesKey: #balance).
	self assert: ((s results at: #SMFakeClass1) includesKey: #initialize).
	self assert: ((s results at: #SMFakeClass1) at: #sum:) class equals: OrderedCollection.
	self assert: ((s results at: #SMFakeClass1) at: #sum:) first class equals: SMTestMethod.
]

{ #category : #test }
SMMethodBasedFocusedTestsStrategyTest >> testMethodsForTestFrom [
	| s cls |
	s := SMMethodBasedFocusedTestsStrategy new.
	cls := SMFakeClass2.
	self assertCollection: ((s methodsForTestFrom: cls) collect: #selector) hasSameElements: #(addHundred: run getFake1)
]

{ #category : #test }
SMMethodBasedFocusedTestsStrategyTest >> testPackageTests [
	| traces s |
	traces := self getTrace.
	s := SMMethodBasedFocusedTestsStrategy new 
		traces: traces;
		classesUnderTest: { SMFakeClass1. SMFakeClass3 }.
	s composeClasses; 
		composedObjectsToTestModel;
		packageTests.	
	self assert: s results size equals: 2.
	self assert: (s results includesKey: #SMFakeClass1).
	self assert: (s results includesKey: #SMFakeClass3).
	self deny: (s results includesKey: #SMFakeClass2).
	self assert: (s results at: #SMFakeClass1) class equals: Array.
	self assert: (s results at: #SMFakeClass1) size equals: 6.
	self assert: (s results at: #SMFakeClass1) first class equals: SMTestMethod.
]

{ #category : #test }
SMMethodBasedFocusedTestsStrategyTest >> testSetNameForTheTests [
	| s m |
	s := SMMethodBasedFocusedTestsStrategy new. 
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
		equals: {'testMethod1_1' . 'testMethod1_2'}.
	self
		assert: ((m at: #method2:arg:) collect: #methodName) asArray
		equals: {'testMethod2Arg_1' . 'testMethod2Arg_2'}.
	self
		assert: ((m at: #method3) collect: #methodName) asArray
		equals: {'testMethod3'}
]
