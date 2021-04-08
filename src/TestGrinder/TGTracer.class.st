Class {
	#name : #TGTracer,
	#superclass : #Object,
	#traits : 'TGInternalClassesTrait',
	#classTraits : 'TGInternalClassesTrait classTrait',
	#instVars : [
		'config',
		'executableCode',
		'captureTargets',
		'observationTargets',
		'coverage',
		'observations',
		'records'
	],
	#category : #'TestGrinder-1.Tracer'
}

{ #category : #'as yet unclassified' }
TGTracer class >> observerMethods [
	^ TGTracerTrait observerMethods
]

{ #category : #'as yet unclassified' }
TGTracer class >> state_variable_name [
	^ TGTracerTrait state_variable_name
]

{ #category : #'as yet unclassified' }
TGTracer >> addStateInstanceVariable: aClass [
	aClass allSubclasses
		do: [ :cls | 
			(cls hasInstVarNamed: self class state_variable_name)
				ifTrue: [ aClass removeInstVarNamed: self class state_variable_name ] ].
	(aClass allInstVarNames includes: self class state_variable_name)
		ifFalse: [ aClass addInstVarNamed: self class state_variable_name ].
	self class observerMethods do: [ :mtd | aClass compile: mtd sourceCode ]
]

{ #category : #accessing }
TGTracer >> captureTargets [
	^ captureTargets
]

{ #category : #accessing }
TGTracer >> captureTargets: anObject [
	captureTargets := anObject
]

{ #category : #accessing }
TGTracer >> config [
	^ config
]

{ #category : #accessing }
TGTracer >> config: anObject [
	config := anObject
]

{ #category : #accessing }
TGTracer >> executableCode [
	^ executableCode
]

{ #category : #accessing }
TGTracer >> executableCode: anObject [
	executableCode := anObject
]

{ #category : #initialization }
TGTracer >> initialize [
	records := OrderedCollection new.
]

{ #category : #'as yet unclassified' }
TGTracer >> installObservers [
	| allsubs |
	allsubs := captureTargets flatCollect: [ :cls | cls allSubclasses ].
	(captureTargets difference: allsubs asSet)
		do: [ :aClass | self addStateInstanceVariable: aClass ].
	captureTargets do: [ :cls | self installObserversFor: cls ].

]

{ #category : #'as yet unclassified' }
TGTracer >> installObserversFor: aClass [
	aClass methods
		select: [ :aMethod | self isItSafeToProxyTo: aMethod ]
		thenDo: [ :aMethod | self installProxyOn: aMethod ]
]

{ #category : #'as yet unclassified' }
TGTracer >> installProxyOn: aMethod [
	| link |
	link := TGProxy on: aMethod action: self.
	link install
]

{ #category : #'as yet unclassified' }
TGTracer >> isItSafeToProxyTo: aMethod [
	(aMethod selector beginsWith: 'tg_') 
		ifTrue: [ ^ false ].
	({#initialization} includes: aMethod protocol)
		ifTrue: [ ^ false ].
	^ true
]

{ #category : #accessing }
TGTracer >> observationTargets [
	^ observationTargets
]

{ #category : #accessing }
TGTracer >> observationTargets: anObject [
	observationTargets := anObject
]

{ #category : #'as yet unclassified' }
TGTracer >> postCall: selector with: args in: aReceiver result: result [
	| id record |
	record := TGReturnLogRecord new
		for: aReceiver
		selector: selector
		args: args
		result: result .
	id := self recordLog: record.
	aReceiver tg_state_updateId: id
]

{ #category : #'as yet unclassified' }
TGTracer >> preCall: selector with: args in: aReceiver [
	| id record |
	record := TGCallLogRecord new
		for: aReceiver
		selector: selector
		args: args.
	id := self recordLog: record.
	aReceiver tg_state_updateId: id
]

{ #category : #'as yet unclassified' }
TGTracer >> recordLog: aRecord [
	records add: aRecord.
	aRecord id: records size.
	^ records size
]

{ #category : #accessing }
TGTracer >> records [
	^ records
]

{ #category : #'as yet unclassified' }
TGTracer >> run [
	[ self installObservers.
	executableCode value ]
		ensure: [ self uninstallObservers ].
	^ observations
]

{ #category : #'as yet unclassified' }
TGTracer >> uninstallObservers [
	captureTargets do: [ :aClass | self uninstallObserversFor: aClass ]
]

{ #category : #'as yet unclassified' }
TGTracer >> uninstallObserversFor: aClass [
	TGProxy cureClass: aClass.
	self class observerMethods
		do: [ :mtd | aClass removeSelector: mtd selector ].
	(aClass hasInstVarNamed: self class state_variable_name)
		ifTrue: [ aClass removeInstVarNamed: self class state_variable_name ]
]
