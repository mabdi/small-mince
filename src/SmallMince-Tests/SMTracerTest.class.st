"
A TGObserverTest is a test class for testing the behavior of TGObserver
"
Class {
	#name : #SMTracerTest,
	#superclass : #TestCase,
	#category : #'SmallMince-Tests-1.Tracer'
}

{ #category : #tests }
SMTracerTest >> testTrace1 [
	| obs |
	obs := SMTracer new 
		
		captureTargets: { SMFakeClass1 };
		executableCode: [SMFakeClass1 new sum: 100; sum: 10].
	obs run.
	self assert: obs records size equals: 6.
	self assert: obs records first class equals: SMCallLogRecord.
	self assert: obs records second class equals: SMReturnLogRecord.
	self assert: ((obs records select: #isCall) collect: #selector) equals: #(initialize sum: sum:) asOrderedCollection.
	self assert: ((obs records select: #isCall) collect: #arguments) equals: (OrderedCollection new add: #();add: (Array with: 100 sm_valueReference) ;add: (Array with: 10 sm_valueReference) ;yourself).
	
]

{ #category : #tests }
SMTracerTest >> testTrace2 [
	| obs rec |
	obs := SMTracer new
		captureTargets:
			{SMFakeClass1.
			SMFakeClass2.
			SMFakeClass3};
		executableCode: [ SMFakeClass3 new example ].
	obs run.
	rec := obs records at: 1.
	self assert: rec isCall.
	self assert: rec receiver theClass equals: SMFakeClass3.
	self assert: rec receiver lastRecordId equals: -1.
	self assert: rec selector equals: #example.
	self assert: (rec state includesKey: #scale).
	self deny: (rec state includesKey: SMTracer state_variable_name).
	self assert: (rec state at: #scale) class equals: SMNullValue.
	self assert: (rec locals at: #obs) class equals: SMSkippedValue.
	rec := obs records at: 16.
	self assert: rec isReturn.
	self assert: rec receiver lastRecordId equals: 1.
	self
		assert: rec receiver uniqueId
		equals: (obs records at: 1) receiver uniqueId.
	self assert: rec selector equals: #example.
	self assert: (rec state at: #scale) equals: 30 sm_valueReference.
	self
		assert: ((obs records at: 2) locals at: #tmp)
		equals: 10 sm_valueReference.	"Although there's no tmp defined inside do: method, its a local from example (the place where block is created)"
	self
		assert: ((obs records at: 6) state at: #balance)
		equals: 50 sm_valueReference.	"A successful initialization when returning"
	self assert: (obs records at: 8) isReturn.
	self
		assert: (obs records at: 8) returnValue theClass
		equals: SMFakeClass1.
	self assert: (obs records at: 8) returnValue lastRecordId equals: 7
]
