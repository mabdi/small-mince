Class {
	#name : #TGMethodBasedFocusedTestsStrategy,
	#superclass : #TGAbstractStrategy,
	#instVars : [
		'synthesizer'
	],
	#category : #'TestGrinder-2.Strategies'
}

{ #category : #'as yet unclassified' }
TGMethodBasedFocusedTestsStrategy >> buildTestMethods [
	self composeClasses.
	self composedObjectsToTestModel.
]

{ #category : #'as yet unclassified' }
TGMethodBasedFocusedTestsStrategy >> composeClasses [
	| dic |
	self classesUnderTest do: [ :cls |
		dic := Dictionary new.
		cls methods do: [ :method |
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
		records: traces.
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
	synthesizer := TGDefaultSynthesizer new
]

{ #category : #'as yet unclassified' }
TGMethodBasedFocusedTestsStrategy >> synthesizer [
	^ synthesizer
]

{ #category : #'as yet unclassified' }
TGMethodBasedFocusedTestsStrategy >> toTestModelObjects: composedObjects selector: selector class: cls [
	self flag: #TODO. "minimize"
	^ composedObjects objectHistories collect: [ :obs | 
			TGTestMethod new 
				objectUnderTest: obs; 
				dependencies: (composedObjects dependenciesFor: obs);
				yourself  
			] 
]
