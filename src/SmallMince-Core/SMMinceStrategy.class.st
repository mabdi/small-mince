Class {
	#name : #SMMinceStrategy,
	#superclass : #SMAbstractStrategy,
	#instVars : [
		'synthesizer'
	],
	#category : #'SmallMince-Core-2.Strategies'
}

{ #category : #'as yet unclassified' }
SMMinceStrategy >> composeClasses [
	| myTraces uids records objectComposed |
	self classesUnderTest
		do: [ :cls | 
			myTraces := traces select: [ :x | x receiver theClass = cls ].
			uids := (myTraces collect: [ :x | x receiver uniqueId ])
				removeDuplicates.
			objectComposed := uids
				collect: [ :uid | 
					records := myTraces select: [ :x | x receiver uniqueId = uid ].
					SMObjectHistoryComposer new
						theClass: cls;
						records: records;
						run ].
			results at: cls name put: objectComposed ]
]

{ #category : #'as yet unclassified' }
SMMinceStrategy >> composedObjectsToTestModel [
	results
		keysAndValuesDo: [ :cls :histories | 
			results
				at: cls
				put:
					(histories
						collect: [ :history | self toTestModelObjects: history class: cls ]) ]
]

{ #category : #initialization }
SMMinceStrategy >> initialize [ 
	super initialize.
	synthesizer := SMDefaultSynthesizer new.
	
]

{ #category : #'as yet unclassified' }
SMMinceStrategy >> methodsForTestFrom: aClass [ 
	^ aClass methods
]

{ #category : #'as yet unclassified' }
SMMinceStrategy >> minimizeTests [
	self flag: #TODO. "minimize"
	"remove all state preserving events"
	"remove events after MUT (think about #close methods)"
	"remove Test t if there is another test t' that t is subset of t'"
]

{ #category : #'as yet unclassified' }
SMMinceStrategy >> packageTests [
	"choose a good name for tests"

	"suggest helper methods by extracting common object creations"

	"remove the method under test classifications from result"

	results
		keysAndValuesDo: [ :className :methodsList | 
			self setNameForTheTests: methodsList.
			results at: className put: methodsList flattened ]
]

{ #category : #'as yet unclassified' }
SMMinceStrategy >> results [
	^ results
]

{ #category : #'as yet unclassified' }
SMMinceStrategy >> run [
	self composeClasses.
	self composedObjectsToTestModel.
	self minimizeTests.
	self packageTests.
	^ results
]

{ #category : #'as yet unclassified' }
SMMinceStrategy >> setNameForTheTests: methodModels [
	methodModels doWithIndex: [ :item :index |
		item size = 1 
			ifTrue: [ item first methodName: ('testN_' , index asString) asSymbol ]
			ifFalse: [ item withIndexDo: [ :item2 :index2 | 
					item2 methodName: ('testN_', index asString, '_', index2 asString) asSymbol 
					 ] ]
		 ]
]

{ #category : #'as yet unclassified' }
SMMinceStrategy >> synthesizer [
	^ synthesizer
]

{ #category : #'as yet unclassified' }
SMMinceStrategy >> toTestModelObjects: composedObjects class: cls [
	^ composedObjects objectHistories
		collect: [ :obs | 
			SMTestMethod new
				objectUnderTest: obs;
				dependencies: (composedObjects dependenciesFor: obs);
				yourself ]
]
