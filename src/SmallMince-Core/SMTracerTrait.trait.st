Trait {
	#name : #SMTracerTrait,
	#instVars : [
		'tg_state'
	],
	#category : #'SmallMince-Core-1.Tracer'
}

{ #category : #'as yet unclassified' }
SMTracerTrait classSide >> observerMethods [
	^ self methods
]

{ #category : #'as yet unclassified' }
SMTracerTrait classSide >> state_variable_name [
	^ self instVarNames first
]

{ #category : #'as yet unclassified' }
SMTracerTrait >> sm_objectStack [
	self sm_state_init.
	^ tg_state stack
]

{ #category : #'as yet unclassified' }
SMTracerTrait >> sm_state_init [
	tg_state ifNil: [ tg_state := SMObjectReference with: self ]
]

{ #category : #'as yet unclassified' }
SMTracerTrait >> sm_state_updateId: id [
	self sm_state_init.
	tg_state lastRecordId: id
]

{ #category : #'as yet unclassified' }
SMTracerTrait >> sm_valueReference [
	self sm_state_init.
	^ tg_state clone
]
