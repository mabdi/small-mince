Class {
	#name : #SMLogRecord,
	#superclass : #Object,
	#traits : 'SMInternalClassesTrait',
	#classTraits : 'SMInternalClassesTrait classTrait',
	#instVars : [
		'receiver',
		'selector',
		'state',
		'locals',
		'arguments',
		'returnValue',
		'argsAfter',
		'stateAfter',
		'exception'
	],
	#category : #'SmallMince-Core-Model'
}

{ #category : #accessing }
SMLogRecord >> argsAfter [

	^ argsAfter
]

{ #category : #accessing }
SMLogRecord >> argsAfter: anArgs [

	argsAfter := self captureArgsState: anArgs
]

{ #category : #accessing }
SMLogRecord >> arguments [
	^ arguments
]

{ #category : #accessing }
SMLogRecord >> arguments: anObject [

	arguments := self captureArgsState: anObject
]

{ #category : #'as yet unclassified' }
SMLogRecord >> captureArgsState: args [
	^ (args collect: [ :arg | arg sm_valueReference]) 
]

{ #category : #'as yet unclassified' }
SMLogRecord >> captureLocals [

	| cntx |
	cntx := thisContext.
	[ cntx receiver sm_internal_class ] whileTrue: [ cntx := cntx sender ].
	locals:= (cntx tempNames collect: [ :key | 
		   | v |
		   v := cntx tempNamed: key.
		   [ key -> v sm_valueReference ]
			   on: Error
			   do: [ key -> (SMSkippedValue with: v) ] ]) asDictionary
]

{ #category : #'as yet unclassified' }
SMLogRecord >> captureState: anObject [
	| instNames |
	instNames := anObject class allInstVarNames reject: [:name | name = SMTracer state_variable_name].
	^ (instNames collect: [ :key | 
		key -> ( anObject instVarNamed: key ) sm_valueReference  ]) asDictionary 
]

{ #category : #accessing }
SMLogRecord >> exception [
	^ exception
]

{ #category : #accessing }
SMLogRecord >> exception: anException [

	exception := anException sm_valueReference
]

{ #category : #'reflective operations' }
SMLogRecord >> gtDisplayString [

	^ selector 
]

{ #category : #testing }
SMLogRecord >> isException [

	^ exception isNotNil 
]

{ #category : #testing }
SMLogRecord >> isReturn [

	^ returnValue isNotNil 
]

{ #category : #testing }
SMLogRecord >> isStatePreserving [

	^ state = stateAfter
]

{ #category : #accessing }
SMLogRecord >> locals [
	^ locals
]

{ #category : #printing }
SMLogRecord >> printOn: aStream [

	aStream nextPutAll: self gtDisplayString
]

{ #category : #accessing }
SMLogRecord >> receiver [
	^ receiver
]

{ #category : #accessing }
SMLogRecord >> receiver: anObject [

	receiver := anObject sm_valueReference.
	state:= (self captureState: anObject).
]

{ #category : #accessing }
SMLogRecord >> returnValue [
	^ returnValue
]

{ #category : #accessing }
SMLogRecord >> returnValue: aValue [

	returnValue := aValue sm_valueReference
]

{ #category : #accessing }
SMLogRecord >> selector [
	^ selector
]

{ #category : #accessing }
SMLogRecord >> selector: anObject [
	selector := anObject
]

{ #category : #accessing }
SMLogRecord >> state [
	^ state
]

{ #category : #accessing }
SMLogRecord >> stateAfter [

	^ stateAfter
]

{ #category : #accessing }
SMLogRecord >> stateAfter: aReceiver [

	stateAfter := (self captureState: aReceiver)
]
