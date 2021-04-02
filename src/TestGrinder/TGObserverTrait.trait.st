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
	^ self instanceVariables first
]

{ #category : #'as yet unclassified' }
TGObserverTrait >> tg_state [
	self tg_state_init.
	^ tg_state clone
]

{ #category : #'as yet unclassified' }
TGObserverTrait >> tg_state_init [
	tg_state ifNil: [ tg_state := TGObjectValue with: self ]
]

{ #category : #'as yet unclassified' }
TGObserverTrait >> tg_state_updateId: id [
	self tg_state_init.
	tg_state lastRecordId: id
]
