"
A TGDefaultSynthesizerTest is a test class for testing the behavior of TGDefaultSynthesizer
"
Class {
	#name : #TGDefaultSynthesizerTest,
	#superclass : #TestCase,
	#category : #'TestGrinder-Tests-4.Synthesis'
}

{ #category : #'as yet unclassified' }
TGDefaultSynthesizerTest >> genEvent1 [
	| ev |
	ev := TGObjectEvent new.
	ev selector: #sum:.
	ev stateBefore: {  }.
	ev stateAfter: {  }.
	ev argsBefore: { 10 tg_valueReference }.
	ev argsAfter: {  }.
	^ ev
]

{ #category : #'as yet unclassified' }
TGDefaultSynthesizerTest >> genEvent2 [
	| evs ev objRef |
	objRef := TGObjectReference new 
		theClass: TGFakeClass1;
		lastRecordId: -1; 
		uniqueId: 99; 
		yourself.
	evs := OrderedCollection new.
	ev := TGObjectEvent new.
	ev selector: #addHundred:.
	ev stateBefore: {  }.
	ev stateAfter: {  }.
	ev argsBefore: { objRef }.
	ev argsAfter: {  }.
	evs add: ev.
	^ evs
]

{ #category : #'as yet unclassified' }
TGDefaultSynthesizerTest >> genHistory [
	| obj objRef |
	objRef := TGObjectReference new 
		theClass: TGFakeClass1;
		lastRecordId: -1; 
		uniqueId: 100; 
		yourself.
	obj := TGObjectHistory new objectReference: objRef.
	obj addEvent: self genEvent1.
	^ obj
]

{ #category : #'as yet unclassified' }
TGDefaultSynthesizerTest >> genHistory2 [
	| obj objRef |
	objRef := TGObjectReference new 
		theClass: TGFakeClass2;
		lastRecordId: -1; 
		uniqueId: 10; 
		yourself.
	obj := TGObjectHistory new objectReference: objRef.
	self genEvent2 do: [:ev | obj addEvent: ev].
	^ obj
]

{ #category : #'as yet unclassified' }
TGDefaultSynthesizerTest >> getSynthesizer [
	^ TGDefaultSynthesizer new
]

{ #category : #tests }
TGDefaultSynthesizerTest >> testBlock [
	| res expected value y |
	y := 0.
	value := [ :x | x + y + 1].
	res := value tg_valueReference synthesisBy: self getSynthesizer.
	expected := RBParser parseExpression: '[ :x | x + y + 1]'.
	self assert: res equals: expected
]

{ #category : #tests }
TGDefaultSynthesizerTest >> testBoolean [
	| res expected |
	res := true tg_valueReference synthesisBy: self getSynthesizer.
	expected := RBParser parseExpression: 'true'.
	self assert: res equals: expected
]

{ #category : #tests }
TGDefaultSynthesizerTest >> testClass [
	| res expected value |
	value := self class.
	res := value tg_valueReference synthesisBy: self getSynthesizer.
	expected := RBParser parseExpression: self class name.
	self assert: res equals: expected
]

{ #category : #tests }
TGDefaultSynthesizerTest >> testDictionaryEmpty [ 
	| res expected value |
	value := Dictionary new.
	res := value tg_valueReference synthesisBy: self getSynthesizer.
	expected := RBParser parseExpression: 'Dictionary new'.
	self assert: res equals: expected
]

{ #category : #tests }
TGDefaultSynthesizerTest >> testDictionaryPrimitive [ 
	| res expected value |
	value := Dictionary new
		at: #slot1 put: 1;
		at: #slot2 put: true;
		at: #slot3 put: nil;
		at: #slot4 put: 'sss';
		yourself.
	res := value tg_valueReference synthesisBy: self getSynthesizer.
	expected := RBParser parseExpression: 'Dictionary new
		at: #slot1 put: 1;
		at: #slot2 put: true;
		at: #slot3 put: nil;
		at: #slot4 put: ''sss'';
		yourself'.
	self assert: res equals: expected
]

{ #category : #tests }
TGDefaultSynthesizerTest >> testFloat [
	| res expected |
	res := 3.14 tg_valueReference synthesisBy: self getSynthesizer.
	expected := RBParser parseExpression: '3.14'.
	self assert: res equals: expected
]

{ #category : #tests }
TGDefaultSynthesizerTest >> testFraction [
	| res expected value |
	value := 1/2.
	res := value tg_valueReference synthesisBy: self getSynthesizer.
	expected := RBParser parseExpression: '1/2'.
	self assert: res equals: expected
]

{ #category : #tests }
TGDefaultSynthesizerTest >> testHistory [
	| value res expected |
	value := self genHistory.
	res := value synthesisBy: self getSynthesizer.
	expected := (RBParser parseExpression: 'var_100 := TGFakeClass1 new. var_100 sum: 10') statements.
	self assert: res equals: expected
]

{ #category : #tests }
TGDefaultSynthesizerTest >> testHistoryDependent [
	| value res expected |
	value := self genHistory2.
	res := value synthesisBy: self getSynthesizer.
	expected := (RBParser parseExpression: 'var_10 := TGFakeClass2 new. var_10 addHundred: var_99') statements.
	self assert: res equals: expected
]

{ #category : #tests }
TGDefaultSynthesizerTest >> testInteger [ 
	| res expected |
	res := 10 tg_valueReference synthesisBy: self getSynthesizer.
	expected := RBParser parseExpression: '10'.
	self assert: res equals: expected
]

{ #category : #tests }
TGDefaultSynthesizerTest >> testListEmpty [ 
	| res expected value |
	value := OrderedCollection new.
	res := value tg_valueReference synthesisBy: self getSynthesizer.
	expected := RBParser parseExpression: 'OrderedCollection new'.
	self assert: res equals: expected.
	
	value := Set new.
	res := value tg_valueReference synthesisBy: self getSynthesizer.
	expected := RBParser parseExpression: 'Set new'.
	self assert: res equals: expected.
	
	value := Array new.
	res := value tg_valueReference synthesisBy: self getSynthesizer.
	expected := RBParser parseExpression: 'Array new'.
	self assert: res equals: expected
	
]

{ #category : #tests }
TGDefaultSynthesizerTest >> testListPrimitive [ 
	| res expected value |
	value := OrderedCollection with: 10 with: 29 with: true.
	res := value tg_valueReference synthesisBy: self getSynthesizer.
	expected := RBParser parseExpression: 'OrderedCollection new add: 10; add: 29; add: true; yourself'.
	self assert: res equals: expected.
	
	value := {45. false} asSet.
	res := value tg_valueReference synthesisBy: self getSynthesizer.
	expected := { RBParser parseExpression: 'Set new add: false; add: 45; yourself'. 
		RBParser parseExpression: 'Set new add: 45; add: false; yourself'}.
	self assert: (expected includes: res).
	
	value := {10. 11. 12. 13}.
	res := value tg_valueReference synthesisBy: self getSynthesizer.
	expected := RBParser parseExpression: 'Array new add: 10; add: 11; add:12; add:13; yourself'.
	self assert: res equals: expected.
	
	value := #(10 11 12 13).
	res := value tg_valueReference synthesisBy: self getSynthesizer.
	expected := RBParser parseExpression: 'Array new add: 10; add: 11; add:12; add:13; yourself'.
	self assert: res equals: expected
		
]

{ #category : #tests }
TGDefaultSynthesizerTest >> testNull [ 
	| res expected |
	res := nil tg_valueReference synthesisBy: self getSynthesizer.
	expected := RBParser parseExpression: 'nil'.
	self assert: res equals: expected
]

{ #category : #tests }
TGDefaultSynthesizerTest >> testSkipped [ 
	| value res expected |
	value := 10 @ 20 corner: 20 @ 20.
	res := value tg_valueReference synthesisBy: self getSynthesizer.
	expected := RBParser parseExpression: 'Rectangle new'.
	self assert: res equals: expected
]

{ #category : #tests }
TGDefaultSynthesizerTest >> testString [
	| res expected |
	res := 'jjj' tg_valueReference synthesisBy: self getSynthesizer.
	expected := RBParser parseExpression: '''jjj'''.
	self assert: res equals: expected
]
