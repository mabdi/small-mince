Class {
	#name : #TGAbstractLogRecord,
	#superclass : #Object,
	#traits : 'TGInternalClassesTrait',
	#classTraits : 'TGInternalClassesTrait classTrait',
	#instVars : [
		'id',
		'receiver',
		'selector',
		'state',
		'locals',
		'arguments'
	],
	#category : #'SmalltalkTestGrinder-Core-Model'
}

{ #category : #accessing }
TGAbstractLogRecord >> arguments [
	^ arguments
]

{ #category : #accessing }
TGAbstractLogRecord >> arguments: anObject [
	arguments := anObject
]

{ #category : #'as yet unclassified' }
TGAbstractLogRecord >> captureArgsState: args [
	^ (args collect: [ :arg | arg tg_valueReference]) 
]

{ #category : #'as yet unclassified' }
TGAbstractLogRecord >> captureLocals [ 
	| cntx |
	cntx := thisContext.
	[ cntx receiver tg_internal_class] 
		whileTrue: [ cntx := cntx sender].
	^ (cntx tempNames collect: [ :key | 
			| v |
			v := (cntx tempNamed: key).
			[key -> (v tg_valueReference)]
			on: Error do: [ key -> (TGSkippedValue with: v) ] ]
		) asDictionary
]

{ #category : #'as yet unclassified' }
TGAbstractLogRecord >> captureState: anObject [
	| instNames |
	instNames := anObject class allInstVarNames reject: [:name | name = TGTracer state_variable_name].
	^ (instNames collect: [ :key | 
		key -> ( anObject instVarNamed: key ) tg_valueReference  ]) asDictionary 
]

{ #category : #accessing }
TGAbstractLogRecord >> id [
	^ id
]

{ #category : #accessing }
TGAbstractLogRecord >> id: anObject [
	id := anObject
]

{ #category : #testing }
TGAbstractLogRecord >> isCall [
	^ false
]

{ #category : #testing }
TGAbstractLogRecord >> isReturn [
	^ false
]

{ #category : #accessing }
TGAbstractLogRecord >> locals [
	^ locals
]

{ #category : #accessing }
TGAbstractLogRecord >> locals: anObject [
	locals := anObject
]

{ #category : #accessing }
TGAbstractLogRecord >> receiver [
	^ receiver
]

{ #category : #accessing }
TGAbstractLogRecord >> receiver: anObject [
	receiver := anObject
]

{ #category : #accessing }
TGAbstractLogRecord >> selector [
	^ selector
]

{ #category : #accessing }
TGAbstractLogRecord >> selector: anObject [
	selector := anObject
]

{ #category : #accessing }
TGAbstractLogRecord >> state [
	^ state
]

{ #category : #accessing }
TGAbstractLogRecord >> state: anObject [
	state := anObject
]
