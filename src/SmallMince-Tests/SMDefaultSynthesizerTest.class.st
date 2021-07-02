"
A TGDefaultSynthesizerTest is a test class for testing the behavior of TGDefaultSynthesizer
"
Class {
	#name : #SMDefaultSynthesizerTest,
	#superclass : #TestCase,
	#category : #'SmallMince-Tests-4.Synthesis'
}

{ #category : #'as yet unclassified' }
SMDefaultSynthesizerTest >> genEvent1 [
	| ev |
	ev := SMObjectReturnEvent new.
	ev selector: #sum:.
	ev stateBefore: {}.
	ev stateAfter: {}.
	ev argsBefore: {10 sm_valueReference}.
	ev argsAfter: {}.
	^ ev
]

{ #category : #'as yet unclassified' }
SMDefaultSynthesizerTest >> genEvent2 [
	| evs ev objRef |
	objRef := SMObjectReference new
		theClass: SMFakeClass1;
		lastRecordId: -1;
		uniqueId: 99;
		yourself.
	evs := OrderedCollection new.
	ev := SMObjectReturnEvent new.
	ev selector: #addHundred:.
	ev stateBefore: {}.
	ev stateAfter: {}.
	ev argsBefore: {objRef}.
	ev argsAfter: {}.
	evs add: ev.
	^ evs
]

{ #category : #'as yet unclassified' }
SMDefaultSynthesizerTest >> genHistory [
	| obj objRef |
	objRef := SMObjectReference new 
		theClass: SMFakeClass1;
		lastRecordId: -1; 
		uniqueId: 100; 
		yourself.
	obj := SMObjectHistory new objectReference: objRef.
	obj addEvent: self genEvent1.
	^ obj
]

{ #category : #'as yet unclassified' }
SMDefaultSynthesizerTest >> genHistory2 [
	| obj objRef |
	objRef := SMObjectReference new 
		theClass: SMFakeClass2;
		lastRecordId: -1; 
		uniqueId: 10; 
		yourself.
	obj := SMObjectHistory new objectReference: objRef.
	self genEvent2 do: [:ev | obj addEvent: ev].
	^ obj
]

{ #category : #'as yet unclassified' }
SMDefaultSynthesizerTest >> getSynthesizer [
	^ SMDefaultSynthesizer new
]

{ #category : #tests }
SMDefaultSynthesizerTest >> testBlock [
	| res expected value y |
	y := 0.
	value := [ :x | x + y + 1].
	res := value sm_valueReference synthesisBy: self getSynthesizer.
	expected := RBParser parseExpression: '[ :x | x + y + 1]'.
	self assert: res equals: expected
]

{ #category : #tests }
SMDefaultSynthesizerTest >> testBoolean [
	| res expected |
	res := true sm_valueReference synthesisBy: self getSynthesizer.
	expected := RBParser parseExpression: 'true'.
	self assert: res equals: expected
]

{ #category : #tests }
SMDefaultSynthesizerTest >> testClass [
	| res expected value |
	value := self class.
	res := value sm_valueReference synthesisBy: self getSynthesizer.
	expected := RBParser parseExpression: self class name.
	self assert: res equals: expected
]

{ #category : #tests }
SMDefaultSynthesizerTest >> testDictionaryEmpty [ 
	| res expected value |
	value := Dictionary new.
	res := value sm_valueReference synthesisBy: self getSynthesizer.
	expected := RBParser parseExpression: 'Dictionary new'.
	self assert: res equals: expected
]

{ #category : #tests }
SMDefaultSynthesizerTest >> testDictionaryPrimitive [ 
	| res expected value |
	value := Dictionary new
		at: #slot1 put: 1;
		at: #slot2 put: true;
		at: #slot3 put: nil;
		at: #slot4 put: 'sss';
		yourself.
	res := value sm_valueReference synthesisBy: self getSynthesizer.
	expected := RBParser parseExpression: 'Dictionary new
		at: #slot1 put: 1;
		at: #slot2 put: true;
		at: #slot3 put: nil;
		at: #slot4 put: ''sss'';
		yourself'.
	self assert: res equals: expected
]

{ #category : #tests }
SMDefaultSynthesizerTest >> testFloat [
	| res expected |
	res := 3.14 sm_valueReference synthesisBy: self getSynthesizer.
	expected := RBParser parseExpression: '3.14'.
	self assert: res equals: expected
]

{ #category : #tests }
SMDefaultSynthesizerTest >> testFraction [
	| res expected value |
	value := 1/2.
	res := value sm_valueReference synthesisBy: self getSynthesizer.
	expected := RBParser parseExpression: '1/2'.
	self assert: res equals: expected
]

{ #category : #tests }
SMDefaultSynthesizerTest >> testHistory [
	| value res expected |
	value := self genHistory.
	res := value synthesisBy: self getSynthesizer.
	expected := (RBParser parseExpression: 'var_100 := SMFakeClass1 new. var_100 sum: 10') statements.
	self assert: res equals: expected
]

{ #category : #tests }
SMDefaultSynthesizerTest >> testHistoryDependent [
	| value res expected |
	value := self genHistory2.
	res := value synthesisBy: self getSynthesizer.
	expected := (RBParser parseExpression: 'var_10 := SMFakeClass2 new. var_10 addHundred: var_99') statements.
	self assert: res equals: expected
]

{ #category : #tests }
SMDefaultSynthesizerTest >> testInteger [ 
	| res expected |
	res := 10 sm_valueReference synthesisBy: self getSynthesizer.
	expected := RBParser parseExpression: '10'.
	self assert: res equals: expected
]

{ #category : #tests }
SMDefaultSynthesizerTest >> testListEmpty [ 
	| res expected value |
	value := OrderedCollection new.
	res := value sm_valueReference synthesisBy: self getSynthesizer.
	expected := RBParser parseExpression: 'OrderedCollection new'.
	self assert: res equals: expected.
	
	value := Set new.
	res := value sm_valueReference synthesisBy: self getSynthesizer.
	expected := RBParser parseExpression: 'Set new'.
	self assert: res equals: expected.
	
	value := Array new.
	res := value sm_valueReference synthesisBy: self getSynthesizer.
	expected := RBParser parseExpression: 'Array new'.
	self assert: res equals: expected
	
]

{ #category : #tests }
SMDefaultSynthesizerTest >> testListPrimitive [ 
	| res expected value |
	value := OrderedCollection with: 10 with: 29 with: true.
	res := value sm_valueReference synthesisBy: self getSynthesizer.
	expected := RBParser parseExpression: 'OrderedCollection new add: 10; add: 29; add: true; yourself'.
	self assert: res equals: expected.
	
	value := {45. false} asSet.
	res := value sm_valueReference synthesisBy: self getSynthesizer.
	expected := { RBParser parseExpression: 'Set new add: false; add: 45; yourself'. 
		RBParser parseExpression: 'Set new add: 45; add: false; yourself'}.
	self assert: (expected includes: res).
	
	value := {10. 11. 12. 13}.
	res := value sm_valueReference synthesisBy: self getSynthesizer.
	expected := RBParser parseExpression: 'Array new add: 10; add: 11; add:12; add:13; yourself'.
	self assert: res equals: expected.
	
	value := #(10 11 12 13).
	res := value sm_valueReference synthesisBy: self getSynthesizer.
	expected := RBParser parseExpression: 'Array new add: 10; add: 11; add:12; add:13; yourself'.
	self assert: res equals: expected
		
]

{ #category : #tests }
SMDefaultSynthesizerTest >> testMethod [
	| value res expected |
	value := SMTestMethod new 
		methodName: #testTest; 
		objectUnderTest: self genHistory.
	res := value synthesisBy: self getSynthesizer.
	expected := (RBParser parseMethod: 'testTest
	| var_100 |
	var_100 := SMFakeClass1 new.
	var_100 sum: 10').
	self assert: res equals: expected
]

{ #category : #tests }
SMDefaultSynthesizerTest >> testMethodException [
	| value res expected obs rec records comp |
	obs := SMTracer new
		captureTargets: {SMFakeClassException};
		executableCode: [ SMFakeClassException runExample ].
	obs run.
	records := obs records.
	records do: [ :r | r receiver uniqueId: 201 ].
	comp := SMObjectHistoryComposer new
		theClass: SMFakeClassException;
		records: records.
	comp run.
	value := SMTestMethod new
		methodName: #testTest;
		objectUnderTest: comp objectHistories asOrderedCollection first.
	res := value synthesisBy: self getSynthesizer.
	expected := RBParser
		parseMethod:
			'testTest
	| var_201 |
	var_201 := SMFakeClassException new.
	var_201 notRaiseAnError.
	[ var_201 raiseAnError ] on: Error do: [:sm_error | ]'.
	self assert: res equals: expected
]

{ #category : #tests }
SMDefaultSynthesizerTest >> testNull [ 
	| res expected |
	res := nil sm_valueReference synthesisBy: self getSynthesizer.
	expected := RBParser parseExpression: 'nil'.
	self assert: res equals: expected
]

{ #category : #tests }
SMDefaultSynthesizerTest >> testSkipped [ 
	| value res expected |
	value := 10 @ 20 corner: 20 @ 20.
	res := value sm_valueReference synthesisBy: self getSynthesizer.
	expected := RBParser parseExpression: 'Rectangle new'.
	self assert: res equals: expected
]

{ #category : #tests }
SMDefaultSynthesizerTest >> testString [
	| res expected |
	res := 'jjj' sm_valueReference synthesisBy: self getSynthesizer.
	expected := RBParser parseExpression: '''jjj'''.
	self assert: res equals: expected
]
