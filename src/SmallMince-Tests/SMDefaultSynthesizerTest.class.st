"
A TGDefaultSynthesizerTest is a test class for testing the behavior of TGDefaultSynthesizer
"
Class {
	#name : #SMDefaultSynthesizerTest,
	#superclass : #TestCase,
	#category : #'SmallMince-Tests-4.Synthesis'
}

{ #category : #'as yet unclassified' }
SMDefaultSynthesizerTest >> getSynthesizer [
	^ SMDefaultSynthesizer new
]

{ #category : #tests }
SMDefaultSynthesizerTest >> testBlock [
	| res expected value y |
	y := 0.
	value := [ :x | x + y + 1 ].
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
	self assert: res  equals: expected
]

{ #category : #tests }
SMDefaultSynthesizerTest >> testDictionaryDependency [
	| res expected value dep1 dep2 |
	dep1 := OrderedCollection with: #hey with: #hoy.
	dep2 := Dictionary new
		at: #hey put: #hoy;
		yourself.
	value := Dictionary new
		at: #slot1 put: 1;
		at: #slot2 put: dep1;
		at: #slot3 put: dep2;
		yourself.
	res := value sm_valueReference synthesisBy: self getSynthesizer.
	expected := RBParser
		parseExpression:
			'tmp_1 := Dictionary new.
tmp_1 at: #slot1 put: 1.
tmp_2 := OrderedCollection new.
tmp_2 add: #hey.
tmp_2 add: #hoy.
tmp_1 at: #slot2 put: tmp_2.
tmp_3 := Dictionary new.
tmp_3 at: #hey put: #hoy.
tmp_1 at: #slot3 put: tmp_3.
tmp_1'.
	self assert: res equals: expected
]

{ #category : #tests }
SMDefaultSynthesizerTest >> testDictionaryEmpty [
	| res expected value |
	value := Dictionary new.
	res := value sm_valueReference synthesisBy: self getSynthesizer.
	expected := RBParser parseExpression: 'Dictionary new'.
	self assert: res first equals: expected
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
	expected := RBParser parseExpression: 'tmp_1 := Dictionary new.
tmp_1 at: #slot1 put: 1.
tmp_1 at: #slot2 put: true.
tmp_1 at: #slot3 put: nil.
tmp_1 at: #slot4 put: ''sss''.
tmp_1'.
	self assert: res equals: expected
]

{ #category : #tests }
SMDefaultSynthesizerTest >> testFakeHttp [

	| value res expected1 expected2 obs records nameMapping synthesizer |
	obs := SMTracer new
		       captureTargets: { 
				       SMFakeHttpAgent.
				       SMFakeMethod.
				       SMFakeProtocol.
				       SMFakeUrl };
		       executableCode: [ SMFakeHttpAgent runExample ].
	obs run.
	records := obs records.
	nameMapping := Dictionary new.
	nameMapping
		at:
		(records keys detect: [ :r | r theClass = SMFakeHttpAgent ])
			uniqueId
		put: 'var_1'.
	nameMapping
		at: (records keys detect: [ :r | r theClass = SMFakeUrl ]) uniqueId
		put: 'var_2'.
	nameMapping
		at:
		(records keys detect: [ :r | r theClass = SMFakeMethod ]) uniqueId
		put: 'var_3'.
	nameMapping
		at:
		(records keys detect: [ :r | r theClass = SMFakeProtocol ]) uniqueId
		put: 'var_4'.

	value := SMDependencyBasedTestTransplantation new
		         traces: obs records;
		         links: obs links;
		         slicingCriteria: [ :traces | 
			         (traces associationsSelect: [ :kvp | 
					          kvp key theClass = SMFakeHttpAgent ]) collect: [ 
					         :history | history last ] ];
		         run.
	value := value anyOne first.


	synthesizer := self getSynthesizer.
	synthesizer varNameMapper: nameMapping.
	res := value synthesisBy: synthesizer.
	expected1 := RBParser parseMethod: 'test1
	| var_2 var_4 var_3 var_1 |
	var_2 := SMFakeUrl new.
	var_2 url: ''google.com''.
	var_4 := SMFakeProtocol new.
	var_4 protocol: ''https''.
	var_2 protocol: var_4.
	var_3 := SMFakeMethod new.
	var_3 method: #GET.
	var_1 := SMFakeHttpAgent new.
	var_1 url: var_2.
	var_1 method: var_3.
	var_1 execute'.
	expected2 := RBParser parseMethod: 'test1
	| var_4 var_3 var_1 var_2 |
	var_4 := SMFakeProtocol new.
	var_4 protocol: ''https''.
	var_3 := SMFakeMethod new.
	var_3 method: #GET.
	var_1 := SMFakeHttpAgent new.
	var_2 := SMFakeUrl new.
	var_2 url: ''google.com''.
	var_2 protocol: var_4.
	var_1 url: var_2.
	var_1 method: var_3.
	var_1 execute'.
	self flag: #todo. "find a better way to assert the correct answer"
	self assert: res = expected1 | (res = expected2)
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
	value := 1 / 2.
	res := value sm_valueReference synthesisBy: self getSynthesizer.
	expected := RBParser parseExpression: '1/2'.
	self assert: res  equals: expected
]

{ #category : #tests }
SMDefaultSynthesizerTest >> testInteger [
	| res expected |
	res := 10 sm_valueReference synthesisBy: self getSynthesizer.
	expected := RBParser parseExpression: '10'.
	self assert: res  equals: expected
]

{ #category : #tests }
SMDefaultSynthesizerTest >> testListDependency [
	| res expected value dep |
	dep := OrderedCollection 
		with: #hi with: #hoy
		.
	value := OrderedCollection with: 10 with: dep.
	res := value sm_valueReference synthesisBy: self getSynthesizer.
	expected := RBParser
		parseExpression:
			'tmp_1 := OrderedCollection new.
tmp_1 add: 10.
tmp_2 := OrderedCollection new.
tmp_2 add: #hi.
tmp_2 add: #hoy.
tmp_1 add: tmp_2.
tmp_1'.
	self assert: res equals: expected
]

{ #category : #tests }
SMDefaultSynthesizerTest >> testListEmpty [
	| res expected value |
	value := OrderedCollection new.
	res := value sm_valueReference synthesisBy: self getSynthesizer.
	expected := RBParser parseExpression: 'OrderedCollection new'.
	self assert: res  equals: expected.
	value := Set new.
	res := value sm_valueReference synthesisBy: self getSynthesizer.
	expected := RBParser parseExpression: 'Set new'.
	self assert: res  equals: expected.
	value := Array new.
	res := value sm_valueReference synthesisBy: self getSynthesizer.
	expected := RBParser parseExpression: 'Array new'.
	self assert: res  equals: expected
]

{ #category : #tests }
SMDefaultSynthesizerTest >> testListPrimitive [
	| res expected value |
	value := OrderedCollection with: 10 with: 29 with: true.
	res := value sm_valueReference synthesisBy: self getSynthesizer.
	expected := RBParser
		parseExpression:
			'tmp_1 := OrderedCollection new.tmp_1 add: 10.tmp_1 add: 29.tmp_1 add: true.
		tmp_1'.
	self assert: res equals: expected.
	value := {45 . false} asSet.
	res := value sm_valueReference synthesisBy: self getSynthesizer.
	expected := {(RBParser
		parseExpression: 'tmp_1 := Set new.tmp_1 add: false.tmp_1 add: 45. tmp_1').
	(RBParser
		parseExpression: 'tmp_1:= Set new.tmp_1 add: 45.tmp_1 add: false. tmp_1')}.
	self assert: (expected includes: res).
	value := {10 . 11 . 12 . 13}.
	res := value sm_valueReference synthesisBy: self getSynthesizer.
	expected := RBParser
		parseExpression:
			'tmp_1 := Array new. tmp_1 add: 10. tmp_1 add: 11.tmp_1 add:12.tmp_1 add:13.tmp_1'.
	self assert: res  equals: expected.
	value := #(10 11 12 13).
	res := value sm_valueReference synthesisBy: self getSynthesizer.
	expected := RBParser
		parseExpression: 'tmp_1 := Array new. tmp_1 add: 10.tmp_1 add: 11.tmp_1 add:12.tmp_1 add:13. tmp_1'.
	self assert: res  equals: expected
]

{ #category : #tests }
SMDefaultSynthesizerTest >> testMethod [

	| value res expected ev list receiver nameMapping synthesizer |
	receiver := SMFakeClass1 new.
	ev := SMLogRecord new.
	ev receiver: receiver.
	ev selector: #sum:.
	ev arguments: { 10 }.
	list := OrderedCollection
		        with: { 
				        #event.
				        ev }
		        with: { 
				        #new.
				        receiver sm_valueReference }.
		nameMapping := Dictionary new.
nameMapping at: receiver sm_valueReference uniqueId put: 'var_100'.
	value := (SMTestMethod from: list) methodName: #testTest.
	synthesizer := self getSynthesizer.
	synthesizer varNameMapper: nameMapping.

	res := value synthesisBy: synthesizer.
	expected := RBParser parseMethod: 'testTest
	| var_100 |
	var_100 := SMFakeClass1 new.
	var_100 sum: 10'.
	self assert: res equals: expected
]

{ #category : #tests }
SMDefaultSynthesizerTest >> testMethodException [

	| value res expected obs rec records comp list ev |
	obs := SMTracer new
		       captureTargets: { SMFakeClassException };
		       executableCode: [ SMFakeClassException runExample ].
	obs run.
	records := obs records anyOne.
	records do: [ :r | r receiver uniqueId: 201 ].

	list := { 
		        { 
			        #event.
			        records second }.
		        { 
			        #event.
			        records first }.
		        { 
			        #new.
			        records first receiver } }.
	value := (SMTestMethod from: list) methodName: #testTest.

	res := value synthesisBy: self getSynthesizer.
	expected := RBParser parseMethod: 'testTest
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
	self assert: res  equals: expected
]

{ #category : #tests }
SMDefaultSynthesizerTest >> testPoint [

	| res expected |
	res := (2@1) sm_valueReference synthesisBy: self getSynthesizer.
	expected := RBParser parseExpression: '2@1'.
	self assert: res equals: expected
]

{ #category : #tests }
SMDefaultSynthesizerTest >> testSkipped [
	| value res expected |
	value := 10 @ 20 corner: 20 @ 20.
	res := value sm_valueReference synthesisBy: self getSynthesizer.
	expected := RBParser parseExpression: 'Rectangle new'.
	self assert: res  equals: expected
]

{ #category : #tests }
SMDefaultSynthesizerTest >> testString [
	| res expected |
	res := 'jjj' sm_valueReference synthesisBy: self getSynthesizer.
	expected := RBParser parseExpression: '''jjj'''.
	self assert: res  equals: expected
]
