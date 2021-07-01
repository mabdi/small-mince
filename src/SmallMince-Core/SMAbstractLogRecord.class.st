Class {
	#name : #SMAbstractLogRecord,
	#superclass : #Object,
	#traits : 'SMInternalClassesTrait',
	#classTraits : 'SMInternalClassesTrait classTrait',
	#instVars : [
		'id',
		'receiver',
		'selector',
		'state',
		'locals',
		'arguments'
	],
	#category : #'SmallMince-Core-Model'
}

{ #category : #accessing }
SMAbstractLogRecord >> arguments [
	^ arguments
]

{ #category : #accessing }
SMAbstractLogRecord >> arguments: anObject [
	arguments := anObject
]

{ #category : #'as yet unclassified' }
SMAbstractLogRecord >> captureArgsState: args [
	^ (args collect: [ :arg | arg sm_valueReference]) 
]

{ #category : #'as yet unclassified' }
SMAbstractLogRecord >> captureLocals [ 
	| cntx |
	cntx := thisContext.
	[ cntx receiver sm_internal_class] 
		whileTrue: [ cntx := cntx sender].
	^ (cntx tempNames collect: [ :key | 
			| v |
			v := (cntx tempNamed: key).
			[key -> (v sm_valueReference)]
			on: Error do: [ key -> (SMSkippedValue with: v) ] ]
		) asDictionary
]

{ #category : #'as yet unclassified' }
SMAbstractLogRecord >> captureState: anObject [
	| instNames |
	instNames := anObject class allInstVarNames reject: [:name | name = SMTracer state_variable_name].
	^ (instNames collect: [ :key | 
		key -> ( anObject instVarNamed: key ) sm_valueReference  ]) asDictionary 
]

{ #category : #accessing }
SMAbstractLogRecord >> id [
	^ id
]

{ #category : #accessing }
SMAbstractLogRecord >> id: anObject [
	id := anObject
]

{ #category : #testing }
SMAbstractLogRecord >> isCall [
	^ false
]

{ #category : #testing }
SMAbstractLogRecord >> isException [
	^ false
]

{ #category : #testing }
SMAbstractLogRecord >> isReturn [
	^ false
]

{ #category : #accessing }
SMAbstractLogRecord >> locals [
	^ locals
]

{ #category : #accessing }
SMAbstractLogRecord >> locals: anObject [
	locals := anObject
]

{ #category : #accessing }
SMAbstractLogRecord >> receiver [
	^ receiver
]

{ #category : #accessing }
SMAbstractLogRecord >> receiver: anObject [
	receiver := anObject
]

{ #category : #accessing }
SMAbstractLogRecord >> selector [
	^ selector
]

{ #category : #accessing }
SMAbstractLogRecord >> selector: anObject [
	selector := anObject
]

{ #category : #accessing }
SMAbstractLogRecord >> state [
	^ state
]

{ #category : #accessing }
SMAbstractLogRecord >> state: anObject [
	state := anObject
]
