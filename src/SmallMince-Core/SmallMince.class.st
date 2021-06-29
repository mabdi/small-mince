Class {
	#name : #SmallMince,
	#superclass : #Object,
	#traits : 'SMInternalClassesTrait',
	#classTraits : 'SMInternalClassesTrait classTrait',
	#instVars : [
		'executableCode',
		'classesToObserve',
		'classesUnderTest',
		'strategy'
	],
	#category : #'SmallMince-Core-0.Core'
}

{ #category : #examples }
SmallMince class >> example1 [ 
	SmallMince new
		classesToObserve:
			{SMFakeClass1.
			SMFakeClass2.
			SMFakeClass3};
		classesUnderTest: { SMFakeClass2 };
		executableCode: [ SMFakeClass3 new example ];
		strategy: SMMethodBasedFocusedTestsStrategy new;
		run
]

{ #category : #accessing }
SmallMince >> classesToObserve [
	^ classesToObserve
]

{ #category : #accessing }
SmallMince >> classesToObserve: anObject [
	classesToObserve := anObject
]

{ #category : #accessing }
SmallMince >> classesUnderTest [
	^ classesUnderTest
]

{ #category : #accessing }
SmallMince >> classesUnderTest: anObject [
	classesUnderTest := anObject
]

{ #category : #accessing }
SmallMince >> executableCode [
	^ executableCode
]

{ #category : #accessing }
SmallMince >> executableCode: anObject [
	executableCode := anObject
]

{ #category : #running }
SmallMince >> run [
	| traces testMethodModels generatedTests | 
	traces := SMTracer new
		captureTargets: self classesToObserve;
		executableCode: self executableCode;
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
			SMTestClassBuilder new buildFor: key methods: value ].
]

{ #category : #accessing }
SmallMince >> strategy [
	^ strategy
]

{ #category : #accessing }
SmallMince >> strategy: anObject [
	strategy := anObject
]
