Class {
	#name : #TGObjectHistoryComposer,
	#superclass : #Object,
	#traits : 'TGInternalClassesTrait',
	#classTraits : 'TGInternalClassesTrait classTrait',
	#instVars : [
		'config',
		'records',
		'theClass',
		'theMethod',
		'objectHistories',
		'dependencies'
	],
	#category : #'SmalltalkTestGrinder-Core-3.Preparation'
}

{ #category : #running }
TGObjectHistoryComposer >> addAllEventsForObject: obj [
	| recs stack r2 |
	recs := records select: [ :rec | obj objectReference uniqueId = rec receiver uniqueId].
	stack := Stack new.
	recs do: [ :r |
		self flag: #TODO. "if the method under test is not at depth 0, you need to break a call"
		r isCall ifTrue: [ stack push: r ].
		r isReturn ifTrue: [ r2 := stack pop.
			r2 selector = r selector ifFalse: [ self error: 'something is wrong here!' ]].
		stack ifEmpty: [ obj addEvent: (TGObjectEvent forCall: r2 return: r) ]
		 ].
	obj setInitializeDone.
	dependencies addAll: (obj dependsOn collect: [ :objRef | TGObjectHistory new objectReference: objRef ])
]

{ #category : #accessing }
TGObjectHistoryComposer >> config [
	^ config
]

{ #category : #accessing }
TGObjectHistoryComposer >> config: anObject [
	config := anObject
]

{ #category : #accessing }
TGObjectHistoryComposer >> dependencies [
	^ dependencies
]

{ #category : #accessing }
TGObjectHistoryComposer >> dependenciesFor: aHistory [
	^ dependencies select: [ :x | aHistory dependsOn includes: x objectReference ]
]

{ #category : #'as yet unclassified' }
TGObjectHistoryComposer >> historiesCache [
	self flag: #TODO. "add a cache mechanism to access to a shared cache which holds generated histories"
]

{ #category : #initialization }
TGObjectHistoryComposer >> initialize [ 
	objectHistories := OrderedCollection new.
	dependencies := Set new
]

{ #category : #running }
TGObjectHistoryComposer >> initializeUniqueObjectsCallingSelector [
	| recs1 receivers |
	recs1 := (records select: #isCall) select: [ :rec | 
		rec selector = theMethod and: [ theClass = rec receiver theClass] ].
	receivers := (recs1 collect: [ :rec |  rec receiver ]) removeDuplicates.
	objectHistories := receivers collect: [ :uId | TGObjectHistory new objectReference: uId ]
	
]

{ #category : #accessing }
TGObjectHistoryComposer >> objectHistories [
	^ objectHistories
]

{ #category : #accessing }
TGObjectHistoryComposer >> records [
	^ records
]

{ #category : #accessing }
TGObjectHistoryComposer >> records: anObject [
	records := anObject
]

{ #category : #running }
TGObjectHistoryComposer >> run [
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
TGObjectHistoryComposer >> theClass [
	^ theClass
]

{ #category : #accessing }
TGObjectHistoryComposer >> theClass: anObject [
	theClass := anObject
]

{ #category : #accessing }
TGObjectHistoryComposer >> theMethod [
	^ theMethod
]

{ #category : #accessing }
TGObjectHistoryComposer >> theMethod: anObject [
	theMethod := anObject
]
