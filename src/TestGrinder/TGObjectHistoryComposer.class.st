Class {
	#name : #TGObjectHistoryComposer,
	#superclass : #Object,
	#instVars : [
		'config',
		'records',
		'theClass',
		'theMethod',
		'objectHistories',
		'dependencies'
	],
	#category : #'TestGrinder-1.Tracer'
}

{ #category : #running }
TGObjectHistoryComposer >> addAllEventsForObject: obj [
	| recs stack r2 |
	recs := records select: [ :rec | obj uId = rec receiver uniqueId].
	stack := Stack new.
	recs do: [ :r |
		r isCall ifTrue: [ stack push: r ].
		r isReturn ifTrue: [ r2 := stack pop.
			r2 selector = r selector ifFalse: [ self error: 'something is wrong here!' ]].
		stack ifEmpty: [ obj setInitIfNil: r2.
			obj addEvent: (TGObjectEvent forCall: r2 return: r) ]
		 ].
	obj setInitializeDone.
	dependencies addAll: (obj dependsOn collect: [ :objRef | TGObjectHistory new uId: objRef uniqueId ])
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

{ #category : #initialization }
TGObjectHistoryComposer >> initialize [ 
	objectHistories := OrderedCollection new.
	dependencies := Set new
]

{ #category : #running }
TGObjectHistoryComposer >> initializeUniqueObjectsCallingSelector [
	| recs1 uniqueIds |
	recs1 := (records select: #isCall) select: [ :rec | 
		rec selector = theMethod and: [ theClass = rec receiver theClass] ].
	uniqueIds := (recs1 collect: [ :rec |  rec receiver uniqueId ]) removeDuplicates.
	objectHistories := uniqueIds collect: [ :uId | TGObjectHistory new uId: uId ]
	
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
