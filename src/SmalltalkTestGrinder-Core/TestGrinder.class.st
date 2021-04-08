Class {
	#name : #TestGrinder,
	#superclass : #Object,
	#traits : 'TGInternalClassesTrait',
	#classTraits : 'TGInternalClassesTrait classTrait',
	#instVars : [
		'executableCode',
		'classesToObserve',
		'classesUnderTest',
		'strategy'
	],
	#category : #'SmalltalkTestGrinder-Core-0.Core'
}

{ #category : #examples }
TestGrinder class >> example1 [ 
	TestGrinder new
		classesToObserve:
			{TGFakeClass1.
			TGFakeClass2.
			TGFakeClass3};
		classesUnderTest: { TGFakeClass2 };
		executableCode: [ TGFakeClass3 new example ];
		strategy: TGMethodBasedFocusedTestsStrategy new;
		run
]

{ #category : #accessing }
TestGrinder >> classesToObserve [
	^ classesToObserve
]

{ #category : #accessing }
TestGrinder >> classesToObserve: anObject [
	classesToObserve := anObject
]

{ #category : #accessing }
TestGrinder >> classesUnderTest [
	^ classesUnderTest
]

{ #category : #accessing }
TestGrinder >> classesUnderTest: anObject [
	classesUnderTest := anObject
]

{ #category : #accessing }
TestGrinder >> executableCode [
	^ executableCode
]

{ #category : #accessing }
TestGrinder >> executableCode: anObject [
	executableCode := anObject
]

{ #category : #running }
TestGrinder >> run [
	| traces testMethodModels generatedTests | 
	traces := TGTracer new
		captureTargets: classesToObserve;
		executableCode: executableCode;
		run;
		records.
	testMethodModels := self strategy 
		traces: traces;
		classesUnderTest: self classesUnderTest; 
		run.
	generatedTests := Dictionary new.
	testMethodModels keysAndValuesDo: [:className :arrayOfMethods | 
		generatedTests at: className put: (arrayOfMethods collect: [:methodModel |
				methodModel synthesisBy: self strategy synthesizer	
			])
		].
	generatedTests keysAndValuesDo: [ :key :value | 
			TGTestClassBuilder new buildFor: key methods: value ].
]

{ #category : #accessing }
TestGrinder >> strategy [
	^ strategy
]

{ #category : #accessing }
TestGrinder >> strategy: anObject [
	strategy := anObject
]
