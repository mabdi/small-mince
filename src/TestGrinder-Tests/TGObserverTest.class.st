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
		captureTargets: { TGFakeClass1  }; 
		captureTargets: { TGFakeClass1 };
		sampleCode: [TGFakeClass1 new sum: 100; sum: 10].
	obs observe.
	self assert: obs records size equals: 6.
	self assert: obs records first class equals: TGCallLogRecord.
	self assert: obs records second class equals: TGReturnLogRecord.
]
