Class {
	#name : #SMMinceStrategy,
	#superclass : #SMAbstractStrategy,
	#instVars : [
		'synthesizer',
		'composedObjects'
	],
	#category : #'SmallMince-Core-2.Strategies'
}

{ #category : #'as yet unclassified' }
SMMinceStrategy >> composeClasses [
	| objectComposed methods |
	composedObjects := SMObjectHistoryComposer new
		records: self traces;
		run.
	self classesUnderTest
		do: [ :cls | 
			objectComposed := self composeClassesFor: cls.
			methods := objectComposed
				collect: [ :history | self toTestModelObjects: history class: cls ].
			results at: cls name put: methods ]
]

{ #category : #'as yet unclassified' }
SMMinceStrategy >> composeClassesFor: cls [
	| myTraces uids records objectComposed |
	myTraces := self traces select: [ :x | x receiver theClass = cls ].
	uids := (myTraces collect: [ :x | x receiver uniqueId ])
		removeDuplicates.
	objectComposed := uids
		collect:
			[ :uid | composedObjects objectHistories detect: [:h | h objectReference uniqueId = uid].  ].
	^ objectComposed
]

{ #category : #initialization }
SMMinceStrategy >> initialize [ 
	super initialize.
	synthesizer := SMDefaultSynthesizer new.
	
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
	self minimizeTests.
	self packageTests.
	^ results
]

{ #category : #'as yet unclassified' }
SMMinceStrategy >> setNameForTheTests: methodModels [
	methodModels doWithIndex: [ :item :index |
		item methodName: ('testN_' , index asString) asSymbol.
		
		 ]
]

{ #category : #'as yet unclassified' }
SMMinceStrategy >> synthesizer [
	^ synthesizer
]

{ #category : #'as yet unclassified' }
SMMinceStrategy >> toTestModelObjects: theComposedObjects class: cls [
	| theTestMethodModel |
	theTestMethodModel := SMTestMethod new
		objectUnderTest: theComposedObjects.
	theTestMethodModel
		dependencies:
			(composedObjects dependenciesFor: theComposedObjects 
				).
	^ theTestMethodModel
]
