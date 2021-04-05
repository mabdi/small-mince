Trait {
	#name : #TGTracerTrait,
	#instVars : [
		'tg_state'
	],
	#category : #'TestGrinder-1.Tracer'
}

{ #category : #'as yet unclassified' }
TGTracerTrait classSide >> observerMethods [
	^ self methods
]

{ #category : #'as yet unclassified' }
TGTracerTrait classSide >> state_variable_name [
	^ self instVarNames first
]

{ #category : #'as yet unclassified' }
TGTracerTrait >> tg_state_init [
	tg_state ifNil: [ tg_state := TGObjectReference with: self ]
]

{ #category : #'as yet unclassified' }
TGTracerTrait >> tg_state_updateId: id [
	self tg_state_init.
	tg_state lastRecordId: id
]

{ #category : #'as yet unclassified' }
TGTracerTrait >> tg_valueReference [
	self tg_state_init.
	^ tg_state clone
]
