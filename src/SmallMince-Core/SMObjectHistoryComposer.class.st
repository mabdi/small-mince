Class {
	#name : #SMObjectHistoryComposer,
	#superclass : #Object,
	#traits : 'SMInternalClassesTrait',
	#classTraits : 'SMInternalClassesTrait classTrait',
	#instVars : [
		'records',
		'objectHistories'
	],
	#category : #'SmallMince-Core-3.Preparation'
}

{ #category : #running }
SMObjectHistoryComposer >> addAllEventsForObject: obj [
	| recs stack r2 |
	recs := records
		select: [ :rec | obj objectReference uniqueId = rec receiver uniqueId ].
	stack := Stack new.
	recs
		do: [ :r | 
			r isCall
				ifTrue: [ stack push: r ].
			(r isReturn or: [ r isException ])
				ifTrue: [ r2 := stack pop.
					r2 selector = r selector
						ifFalse: [ self error: 'something is wrong here!' ] ].
			stack
				ifEmpty: [ r isReturn
						ifTrue: [ obj addEvent: (SMObjectReturnEvent forCall: r2 return: r) ].
					r isException
						ifTrue: [ obj addEvent: (SMObjectExceptionEvent forCall: r2 exception: r) ] ] ].
	"obj setInitializeDone.
	dependencies
		addAll:
			(obj dependsOn
				collect: [ :objRef | SMObjectHistory new objectReference: objRef ])"
]

{ #category : #accessing }
SMObjectHistoryComposer >> dependenciesFor: aHistory [
	^ aHistory dependsOn
				collect: [ :depId | 
					self objectHistories
						detect: [ :his | his objectReference uniqueId = depId ] ]
]

{ #category : #initialization }
SMObjectHistoryComposer >> initialize [
	objectHistories := OrderedCollection new.
	
]

{ #category : #running }
SMObjectHistoryComposer >> initializeUniqueObjectsCallingSelector [
	| receivers |
	receivers := (records collect: [ :rec |  rec receiver ]) removeDuplicates.
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
	objectHistories do: [ :obj | self addAllEventsForObject: obj ].
	"newDependencies := dependencies reject: #isInitialized.
	[ newDependencies isNotEmpty ]
		whileTrue: [ newDependencies do: [ :obj | self addAllEventsForObject: obj ].
			newDependencies := dependencies reject: #isInitialized ]"
]
