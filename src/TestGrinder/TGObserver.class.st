Class {
	#name : #TGObserver,
	#superclass : #Object,
	#instVars : [
		'config',
		'sampleCode',
		'captureTargets',
		'observationTargets',
		'coverage',
		'observations',
		'records'
	],
	#category : #'TestGrinder-Observation'
}

{ #category : #'as yet unclassified' }
TGObserver class >> observerMethods [
	^ TGObserverTrait observerMethods
]

{ #category : #'as yet unclassified' }
TGObserver class >> state_variable_name [
	^ TGObserverTrait state_variable_name
]

{ #category : #'as yet unclassified' }
TGObserver >> addStateInstanceVariable: aClass [
	aClass allSubclasses
		do: [ :cls | 
			(cls hasInstVarNamed: self class state_variable_name)
				ifTrue: [ aClass removeInstVarNamed: self class state_variable_name ] ].
	(aClass allInstVarNames includes: self class state_variable_name)
		ifFalse: [ aClass addInstVarNamed: self class state_variable_name ].
	self class observerMethods do: [ :mtd | aClass compile: mtd sourceCode ]
]

{ #category : #accessing }
TGObserver >> captureTargets [
	^ captureTargets
]

{ #category : #accessing }
TGObserver >> captureTargets: anObject [
	captureTargets := anObject
]

{ #category : #accessing }
TGObserver >> config [
	^ config
]

{ #category : #accessing }
TGObserver >> config: anObject [
	config := anObject
]

{ #category : #initialization }
TGObserver >> initialize [
	records := OrderedCollection new
]

{ #category : #'as yet unclassified' }
TGObserver >> installObservers [
	| allsubs |
	allsubs := captureTargets flatCollect: [ :cls | cls allSubclasses ].
	(captureTargets difference: allsubs asSet)
		do: [ :aClass | self addStateInstanceVariable: aClass ].
	captureTargets do: [ :cls | self installObserversFor: cls ].

]

{ #category : #'as yet unclassified' }
TGObserver >> installObserversFor: aClass [
	aClass methods
		select: [ :aMethod | self isItSafeToProxyTo: aMethod ]
		thenDo: [ :aMethod | self installProxyOn: aMethod ]
]

{ #category : #'as yet unclassified' }
TGObserver >> installProxyOn: aMethod [
	| link |
	link := TGProxy on: aMethod action: self.
	link install
]

{ #category : #'as yet unclassified' }
TGObserver >> isItSafeToProxyTo: aMethod [
	(aMethod selector beginsWith: 'tg_') 
		ifTrue: [ ^ false ].
	({#initialization} includes: aMethod protocol)
		ifTrue: [ ^ false ].
	^ true
]

{ #category : #accessing }
TGObserver >> observationTargets [
	^ observationTargets
]

{ #category : #accessing }
TGObserver >> observationTargets: anObject [
	observationTargets := anObject
]

{ #category : #'as yet unclassified' }
TGObserver >> observe [
	[ self installObservers.
	sampleCode value ]
		ensure: [ self uninstallObservers ].
	^ observations
]

{ #category : #'as yet unclassified' }
TGObserver >> postCall: selector with: args in: aReceiver result: result [
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
TGObserver >> preCall: selector with: args in: aReceiver [
	| id record |
	record := TGCallLogRecord new
		for: aReceiver
		selector: selector
		args: args.
	self flag: #TODO.	"install metalink here to the nodes in the method to capture the coverage"
	id := self recordLog: record.
	aReceiver tg_state_updateId: id
]

{ #category : #'as yet unclassified' }
TGObserver >> recordLog: aRecord [
	records add: aRecord.
	^ records size
]

{ #category : #accessing }
TGObserver >> records [
	^ records
]

{ #category : #accessing }
TGObserver >> sampleCode [
	^ sampleCode
]

{ #category : #accessing }
TGObserver >> sampleCode: anObject [
	sampleCode := anObject
]

{ #category : #'as yet unclassified' }
TGObserver >> tg_internal_class [
	^ true
]

{ #category : #'as yet unclassified' }
TGObserver >> uninstallObservers [
	captureTargets do: [ :aClass | self uninstallObserversFor: aClass ]
]

{ #category : #'as yet unclassified' }
TGObserver >> uninstallObserversFor: aClass [
	TGProxy cureClass: aClass.
	self class observerMethods
		do: [ :mtd | aClass removeSelector: mtd selector ].
	(aClass hasInstVarNamed: self class state_variable_name)
		ifTrue: [ aClass removeInstVarNamed: self class state_variable_name ]
]
