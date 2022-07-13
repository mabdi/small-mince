Class {
	#name : #SmallMince,
	#superclass : #Object,
	#traits : 'SMInternalClassesTrait',
	#classTraits : 'SMInternalClassesTrait classTrait',
	#instVars : [
		'executableCode',
		'classesToObserve',
		'strategy',
		'slicingCriteria'
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

{ #category : #examples }
SmallMince class >> exampleMario [

	SmallMince new
		classesToObserve: 'SmallMince-ToyExample' asPackage classes;
		slicingCriteria: [:record | record ];
		executableCode: [ (SMEXMarioGameTest selector: #testRuns) run ];
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
	testMethodModels := SMDependencyBasedTestTransplantation new
		                    traces: traces;
		                    slicingCriteria: self slicingCriteria;
		                    run.
	generatedTests := Dictionary new.
	testMethodModels keysAndValuesDo: [ :className :arrayOfMethods | 
		generatedTests
			at: className
			put: (arrayOfMethods collect: [ :methodModel | 
					 methodModel synthesisBy: SMDefaultSynthesizer new ]) ].
	generatedTests keysAndValuesDo: [ :key :value | 
		SMTestClassBuilder new buildFor: key methods: value ]
]

{ #category : #accessing }
SmallMince >> slicingCriteria [

	^ slicingCriteria
]

{ #category : #accessing }
SmallMince >> slicingCriteria: anObject [

	slicingCriteria := anObject
]
