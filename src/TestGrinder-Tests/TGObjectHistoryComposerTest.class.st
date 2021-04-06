"
A TGObjectHistoryComposerTest is a test class for testing the behavior of TGObjectHistoryComposer
"
Class {
	#name : #TGObjectHistoryComposerTest,
	#superclass : #TestCase,
	#category : #'TestGrinder-Tests-2.HistoryComposer'
}

{ #category : #accessing }
TGObjectHistoryComposerTest >> config [
	^ self
]

{ #category : #tests }
TGObjectHistoryComposerTest >> testN1 [
	| obs comp histories |
	obs := TGTracer new 
		config: self config;
		captureTargets: { TGFakeClass1 };
		sampleCode: [ |x1 x2 x3| x1 := TGFakeClass1 new sum: 100; balance.
			x2 := TGFakeClass1 new balance.
			x3 := TGFakeClass1 new balance; sum: 10; sum: 10;balance; balance;sum: 10].
	obs run.
	comp := TGObjectHistoryComposer new 
		config: self config; 
		theClass: TGFakeClass1; 
		theMethod: #sum:; 
		records: obs records.
	comp run.
	histories := comp objectHistories asOrderedCollection .
	self assert: histories size equals: 2.
	self assert: histories first theClass equals: TGFakeClass1.
	self assert: histories second theClass equals: TGFakeClass1.
	self assert: histories first events size equals: 3.
	self assert: histories second events size equals: 7.
	self assert: (histories first events collect: #selector) equals: (OrderedCollection newFrom: #(initialize sum: balance)).
	self assert: (histories second events collect: #selector) equals: (OrderedCollection newFrom: #(initialize balance sum: sum: balance balance sum:)).
	self assert: (histories first events collect: [:ev | ev value isStatePreserving]) equals: (OrderedCollection newFrom: #(false false true)).
	self assert: (histories second events collect: [:ev | ev value isStatePreserving]) equals: (OrderedCollection newFrom: #(false true false false true true false)).
	self assertEmpty: comp dependencies .
]

{ #category : #tests }
TGObjectHistoryComposerTest >> testN2 [
	| obs comp histories |
	obs := TGTracer new 
		config: self config;
		captureTargets: { TGFakeClass1 . TGFakeClass2};
		sampleCode: [ |x| x := TGFakeClass1 new. TGFakeClass2 new addHundred: x].
	obs run.
	comp := TGObjectHistoryComposer new 
		config: self config; 
		theClass: TGFakeClass2; 
		theMethod: #addHundred:; 
		records: obs records.
	comp run.
	histories := comp objectHistories asOrderedCollection .
	self assert: histories size equals: 1.
	self assert: histories first objectReference theClass equals: TGFakeClass2.
	self assert: histories first events size equals: 1.
	self assert: (histories first events collect: #selector) equals: (OrderedCollection newFrom: #(addHundred:)).
	self assert: comp dependencies size equals: 1.
	self assert: comp dependencies asOrderedCollection first objectReference theClass equals: TGFakeClass1.
	self assert: comp dependencies asOrderedCollection first objectReference uniqueId equals: histories first events first argsBefore first uniqueId.
	self assert: histories first events first argsAfter first uniqueId equals: histories first events first argsBefore first uniqueId.
]
