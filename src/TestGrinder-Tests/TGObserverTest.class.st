"
A TGObserverTest is a test class for testing the behavior of TGObserver
"
Class {
	#name : #TGObserverTest,
	#superclass : #TestCase,
	#category : #'TestGrinder-Tests-Observation'
}

{ #category : #tests }
TGObserverTest >> testObserve1 [
	| obs |
	obs := TGObserver new 
		config: nil;
		captureTargets: { TGFakeClass1 };
		sampleCode: [TGFakeClass1 new sum: 100; sum: 10].
	obs observe.
	self assert: obs records size equals: 6.
	self assert: obs records first class equals: TGCallLogRecord.
	self assert: obs records second class equals: TGReturnLogRecord.
	self assert: ((obs records select: #isCall) collect: #selector) equals: #(initialize sum: sum:) asOrderedCollection.
	self assert: ((obs records select: #isCall) collect: #arguments) equals: (OrderedCollection new add: #();add: (Array with: 100 tg_valueReference) ;add: (Array with: 10 tg_valueReference) ;yourself).
	
]

{ #category : #tests }
TGObserverTest >> testObserve2 [
	| obs |
	obs := TGObserver new 
		config: nil;
		captureTargets: { TGFakeClass1 . TGFakeClass2 . TGFakeClass3};
		sampleCode: [TGFakeClass3 new example].
	obs observe.
	self assert: obs records size equals: 6.
	self assert: obs records first class equals: TGCallLogRecord.
	self assert: obs records second class equals: TGReturnLogRecord.
	self assert: ((obs records select: #isCall) collect: #selector) equals: #(initialize sum: sum:) asOrderedCollection.
	self assert: ((obs records select: #isCall) collect: #arguments) equals: (OrderedCollection new add: #();add: (Array with: 100 tg_valueReference) ;add: (Array with: 10 tg_valueReference) ;yourself).
	
]
