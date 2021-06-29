Class {
	#name : #SMObjectHistoryComposer,
	#superclass : #Object,
	#traits : 'SMInternalClassesTrait',
	#classTraits : 'SMInternalClassesTrait classTrait',
	#instVars : [
		'records',
		'theClass',
		'theMethod',
		'objectHistories',
		'dependencies'
	],
	#category : #'SmallMince-Core-3.Preparation'
}

{ #category : #running }
SMObjectHistoryComposer >> addAllEventsForObject: obj [
	| recs stack r2 |
	recs := records select: [ :rec | obj objectReference uniqueId = rec receiver uniqueId].
	stack := Stack new.
	recs do: [ :r |
		self flag: #TODO. "if the method under test is not at depth 0, you need to break a call"
		r isCall ifTrue: [ stack push: r ].
		r isReturn ifTrue: [ r2 := stack pop.
			r2 selector = r selector ifFalse: [ self error: 'something is wrong here!' ]].
		stack ifEmpty: [ obj addEvent: (SMObjectEvent forCall: r2 return: r) ]
		 ].
	obj setInitializeDone.
	dependencies addAll: (obj dependsOn collect: [ :objRef | SMObjectHistory new objectReference: objRef ])
]

{ #category : #accessing }
SMObjectHistoryComposer >> dependencies [
	^ dependencies
]

{ #category : #accessing }
SMObjectHistoryComposer >> dependenciesFor: aHistory [
	^ dependencies select: [ :x | aHistory dependsOn includes: x objectReference ]
]

{ #category : #'as yet unclassified' }
SMObjectHistoryComposer >> historiesCache [
	self flag: #TODO. "add a cache mechanism to access to a shared cache which holds generated histories"
]

{ #category : #initialization }
SMObjectHistoryComposer >> initialize [ 
	objectHistories := OrderedCollection new.
	dependencies := Set new
]

{ #category : #running }
SMObjectHistoryComposer >> initializeUniqueObjectsCallingSelector [
	| recs1 receivers |
	recs1 := (records select: #isCall) select: [ :rec | 
		rec selector = theMethod and: [ theClass = rec receiver theClass] ].
	receivers := (recs1 collect: [ :rec |  rec receiver ]) removeDuplicates.
	objectHistories := receivers collect: [ :uId | SMObjectHistory new objectReference: uId ]
	
]

{ #category : #accessing }
SMObjectHistoryComposer >> objectHistories [
	^ objectHistories
]

{ #category : #accessing }
SMObjectHistoryComposer >> records [
	^ records
]

{ #category : #accessing }
SMObjectHistoryComposer >> records: anObject [
	records := anObject
]

{ #category : #running }
SMObjectHistoryComposer >> run [
	| newDependencies |
	self initializeUniqueObjectsCallingSelector.
	objectHistories do: [ :obj | 
		self addAllEventsForObject: obj ].
	newDependencies := (dependencies reject: #isInitialized).
	[ newDependencies isNotEmpty ] whileTrue: [ 
		 newDependencies do: [ :obj |
			self addAllEventsForObject: obj ].
		newDependencies := (dependencies reject: #isInitialized).
	 ]
]

{ #category : #accessing }
SMObjectHistoryComposer >> theClass [
	^ theClass
]

{ #category : #accessing }
SMObjectHistoryComposer >> theClass: anObject [
	theClass := anObject
]

{ #category : #accessing }
SMObjectHistoryComposer >> theMethod [
	^ theMethod
]

{ #category : #accessing }
SMObjectHistoryComposer >> theMethod: anObject [
	theMethod := anObject
]
