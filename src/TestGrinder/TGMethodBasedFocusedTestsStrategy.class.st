Class {
	#name : #TGMethodBasedFocusedTestsStrategy,
	#superclass : #TGAbstractStrategy,
	#instVars : [
		'synthesizer'
	],
	#category : #'TestGrinder-2.Strategies'
}

{ #category : #'as yet unclassified' }
TGMethodBasedFocusedTestsStrategy >> composeClasses [
	| dic |
	self classesUnderTest do: [ :cls |
		dic := Dictionary new.
		(self methodsForTestFrom: cls) do: [ :method |
			dic at: method selector put: 
				(self composeForMethod: method selector inClass: cls) 
			 ].
		results at: cls name put: dic ].
	
]

{ #category : #'as yet unclassified' }
TGMethodBasedFocusedTestsStrategy >> composeForMethod: aSelector inClass: aClass [
	^ TGObjectHistoryComposer new 
		theClass: aClass; 
		theMethod: aSelector; 
		records: traces;
		run.
]

{ #category : #'as yet unclassified' }
TGMethodBasedFocusedTestsStrategy >> composedObjectsToTestModel [
	results keysAndValuesDo: [ :cls :methods |
		methods keysAndValuesDo: [ :selector :composedObjects | 
			methods at: selector put: (self toTestModelObjects: composedObjects selector: selector class: cls)
			]
		 ]
]

{ #category : #initialization }
TGMethodBasedFocusedTestsStrategy >> initialize [ 
	synthesizer := TGDefaultSynthesizer new.
	results := Dictionary new
]

{ #category : #'as yet unclassified' }
TGMethodBasedFocusedTestsStrategy >> methodsForTestFrom: aClass [ 
	^ aClass methods
]

{ #category : #'as yet unclassified' }
TGMethodBasedFocusedTestsStrategy >> minimizeTests [
	self flag: #TODO. "minimize"
	"remove all state preserving events"
	"remove events after MUT (think about #close methods)"
	"remove Test t if there is another test t' that t is subset of t'"
]

{ #category : #'as yet unclassified' }
TGMethodBasedFocusedTestsStrategy >> packageTests [
	"choose a good name for tests"
	"suggest helper methods by extracting common object creations"
	"remove the method under test classifications from result"
	results keysAndValuesDo: [ :className :methodsDic |
		self setNameForTheTests: methodsDic.
		results at: className put: methodsDic values flattened.
		 ]
]

{ #category : #'as yet unclassified' }
TGMethodBasedFocusedTestsStrategy >> results [
	^ results
]

{ #category : #'as yet unclassified' }
TGMethodBasedFocusedTestsStrategy >> run [
	self composeClasses.
	self composedObjectsToTestModel.
	self minimizeTests.
	self packageTests.
	^ results
]

{ #category : #'as yet unclassified' }
TGMethodBasedFocusedTestsStrategy >> setNameForTheTests: methodModels [
	methodModels keysAndValuesDo: [ :k :v |
		v size = 1 
			ifTrue: [ v first methodName: k asTestSelector ]
			ifFalse: [ v withIndexDo: [ :item :index | 
					item methodName: (k asTestSelector asString, '_', index asString) asSymbol 
					 ] ]
		 ]
]

{ #category : #'as yet unclassified' }
TGMethodBasedFocusedTestsStrategy >> synthesizer [
	^ synthesizer
]

{ #category : #'as yet unclassified' }
TGMethodBasedFocusedTestsStrategy >> toTestModelObjects: composedObjects selector: selector class: cls [
	^ composedObjects objectHistories collect: [ :obs | 
			TGTestMethod new 
				objectUnderTest: obs; 
				dependencies: (composedObjects dependenciesFor: obs);
				yourself  
			] 
]
