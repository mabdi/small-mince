"
A TGObjectHistoryComposerTest is a test class for testing the behavior of TGObjectHistoryComposer
"
Class {
	#name : #SMObjectHistoryComposerTest,
	#superclass : #TestCase,
	#category : #'SmallMince-Tests-3.Preparation'
}

{ #category : #testing }
SMObjectHistoryComposerTest >> expectedFailures [ 
	^ #(testN3)
]

{ #category : #tests }
SMObjectHistoryComposerTest >> testN1 [
	| obs comp histories |
	obs := SMTracer new 
		captureTargets: { SMFakeClass1 };
		executableCode: [ |x1 x2 x3| x1 := SMFakeClass1 new sum: 100; balance.
			x2 := SMFakeClass1 new balance.
			x3 := SMFakeClass1 new balance; sum: 10; sum: 10;balance; balance;sum: 10].
	obs run.
	comp := SMObjectHistoryComposer new 
		theClass: SMFakeClass1; 
		theMethod: #sum:; 
		records: obs records.
	comp run.
	histories := comp objectHistories asOrderedCollection .
	self assert: histories size equals: 2.
	self assert: histories first objectReference theClass equals: SMFakeClass1.
	self assert: histories second objectReference theClass equals: SMFakeClass1.
	self assert: histories first events size equals: 3.
	self assert: histories second events size equals: 7.
	self assert: (histories first events collect: #selector) equals: (OrderedCollection newFrom: #(initialize sum: balance)).
	self assert: (histories second events collect: #selector) equals: (OrderedCollection newFrom: #(initialize balance sum: sum: balance balance sum:)).
	self assert: (histories first events collect: [:ev | ev value isStatePreserving]) equals: (OrderedCollection newFrom: #(false false true)).
	self assert: (histories second events collect: [:ev | ev value isStatePreserving]) equals: (OrderedCollection newFrom: #(false true false false true true false)).
	self assertEmpty: comp dependencies .
]

{ #category : #tests }
SMObjectHistoryComposerTest >> testN2 [
	| obs comp histories |
	obs := SMTracer new 
		captureTargets: { SMFakeClass1 . SMFakeClass2};
		executableCode: [ |x| x := SMFakeClass1 new. SMFakeClass2 new addHundred: x].
	obs run.
	comp := SMObjectHistoryComposer new 
		theClass: SMFakeClass2; 
		theMethod: #addHundred:; 
		records: obs records.
	comp run.
	histories := comp objectHistories asOrderedCollection .
	self assert: histories size equals: 1.
	self assert: histories first objectReference theClass equals: SMFakeClass2.
	self assert: histories first events size equals: 1.
	self assert: (histories first events collect: #selector) equals: (OrderedCollection newFrom: #(addHundred:)).
	self assert: comp dependencies size equals: 1.
	self assert: comp dependencies asOrderedCollection first objectReference theClass equals: SMFakeClass1.
	self assert: comp dependencies asOrderedCollection first objectReference uniqueId equals: histories first events first argsBefore first uniqueId.
	self assert: histories first events first argsAfter first uniqueId equals: histories first events first argsBefore first uniqueId.
]

{ #category : #tests }
SMObjectHistoryComposerTest >> testN3 [
	| obs comp histories |
	obs := SMTracer new 
		config: self config;
		captureTargets: { SMFakeClass1 . SMFakeClass2};
		executableCode: [ |x| x := SMFakeClass2 new run].
	obs run.
	comp := SMObjectHistoryComposer new 
		config: self config; 
		theClass: SMFakeClass2; 
		theMethod: #getFake1; 
		records: obs records.
	comp run.
	histories := comp objectHistories asOrderedCollection .
	self assert: histories size equals: 1.
	self assert: histories first objectReference theClass equals: SMFakeClass2.
	self assert: histories first events size equals: 1.
	self assert: (histories first events collect: #selector) equals: (OrderedCollection newFrom: #(getFake1)).
	self assert: comp dependencies size equals: 1.
	self assert: comp dependencies asOrderedCollection first objectReference theClass equals: SMFakeClass1.
	self assert: comp dependencies asOrderedCollection first objectReference uniqueId equals: histories first events first argsBefore first uniqueId.
	self assert: histories first events first argsAfter first uniqueId equals: histories first events first argsBefore first uniqueId.
]
