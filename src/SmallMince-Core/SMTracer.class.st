Class {
	#name : #SMTracer,
	#superclass : #Object,
	#traits : 'SMInternalClassesTrait',
	#classTraits : 'SMInternalClassesTrait classTrait',
	#instVars : [
		'config',
		'executableCode',
		'captureTargets',
		'observationTargets',
		'coverage',
		'observations',
		'records'
	],
	#category : #'SmallMince-Core-1.Tracer'
}

{ #category : #'as yet unclassified' }
SMTracer class >> observerMethods [
	^ SMTracerTrait observerMethods
]

{ #category : #'as yet unclassified' }
SMTracer class >> state_variable_name [
	^ SMTracerTrait state_variable_name
]

{ #category : #'as yet unclassified' }
SMTracer >> addStateInstanceVariable: aClass [
	aClass allSubclasses
		do: [ :cls | 
			(cls hasInstVarNamed: self class state_variable_name)
				ifTrue: [ aClass removeInstVarNamed: self class state_variable_name ] ].
	(aClass allInstVarNames includes: self class state_variable_name)
		ifFalse: [ aClass addInstVarNamed: self class state_variable_name ].
	self class observerMethods do: [ :mtd | aClass compile: mtd sourceCode ]
]

{ #category : #accessing }
SMTracer >> captureTargets [
	^ captureTargets
]

{ #category : #accessing }
SMTracer >> captureTargets: anObject [
	captureTargets := anObject
]

{ #category : #accessing }
SMTracer >> config [
	^ config
]

{ #category : #accessing }
SMTracer >> config: anObject [
	config := anObject
]

{ #category : #accessing }
SMTracer >> executableCode [
	^ executableCode
]

{ #category : #accessing }
SMTracer >> executableCode: anObject [
	executableCode := anObject
]

{ #category : #initialization }
SMTracer >> initialize [
	records := OrderedCollection new.
]

{ #category : #'as yet unclassified' }
SMTracer >> installObservers [
	| allsubs |
	allsubs := captureTargets flatCollect: [ :cls | cls allSubclasses ].
	(captureTargets difference: allsubs asSet)
		do: [ :aClass | self addStateInstanceVariable: aClass ].
	captureTargets do: [ :cls | self installObserversFor: cls ].

]

{ #category : #'as yet unclassified' }
SMTracer >> installObserversFor: aClass [
	aClass methods
		select: [ :aMethod | self isItSafeToProxyTo: aMethod ]
		thenDo: [ :aMethod | self installProxyOn: aMethod ]
]

{ #category : #'as yet unclassified' }
SMTracer >> installProxyOn: aMethod [
	| link |
	link := SMProxy on: aMethod action: self.
	link install
]

{ #category : #'as yet unclassified' }
SMTracer >> isItSafeToProxyTo: aMethod [
	(aMethod selector beginsWith: 'sm_') 
		ifTrue: [ ^ false ].
	({#initialization} includes: aMethod protocol)
		ifTrue: [ ^ false ].
	^ true
]

{ #category : #accessing }
SMTracer >> observationTargets [
	^ observationTargets
]

{ #category : #accessing }
SMTracer >> observationTargets: anObject [
	observationTargets := anObject
]

{ #category : #'as yet unclassified' }
SMTracer >> postCall: selector with: args in: aReceiver result: result [
	| id record |
	record := SMReturnLogRecord new
		for: aReceiver
		selector: selector
		args: args
		result: result .
	id := self recordLog: record.
	aReceiver sm_state_updateId: id
]

{ #category : #'as yet unclassified' }
SMTracer >> preCall: selector with: args in: aReceiver [
	| id record |
	record := SMCallLogRecord new
		for: aReceiver
		selector: selector
		args: args.
	id := self recordLog: record.
	aReceiver sm_state_updateId: id
]

{ #category : #'as yet unclassified' }
SMTracer >> recordLog: aRecord [
	records add: aRecord.
	aRecord id: records size.
	^ records size
]

{ #category : #accessing }
SMTracer >> records [
	^ records
]

{ #category : #'as yet unclassified' }
SMTracer >> run [
	[ self installObservers.
	executableCode value ]
		ensure: [ self uninstallObservers ].
	^ observations
]

{ #category : #'as yet unclassified' }
SMTracer >> uninstallObservers [
	captureTargets do: [ :aClass | self uninstallObserversFor: aClass ]
]

{ #category : #'as yet unclassified' }
SMTracer >> uninstallObserversFor: aClass [
	SMProxy cureClass: aClass.
	self class observerMethods
		do: [ :mtd | aClass removeSelector: mtd selector ].
	(aClass hasInstVarNamed: self class state_variable_name)
		ifTrue: [ aClass removeInstVarNamed: self class state_variable_name ]
]
