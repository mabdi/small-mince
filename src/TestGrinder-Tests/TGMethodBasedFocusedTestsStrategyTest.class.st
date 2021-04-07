"
A TGMethodBasedFocusedTestsStrategyTest is a test class for testing the behavior of TGMethodBasedFocusedTestsStrategy
"
Class {
	#name : #TGMethodBasedFocusedTestsStrategyTest,
	#superclass : #TestCase,
	#category : #'TestGrinder-Tests-2.Strategies'
}

{ #category : #'as yet unclassified' }
TGMethodBasedFocusedTestsStrategyTest >> getTrace [
	^ TGTracer new
		config: nil;
		captureTargets:
			{TGFakeClass1.
			TGFakeClass2.
			TGFakeClass3};
		executableCode: [ TGFakeClass3 new example ];
		run; 
	 	records
]

{ #category : #tests }
TGMethodBasedFocusedTestsStrategyTest >> testComposeClasses [
	| traces s |
	traces := self getTrace.
	s := TGMethodBasedFocusedTestsStrategy new 
		traces: traces;
		classesUnderTest: { TGFakeClass1. TGFakeClass3 }.
	s composeClasses.
	self assert: s results size equals: 2.
	self assert: (s results includesKey: #TGFakeClass1).
	self assert: (s results includesKey: #TGFakeClass3).
	self deny: (s results includesKey: #TGFakeClass2).
	self assert: ((s results at: #TGFakeClass1) includesKey: #sum:).
	self assert: ((s results at: #TGFakeClass1) includesKey: #balance).
	self assert: ((s results at: #TGFakeClass1) includesKey: #initialize).
	self assert: ((s results at: #TGFakeClass1) at: #sum:) class equals: TGObjectHistoryComposer.
]

{ #category : #test }
TGMethodBasedFocusedTestsStrategyTest >> testComposedObjectsToTestModel [
	| traces s |
	traces := self getTrace.
	s := TGMethodBasedFocusedTestsStrategy new 
		traces: traces;
		classesUnderTest: { TGFakeClass1. TGFakeClass3 }.
	s composeClasses; 
		composedObjectsToTestModel.	
	self assert: s results size equals: 2.
	self assert: (s results includesKey: #TGFakeClass1).
	self assert: (s results includesKey: #TGFakeClass3).
	self deny: (s results includesKey: #TGFakeClass2).
	self assert: ((s results at: #TGFakeClass1) includesKey: #sum:).
	self assert: ((s results at: #TGFakeClass1) includesKey: #balance).
	self assert: ((s results at: #TGFakeClass1) includesKey: #initialize).
	self assert: ((s results at: #TGFakeClass1) at: #sum:) class equals: OrderedCollection.
	self assert: ((s results at: #TGFakeClass1) at: #sum:) first class equals: TGTestMethod.
]

{ #category : #test }
TGMethodBasedFocusedTestsStrategyTest >> testMethodsForTestFrom [
	| s cls |
	s := TGMethodBasedFocusedTestsStrategy new.
	cls := TGFakeClass2.
	self assertCollection: ((s methodsForTestFrom: cls) collect: #selector) hasSameElements: #(addHundred: run getFake1)
]

{ #category : #test }
TGMethodBasedFocusedTestsStrategyTest >> testPackageTests [
	| traces s |
	traces := self getTrace.
	s := TGMethodBasedFocusedTestsStrategy new 
		traces: traces;
		classesUnderTest: { TGFakeClass1. TGFakeClass3 }.
	s composeClasses; 
		composedObjectsToTestModel;
		packageTests.	
	self assert: s results size equals: 2.
	self assert: (s results includesKey: #TGFakeClass1).
	self assert: (s results includesKey: #TGFakeClass3).
	self deny: (s results includesKey: #TGFakeClass2).
	self assert: (s results at: #TGFakeClass1) class equals: Array.
	self assert: (s results at: #TGFakeClass1) size equals: 6.
	self assert: (s results at: #TGFakeClass1) first class equals: TGTestMethod.
]

{ #category : #test }
TGMethodBasedFocusedTestsStrategyTest >> testSetNameForTheTests [
	| s m |
	s := TGMethodBasedFocusedTestsStrategy new.
	m := {(#method1 -> {TGTestMethod new.TGTestMethod new}).
		(#method2:arg: -> {TGTestMethod new.TGTestMethod new}).
		(#method3 -> {TGTestMethod new})} asDictionary.
	s setNameForTheTests: m.
	self assert: ((m at: #method1) collect: #methodName) asArray equals: {'testMethod1_1'. 'testMethod1_2'}.
	self assert: ((m at: #method2:arg:) collect: #methodName) asArray equals: {'testMethod2Arg_1'. 'testMethod2Arg_2'}.
	self assert: ((m at: #method3) collect: #methodName) asArray equals: {'testMethod3'}
]
