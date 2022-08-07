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

	| obs history |
	obs := SMTracer new
		       captureTargets: { SMFakeClass1 };
		       executableCode: [ 
			       SMFakeClass1 new
				       sum: 100;
				       sum: 10 ].
	obs run.
	self assert: obs records size equals: 1.
	history := obs records at: obs records keys first.
	self assert: history size equals: 3.
	self assert: history first class equals: SMLogRecord.
	self assert: history second class equals: SMLogRecord.
	self
		assert: (history collect: #selector)
		equals: #( initialize sum: sum: ) asOrderedCollection.
	self
		assert: (history collect: #arguments)
		equals: (OrderedCollection new
				 add: #(  );
				 add: (Array with: 100 sm_valueReference);
				 add: (Array with: 10 sm_valueReference);
				 yourself)
]

{ #category : #tests }
SMTracerTest >> testTrace2 [

	| obs rec historySMFakeClass1 historySMFakeClass2 historySMFakeClass3 |
	obs := SMTracer new
		       captureTargets: { 
				       SMFakeClass1.
				       SMFakeClass2.
				       SMFakeClass3 };
		       executableCode: [ SMFakeClass3 new example ].
	obs run.
	historySMFakeClass1 := obs records at:
		                       (obs records keys select: [ :index | 
			                        index theClass = SMFakeClass1 ]) first.

	rec := historySMFakeClass1 at: 1.
	self assert: rec isReturn.
	self assert: rec receiver theClass equals: SMFakeClass1.
	self assert: rec receiver version equals: 1.
	self assert: rec selector equals: #initialize.
	self assert: (rec state at: #balance) class equals: SMNullValue.
	self
		assert: (rec stateAfter at: #balance)
		equals: 0 sm_valueReference.
	self assertEmpty: rec arguments.
	self assertEmpty: rec argsAfter.

	rec := historySMFakeClass1 at: 2.
	self assert: rec receiver theClass equals: SMFakeClass1.
	self assert: rec receiver version equals: 2.
	self assert: rec selector equals: #sum:.
	self assert: (rec state at: #balance) equals: 0 sm_valueReference.
	self assert: ({ 
			 50 sm_valueReference.
			 60 sm_valueReference } includes: (rec stateAfter at: #balance)).
	self assert: ({ 
			 50 sm_valueReference.
			 60 sm_valueReference } includes: rec arguments first).
	self assert: ({ 
			 50 sm_valueReference.
			 60 sm_valueReference } includes: rec argsAfter first).
	historySMFakeClass1 := obs records at:
		                       (obs records keys select: [ :index | 
			                        index theClass = SMFakeClass1 ]) second.
	rec := historySMFakeClass1 at: 3.
	self assert: rec receiver theClass equals: SMFakeClass1.
	self assert: rec receiver version equals: 3.
	self assert: rec selector equals: #balance.
	self assert: ({ 
			 50 sm_valueReference.
			 60 sm_valueReference } includes: rec returnValue).
	historySMFakeClass2 := obs records at:
		                       (obs records keys select: [ :index | 
			                        index theClass = SMFakeClass2 ]) first.
	rec := historySMFakeClass2 at: 1.
	self assert: rec receiver theClass equals: SMFakeClass2.
	self assert: rec selector equals: #run.
	self assert: rec receiver version equals: 1.
	self assert: rec returnValue equals: 110 sm_valueReference.

	historySMFakeClass3 := obs records at:
		                       (obs records keys select: [ :index | 
			                        index theClass = SMFakeClass3 ]) first.

	rec := historySMFakeClass3 at: 1.
	self assert: rec receiver theClass equals: SMFakeClass3.
	self assert: rec selector equals: #example.
	self assert: rec receiver version equals: 1.
	self assert: (rec state includesKey: #scale).
	self deny: (rec state includesKey: SMTracer state_variable_name).
	self assert: (rec state at: #scale) class equals: SMNullValue.
	self assert: rec isReturn.
	self assert: (rec stateAfter at: #scale) equals: 30 sm_valueReference
]

{ #category : #tests }
SMTracerTest >> testTrace3 [

	| obs objO objA objR objX objY objZ objD |
	obs := SMTracer new
		       captureTargets: { 
				       SMDriver.
				       SMClassA.
				       SMClassO.
				       SMClassX.
				       SMClassY.
				       SMClassZ.
				       SMClassR };
		       executableCode: [ SMDriverTest run: #test1 ].
	obs run.
	objO := obs records at:
		        (obs records keys select: [ :index | 
			         index theClass = SMClassO ]) first.

	objR := obs records at:
		        (obs records keys select: [ :index | 
			         index theClass = SMClassR ]) first.
	objX := obs records at:
		        (obs records keys select: [ :index | 
			         index theClass = SMClassX ]) first.
	objY := obs records at:
		        (obs records keys select: [ :index | 
			         index theClass = SMClassY ]) first.
	objZ := obs records at:
		        (obs records keys select: [ :index | 
			         index theClass = SMClassZ ]) first.
	objD := obs records at:
		        (obs records keys select: [ :index | 
			         index theClass = SMDriver ]) first.
	self assert: objD size equals: 3.
	self assert: objO size equals: 3.
	self assert: objR size equals: 1.
	self assert: objX size equals: 2.
	self assert: objY size equals: 1.
	self assert: objZ size equals: 1.
	self
		assert:
		(obs records keys select: [ :index | index theClass = SMClassA ])
			size
		equals: 0.

	self assert: objD first returnValue version equals: 2.
	self assert: objD third arguments first version equals: 4.
	self assert: objO first arguments first version equals: 1.
	self assert: objO first arguments second version equals: 1.
	self assert: objO first argsAfter second version equals: 3.
	self assert: objO second returnValue version equals: 2.
	self assert: objX second arguments first version equals: 1.
	self assert: objX second argsAfter first version equals: 2.
	self assert: objY first arguments first version equals: 2.
]

{ #category : #tests }
SMTracerTest >> testTraceException [

	| obs rec history |
	obs := SMTracer new
		       captureTargets: { SMFakeClassException };
		       executableCode: [ SMFakeClassException runExample ].
	obs run.
	self assert: obs records size equals: 1.
	history := obs records at: obs records keys first.
	
	self assert: history size equals: 2.
	self assert: history first isReturn.
	self assert: history second isException.
	self assert: history second exception theClass equals: Error.
	self
		assert: history second exception errorMessage
		equals: 'something bad'
]
