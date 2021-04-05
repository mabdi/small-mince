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
	obs := TGTracer new 
		config: nil;
		captureTargets: { TGFakeClass1 };
		sampleCode: [TGFakeClass1 new sum: 100; sum: 10].
	obs run.
	self assert: obs records size equals: 6.
	self assert: obs records first class equals: TGCallLogRecord.
	self assert: obs records second class equals: TGReturnLogRecord.
	self assert: ((obs records select: #isCall) collect: #selector) equals: #(initialize sum: sum:) asOrderedCollection.
	self assert: ((obs records select: #isCall) collect: #arguments) equals: (OrderedCollection new add: #();add: (Array with: 100 tg_valueReference) ;add: (Array with: 10 tg_valueReference) ;yourself).
	
]

{ #category : #tests }
TGObserverTest >> testObserve2 [
	| obs rec |
	obs := TGTracer new
		config: nil;
		captureTargets:
			{TGFakeClass1.
			TGFakeClass2.
			TGFakeClass3};
		sampleCode: [ TGFakeClass3 new example ].
	obs run.
	rec := obs records at: 1.
	self assert: rec isCall.
	self assert: rec receiver theClass equals: TGFakeClass3.
	self assert: rec receiver lastRecordId equals: -1.
	self assert: rec selector equals: #example.
	self assert: (rec state includesKey: #scale).
	self deny: (rec state includesKey: TGTracer state_variable_name ).
	self assert: (rec state at: #scale) class equals: TGNullValue.
	self assert: (rec locals at: #obs) class equals: TGSkippedValue.
	rec := obs records at: 2.
	self assert: rec isCall.
	self assert: rec receiver lastRecordId equals: 1.
	self assert: rec receiver uniqueId  equals: (obs records at: 1) receiver uniqueId.
	self assert: rec selector equals: #do:.
	self assert: (rec state at: #scale)  equals: 30 tg_valueReference.
	self assert: (rec locals at: #tmp)  equals: 10 tg_valueReference.	
	self assert: (rec arguments at: 1) class equals: TGBlockValue.
	
	self assert: ((obs records at: 3) locals at: #tmp)  equals: 10 tg_valueReference. "Although there's no tmp defined inside do: method, its a local from example (the place where block is created)"
	self assert: ((obs records at: 6) state at: #balance)  equals: 0 tg_valueReference. "A successful initialization when returning"
	self assert: (obs records at: 7) isReturn.
	self assert: (obs records at:7) returnValue theClass equals: TGFakeClass1.
	self assert: (obs records at: 7) returnValue lastRecordId equals: 6.
]
