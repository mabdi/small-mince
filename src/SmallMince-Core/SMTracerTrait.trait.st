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
SMTracerTrait >> sm_cache_pre: anObject [

	tg_state pre_record: anObject
]

{ #category : #'as yet unclassified' }
SMTracerTrait >> sm_cached_pre [ 

	^ tg_state pre_record
]

{ #category : #'as yet unclassified' }
SMTracerTrait >> sm_objectStack [
	self sm_state_init.
	^ tg_state stack
]

{ #category : #'as yet unclassified' }
SMTracerTrait >> sm_state_init [
	tg_state ifNil: [ tg_state := SMObjectValue with: self ]
]

{ #category : #'as yet unclassified' }
SMTracerTrait >> sm_valueReference [

	self sm_state_init.
	^ SMObjectReference from: tg_state
]

{ #category : #'as yet unclassified' }
SMTracerTrait >> sm_versionIncrease [

	tg_state versionIncrease
]
