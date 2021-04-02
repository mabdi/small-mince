Trait {
	#name : #TGObserverTrait,
	#instVars : [
		'tg_state'
	],
	#category : #'TestGrinder-Observation'
}

{ #category : #'as yet unclassified' }
TGObserverTrait classSide >> observerMethods [
	^ self methods
]

{ #category : #'as yet unclassified' }
TGObserverTrait classSide >> state_variable_name [
	^ self instVarNames first
]

{ #category : #'as yet unclassified' }
TGObserverTrait >> tg_state_init [
	tg_state ifNil: [ tg_state := TGObjectReference with: self ]
]

{ #category : #'as yet unclassified' }
TGObserverTrait >> tg_state_updateId: id [
	self tg_state_init.
	tg_state lastRecordId: id
]

{ #category : #'as yet unclassified' }
TGObserverTrait >> tg_valueReference [
	self tg_state_init.
	^ tg_state clone
]
