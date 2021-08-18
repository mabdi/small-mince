Class {
	#name : #SMMethodBasedFocusedTestsStrategy,
	#superclass : #SMAbstractStrategy,
	#instVars : [
		'synthesizer'
	],
	#category : #'SmallMince-Core-2.Strategies'
}

{ #category : #'as yet unclassified' }
SMMethodBasedFocusedTestsStrategy >> composeClasses [
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
SMMethodBasedFocusedTestsStrategy >> composeForMethod: aSelector inClass: aClass [
	| records |
	records := (self traces select: #isCall)
		select:
			[ :rec | rec selector = aSelector and: [ aClass = rec receiver theClass ] ].
	^ SMObjectHistoryComposer new
		records: records;
		run
]

{ #category : #'as yet unclassified' }
SMMethodBasedFocusedTestsStrategy >> composedObjectsToTestModel [
	results keysAndValuesDo: [ :cls :methods |
		methods keysAndValuesDo: [ :selector :composedObjects | 
			methods at: selector put: (self toTestModelObjects: composedObjects selector: selector class: cls)
			]
		 ]
]

{ #category : #initialization }
SMMethodBasedFocusedTestsStrategy >> initialize [ 
	super initialize.
	synthesizer := SMDefaultSynthesizer new.
	
]

{ #category : #'as yet unclassified' }
SMMethodBasedFocusedTestsStrategy >> methodsForTestFrom: aClass [ 
	^ aClass methods
]

{ #category : #'as yet unclassified' }
SMMethodBasedFocusedTestsStrategy >> minimizeTests [
	self flag: #TODO. "minimize"
	"remove all state preserving events"
	"remove events after MUT (think about #close methods)"
	"remove Test t if there is another test t' that t is subset of t'"
]

{ #category : #'as yet unclassified' }
SMMethodBasedFocusedTestsStrategy >> packageTests [
	"choose a good name for tests"
	"suggest helper methods by extracting common object creations"
	"remove the method under test classifications from result"
	results keysAndValuesDo: [ :className :methodsDic |
		self setNameForTheTests: methodsDic.
		results at: className put: methodsDic values flattened.
		 ]
]

{ #category : #'as yet unclassified' }
SMMethodBasedFocusedTestsStrategy >> results [
	^ results
]

{ #category : #'as yet unclassified' }
SMMethodBasedFocusedTestsStrategy >> run [
	self composeClasses.
	self composedObjectsToTestModel.
	self minimizeTests.
	self packageTests.
	^ results
]

{ #category : #'as yet unclassified' }
SMMethodBasedFocusedTestsStrategy >> setNameForTheTests: methodModels [
	methodModels keysAndValuesDo: [ :k :v |
		v size = 1 
			ifTrue: [ v first methodName: k asTestSelector ]
			ifFalse: [ v withIndexDo: [ :item :index | 
					item methodName: (k asTestSelector asString, '_', index asString) asSymbol 
					 ] ]
		 ]
]

{ #category : #'as yet unclassified' }
SMMethodBasedFocusedTestsStrategy >> synthesizer [
	^ synthesizer
]

{ #category : #'as yet unclassified' }
SMMethodBasedFocusedTestsStrategy >> toTestModelObjects: composedObjects selector: selector class: cls [
	^ composedObjects objectHistories collect: [ :obs | 
			SMTestMethod new 
				objectUnderTest: obs; 
				dependencies: (composedObjects dependenciesFor: obs);
				yourself  
			] 
]
