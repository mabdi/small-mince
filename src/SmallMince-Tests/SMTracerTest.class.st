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
		       executableCode: [ 
			       SMFakeClass1 new
				       sum: 100;
				       sum: 10 ].
	obs run.
	self assert: obs records size equals: 3.
	self assert: obs records first class equals: SMLogRecord.
	self assert: obs records second class equals: SMLogRecord.
	self
		assert: (obs records collect: #selector)
		equals: #( initialize sum: sum: ) asOrderedCollection.
	self
		assert: ((obs records ) collect: #arguments)
		equals: (OrderedCollection new
				 add: #(  );
				 add: (Array with: 100 sm_valueReference);
				 add: (Array with: 10 sm_valueReference);
				 yourself)
]

{ #category : #tests }
SMTracerTest >> testTrace2 [

	| obs rec |
	obs := SMTracer new
		       captureTargets: { 
				       SMFakeClass1.
				       SMFakeClass2.
				       SMFakeClass3 };
		       executableCode: [ SMFakeClass3 new example ].
	obs run.
	rec := obs records at: 1.
	self assert: rec isReturn.
	self assert: rec receiver theClass equals: SMFakeClass1.
	self assert: rec receiver version equals: 0.
	self assert: rec selector equals: #initialize.
	self assert: (rec state at: #balance) class equals: SMNullValue.
	self
		assert: (rec stateAfter at: #balance)
		equals: 0 sm_valueReference.
	self assertEmpty: rec arguments.
	self assertEmpty: rec argsAfter.

	rec := obs records at: 2.
	self assert: rec receiver theClass equals: SMFakeClass1.
	self assert: rec receiver version equals: 1.
	self assert: rec selector equals: #sum:.
	self assert: (rec state at: #balance) equals: 0 sm_valueReference.
	self
		assert: (rec stateAfter at: #balance)
		equals: 50 sm_valueReference.
	self assert: rec arguments first equals: 50 sm_valueReference.
	self assert: rec argsAfter first equals: 50 sm_valueReference.

	rec := obs records at: 6.
	self assert: rec receiver theClass equals: SMFakeClass1.
	self assert: rec receiver version equals: 2.
	self assert: rec selector equals: #balance.
	self assert: rec returnValue equals: 60 sm_valueReference.

	rec := obs records at: 7.
	self assert: rec receiver theClass equals: SMFakeClass2.
	self assert: rec selector equals: #run.
	self assert: rec receiver version equals: 0.
	self assert: rec returnValue equals: 110 sm_valueReference.



	rec := obs records at: 8.
	self assert: rec receiver theClass equals: SMFakeClass3.
	self assert: rec selector equals: #example.
	self assert: rec receiver version equals: 0.
	self assert: (rec state includesKey: #scale).
	self deny: (rec state includesKey: SMTracer state_variable_name).
	self assert: (rec state at: #scale) class equals: SMNullValue.
	self assert: rec isReturn.
	self assert: (rec stateAfter at: #scale) equals: 30 sm_valueReference.
	
]

{ #category : #tests }
SMTracerTest >> testTraceException [
	| obs rec |
	obs := SMTracer new
		captureTargets: {SMFakeClassException};
		executableCode: [ SMFakeClassException runExample ].
	obs run.
	rec := obs records.
	self assert: rec size equals: 2.
	self assert: rec first isReturn.
	self assert: rec second isException.
	self assert: (rec second) exception theClass equals: Error.
	self assert: (rec second) exception errorMessage equals: 'something bad'.
	
]
