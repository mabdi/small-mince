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
	#category : #'TestGrinder-0.Core'
}

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
		sampleCode: executableCode;
		run.
	testMethodModels := self strategy 
		traces: traces;
		classesUnderTest: self classesUnderTest; 
		buildTestMethods.
	generatedTests := testMethodModels collect: [ :testModel | 
		testModel synthesisBy: self strategy synthesizer ].
	generatedTests keysAndValuesDo: [ :key :value | 
			TGTestClassBuilder new buildFor: key methods: value ].
	TGTestClassBuilder new defaultTempPackage asPackage browse.
	traces inspect
]

{ #category : #accessing }
TestGrinder >> strategy [
	^ strategy
]

{ #category : #accessing }
TestGrinder >> strategy: anObject [
	strategy := anObject
]
